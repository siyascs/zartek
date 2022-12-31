import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:zartek/model/categoryDishesModel.dart';
import 'package:zartek/repo/api_status.dart';
import 'package:zartek/utils/constants.dart';

class DishServices {
  static Future<Object> getDishes() async {
    try {
      var response = await http.get(Uri.parse(DISHES_LIST));
      if (SUCCESS == response.statusCode) {
        try {
          return Success(response: categoryDishesModelFromJson(response.body));
        }catch(e){
          print(e.toString());
        }
      }
      return Failure(
          code: USER_INVALID_RESPONSE, errorResponse: 'Invalid Response');
    } on HttpException {
      return Failure(
          code: NO_INTERNET, errorResponse: 'No Internet Connection');
    } on SocketException {
      return Failure(
          code: NO_INTERNET, errorResponse: 'No Internet Connection');
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: 'Invalid Format');
    } catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Unknown Error');
    }
  }
}
