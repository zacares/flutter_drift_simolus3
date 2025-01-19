import 'package:test/test.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:drift/src/sqlite3/database_tracker.dart';

void main() {
  late DatabaseTracker tracker;

  setUp(() {
    tracker = DatabaseTracker();
  });

  tearDown(() {
    tracker.dispose();
  });

  test('tracks and closes existing database connections', () {
    // Open two in-memory SQLite databases.
    final db1 = sqlite3.openInMemory();
    final db2 = sqlite3.openInMemory();

    // Register each database with the tracker.
    tracker.markOpened('db1_path', db1);
    tracker.markOpened('db2_path', db2);

    // Use the tracker to close all tracked connections.
    tracker.closeExisting();

    // After closing, further queries should throw an error.
    expect(
      () => db1.execute('INSERT INTO test1 (id) VALUES (1)'),
      throwsA(anything),
    );
    expect(
      () => db2.execute('INSERT INTO test2 (id) VALUES (2)'),
      throwsA(anything),
    );
  });

  test('throws StateError after disposal', () {
    // Dispose immediately
    tracker.dispose();

    // Any usage of the tracker after dispose should throw a StateError.
    expect(
      () => tracker.markOpened('test', sqlite3.openInMemory()),
      throwsStateError,
    );
    expect(() => tracker.closeExisting(), throwsStateError);
  });

  test('multiple calls to dispose are safe', () {
    // Dispose can be called multiple times without throwing errors.
    expect(() => tracker.dispose(), returnsNormally);
    expect(() => tracker.dispose(), returnsNormally);
  });

  test('isDisposed reflects tracker state', () {
    expect(tracker.isDisposed, isFalse);

    tracker.dispose();
    expect(tracker.isDisposed, isTrue);
  });
}
