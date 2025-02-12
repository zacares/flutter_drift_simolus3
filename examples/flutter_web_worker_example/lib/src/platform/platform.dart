import 'package:drift/drift.dart';

import 'platform_stub.dart'
    if (dart.library.io) 'platform_app.dart'
    if (dart.library.js_interop) 'platform_web.dart';

class Platform {
  static QueryExecutor createDatabaseConnection(String databaseName) =>
      PlatformInterface.createDatabaseConnection(databaseName);
}
