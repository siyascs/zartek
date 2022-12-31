import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zartek/view/homeScreen.dart';
import 'package:zartek/viewModel/cartViewModel.dart';
import 'package:zartek/viewModel/dishesViewModel.dart';

class CartScreen extends StatefulWidget {
  final String authType;
  const CartScreen({Key key,this.authType}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<TextEditingController> _priceList = [];

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    DishesViewModel dishesViewModel = context.watch<DishesViewModel>();
    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Order Summary"),
      ),
        body: Consumer<CartViewModel>(
      builder: (context, value, child) =>value.lst.isNotEmpty?Card(
          elevation: 2,
          child: Column(
            children: [
              Container(
                height: 35,
                width: screenSize.width,
                decoration: BoxDecoration(
                    color: Color(0xFF0E3C22),
                    borderRadius: BorderRadius.circular(5)
                ),
                child: Center(
                  child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text("${value.lst.length} Dishes - ${value.getItemCount()} Items")
                  ),
                ),
              ),
               Expanded(
                child: ListView.builder(
                      itemCount: value.lst.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Text("0"),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(value.lst[index].dishName),
                              SizedBox(height: 8),
                              Text("INR ${value.lst[index].price*value.lst[index].itemCount}"),
                              SizedBox(height: 8),
                              Text("${value.lst[index].calories*value.lst[index].itemCount} Calories"),

                            ],
                          ),
                          trailing:
                          Container(
                            height: 35,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Color(0xFF0E3C22),
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(4),
                                child:
                                Consumer<CartViewModel>(
                                  builder: (context, value, child) => Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                          onTap: (){
                                            setState((){
                                              value.lst[index].itemCount--;
                                            });
                                          },
                                          child: const Icon(Icons.remove,color: Colors.white)),
                                      Text(value.lst[index].itemCount.toString(),style: TextStyle(color: Colors.white,fontSize: 12)),
                                      GestureDetector(
                                          onTap: (){
                                            setState((){
                                              value.lst[index].itemCount++;

                                            });
                                            if(value.lst[index].itemCount>1){
                                              value.update(value.lst[index].dishId,
                                                  value.lst[index].dishName,
                                                  value.lst[index].price,
                                                  value.lst[index].dishType,
                                                  value.lst[index].calories,
                                                  value.lst[index].itemCount);
                                            }
                                          },
                                          child: const Icon(Icons.add,color: Colors.white)),
                                    ],
                                  ),
                                )
                            ),
                          ),

                        );
                      },
                    ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Total Amount"),
                  Text("INR ${value.getTotalAmount()}")
                ],
              ),

              GestureDetector(
                onTap: (){
                  alertBox();
                  value.clearItem();
                },
                child: Container(
                  height: 35,
                  width: screenSize.width,
                  decoration: BoxDecoration(
                      color: Color(0xFF0E3C22),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: const Center(
                    child: Padding(
                        padding: EdgeInsets.all(4),
                        child: Text("Place Order")
                    ),
                  ),
                ),
              ),

            ],
          ),
        ):const Center(child: Text("Cart is empty")),
        )
      );
  }
  Widget alertBox(){
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Text("SUCCESS"),
            content: const Text("Order Successfully Placed"),
            actions: <Widget>[
              TextButton(
                child: const Text("OK"),
                // textColor: Colors.white,
                // color: Colors.blue,
                onPressed: () async{
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => HomeScreen(authType: widget.authType)
                  ));
                }

                ,
              )
            ],
          );
        }
    );
  }
}
