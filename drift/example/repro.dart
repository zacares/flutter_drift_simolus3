import 'package:drift/drift.dart';

part 'repro.g.dart';

@UseRowClass(User, generateInsertable: true)
class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get some => text()();
  TextColumn get some2 => text()();
}

class User implements Insertable<User> {
  User({required this.id, required this.some, String? some2})
      : some2 = some2 ?? some;

  final int id;
  final String some;
  final String some2;

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    return toInsertable().toColumns(nullToAbsent);
  }
}

@DriftDatabase(tables: [Users])
class Database {}
