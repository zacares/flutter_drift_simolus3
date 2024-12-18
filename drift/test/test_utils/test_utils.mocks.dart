// Mocks generated by Mockito 5.4.5 from annotations
// in drift/test/test_utils/test_utils.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:drift/drift.dart' as _i6;
import 'package:drift/src/runtime/executor/helpers/delegates.dart' as _i3;
import 'package:drift/src/runtime/executor/helpers/results.dart' as _i2;
import 'package:drift/src/runtime/executor/stream_queries.dart' as _i7;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i4;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeQueryResult_0 extends _i1.SmartFake implements _i2.QueryResult {
  _FakeQueryResult_0(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

/// A class which mocks [DatabaseDelegate].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseDelegate extends _i1.Mock implements _i3.DatabaseDelegate {
  @override
  bool get isInTransaction =>
      (super.noSuchMethod(
            Invocation.getter(#isInTransaction),
            returnValue: false,
            returnValueForMissingStub: false,
          )
          as bool);

  @override
  set isInTransaction(bool? _isInTransaction) => super.noSuchMethod(
    Invocation.setter(#isInTransaction, _isInTransaction),
    returnValueForMissingStub: null,
  );

  @override
  _i3.DbVersionDelegate get versionDelegate =>
      (super.noSuchMethod(
            Invocation.getter(#versionDelegate),
            returnValue: _i4.dummyValue<_i3.DbVersionDelegate>(
              this,
              Invocation.getter(#versionDelegate),
            ),
            returnValueForMissingStub: _i4.dummyValue<_i3.DbVersionDelegate>(
              this,
              Invocation.getter(#versionDelegate),
            ),
          )
          as _i3.DbVersionDelegate);

  @override
  _i3.TransactionDelegate get transactionDelegate =>
      (super.noSuchMethod(
            Invocation.getter(#transactionDelegate),
            returnValue: _i4.dummyValue<_i3.TransactionDelegate>(
              this,
              Invocation.getter(#transactionDelegate),
            ),
            returnValueForMissingStub: _i4.dummyValue<_i3.TransactionDelegate>(
              this,
              Invocation.getter(#transactionDelegate),
            ),
          )
          as _i3.TransactionDelegate);

  @override
  _i5.FutureOr<bool> get isOpen =>
      (super.noSuchMethod(
            Invocation.getter(#isOpen),
            returnValue: _i5.Future<bool>.value(false),
            returnValueForMissingStub: _i5.Future<bool>.value(false),
          )
          as _i5.FutureOr<bool>);

  @override
  _i5.Future<void> open(_i6.QueryExecutorUser? db) =>
      (super.noSuchMethod(
            Invocation.method(#open, [db]),
            returnValue: _i5.Future<void>.value(),
            returnValueForMissingStub: _i5.Future<void>.value(),
          )
          as _i5.Future<void>);

  @override
  _i5.Future<void> close() =>
      (super.noSuchMethod(
            Invocation.method(#close, []),
            returnValue: _i5.Future<void>.value(),
            returnValueForMissingStub: _i5.Future<void>.value(),
          )
          as _i5.Future<void>);

  @override
  void notifyDatabaseOpened(_i6.OpeningDetails? details) => super.noSuchMethod(
    Invocation.method(#notifyDatabaseOpened, [details]),
    returnValueForMissingStub: null,
  );

  @override
  _i5.Future<_i2.QueryResult> runSelect(
    String? statement,
    List<Object?>? args,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#runSelect, [statement, args]),
            returnValue: _i5.Future<_i2.QueryResult>.value(
              _FakeQueryResult_0(
                this,
                Invocation.method(#runSelect, [statement, args]),
              ),
            ),
            returnValueForMissingStub: _i5.Future<_i2.QueryResult>.value(
              _FakeQueryResult_0(
                this,
                Invocation.method(#runSelect, [statement, args]),
              ),
            ),
          )
          as _i5.Future<_i2.QueryResult>);

  @override
  _i5.Future<int> runUpdate(String? statement, List<Object?>? args) =>
      (super.noSuchMethod(
            Invocation.method(#runUpdate, [statement, args]),
            returnValue: _i5.Future<int>.value(0),
            returnValueForMissingStub: _i5.Future<int>.value(0),
          )
          as _i5.Future<int>);

  @override
  _i5.Future<int> runInsert(String? statement, List<Object?>? args) =>
      (super.noSuchMethod(
            Invocation.method(#runInsert, [statement, args]),
            returnValue: _i5.Future<int>.value(0),
            returnValueForMissingStub: _i5.Future<int>.value(0),
          )
          as _i5.Future<int>);

  @override
  _i5.Future<void> runCustom(String? statement, List<Object?>? args) =>
      (super.noSuchMethod(
            Invocation.method(#runCustom, [statement, args]),
            returnValue: _i5.Future<void>.value(),
            returnValueForMissingStub: _i5.Future<void>.value(),
          )
          as _i5.Future<void>);

  @override
  _i5.Future<void> runBatched(_i6.BatchedStatements? statements) =>
      (super.noSuchMethod(
            Invocation.method(#runBatched, [statements]),
            returnValue: _i5.Future<void>.value(),
            returnValueForMissingStub: _i5.Future<void>.value(),
          )
          as _i5.Future<void>);
}

/// A class which mocks [DynamicVersionDelegate].
///
/// See the documentation for Mockito's code generation for more information.
class MockDynamicVersionDelegate extends _i1.Mock
    implements _i3.DynamicVersionDelegate {
  @override
  _i5.Future<int> get schemaVersion =>
      (super.noSuchMethod(
            Invocation.getter(#schemaVersion),
            returnValue: _i5.Future<int>.value(0),
            returnValueForMissingStub: _i5.Future<int>.value(0),
          )
          as _i5.Future<int>);

  @override
  _i5.Future<void> setSchemaVersion(int? version) =>
      (super.noSuchMethod(
            Invocation.method(#setSchemaVersion, [version]),
            returnValue: _i5.Future<void>.value(),
            returnValueForMissingStub: _i5.Future<void>.value(),
          )
          as _i5.Future<void>);
}

/// A class which mocks [SupportedTransactionDelegate].
///
/// See the documentation for Mockito's code generation for more information.
class MockSupportedTransactionDelegate extends _i1.Mock
    implements _i3.SupportedTransactionDelegate {
  @override
  bool get managesLockInternally =>
      (super.noSuchMethod(
            Invocation.getter(#managesLockInternally),
            returnValue: false,
            returnValueForMissingStub: false,
          )
          as bool);

  @override
  _i5.FutureOr<void> startTransaction(
    _i5.Future<dynamic> Function(_i3.QueryDelegate)? run,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#startTransaction, [run]),
            returnValueForMissingStub: null,
          )
          as _i5.FutureOr<void>);
}

/// A class which mocks [StreamQueryStore].
///
/// See the documentation for Mockito's code generation for more information.
class MockStreamQueries extends _i1.Mock implements _i7.StreamQueryStore {
  @override
  _i5.Stream<T> registerStream<T extends Object>(
    _i7.QueryStreamFetcher<T>? fetcher,
    _i6.DatabaseConnectionUser? database,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#registerStream, [fetcher, database]),
            returnValue: _i5.Stream<T>.empty(),
            returnValueForMissingStub: _i5.Stream<T>.empty(),
          )
          as _i5.Stream<T>);

  @override
  _i5.Stream<Set<_i6.TableUpdate>> updatesForSync(
    _i6.TableUpdateQuery? query,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#updatesForSync, [query]),
            returnValue: _i5.Stream<Set<_i6.TableUpdate>>.empty(),
            returnValueForMissingStub: _i5.Stream<Set<_i6.TableUpdate>>.empty(),
          )
          as _i5.Stream<Set<_i6.TableUpdate>>);

  @override
  void handleTableUpdates(Set<_i6.TableUpdate>? updates) => super.noSuchMethod(
    Invocation.method(#handleTableUpdates, [updates]),
    returnValueForMissingStub: null,
  );

  @override
  void markAsClosed(
    _i7.QueryStream<Object>? stream,
    void Function()? whenRemoved,
  ) => super.noSuchMethod(
    Invocation.method(#markAsClosed, [stream, whenRemoved]),
    returnValueForMissingStub: null,
  );

  @override
  void markAsOpened(_i7.QueryStream<Object>? stream) => super.noSuchMethod(
    Invocation.method(#markAsOpened, [stream]),
    returnValueForMissingStub: null,
  );

  @override
  _i5.Future<void> close() =>
      (super.noSuchMethod(
            Invocation.method(#close, []),
            returnValue: _i5.Future<void>.value(),
            returnValueForMissingStub: _i5.Future<void>.value(),
          )
          as _i5.Future<void>);
}
