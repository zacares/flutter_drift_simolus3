---

title: Selects
description: Select rows or individual columns from tables in Dart

---

This page describes how to write `SELECT` statements with drift's dart_api.
To make examples easier to grasp, they're referencing two common tables forming
the basis of a todo-list app:

{{ load_snippet('tables','lib/snippets/_shared/todo_tables.dart.excerpt.json') }}

For each table you've specified in the `@DriftDatabase` annotation on your database class,
a corresponding getter for a table will be generated. That getter can be used to
run statements:

```dart
@DriftDatabase(tables: [TodoItems, Categories])
class MyDatabase extends _$MyDatabase {

  // the schemaVersion getter and the constructor from the previous page
  // have been omitted.

  // loads all todo entries
  Future<List<TodoItem>> get allTodoItems => select(todoItems).get();

  // watches all todo entries in a given category. The stream will automatically
  // emit new items whenever the underlying data changes.
  Stream<List<TodoItem>> watchEntriesInCategory(Category c) {
    return (select(todos)..where((t) => t.category.equals(c.id))).watch();
  }
}
```

Drift makes writing queries easy and safe. This page describes how to write basic select
queries, but also explains how to use joins and subqueries for advanced queries.

## Simple selects

You can create `select` statements by starting them with `select(tableName)`, where the
table name
is a field generated for you by drift. Each table used in a database will have a matching field
to run queries against. Any query can be run once with `get()`
[or be turned into an auto-updating stream using `watch()`](streams.md).

### Where
You can apply filters to a query by calling `where()`. The where method takes a function that
should map the given table to an `Expression` of boolean. A common way to create such expression
is by using `equals` on expressions. Integer columns can also be compared with `isBiggerThan`
and `isSmallerThan`. You can compose expressions using `a & b, a | b` and `a.not()`. For more
details on expressions, see [this guide](../dart_api/expressions.md).

### Limit
You can limit the amount of results returned by calling `limit` on queries. The method accepts
the amount of rows to return and an optional offset.

{{ load_snippet('limit','lib/snippets/dart_api/select.dart.excerpt.json') }}


### Ordering
You can use the `orderBy` method on the select statement. It expects a list of functions that extract the individual
ordering terms from the table. You can use any expression as an ordering term - for more details, see
[this guide](../dart_api/expressions.md).

{{ load_snippet('order-by','lib/snippets/dart_api/select.dart.excerpt.json') }}

You can also reverse the order by setting the `mode` property of the `OrderingTerm` to
`OrderingMode.desc`.

### Single values
If you know a query is never going to return more than one row, wrapping the result in a `List`
can be tedious. Drift lets you work around that with `getSingle` and `watchSingle`:

{{ load_snippet('single','lib/snippets/dart_api/select.dart.excerpt.json') }}

If an entry with the provided id exists, it will be sent to the stream. Otherwise,
`null` will be added to stream. If a query used with `watchSingle` ever returns
more than one entry (which is impossible in this case), an error will be added
instead.

### Mapping
Before calling `watch` or `get` (or the single variants), you can use `map` to transform
the result.

{{ load_snippet('mapping','lib/snippets/dart_api/select.dart.excerpt.json') }}

### Deferring get vs watch
If you want to make your query consumable as either a `Future` or a `Stream`,
you can refine your return type using one of the `Selectable` abstract base classes;

{{ load_snippet('selectable','lib/snippets/dart_api/select.dart.excerpt.json') }}

These base classes don't have query-building or `map` methods, signaling to the consumer
that they are complete results.


## Joins

Drift supports sql joins to write queries that operate on more than one table. To use that feature, start
a select regular select statement with `select(table)` and then add a list of joins using `.join()`. For
inner and left outer joins, a `ON` expression needs to be specified.

{{ load_snippet('joinIntro','lib/snippets/dart_api/select.dart.excerpt.json') }}

Of course, you can also join multiple tables:

{{ load_snippet('otherTodosInSameCategory','lib/snippets/dart_api/select.dart.excerpt.json') }}

### Parsing results

Calling `get()` or `watch` on a select statement with join returns a `Future` or `Stream` of
`List<TypedResult>`, respectively. Each `TypedResult` represents a row from which data can be
read. It contains a `rawData` getter to obtain the raw columns. But more importantly, the
`readTable` method can be used to read a data class from a table.

In the example query above, we've read the todo entry and the category from each row like this:

{{ load_snippet('results','lib/snippets/dart_api/select.dart.excerpt.json') }}

_Note_: `readTable` will throw an `ArgumentError` when a table is not present in the row. For instance,
todo entries might not be in any category. To account for that, we use `row.readTableOrNull` to load
categories.

