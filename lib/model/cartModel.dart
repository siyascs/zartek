class CartModel {
  CartModel({
    this.dishId,
    this.dishName,
    this.price,
    this.dishType,
    this.calories,
    this.itemCount
  });

  String dishId;
  String dishName;
  double price;
  int dishType;
  double calories;
  int itemCount;

  Map<String, dynamic> toJson() => {
    "dishId": dishId,
    "dishName": dishName,
    "price":price,
    "dishType":dishType,
    "calories":calories,
    "itemCount":itemCount
  };
}