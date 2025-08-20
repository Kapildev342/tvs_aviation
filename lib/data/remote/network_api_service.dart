import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:tvsaviation/resources/constants.dart';

import 'app_exception.dart';
import 'base_api_service.dart';

class NetworkApiService extends BaseApiService {
  @override
  Future<dynamic> getLogin({required String url, required String userName, required String password, required String fcmToken}) async {
    dynamic responseJson;
    try {
      Map<String, dynamic> body = {"email": userName, "password": password, "fcmToken": fcmToken};
      var uri = Uri.parse(baseUrl + versionAuth + url);
      final response = await http.post(uri, body: body);
      responseJson = returnResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> getLogout({required String url}) async {
    dynamic responseJson;
    try {
      var uri = Uri.parse(baseUrl + versionAuth + url);
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      final response = await http.post(uri, headers: headers);
      responseJson = returnResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> sendOtp({required String url, required String email}) async {
    dynamic responseJson;
    try {
      Map<String, dynamic> body = {"email": email};
      var uri = Uri.parse(baseUrl + versionAuth + url);
      final response = await http.post(uri, body: body);
      responseJson = returnResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> otpValidation({required String url, required String email, required String otp}) async {
    dynamic responseJson;
    try {
      Map<String, dynamic> body = {"email": email, "verificationCode": otp};
      var uri = Uri.parse(baseUrl + versionAuth + url);
      final response = await http.post(uri, body: body);
      responseJson = returnResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> sendOtpResend({required String url, required String email}) async {
    dynamic responseJson;
    try {
      Map<String, dynamic> body = {"email": email};
      var uri = Uri.parse(baseUrl + versionAuth + url);
      final response = await http.post(uri, body: body);
      responseJson = returnResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> createPassword({required String url, required String email, required String password}) async {
    dynamic responseJson;
    try {
      Map<String, dynamic> body = {
        "email": email,
        "newPassword": password,
      };
      var uri = Uri.parse(baseUrl + versionAuth + url);
      final response = await http.post(uri, body: body);
      responseJson = returnResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> getLocation({required String url}) async {
    dynamic responseJson;
    try {
      var uri = Uri.parse(baseUrl + versionLocation + url);
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      final response = await http.get(uri, headers: headers);
      responseJson = returnResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> getNotification({required String url, required String locationId, required String category}) async {
    dynamic responseJson;
    try {
      var uri = Uri.parse(baseUrl + versionNotifications + url);
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, String> body = {"locationId": locationId, "category": category};
      final response = await http.post(uri, headers: headers, body: body);
      responseJson = returnResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> getNotificationCount({required String url}) async {
    dynamic responseJson;
    try {
      var uri = Uri.parse(baseUrl + versionNotifications + url);
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      final response = await http.get(uri, headers: headers);
      responseJson = returnResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> readNotification({required String url, required String notificationId}) async {
    dynamic responseJson;
    try {
      var uri = Uri.parse(baseUrl + versionNotifications + url);
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, String> body = {"id": notificationId};
      final response = await http.post(uri, headers: headers, body: body);
      responseJson = returnResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> getSector({required String url}) async {
    dynamic responseJson;
    try {
      var uri = Uri.parse(baseUrl + versionSector + url);
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      final response = await http.get(uri, headers: headers);
      responseJson = returnResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> getHandler({required String url}) async {
    dynamic responseJson;
    try {
      var uri = Uri.parse(baseUrl + versionHandler + url);
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      final response = await http.get(uri, headers: headers);
      responseJson = returnResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> getCrew({required String url}) async {
    dynamic responseJson;
    try {
      var uri = Uri.parse(baseUrl + versionUser + url);
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      final response = await http.get(uri, headers: headers);
      responseJson = returnResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> getCategory({required String url}) async {
    dynamic responseJson;
    try {
      var uri = Uri.parse(baseUrl + versionCategory + url);
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      final response = await http.get(uri, headers: headers);
      responseJson = returnResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> getInventoryCategory({required String url, required Map<String, dynamic> query}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + versionInventory + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      Response response = await dio.post(uri, options: Options(headers: headers), data: body);
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> getInventory({required String url, required Map<String, dynamic> query}) async {
    dynamic responseJson;
    try {
      var uri = Uri.parse(baseUrl + versionInventory + url);
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      final response = await http.post(uri, headers: headers, body: body);
      responseJson = returnResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> getCheckList({required String url, required Map<String, dynamic> query}) async {
    dynamic responseJson;
    try {
      var uri = Uri.parse(baseUrl + versionCheckList + url);
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      final response = await http.post(uri, headers: headers, body: body);
      responseJson = returnResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> createStockMovement({required String url, required Map<String, dynamic> query}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + versionStockMovement + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      Response response = await dio.post(uri, options: Options(headers: headers), data: body);
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> getAllTransit({required String url, required Map<String, dynamic> query}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + versionStockMovement + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      Response response = await dio.post(uri, options: Options(headers: headers), data: body);
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> getSingleTransit({required String url, required Map<String, dynamic> query}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + versionStockMovement + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      Response response = await dio.post(uri, options: Options(headers: headers), data: body);
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> confirmStockMovement({required String url, required Map<String, dynamic> query}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + versionStockMovement + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      Response response = await dio.post(uri, options: Options(headers: headers), data: body);
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> fileDownload({required String url, required Map<String, dynamic> query}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + versionStockMovement + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      Response response = await dio.post(uri, options: Options(responseType: ResponseType.bytes, headers: headers), data: body);
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> editProfileFunction({required String url, required Map<String, dynamic> query, required Map<String, File> files}) async {
    Dio dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 25),
        receiveTimeout: const Duration(seconds: 25),
        sendTimeout: const Duration(seconds: 25),
      ),
    );
    dynamic responseJson;
    try {
      String uri = baseUrl + versionUser + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      if (files["profileImage"]!.path == "") {
        Response response = await dio.post(uri, options: Options(headers: headers), data: body);
        responseJson = returnDioResponse(response);
      } else {
        Map<String, MultipartFile> fileMap = {};
        for (MapEntry fileEntry in files.entries) {
          File file = fileEntry.value;
          String fileName = file.path;
          fileMap[fileEntry.key] = await MultipartFile.fromFile(file.path, filename: fileName);
        }
        query.addAll(fileMap);
        var formData = FormData.fromMap(query);
        var response = await dio.post(
          uri,
          data: formData,
          options: Options(
            method: 'POST',
            headers: {HttpHeaders.authorizationHeader: mainVariables.generalVariables.userToken, 'content-Type': 'multipart/form-data'},
          ),
        );
        responseJson = returnDioResponse(response);
      }
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> changePasswordFunction({required String url, required Map<String, dynamic> query}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + versionUser + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      Response response = await dio.post(uri, options: Options(headers: headers), data: body);
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> reportsMainFunction({required String url, required Map<String, dynamic> query}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + versionReports + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      Response response = await dio.post(uri, options: Options(headers: headers), data: body);
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> fileReportsDownload({required String url, required Map<String, dynamic> query}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + versionReports + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      Response response = await dio.post(uri, options: Options(responseType: ResponseType.bytes, headers: headers), data: body);
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> filePdfDownload({required String url}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + versionManual + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Response response = await dio.post(uri, options: Options(responseType: ResponseType.bytes, headers: headers));
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> filePdfUpload({required String url, required Map<String, File> files}) async {
    Dio dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 25),
        receiveTimeout: const Duration(seconds: 25),
        sendTimeout: const Duration(seconds: 25),
      ),
    );
    dynamic responseJson;
    try {
      String uri = baseUrl + versionManual + url;
      Map<String, dynamic> query = {};
      Map<String, MultipartFile> fileMap = {};
      for (MapEntry fileEntry in files.entries) {
        File file = fileEntry.value;
        String fileName = file.path;
        fileMap[fileEntry.key] = await MultipartFile.fromFile(file.path, filename: fileName);
      }
      query.addAll(fileMap);
      var formData = FormData.fromMap(query);
      var response = await dio.post(
        uri,
        data: formData,
        options: Options(
          method: 'POST',
          headers: {HttpHeaders.authorizationHeader: mainVariables.generalVariables.userToken, 'content-Type': 'multipart/form-data'},
        ),
      );
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> fileCsvUpload({required String url, required Map<String, File> files}) async {
    Dio dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 25),
        receiveTimeout: const Duration(seconds: 25),
        sendTimeout: const Duration(seconds: 25),
      ),
    );
    dynamic responseJson;
    try {
      String uri = baseUrl + versionInventory + url;
      Map<String, dynamic> query = {};
      Map<String, MultipartFile> fileMap = {};
      for (MapEntry fileEntry in files.entries) {
        File file = fileEntry.value;
        String fileName = file.path;
        fileMap[fileEntry.key] = await MultipartFile.fromFile(file.path, filename: fileName);
      }
      query.addAll(fileMap);
      var formData = FormData.fromMap(query);
      var response = await dio.post(
        uri,
        data: formData,
        options: Options(
          method: 'POST',
          headers: {HttpHeaders.authorizationHeader: mainVariables.generalVariables.userToken, 'content-Type': 'multipart/form-data'},
        ),
      );
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> getInventoryProductsList({required String url, required Map<String, dynamic> query}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + versionInventory + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      Response response = await dio.post(uri, options: Options(headers: headers), data: body);
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> getProductTransitList({required String url, required Map<String, dynamic> query}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + versionStockMovement + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      Response response = await dio.post(uri, options: Options(headers: headers), data: body);
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> productCountByLocation({required String url, required Map<String, dynamic> query}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + versionInventory + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      Response response = await dio.post(uri, options: Options(headers: headers), data: body);
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> productDetailsByProduct({required String url, required Map<String, dynamic> query}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + versionInventory + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      Response response = await dio.post(uri, options: Options(headers: headers), data: body);
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> shortageDetailsByProduct({required String url, required Map<String, dynamic> query}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + versionDispute + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      Response response = await dio.post(uri, options: Options(headers: headers), data: body);
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> minimumLevelUpdate({required String url, required Map<String, dynamic> query}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + versionInventory + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      Response response = await dio.post(uri, options: Options(headers: headers), data: body);
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> quantityUpdate({required String url, required Map<String, dynamic> query}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + versionInventory + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      Response response = await dio.post(uri, options: Options(headers: headers), data: body);
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> getBrandTypeList({required String url, required Map<String, dynamic> query}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + versionBrand + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      Response response = await dio.post(uri, options: Options(headers: headers), data: body);
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> addBrandType({required String url, required Map<String, dynamic> query}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + versionBrand + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      Response response = await dio.post(uri, options: Options(headers: headers), data: body);
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> deleteBrandType({required String url, required Map<String, dynamic> query}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + versionBrand + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      Response response = await dio.post(uri, options: Options(headers: headers), data: body);
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> editBrandType({required String url, required Map<String, dynamic> query}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + versionBrand + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      Response response = await dio.post(uri, options: Options(headers: headers), data: body);
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> getCategoriesList({required String url, required Map<String, dynamic> query}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + versionCategory + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      Response response = await dio.post(uri, options: Options(headers: headers), data: body);
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> addCategory({required String url, required Map<String, dynamic> query}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + versionCategory + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      Response response = await dio.post(uri, options: Options(headers: headers), data: body);
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> deleteCategory({required String url, required Map<String, dynamic> query}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + versionCategory + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      Response response = await dio.post(uri, options: Options(headers: headers), data: body);
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> editCategory({required String url, required Map<String, dynamic> query}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + versionCategory + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      Response response = await dio.post(uri, options: Options(headers: headers), data: body);
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> getHandlerList({required String url, required Map<String, dynamic> query}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + versionHandler + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      Response response = await dio.post(uri, options: Options(headers: headers), data: body);
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> addHandler({required String url, required Map<String, dynamic> query}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + versionHandler + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      Response response = await dio.post(uri, options: Options(headers: headers), data: body);
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> deleteHandler({required String url, required Map<String, dynamic> query}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + versionHandler + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      Response response = await dio.post(uri, options: Options(headers: headers), data: body);
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> editHandler({required String url, required Map<String, dynamic> query}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + versionHandler + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      Response response = await dio.post(uri, options: Options(headers: headers), data: body);
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> getWarehouseOrAircraftList({required String url, required Map<String, dynamic> query}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + versionLocation + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      Response response = await dio.post(uri, options: Options(headers: headers), data: body);
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> addWarehouseOrAircraft({required String url, required Map<String, dynamic> query}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + versionLocation + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      Response response = await dio.post(uri, options: Options(headers: headers), data: body);
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> deleteWarehouseOrAircraft({required String url, required Map<String, dynamic> query}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + versionLocation + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      Response response = await dio.post(uri, options: Options(headers: headers), data: body);
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> editWarehouseOrAircraft({required String url, required Map<String, dynamic> query}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + versionLocation + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      Response response = await dio.post(uri, options: Options(headers: headers), data: body);
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> getSectorList({required String url, required Map<String, dynamic> query}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + versionSector + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      Response response = await dio.post(uri, options: Options(headers: headers), data: body);
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> addSector({required String url, required Map<String, dynamic> query}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + versionSector + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      Response response = await dio.post(uri, options: Options(headers: headers), data: body);
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> deleteSector({required String url, required Map<String, dynamic> query}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + versionSector + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      Response response = await dio.post(uri, options: Options(headers: headers), data: body);
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> editSector({required String url, required Map<String, dynamic> query}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + versionSector + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      Response response = await dio.post(uri, options: Options(headers: headers), data: body);
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> getCrewList({required String url, required Map<String, dynamic> query}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + versionUser + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      Response response = await dio.post(uri, options: Options(headers: headers), data: body);
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> addCrew({required String url, required Map<String, dynamic> query}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + versionUser + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      Response response = await dio.post(uri, options: Options(headers: headers), data: body);
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> deleteCrew({required String url, required Map<String, dynamic> query}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + versionUser + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      Response response = await dio.post(uri, options: Options(headers: headers), data: body);
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> editCrew({required String url, required Map<String, dynamic> query}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + versionUser + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      Response response = await dio.post(uri, options: Options(headers: headers), data: body);
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> activateCrew({required String url, required Map<String, dynamic> query}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + versionUser + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      Response response = await dio.post(uri, options: Options(headers: headers), data: body);
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> deactivateCrew({required String url, required Map<String, dynamic> query}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + versionUser + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      Response response = await dio.post(uri, options: Options(headers: headers), data: body);
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> getAllCategory({required String url}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + versionCategory + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Response response = await dio.get(uri, options: Options(headers: headers));
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> getAllBrand({required String url}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + versionBrand + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Response response = await dio.get(uri, options: Options(headers: headers));
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> getAllProductBrand({required String url}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + versionProducts + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Response response = await dio.get(uri, options: Options(headers: headers));
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> getProductsList({required String url, required Map<String, dynamic> query}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + versionProducts + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      Response response = await dio.post(uri, options: Options(headers: headers), data: body);
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> addProduct({required String url, required Map<String, dynamic> query, required Map<String, File> files}) async {
    Dio dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 25),
        receiveTimeout: const Duration(seconds: 25),
        sendTimeout: const Duration(seconds: 25),
      ),
    );
    dynamic responseJson;
    try {
      String uri = baseUrl + versionProducts + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      if (files["productImage"]!.path == "") {
        Response response = await dio.post(uri, options: Options(headers: headers), data: body);
        responseJson = returnDioResponse(response);
      } else {
        Map<String, MultipartFile> fileMap = {};
        for (MapEntry fileEntry in files.entries) {
          File file = fileEntry.value;
          String fileName = file.path;
          fileMap[fileEntry.key] = await MultipartFile.fromFile(file.path, filename: fileName);
        }
        query.addAll(fileMap);
        var formData = FormData.fromMap(query);
        var response = await dio.post(
          uri,
          data: formData,
          options: Options(
            method: 'POST',
            headers: {HttpHeaders.authorizationHeader: mainVariables.generalVariables.userToken, 'content-Type': 'multipart/form-data'},
          ),
        );
        responseJson = returnDioResponse(response);
      }
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> deleteProduct({required String url, required Map<String, dynamic> query}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + versionProducts + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      Response response = await dio.post(uri, options: Options(headers: headers), data: body);
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> editProduct({required String url, required Map<String, dynamic> query, required Map<String, File> files}) async {
    Dio dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 25),
        receiveTimeout: const Duration(seconds: 25),
        sendTimeout: const Duration(seconds: 25),
      ),
    );
    dynamic responseJson;
    try {
      String uri = baseUrl + versionProducts + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      if (files["productImage"]!.path == "") {
        Response response = await dio.post(uri, options: Options(headers: headers), data: body);
        responseJson = returnDioResponse(response);
      } else {
        Map<String, MultipartFile> fileMap = {};
        for (MapEntry fileEntry in files.entries) {
          File file = fileEntry.value;
          String fileName = file.path;
          fileMap[fileEntry.key] = await MultipartFile.fromFile(file.path, filename: fileName);
        }
        query.addAll(fileMap);
        var formData = FormData.fromMap(query);
        var response = await dio.post(
          uri,
          data: formData,
          options: Options(
            method: 'POST',
            headers: {HttpHeaders.authorizationHeader: mainVariables.generalVariables.userToken, 'content-Type': 'multipart/form-data'},
          ),
        );
        responseJson = returnDioResponse(response);
      }
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> activateProduct({required String url, required Map<String, dynamic> query}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + versionProducts + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      Response response = await dio.post(uri, options: Options(headers: headers), data: body);
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> deactivateProduct({required String url, required Map<String, dynamic> query}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + versionProducts + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      Response response = await dio.post(uri, options: Options(headers: headers), data: body);
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> productMiniLevelExpiry({required String url, required Map<String, dynamic> query}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + versionInventory + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      Response response = await dio.post(uri, options: Options(headers: headers), data: body);
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> addInventory({required String url, required Map<String, dynamic> query}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + versionInventory + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      Response response = await dio.post(uri, options: Options(headers: headers), data: body);
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> addCheckList({required String url, required Map<String, dynamic> query}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + versionCheckList + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      Response response = await dio.post(uri, options: Options(headers: headers), data: body);
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> addDispute({required String url, required Map<String, dynamic> query}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + versionDispute + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      Response response = await dio.post(uri, options: Options(headers: headers), data: body);
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> getDisputeDetails({required String url, required Map<String, dynamic> query}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + versionDispute + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      Response response = await dio.post(uri, options: Options(headers: headers), data: body);
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> disputeAdminComment({required String url, required Map<String, dynamic> query}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + versionDispute + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      Response response = await dio.post(uri, options: Options(headers: headers), data: body);
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> getSingleCheckListDetail({required String url, required Map<String, dynamic> query}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + versionCheckList + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      Response response = await dio.post(uri, options: Options(headers: headers), data: body);
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> getProduct({required String url, required Map<String, dynamic> query}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + versionProducts + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      Response response = await dio.post(uri, options: Options(headers: headers), data: body);
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> getCart({required String url, required Map<String, dynamic> query}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + cartModule + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      print("uri : $uri");
      print("headers : $headers");
      print("body : $body");
      Response response = await dio.post(uri, options: Options(headers: headers), data: body);
      responseJson = returnDioResponse(response);
      print("responseJson: $responseJson");
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> updateCart({required String url, required Map<String, dynamic> query}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + cartModule + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      Response response = await dio.post(uri, options: Options(headers: headers), data: body);
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> cartAction({required String url, required Map<String, dynamic> query}) async {
    Dio dio = Dio();
    dynamic responseJson;
    try {
      String uri = baseUrl + cartModule + url;
      Map<String, String> headers = {"Authorization": mainVariables.generalVariables.userToken};
      Map<String, dynamic> body = query;
      Response response = await dio.post(uri, options: Options(headers: headers), data: body);
      responseJson = returnDioResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 201:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.toString());
      case 401:
      case 403:
      case 404:
        dynamic responseJson = jsonDecode(response.body);
        throw UnauthorisedException(responseJson['message']);
      case 500:
      default:
        throw FetchDataException('Error occurred while communication with server with status code : ${response.statusCode}');
    }
  }

  dynamic returnDioResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = response.data;
        return responseJson;
      case 201:
        dynamic responseJson = response.data;
        return responseJson;
      case 400:
        throw BadRequestException(response.toString());
      case 401:
      case 403:
      case 404:
        dynamic responseJson = response.data;
        throw UnauthorisedException(responseJson['message']);
      case 500:
      default:
        throw FetchDataException('Error occurred while communication with server with status code : ${response.statusCode}');
    }
  }
}