## Custom columns

Select statements aren't limited to columns from tables. You can also include more complex expressions in the
query. For each row in the result, those expressions will be evaluated by the database engine.

{{ load_snippet('custom-columns','lib/snippets/dart_api/select.dart.excerpt.json') }}

Note that the `like` check is _not_ performed in Dart - it's sent to the underlying database engine which
can efficiently compute it for all rows.

## Aliases
Sometimes, a query references a table more than once. Consider the following example to store saved routes for a
navigation system:
```dart
class GeoPoints extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get latitude => text()();
  TextColumn get longitude => text()();
}

class Routes extends Table {

  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();

  // contains the id for the start and destination geopoint.
  IntColumn get start => integer()();
  IntColumn get destination => integer()();
}
```

Now, let's say we wanted to also load the start and destination `GeoPoint` object for each route. We'd have to use
a join on the `geo-points` table twice: For the start and destination point. To express that in a query, aliases
can be used:
```dart
class RouteWithPoints {
  final Route route;
  final GeoPoint start;
  final GeoPoint destination;

  RouteWithPoints({this.route, this.start, this.destination});
}

// inside the database class:
Future<List<RouteWithPoints>> loadRoutes() async {
  // create aliases for the geoPoints table so that we can reference it twice
  final start = alias(geoPoints, 's');
  final destination = alias(geoPoints, 'd');

  final rows = await select(routes).join([
    innerJoin(start, start.id.equalsExp(routes.start)),
    innerJoin(destination, destination.id.equalsExp(routes.destination)),
  ]).get();

  return rows.map((resultRow) {
    return RouteWithPoints(
      route: resultRow.readTable(routes),
      start: resultRow.readTable(start),
      destination: resultRow.readTable(destination),
    );
  }).toList();
}
```
The generated statement then looks like this:
```sql
SELECT
    routes.id, routes.name, routes.start, routes.destination,
    s.id, s.name, s.latitude, s.longitude,
    d.id, d.name, d.latitude, d.longitude
FROM routes
    INNER JOIN geo_points s ON s.id = routes.start
    INNER JOIN geo_points d ON d.id = routes.destination
```

## `ORDER BY` and `WHERE` on joins

Similar to queries on a single table, `orderBy` and `where` can be used on joins too.
The initial example from above is expanded to only include todo entries with a specified
filter and to order results based on the category's id:

```dart
Stream<List<EntryWithCategory>> entriesWithCategory(String entryFilter) {
  final query = select(todos).join([
    leftOuterJoin(categories, categories.id.equalsExp(todos.category)),
  ]);
  query.where(todos.content.like(entryFilter));
  query.orderBy([OrderingTerm.asc(categories.id)]);
  // ...
}
```

As a join can have more than one table, all tables in `where` and `orderBy` have to
be specified directly (unlike the callback on single-table queries that gets called
with the right table by default).

## Group by

Sometimes, you need to run queries that _aggregate_ data, meaning that data you're interested in
comes from multiple rows. Common questions include

- how many todo entries are in each category?
- how many entries did a user complete each month?
- what's the average length of a todo entry?

