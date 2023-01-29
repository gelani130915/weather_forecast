import 'dart:convert';

import 'package:http/http.dart';  

  dynamic returnResponse(Response response) {
    try{
      switch (response.statusCode) {
        case 201: 200;
          var responseJson = json.decode(response.body.toString());
          return responseJson;
        case 400:
          throw BadRequestException(response.body.toString());
        case 401:
        case 403:
          throw UnauthorisedException(response.body.toString());
        case 500:
        default:
          throw FetchDataException(
            message: 'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
      }
    } catch(e){
      throw FetchDataException(message: e.toString());
    }
  }


class AppException implements Exception {
  final message;
  final prefix;
  
AppException([this.message, this.prefix]);
  
@override
  String toString() {
    return "$prefix$message";
  }
}

class FetchDataException extends AppException {
  FetchDataException({required String message})
      : super(message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends AppException {
  InvalidInputException({required String message}) : super(message, "Invalid Input: ");
}