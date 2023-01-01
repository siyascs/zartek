import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zartek/utils/Colors.dart';
import 'package:zartek/view/homeScreen.dart';
import 'package:zartek/viewModel/cartViewModel.dart';
import 'package:zartek/viewModel/dishesViewModel.dart';
import 'package:zartek/widget/styles.dart';

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
        backgroundColor: whiteColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.grey),
          onPressed: () => Navigator.push(context, MaterialPageRoute(
              builder: (context) => HomeScreen(authType: widget.authType)
          )),
        ),
        title:  Text("Order Summary",style: poppinsRegularText()),
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
                    color: darkGreen,
                    borderRadius: BorderRadius.circular(5)
                ),
                child: Center(
                  child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text("${value.lst.length} Dishes - ${value.getItemCount()} Items",style: poppinsSemiBoldWhiteText(),)
                  ),
                ),
              ),
               SizedBox(height: 10),
               Expanded(
                child: ListView.builder(
                      itemCount: value.lst.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              leading: value.lst[index].dishType==1?
                              Image.asset("assets/images/vegicon.png",width: 30,height: 30):Image.asset("assets/images/nonvegicon.png",width: 30,height: 30),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(value.lst[index].dishName,style: poppinsBoldText()),
                                  const SizedBox(height: 8),
                                  Text("INR ${value.lst[index].price*value.lst[index].itemCount}",style: poppinsMediumText()),
                                  const SizedBox(height: 8),
                                  Text("${value.lst[index].calories*value.lst[index].itemCount} Calories",style: poppinsMediumText()),

                                ],

                              ),
                              trailing:
                              Container(
                                height: 35,
                                width: 100,
                                decoration: BoxDecoration(
                                    color: darkGreen,
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
                                                if(value.lst[index].itemCount!=0){
                                                  setState((){
                                                    value.lst[index].itemCount--;
                                                  });
                                                }
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

                            ),
                            const SizedBox(height: 10),
                            const Divider()
                          ],
                        );
                      },
                    ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10,right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text("Total Amount",style: poppinsBoldText()),
                    Text("INR ${value.getTotalAmount()}",style: poppinsBoldText())
                  ],
                ),
              ),
              const SizedBox(height: 20),

              GestureDetector(
                onTap: (){
                  alertBox();
                  value.clearItem();
                },
                child: Container(
                  height: 35,
                  width: screenSize.width,
                  decoration: BoxDecoration(
                      color: darkGreen,
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child:  Center(
                    child: Padding(
                        padding: EdgeInsets.all(4),
                        child: Text("Place Order",style: poppinsSemiBoldWhiteText())
                    ),
                  ),
                ),
              ),

            ],
          ),
        ): Center(child: Text("Cart is empty",style: poppinsBoldText())),
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
