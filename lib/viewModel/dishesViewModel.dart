import 'package:flutter/material.dart';
import 'package:zartek/model/categoryDishesModel.dart';
import 'package:zartek/model/dishesErrorModel.dart';
import 'package:zartek/repo/api_status.dart';
import 'package:zartek/repo/dish_service.dart';

class DishesViewModel extends ChangeNotifier {
  //
  bool _loading = false;
  List<CategoryDishesModel> _dishesModel = [];
  DishesErrorModel _dishError;

  bool get loading => _loading;
  List<CategoryDishesModel> get dishModel => _dishesModel;
  DishesErrorModel get userError => _dishError;

  DishesViewModel() {
    getCategoryDishes();
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setDishListModel(List<CategoryDishesModel> dishListModel) {
    _dishesModel = dishListModel;
  }

  setUserError(DishesErrorModel userError) {
    _dishError = userError;
  }




  // addUser() async {
  //   if (!isValid()) {
  //     return;
  //   }
  //   _dishesModel.add(addingUser);
  //   _addingUser = CategoryDishesModel();
  //   notifyListeners();
  //   return true;
  // }

  // isValid() {
  //   if (addingUser.name == null || addingUser.name.isEmpty) {
  //     return false;
  //   }
  //   if (addingUser.email == null || addingUser.email.isEmpty) {
  //     return false;
  //   }
  //   return true;
  // }

  getCategoryDishes() async {
    setLoading(true);
    var response = await DishServices.getDishes();
    print(response);
    if (response is Success) {
      print("success");
      setDishListModel(response.response as List<CategoryDishesModel>);
    }
    if (response is Failure) {
      print("failure");
      DishesErrorModel userError = DishesErrorModel(
        code: response.code,
        message: response.errorResponse,
      );
      setUserError(userError);
    }
    setLoading(false);
  }
}