import 'package:http_interceptor/http/interceptor_contract.dart';
import 'package:http_interceptor/models/request_data.dart';
import 'package:http_interceptor/models/response_data.dart';

import 'custom_logger.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    CustomLogger.logInfo("Sending request");
    CustomLogger.logToLogcat(
        tag: "RequestData",
        subTag: "interceptRequest",
        message: "Requisição para: ${data.baseUrl}\n${data.headers}",
        logLevel: AndroidLogLevel.verbose);
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    CustomLogger.logInfo("Receiving response");
    if (data.statusCode ~/ 100 == 2) {
      CustomLogger.logToLogcat(
          tag: "ResponseData",
          subTag: "interceptResponse",
          message:
              "Resposta de ${data.url}\n${data.headers}\n${data.statusCode}\n ${data.body}",
          logLevel: AndroidLogLevel.info);
    } else {
      CustomLogger.logToLogcat(
          tag: "ResponseData",
          subTag: "interceptResponse",
          message:
              "Resposta de ${data.url}\n${data.headers}\n${data.statusCode}\n ${data.body}",
          logLevel: AndroidLogLevel.error);
    }
    return data;
  }
}