What these queries have in common is that data from multiple rows needs to be combined into a single
row. In sql, this can be achieved with "aggregate functions", for which drift has
[builtin support](expressions.md#aggregate-functions-like-count-and-sum).

_Additional info_: A good tutorial for group by in sql is available [here](https://www.sqlitetutorial.net/sqlite-group-by/).

To write a query that answers the first question for us, we can use the `count` function.
We're going to select all categories and join each todo entry for each category. What's special is that we set
`useColumns: false` on the join. We do that because we're not interested in the columns of the todo item.
We only care about how many there are. By default, drift would attempt to read each todo item when it appears
in a join.

{{ load_snippet('countTodosInCategories','lib/snippets/dart_api/select.dart.excerpt.json') }}

To find the average length of a todo entry, we use `avg`. In this case, we don't even have to use
a `join` since all the data comes from a single table (todos).
That's a problem though - in the join, we used `useColumns: false` because we weren't interested
in the columns of each todo item. Here we don't care about an individual item either, but there's
no join where we could set that flag.
Drift provides a special method for this case - instead of using `select`, we use `selectOnly`.
The "only" means that drift will only report columns we added via "addColumns". In a regular select,
all columns from the table would be selected, which is what you'd usually need.

{{ load_snippet('averageItemLength','lib/snippets/dart_api/select.dart.excerpt.json') }}

## Using selects as inserts

In SQL, an `INSERT INTO SELECT` statement can be used to efficiently insert the rows from a `SELECT`
statement into a table.
It is possible to construct these statements in drift with the `insertFromSelect` method.
This example shows how that method is used to construct a statement that creates a new category
for each todo entry that didn't have one assigned before:

{{ load_snippet('createCategoryForUnassignedTodoEntries','lib/snippets/dart_api/select.dart.excerpt.json') }}

The first parameter for `insertFromSelect` is the select statement statement to use as a source.
Then, the `columns` map maps columns from the table in which rows are inserted to columns from the
select statement.
In the example, the `newDescription` expression as added as a column to the query.
Then, the map entry `categories.description: newDescription` is used so that the `description` column
for new category rows gets set to that expression.

## Subqueries

Starting from drift 2.11, you can use `Subquery` to use an existing select statement as part of more
complex join.

This snippet uses `Subquery` to count how many of the top-10 todo items (by length of their title) are
in each category.
It does this by first creating a select statement for the top-10 items (but not executing it), and then
joining this select statement onto a larger one grouping by category:

{{ load_snippet('subquery','lib/snippets/dart_api/select.dart.excerpt.json') }}

Any statement can be used as a subquery. But be aware that, unlike [subquery expressions](expressions.md#scalar-subqueries), full subqueries can't use tables from the outer select statement.

## JSON support

sqlite3 has great support for [JSON operators](https://sqlite.org/json1.html) that are also available
in drift (under the additional `'package:drift/extensions/json1.dart'` import).
JSON support is helpful when storing a dynamic structure that is best represented with JSON, or when
you have an existing structure (perhaps because you're migrating from a document-based storage)
that you need to support.

As an example, consider a contact book application that started with a JSON structure to store
contacts:

{{ load_snippet('existing','lib/snippets/dart_api/json.dart.excerpt.json') }}

To easily store this contact representation in a drift database, one could use a JSON column:

{{ load_snippet('contacts','lib/snippets/dart_api/json.dart.excerpt.json') }}

Note the `name` column as well: It uses `generatedAs` with the `jsonExtract` function to
extract the `name` field from the JSON value on the fly.
The full syntax for JSON path arguments is explained on the [sqlite3 website](https://sqlite.org/json1.html#path_arguments).

To make the example more complex, let's look at another table storing a log of phone calls:

{{ load_snippet('calls','lib/snippets/dart_api/json.dart.excerpt.json') }}

Let's say we wanted to find the contact for each call, if there is any with a matching phone number.
For this to be expressible in SQL, each `contacts` row would somehow have to be expanded into a row
for each stored phone number.
Luckily, the `json_each` function in sqlite3 can do exactly that, and drift exposes it:

{{ load_snippet('calls-with-contacts','lib/snippets/dart_api/json.dart.excerpt.json') }}

## Selects without tables

Some queries don't need a `FROM` clause at all and instead just select some expressions directly.
An example for this may be a select that just uses subquery expressions, like here to query whether
any rows exist in a table:

{{ load_snippet('hasTodoItem','lib/snippets/dart_api/select.dart.excerpt.json') }}

The `selectExpressions` API is similar to `selectOnly`, except that it doesn't require any table
at all.
Instead, the expressions in the list passed to `selectExpressions` are evaluated in a standalone
select statement and can be parsed from the `TypedResult` class returned when evaluating the
query.

## Compound selects

With compound selects, the results of multiple selects statements can be returned at once.
Different operators are available to apply set operations on queries, namely:

1. `UNION ALL` and `UNION`: Returns the results of two select statements in a select, with
   duplicates included or filtered, respectively.
2. `EXCEPT`: Returns all rows of the first select statement that did not appear in the second
   query.
3. `INTERSECT`: Returns all rows that were returned by both select statements.

As an example, consider the tables used to track todo items introduced [in the article on tables](tables.md#defining-tables). Here, one table stores todo items and another table defines categories
that can be used to group these items.
Now, perhaps you want to query how many items are assigned to each category, as well as the amount
of items not in any category.
The first query can be written with a `groupBy` on categories and a [subquery](expressions.md#subqueries)
to count associated todo items.
When grouping on the categories table though, there will be no "null" group. So, one way to resolve
everything in a single query is to write another query and use `unionAll`:

{{ load_snippet('compound','lib/snippets/dart_api/select.dart.excerpt.json') }}

This query will return one row for each category, counting associated todo items. Also, it includes
a final row without a category description reporting the count of todo items outside of categories.

With all of these operators, all involved queries must return compatible rows. This is because
the queries are ultimately reported as a single result set, so they must return the same column
types.
It is possible to apply a `LIMIT` and `ORDER BY` clause to compound select statements, but only
to the first statement (the one on which `union`, `unionAll`, `except` or `intersect` is called).
