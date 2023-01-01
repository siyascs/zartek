import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zartek/view/authenitcationScreen.dart';
import 'package:zartek/view/homeScreen.dart';
import 'package:zartek/viewModel/cartViewModel.dart';
import 'package:zartek/viewModel/dishesViewModel.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DishesViewModel()),
        ChangeNotifierProvider(create: (_) => CartViewModel()),
      ],
      child: const MaterialApp(
        title: 'Zartek',
        debugShowCheckedModeBanner: false,
        home:  UserAuthentication(),
      ),
    );
  }
}

