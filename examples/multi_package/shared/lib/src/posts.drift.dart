// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:shared/src/posts.drift.dart' as i1;
import 'package:drift/internal/modular.dart' as i2;
import 'package:shared/src/users.drift.dart' as i3;

typedef $PostsCreateCompanionBuilder = i1.PostsCompanion Function({
  required int author,
  i0.Value<String?> content,
  i0.Value<int> rowid,
});
typedef $PostsUpdateCompanionBuilder = i1.PostsCompanion Function({
  i0.Value<int> author,
  i0.Value<String?> content,
  i0.Value<int> rowid,
});

final class $PostsReferences
    extends i0.BaseReferences<i0.GeneratedDatabase, i1.Posts, i1.Post> {
  $PostsReferences(super.$_db, super.$_table, super.$_typedResult);

  static i3.$UsersTable _authorTable(i0.GeneratedDatabase db) =>
      i2.ReadDatabaseContainer(db)
          .resultSet<i3.$UsersTable>('users')
          .createAlias(i0.$_aliasNameGenerator(
              i2.ReadDatabaseContainer(db).resultSet<i1.Posts>('posts').author,
              i2.ReadDatabaseContainer(db)
                  .resultSet<i3.$UsersTable>('users')
                  .id));

  i3.$$UsersTableProcessedTableManager get author {
    final $_column = $_itemColumn<int>('author')!;

    final manager = i3
        .$$UsersTableTableManager($_db,
            i2.ReadDatabaseContainer($_db).resultSet<i3.$UsersTable>('users'))
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_authorTable($_db));
    if (item == null) return manager;
    return i0.ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $PostsFilterComposer extends i0.Composer<i0.GeneratedDatabase, i1.Posts> {
  $PostsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => i0.ColumnFilters(column));

  i3.$$UsersTableFilterComposer get author {
    final i3.$$UsersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.author,
        referencedTable:
            i2.ReadDatabaseContainer($db).resultSet<i3.$UsersTable>('users'),
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            i3.$$UsersTableFilterComposer(
              $db: $db,
              $table: i2.ReadDatabaseContainer($db)
                  .resultSet<i3.$UsersTable>('users'),
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $PostsOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.Posts> {
  $PostsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => i0.ColumnOrderings(column));

  i3.$$UsersTableOrderingComposer get author {
    final i3.$$UsersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.author,
        referencedTable:
            i2.ReadDatabaseContainer($db).resultSet<i3.$UsersTable>('users'),
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            i3.$$UsersTableOrderingComposer(
              $db: $db,
              $table: i2.ReadDatabaseContainer($db)
                  .resultSet<i3.$UsersTable>('users'),
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $PostsAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.Posts> {
  $PostsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  i3.$$UsersTableAnnotationComposer get author {
    final i3.$$UsersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.author,
        referencedTable:
            i2.ReadDatabaseContainer($db).resultSet<i3.$UsersTable>('users'),
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            i3.$$UsersTableAnnotationComposer(
              $db: $db,
              $table: i2.ReadDatabaseContainer($db)
                  .resultSet<i3.$UsersTable>('users'),
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $PostsTableManager extends i0.RootTableManager<
    i0.GeneratedDatabase,
    i1.Posts,
    i1.Post,
    i1.$PostsFilterComposer,
    i1.$PostsOrderingComposer,
    i1.$PostsAnnotationComposer,
    $PostsCreateCompanionBuilder,
    $PostsUpdateCompanionBuilder,
    (i1.Post, i1.$PostsReferences),
    i1.Post,
    i0.PrefetchHooks Function({bool author})> {
  $PostsTableManager(i0.GeneratedDatabase db, i1.Posts table)
      : super(i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i1.$PostsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              i1.$PostsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              i1.$PostsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            i0.Value<int> author = const i0.Value.absent(),
            i0.Value<String?> content = const i0.Value.absent(),
            i0.Value<int> rowid = const i0.Value.absent(),
          }) =>
              i1.PostsCompanion(
            author: author,
            content: content,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required int author,
            i0.Value<String?> content = const i0.Value.absent(),
            i0.Value<int> rowid = const i0.Value.absent(),
          }) =>
              i1.PostsCompanion.insert(
            author: author,
            content: content,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), i1.$PostsReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({author = false}) {
            return i0.PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends i0.TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (author) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.author,
                    referencedTable: i1.$PostsReferences._authorTable(db),
                    referencedColumn: i1.$PostsReferences._authorTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $PostsProcessedTableManager = i0.ProcessedTableManager<
    i0.GeneratedDatabase,
    i1.Posts,
    i1.Post,
    i1.$PostsFilterComposer,
    i1.$PostsOrderingComposer,
    i1.$PostsAnnotationComposer,
    $PostsCreateCompanionBuilder,
    $PostsUpdateCompanionBuilder,
    (i1.Post, i1.$PostsReferences),
    i1.Post,
    i0.PrefetchHooks Function({bool author})>;

class Posts extends i0.Table with i0.TableInfo<Posts, i1.Post> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  Posts(this.attachedDatabase, [this._alias]);
  static const i0.VerificationMeta _authorMeta =
      const i0.VerificationMeta('author');
  late final i0.GeneratedColumn<int> author = i0.GeneratedColumn<int>(
      'author', aliasedName, false,
      type: i0.DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES users(id)');
  static const i0.VerificationMeta _contentMeta =
      const i0.VerificationMeta('content');
  late final i0.GeneratedColumn<String> content = i0.GeneratedColumn<String>(
      'content', aliasedName, true,
      type: i0.DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<i0.GeneratedColumn> get $columns => [author, content];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'posts';
  @override
  i0.VerificationContext validateIntegrity(i0.Insertable<i1.Post> instance,
      {bool isInserting = false}) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('author')) {
      context.handle(_authorMeta,
          author.isAcceptableOrUnknown(data['author']!, _authorMeta));
    } else if (isInserting) {
      context.missing(_authorMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => const {};
  @override
  i1.Post map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.Post(
      author: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.int, data['${effectivePrefix}author'])!,
      content: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}content']),
    );
  }

  @override
  Posts createAlias(String alias) {
    return Posts(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class Post extends i0.DataClass implements i0.Insertable<i1.Post> {
  final int author;
  final String? content;
  const Post({required this.author, this.content});
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['author'] = i0.Variable<int>(author);
    if (!nullToAbsent || content != null) {
      map['content'] = i0.Variable<String>(content);
    }
    return map;
  }

  i1.PostsCompanion toCompanion(bool nullToAbsent) {
    return i1.PostsCompanion(
      author: i0.Value(author),
      content: content == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(content),
    );
  }

  factory Post.fromJson(Map<String, dynamic> json,
      {i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return Post(
      author: serializer.fromJson<int>(json['author']),
      content: serializer.fromJson<String?>(json['content']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'author': serializer.toJson<int>(author),
      'content': serializer.toJson<String?>(content),
    };
  }

  i1.Post copyWith(
          {int? author, i0.Value<String?> content = const i0.Value.absent()}) =>
      i1.Post(
        author: author ?? this.author,
        content: content.present ? content.value : this.content,
      );
  Post copyWithCompanion(i1.PostsCompanion data) {
    return Post(
      author: data.author.present ? data.author.value : this.author,
      content: data.content.present ? data.content.value : this.content,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Post(')
          ..write('author: $author, ')
          ..write('content: $content')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(author, content);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.Post &&
          other.author == this.author &&
          other.content == this.content);
}

class PostsCompanion extends i0.UpdateCompanion<i1.Post> {
  final i0.Value<int> author;
  final i0.Value<String?> content;
  final i0.Value<int> rowid;
  const PostsCompanion({
    this.author = const i0.Value.absent(),
    this.content = const i0.Value.absent(),
    this.rowid = const i0.Value.absent(),
  });
  PostsCompanion.insert({
    required int author,
    this.content = const i0.Value.absent(),
    this.rowid = const i0.Value.absent(),
  }) : author = i0.Value(author);
  static i0.Insertable<i1.Post> custom({
    i0.Expression<int>? author,
    i0.Expression<String>? content,
    i0.Expression<int>? rowid,
  }) {
    return i0.RawValuesInsertable({
      if (author != null) 'author': author,
      if (content != null) 'content': content,
      if (rowid != null) 'rowid': rowid,
    });
  }

  i1.PostsCompanion copyWith(
      {i0.Value<int>? author,
      i0.Value<String?>? content,
      i0.Value<int>? rowid}) {
    return i1.PostsCompanion(
      author: author ?? this.author,
      content: content ?? this.content,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (author.present) {
      map['author'] = i0.Variable<int>(author.value);
    }
    if (content.present) {
      map['content'] = i0.Variable<String>(content.value);
    }
    if (rowid.present) {
      map['rowid'] = i0.Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PostsCompanion(')
          ..write('author: $author, ')
          ..write('content: $content, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class PostsDrift extends i2.ModularAccessor {
  PostsDrift(i0.GeneratedDatabase db) : super(db);
  i0.Selectable<AllPostsResult> allPosts({required AllPosts$limit limit}) {
    var $arrayStartIndex = 1;
    final generatedlimit = $write(
        limit(this.posts, alias(this.users, 'author')),
        hasMultipleTables: true,
        startIndex: $arrayStartIndex);
    $arrayStartIndex += generatedlimit.amountOfVariables;
    return customSelect(
        'SELECT"posts"."author" AS "nested_0.author", "posts"."content" AS "nested_0.content","author"."id" AS "nested_1.id", "author"."name" AS "nested_1.name" FROM posts INNER JOIN users AS author ON author.id = posts.author ${generatedlimit.sql}',
        variables: [
          ...generatedlimit.introducedVariables
        ],
        readsFrom: {
          posts,
          users,
          ...generatedlimit.watchedTables,
        }).asyncMap((i0.QueryRow row) async => AllPostsResult(
          posts: await posts.mapFromRow(row, tablePrefix: 'nested_0'),
          author: await users.mapFromRow(row, tablePrefix: 'nested_1'),
        ));
  }

  i1.Posts get posts =>
      i2.ReadDatabaseContainer(attachedDatabase).resultSet<i1.Posts>('posts');
  i3.$UsersTable get users => i2.ReadDatabaseContainer(attachedDatabase)
      .resultSet<i3.$UsersTable>('users');
}

class AllPostsResult {
  final i1.Post posts;
  final i3.User author;
  AllPostsResult({
    required this.posts,
    required this.author,
  });
}

typedef AllPosts$limit = i0.Limit Function(
    i1.Posts posts, i3.$UsersTable author);
