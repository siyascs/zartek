import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zartek/viewModel/cartViewModel.dart';
import 'package:zartek/viewModel/dishesViewModel.dart';

class DishListScreen extends StatefulWidget {
  final String menuCategory;
  const DishListScreen({Key key,@required this.menuCategory}) : super(key: key);

  @override
  State<DishListScreen> createState() => _DishListScreenState();
}

class _DishListScreenState extends State<DishListScreen> {
  int _selectedItemIndex;
  _onItemIncrement(int index) {
    setState(() {
      _selectedItemIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    DishesViewModel dishesViewModel = context.watch<DishesViewModel>();
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: dishesViewModel.dishModel.isNotEmpty?Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: dishesViewModel.dishModel[0].tableMenuList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ListView.builder(
                            itemCount: dishesViewModel.dishModel[0].tableMenuList[index].categoryDishes.length,
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int position) {
                              if(dishesViewModel.dishModel[0].tableMenuList[index].menuCategory==widget.menuCategory){
                                return ListTile(
                                  leading: dishesViewModel.dishModel[0].tableMenuList[index].categoryDishes[position].dishType==1?
                                  Image.asset("assets/images/vegicon.png",width: 30,height: 30):Image.asset("assets/images/nonvegicon.png",width: 30,height: 30),
                                  title: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(dishesViewModel.dishModel[0].tableMenuList[index].categoryDishes[position].dishName),
                                      const SizedBox(height: 8),
                                      Text("INR${dishesViewModel.dishModel[0].tableMenuList[index].categoryDishes[position].dishPrice}"),
                                      const SizedBox(height: 8),
                                      Text(dishesViewModel.dishModel[0].tableMenuList[index].categoryDishes[position].dishDescription),
                                      const SizedBox(height: 10),
                                      Container(
                                        height: 35,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          color: Colors.green,
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
                                                      dishesViewModel.dishModel[0].tableMenuList[index].categoryDishes[position].itemQuantity--;
                                                    });
                                                    value.update(dishesViewModel.dishModel[0].tableMenuList[index].categoryDishes[position].dishId,
                                                        dishesViewModel.dishModel[0].tableMenuList[index].categoryDishes[position].dishName,
                                                        dishesViewModel.dishModel[0].tableMenuList[index].categoryDishes[position].dishPrice,
                                                        dishesViewModel.dishModel[0].tableMenuList[index].categoryDishes[position].dishType,
                                                        dishesViewModel.dishModel[0].tableMenuList[index].categoryDishes[position].dishCalories,
                                                        dishesViewModel.dishModel[0].tableMenuList[index].categoryDishes[position].itemQuantity);
                                                    if(dishesViewModel.dishModel[0].tableMenuList[index].categoryDishes[position].itemQuantity==0){
                                                      value.del(dishesViewModel.dishModel[0].tableMenuList[index].categoryDishes[position].dishId);
                                                    }
                                                  },
                                                  child: const Icon(Icons.remove,color: Colors.white)),
                                              Text(dishesViewModel.dishModel[0].tableMenuList[index].categoryDishes[position].itemQuantity.toString(),style: TextStyle(color: Colors.white,fontSize: 12)),
                                              GestureDetector(
                                                onTap: (){
                                                  setState((){
                                                    dishesViewModel.dishModel[0].tableMenuList[index].categoryDishes[position].itemQuantity++;
                                                  });
                                                  if(dishesViewModel.dishModel[0].tableMenuList[index].categoryDishes[position].itemQuantity==1){
                                                    value.add(dishesViewModel.dishModel[0].tableMenuList[index].categoryDishes[position].dishId,
                                                        dishesViewModel.dishModel[0].tableMenuList[index].categoryDishes[position].dishName,
                                                        dishesViewModel.dishModel[0].tableMenuList[index].categoryDishes[position].dishPrice,
                                                        dishesViewModel.dishModel[0].tableMenuList[index].categoryDishes[position].dishType,
                                                        dishesViewModel.dishModel[0].tableMenuList[index].categoryDishes[position].dishCalories,
                                                        dishesViewModel.dishModel[0].tableMenuList[index].categoryDishes[position].itemQuantity);
                                                  }
                                                  if(dishesViewModel.dishModel[0].tableMenuList[index].categoryDishes[position].itemQuantity>1){
                                                    value.update(dishesViewModel.dishModel[0].tableMenuList[index].categoryDishes[position].dishId,
                                                        dishesViewModel.dishModel[0].tableMenuList[index].categoryDishes[position].dishName,
                                                        dishesViewModel.dishModel[0].tableMenuList[index].categoryDishes[position].dishPrice,
                                                        dishesViewModel.dishModel[0].tableMenuList[index].categoryDishes[position].dishType,
                                                        dishesViewModel.dishModel[0].tableMenuList[index].categoryDishes[position].dishCalories,
                                                        dishesViewModel.dishModel[0].tableMenuList[index].categoryDishes[position].itemQuantity);
                                                  }


                                                },
                                                  child: const Icon(Icons.add,color: Colors.white)),
                                            ],
                                          ),
                                          )
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      if(dishesViewModel.dishModel[0].tableMenuList[index].categoryDishes[position].addonCat.isNotEmpty)const Text(
                                        "Customizations Available"
                                      ),
                                      const SizedBox(height: 10),
                                      const Divider()
                                    ],
                                  ),
                                  trailing: Image.asset("assets/images/dish.jpeg",width: 75,height: 75),
                                );
                              }
                              return Container();
                            }),
                      ],
                    );
                  }),
            )
          ],
        ),
      ):Center(child: CircularProgressIndicator())
    );
  }
}
