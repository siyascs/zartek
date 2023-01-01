import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zartek/utils/Colors.dart';
import 'package:zartek/view/authenitcationScreen.dart';
import 'package:zartek/view/cart.dart';
import 'package:zartek/view/dishList.dart';
import 'package:zartek/viewModel/cartViewModel.dart';
import 'package:zartek/viewModel/dishesViewModel.dart';
import 'package:zartek/widget/custom_tab_view.dart';
import 'package:zartek/widget/styles.dart';

class HomeScreen extends StatefulWidget {
  final String authType;
  const HomeScreen({Key key,this.authType}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int initPosition = 0;
  String name;
  String uid;
  String imageUrl;
  final FirebaseAuth auth = FirebaseAuth.instance;
  signOut() async {
    await auth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => UserAuthentication()));
  }

  @override
  void initState() {
    super.initState();
    if(widget.authType=="phone"){
      name=FirebaseAuth.instance.currentUser.phoneNumber;
    }
    if(widget.authType=="google"){
      name=FirebaseAuth.instance.currentUser.email;
    }
    imageUrl=FirebaseAuth.instance.currentUser.photoURL;
    uid=FirebaseAuth.instance.currentUser.uid;
  }
  @override
  Widget build(BuildContext context) {
    DishesViewModel dishesViewModel = context.watch<DishesViewModel>();

    return DefaultTabController(
      length: dishesViewModel.dishModel[0].tableMenuList.length,
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: whiteColor,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.grey // Changing Drawer Icon Size
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 0.0, top: 8.0),
              child: Stack(
                children:[
                  IconButton(
                    icon: const Icon(
                      Icons.shopping_cart,
                      color: Colors.grey,
                    ),

                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => CartScreen(authType: widget.authType)));
                    },
                  ),
                  Consumer<CartViewModel>(
                    builder: (context, value, child) =>value.lst.isNotEmpty?Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: CircleAvatar(
                        radius: 8.0,
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        child: Text(
                          value.lst.length.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ):Container(),
                  )
                ]
              ),
            )

          ],
        ),
        body:SafeArea(
              child: dishesViewModel.dishModel.isNotEmpty?CustomTabView(
                initPosition: initPosition,
                itemCount: dishesViewModel.dishModel[0].tableMenuList.length,
                tabBuilder: (context, index) {
                  return Tab(text: dishesViewModel.dishModel[0].tableMenuList[index].menuCategory);
                },
                pageBuilder: (context, index) {
                  return DishListScreen(
                    menuCategory: dishesViewModel.dishModel[0].tableMenuList[index].menuCategory,
                  );

                },
                onPositionChange: (index) {
                  initPosition = index;
                },
                onScroll: (position) => print('$position'),
              ):CircularProgressIndicator(),
            ),
        drawer:Drawer(
        elevation: 4,
        child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                  decoration: const BoxDecoration(
                    color: greenColor,
                  ),
                child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    imageUrl!=null?CircleAvatar(
                      radius: 50.0,
                      backgroundImage:
                      NetworkImage(imageUrl),
                      backgroundColor: Colors.transparent,
                    ):const CircleAvatar(
                      radius: 30.0,
                      backgroundImage:
                      NetworkImage('https://via.placeholder.com/150'),
                      backgroundColor: Colors.transparent,
                    ),
                    SizedBox(height: 8),

                    Text(name,style: poppinsMediumText()),
                    const SizedBox(height: 8),
                    Text("ID: $uid",style: poppinsMediumText())
                  ],
                )

              ),
              ListTile(
                title: const Text(
                  "Log out",
                ),
                onTap: () {
                  signOut();
                },
                leading: const Icon(Icons.logout),
                //     height: 20, width: 20),
              ),
            ],
          ),
      ),

      ),

    );
  }

}
