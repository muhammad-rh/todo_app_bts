part of '../class/app_env.dart';

class AppApi {
  static const String baseURL = 'http://94.74.86.174:8080/api';

  static Future<bool> keepToken({
    required String token,
    required String username,
    required String password,
  }) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    storage.setString('username', username);
    storage.setString('password', password);
    return storage.setString("token", token);
  }

  static Future<void> removeToken(BuildContext context) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    storage.remove("nik");
    storage.remove("password");
    storage.remove("token");

    // ignore: use_build_context_synchronously
    context.removeToNamed(route: AppRoute.loginPage.path);
  }

  static Future<bool> setAuth({required String value}) async {
    return (await SharedPreferences.getInstance())
        .setString('DATA_CURRENT_USER', value);
  }

  static Future get<T extends Object>(
      {required String path,
      bool withToken = true,
      Map<String, dynamic>? param}) async {
    if (withToken) {
      SharedPreferences storage = await SharedPreferences.getInstance();
      String? token = storage.getString("token");
      try {
        final response = await Dio().get<T>(
          baseURL + path,
          queryParameters: param,
          options: Options(
              headers: {
                "Authorization": "Bearer ${token!}",
                "Accept": "application/json"
              },
              receiveTimeout: AppConstant.timeout,
              sendTimeout: AppConstant.timeout),
        );
        return _returnResponse(response);
      } on DioException catch (e) {
        if (e.response!.statusCode! >= 500) {
          return _returnResponse(e.response!);
        } else {
          return e.response!;
        }
      }
    } else {
      try {
        final response = await Dio().get<T>(
          baseURL + path,
          queryParameters: param,
          options: Options(
            headers: {
              "Accept": "application/json",
            },
            receiveTimeout: AppConstant.timeout,
            sendTimeout: AppConstant.timeout,
          ),
        );
        return _returnResponse(response);
      } on DioException catch (e) {
        return _returnResponse(e.response!);
      }
    }
  }

  static Future post<T extends Object>(
      {required String path,
      bool withToken = true,
      int minute = 1,
      dynamic formdata,
      Map<String, dynamic>? param}) async {
    if (withToken) {
      SharedPreferences storage = await SharedPreferences.getInstance();
      String? token = storage.getString("token");
      try {
        final response = await Dio().post<T>(baseURL + path,
            queryParameters: param,
            options: Options(
                headers: {
                  "Authorization": "Bearer ${token!}",
                  "Accept": "application/json"
                },
                receiveTimeout: AppConstant.timeout,
                sendTimeout: AppConstant.timeout),
            data: formdata);
        return _returnResponse(response);
      } on DioException catch (e) {
        if (e.response!.statusCode! >= 500) {
          return _returnResponse(e.response!);
        } else {
          return e.response;
        }
      }
    } else {
      try {
        final response = await Dio().post(
          baseURL + path,
          data: formdata,
          options: Options(
            headers: {
              "Accept": "application/json",
            },
            receiveTimeout: AppConstant.timeout,
            sendTimeout: AppConstant.timeout,
          ),
        );

        return _returnResponse(response);
      } on DioException catch (e) {
        if (e.response!.statusCode! >= 500) {
          return _returnResponse(e.response!);
        } else {
          return e.response;
        }
      }
    }
  }

  static Future put<T extends Object>(
      {required String path,
      bool withToken = true,
      Map<String, dynamic>? formdata,
      Map<String, dynamic>? param}) async {
    if (withToken) {
      SharedPreferences storage = await SharedPreferences.getInstance();
      String? token = storage.getString("token");
      try {
        final response = await Dio().put<T>(baseURL + path,
            queryParameters: param,
            options: Options(
                headers: {
                  "Authorization": "Bearer ${token!}",
                  "Accept": "application/json"
                },
                receiveTimeout: AppConstant.timeout,
                sendTimeout: AppConstant.timeout),
            data: formdata != null ? FormData.fromMap(formdata) : null);
        return _returnResponse(response);
      } on DioException catch (e) {
        if (e.response!.statusCode! >= 500) {
          return _returnResponse(e.response!);
        } else {
          return e.response!;
        }
      }
    } else {
      try {
        final response = await Dio().put<T>(
          baseURL + path,
          queryParameters: param,
          data: formdata != null ? FormData.fromMap(formdata) : null,
          options: Options(
            headers: {
              "Accept": "application/json",
            },
            receiveTimeout: AppConstant.timeout,
            sendTimeout: AppConstant.timeout,
          ),
        );
        return _returnResponse(response);
      } on DioException catch (e) {
        if (e.response!.statusCode! >= 500) {
          return _returnResponse(e.response!);
        } else {
          return e.response!;
        }
      }
    }
  }

  static delete<T extends Object>(
      {required String path, bool withToken = true}) async {
    if (withToken) {
      SharedPreferences storage = await SharedPreferences.getInstance();
      String? token = storage.getString("token");
      try {
        final response = await Dio().delete<T>(
          baseURL + path,
          options: Options(
              headers: {
                "Authorization": "Bearer ${token!}",
                "Accept": "application/json",
              },
              receiveTimeout: AppConstant.timeout,
              sendTimeout: AppConstant.timeout),
        );
        return _returnResponse(response);
      } on DioException catch (e) {
        return _returnResponse(e.response!);
      }
    } else {
      try {
        final response = await Dio().delete<T>(
          baseURL + path,
          options: Options(
            headers: {
              "Accept": "application/json",
            },
            receiveTimeout: AppConstant.timeout,
            sendTimeout: AppConstant.timeout,
          ),
        );
        return _returnResponse(response);
      } on DioException catch (e) {
        return _returnResponse(e.response!);
      }
    }
  }
}

dynamic _returnResponse(Response<dynamic> response) {
  switch (response.statusCode) {
    case 200:
      return response;
    case 201:
      return response;
    case 400:
      throw BadRequestException(response.data['message']);
    case 401:
      throw UnauthorizedException(response.data['message']);
    case 403:
      throw ForbiddenException(response.data['message']);
    case 404:
      throw BadRequestException(response.data);
    case 500:
      throw FetchDataException('Internal Server Error');
    default:
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode: ${response.statusCode}');
  }
}

class AppException implements Exception {
  final String? details;

  AppException({this.details});

  @override
  String toString() {
    return '$details';
  }
}

class FetchDataException extends AppException {
  FetchDataException(String? details) : super(details: details);
}

class BadRequestException extends AppException {
  BadRequestException(String? details) : super(details: details);
}

class UnauthorizedException extends AppException {
  UnauthorizedException(String? details) : super(details: details);
}

class ForbiddenException extends AppException {
  ForbiddenException(String? details) : super(details: details);
}

class InvalidInputException extends AppException {
  InvalidInputException(String? details) : super(details: details);
}

class AuthenticationException extends AppException {
  AuthenticationException(String? details) : super(details: details);
}

class TimeOutException extends AppException {
  TimeOutException(String? details) : super(details: details);
}
