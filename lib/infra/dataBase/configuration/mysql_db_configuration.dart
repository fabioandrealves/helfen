import 'package:helfen_bus/infra/http/mapS.dart';
import 'package:mysql1/mysql1.dart';

import '../../logger/custom_logger.dart';
import '../db_configuration.dart';

class MySqlDBConfiguration implements DBConfiguration {
  MySqlConnection? _connection;

  @override
  Future<MySqlConnection> get connection async {
    _connection ??= await createConnection();
    if (_connection == null) {
      throw Exception('[ERROR/DB --> Failed Create Connection');
    }
    return _connection!;
  }

  @override
  Future<MySqlConnection?> createConnection() async {
    try {
      return await MySqlConnection.connect(ConnectionSettings(
        host: 'i9i.h.filess.io',
        port: 3307,
        user: '992888980_writingfew',
        password: Maps.databasePassword,
        db: '992888980_writingfew',
      ));
    } catch (e) {
      CustomLogger.logError("Error to connect database: $e");
    }
    return null;
  }
}
