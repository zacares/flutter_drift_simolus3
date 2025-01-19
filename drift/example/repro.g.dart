// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repro.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _someMeta = const VerificationMeta('some');
  @override
  late final GeneratedColumn<String> some = GeneratedColumn<String>(
      'some', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _some2Meta = const VerificationMeta('some2');
  @override
  late final GeneratedColumn<String> some2 = GeneratedColumn<String>(
      'some2', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, some, some2];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('some')) {
      context.handle(
          _someMeta, some.isAcceptableOrUnknown(data['some']!, _someMeta));
    } else if (isInserting) {
      context.missing(_someMeta);
    }
    if (data.containsKey('some2')) {
      context.handle(
          _some2Meta, some2.isAcceptableOrUnknown(data['some2']!, _some2Meta));
    } else if (isInserting) {
      context.missing(_some2Meta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      some: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}some'])!,
      some2: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}some2'])!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> some;
  final Value<String> some2;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.some = const Value.absent(),
    this.some2 = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String some,
    required String some2,
  })  : some = Value(some),
        some2 = Value(some2);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? some,
    Expression<String>? some2,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (some != null) 'some': some,
      if (some2 != null) 'some2': some2,
    });
  }

  UsersCompanion copyWith(
      {Value<int>? id, Value<String>? some, Value<String>? some2}) {
    return UsersCompanion(
      id: id ?? this.id,
      some: some ?? this.some,
      some2: some2 ?? this.some2,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (some.present) {
      map['some'] = Variable<String>(some.value);
    }
    if (some2.present) {
      map['some2'] = Variable<String>(some2.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('some: $some, ')
          ..write('some2: $some2')
          ..write(')'))
        .toString();
  }
}

class _$UserInsertable implements Insertable<User> {
  User _object;
  _$UserInsertable(this._object);
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(_object.id),
      some: Value(_object.some),
      some2: Value(_object.some2),
    ).toColumns(false);
  }
}

extension UserToInsertable on User {
  _$UserInsertable toInsertable() {
    return _$UserInsertable(this);
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  $DatabaseManager get managers => $DatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [users];
}

typedef $$UsersTableCreateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  required String some,
  required String some2,
});
typedef $$UsersTableUpdateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  Value<String> some,
  Value<String> some2,
});

class $$UsersTableFilterComposer extends Composer<_$Database, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get some => $composableBuilder(
      column: $table.some, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get some2 => $composableBuilder(
      column: $table.some2, builder: (column) => ColumnFilters(column));
}

class $$UsersTableOrderingComposer extends Composer<_$Database, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get some => $composableBuilder(
      column: $table.some, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get some2 => $composableBuilder(
      column: $table.some2, builder: (column) => ColumnOrderings(column));
}

class $$UsersTableAnnotationComposer extends Composer<_$Database, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get some =>
      $composableBuilder(column: $table.some, builder: (column) => column);

  GeneratedColumn<String> get some2 =>
      $composableBuilder(column: $table.some2, builder: (column) => column);
}

class $$UsersTableTableManager extends RootTableManager<
    _$Database,
    $UsersTable,
    User,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableAnnotationComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder,
    (User, BaseReferences<_$Database, $UsersTable, User>),
    User,
    PrefetchHooks Function()> {
  $$UsersTableTableManager(_$Database db, $UsersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> some = const Value.absent(),
            Value<String> some2 = const Value.absent(),
          }) =>
              UsersCompanion(
            id: id,
            some: some,
            some2: some2,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String some,
            required String some2,
          }) =>
              UsersCompanion.insert(
            id: id,
            some: some,
            some2: some2,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UsersTableProcessedTableManager = ProcessedTableManager<
    _$Database,
    $UsersTable,
    User,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableAnnotationComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder,
    (User, BaseReferences<_$Database, $UsersTable, User>),
    User,
    PrefetchHooks Function()>;

class $DatabaseManager {
  final _$Database _db;
  $DatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
}
