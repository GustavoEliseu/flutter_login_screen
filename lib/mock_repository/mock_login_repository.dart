import 'package:dio/dio.dart';
import 'package:flutter_login_screen/utils/string_extension.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_login_screen/models/user_data.dart';
import 'dart:convert';

class DioMock extends Mock implements Dio {
  DioMock(BaseOptions options) {
    this.options = options;
  }
}

class LoginRepository {
  final url = "https://myloginmocked.com/api/v1/login";
  LoginRepository();

//TODO - create custom Response class, with status code Constants.

  Future<(String message, int statusCode)> login(User user) async {
    final dio = Dio(BaseOptions());
    final dioAdapter = DioAdapter(dio: dio);
    final DioExceptionType exceptionType;

    final int statusCode;
    String message = "";
    String encodedUser = jsonEncode(
        User(user.name, user.password.toPasswordBinarySafeEncodedString())
            .toJson());
    switch (user.name) {
      case "404":
        statusCode = 404;
        message = "Could not reach the server, check your connection!";
        exceptionType = DioExceptionType.connectionError;
      case "unused":
        statusCode = 403;
        message = "User does not exist!";
        exceptionType = DioExceptionType.badResponse;
      case "invalid":
        statusCode = 403;
        message = "Invalid credentials!";
        exceptionType = DioExceptionType.badResponse;
      case "timeout":
        statusCode = 408;
        message = "Could not reach the server, due to a timeout";
        exceptionType = DioExceptionType.connectionTimeout;
      default:
        statusCode = 200;
        message = "Successful Login!";
        exceptionType = DioExceptionType.unknown;
    }
    bool isError = statusCode != 200;
    final RequestOptions requestOptions =
        RequestOptions(path: url, method: 'POST');

    dioAdapter.onPost(
        url,
        data: encodedUser,
        (server) => {
              if (isError)
                {
                  server.throws(
                    statusCode,
                    DioException(
                        response: Response(
                            requestOptions: requestOptions,
                            statusCode: statusCode,
                            statusMessage: message),
                        requestOptions: requestOptions,
                        error: exceptionType,
                        message: message),
                    delay: const Duration(seconds: 1),
                  )
                }
              else
                {
                  server.reply(
                    statusCode,
                    {'message': message},
                    // Reply would wait for one-sec before returning data.
                    delay: const Duration(seconds: 1),
                  )
                }
            });
    try {
      Response response = await dio.post(url, data: encodedUser);

      String messageToSend = response.statusMessage ?? message;
      int statusToSend = response.statusCode ?? statusCode;

      return (messageToSend, statusToSend);
    } on DioException catch (e) {
      print(e.message);
      String response = e.response?.statusMessage ??
          e.message ??
          "Something went wrong, we could not reach the server!";
      int statusToSend = e.response?.statusCode ?? statusCode;
      return (response, statusToSend);
    } on Exception catch (e) {
      print(e.toString());
      return (message, statusCode);
    }
  }
}
