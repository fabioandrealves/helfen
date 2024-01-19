import 'package:helfen_bus/http/logger/custom_logger.dart';
import 'package:http_interceptor/http/interceptor_contract.dart';
import 'package:http_interceptor/models/request_data.dart';
import 'package:http_interceptor/models/response_data.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    CustomLogger.logInfo("Calling");
    CustomLogger.logToLogcat(
        tag: "RequestData",
        subTag: "interceptRequest",
        message: "Getting connection to ${data.baseUrl}\n${data.headers}",
        logLevel: AndroidLogLevel.verbose);
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    if (data.statusCode ~/ 100 == 2) {
      CustomLogger.logInfo("Sucess");
      CustomLogger.logToLogcat(
          tag: "ResponseData",
          subTag: "interceptResponse",
          message:
              "Response from ${data.url}\n${data.headers}\n${data.statusCode}\n ${data.body}",
          logLevel: AndroidLogLevel.info);
    } else {
      CustomLogger.logError("Error");
      CustomLogger.logToLogcat(
          tag: "ResponseData",
          subTag: "interceptResponse",
          message:
              "Response from ${data.url}\n${data.headers}\n${data.statusCode}\n ${data.body}",
          logLevel: AndroidLogLevel.error);
    }
    return data;
  }
}
