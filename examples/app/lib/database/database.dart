import 'package:drift/drift.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:riverpod/riverpod.dart';

import 'connection/connection.dart' as impl;
import 'tables.dart';

// Generated by drift_dev when running `build_runner build`
part 'database.g.dart';

@DriftDatabase(tables: [TodoEntries, Categories], include: {'sql.drift'})
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(impl.connect());

  AppDatabase.forTesting(DatabaseConnection connection) : super(connection);

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onUpgrade: ((m, from, to) async {
        for (var step = from + 1; step <= to; step++) {
          switch (step) {
            case 2:
              // The todoEntries.dueDate column was added in version 2.
              await m.addColumn(todoEntries, todoEntries.dueDate);
              break;
            case 3:
              // New triggers were added in version 3:
              await m.create(todosDelete);
              await m.create(todosUpdate);

              // Also, the `REFERENCES` constraint was added to
              // [TodoEntries.category]. Run a table migration to rebuild all
              // column constraints without loosing data.
              await m.alterTable(TableMigration(todoEntries));
              break;
          }
        }
      }),
      beforeOpen: (details) async {
        // Make sure that foreign keys are enabled
        await customStatement('PRAGMA foreign_keys = ON');

        if (details.wasCreated) {
          // Create a bunch of default values so the app doesn't look too empty
          // on the first start.
          await batch((b) {
            b.insert(
              categories,
              CategoriesCompanion.insert(name: 'Important', color: Colors.red),
            );

            b.insertAll(todoEntries, [
              TodoEntriesCompanion.insert(description: 'Check out drift'),
              TodoEntriesCompanion.insert(
                  description: 'Fix session invalidation bug',
                  category: const Value(1)),
              TodoEntriesCompanion.insert(
                  description: 'Add favorite movies to home page'),
            ]);
          });
        }

        // This follows the recommendation to validate that the database schema
        // matches what drift expects (https://drift.simonbinder.eu/docs/advanced-features/migrations/#verifying-a-database-schema-at-runtime).
        // It allows catching bugs in the migration logic early.
        await impl.validateDatabaseSchema(this);
      },
    );
  }

  Future<List<TodoEntryWithCategory>> search(String query) {
    return _search(query).map((row) {
      return TodoEntryWithCategory(entry: row.todos, category: row.cat);
    }).get();
  }

  Stream<List<CategoryWithCount>> categoriesWithCount() {
    // the _categoriesWithCount method has been generated automatically based
    // on the query declared in the @DriftDatabase annotation
    return _categoriesWithCount().map((row) {
      final hasId = row.id != null;
      final category = hasId
          ? Category(id: row.id!, name: row.name!, color: row.color!)
          : null;

      return CategoryWithCount(category, row.amount);
    }).watch();
  }

  /// Returns an auto-updating stream of all todo entries in a given category
  /// id.
  Stream<List<TodoEntryWithCategory>> entriesInCategory(int? categoryId) {
    final query = select(todoEntries).join([
      leftOuterJoin(categories, categories.id.equalsExp(todoEntries.category))
    ]);

    if (categoryId != null) {
      query.where(categories.id.equals(categoryId));
    } else {
      query.where(categories.id.isNull());
    }

    return query.map((row) {
      return TodoEntryWithCategory(
        entry: row.readTable(todoEntries),
        category: row.readTableOrNull(categories),
      );
    }).watch();
  }

  Future<void> deleteCategory(Category category) {
    return transaction(() async {
      // First, move todo entries that might remain into the default category
      await (todoEntries.update()
            ..where((todo) => todo.category.equals(category.id)))
          .write(const TodoEntriesCompanion(category: Value(null)));

      // Then, delete the category
      await categories.deleteOne(category);
    });
  }

  static final StateProvider<AppDatabase> provider = StateProvider((ref) {
    final database = AppDatabase();
    ref.onDispose(database.close);

    return database;
  });
}

class TodoEntryWithCategory {
  final TodoEntry entry;
  final Category? category;

  TodoEntryWithCategory({required this.entry, this.category});
}

class CategoryWithCount {
  // can be null, in which case we count how many entries don't have a category
  final Category? category;
  final int count; // amount of entries in this category

  CategoryWithCount(this.category, this.count);
}
