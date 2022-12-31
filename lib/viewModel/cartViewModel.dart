import 'package:flutter/widgets.dart';
import 'package:zartek/model/cartModel.dart';

class CartViewModel with ChangeNotifier {
  List<CartModel> lst = List<CartModel>();

  add(String dishId,String dishName, double price,int dishType,double calories,int itemCount) {
    lst.add(CartModel(dishId: dishId,dishName: dishName,price: price,dishType: dishType,calories: calories,itemCount: itemCount));
    notifyListeners();
  }

  update(String dishId,String dishName, double price,int dishType,double calories,int itemCount){
    int index = lst.indexWhere((item) => item.dishId == dishId);
    lst[index]=CartModel(dishId: dishId,dishName: dishName,price: price,dishType: dishType,calories: calories,itemCount: itemCount);
    notifyListeners();
  }

  del(String dishId) {
    int index = lst.indexWhere((item) => item.dishId == dishId);
    lst.removeAt(index);
    notifyListeners();
  }
  void clearItem() {
    lst.clear();
    notifyListeners();
  }
  getTotalAmount(){
    double totalPrice=0;
    for (int i=0;i<lst.length;i++){
      totalPrice = totalPrice + (lst[i].price*lst[i].itemCount);
    }
    notifyListeners();
    return totalPrice;
  }
  getItemCount(){
    int itemCount=0;
    for (int i=0;i<lst.length;i++){
      itemCount = itemCount + lst[i].itemCount;
    }
    notifyListeners();
    return itemCount;
  }
}