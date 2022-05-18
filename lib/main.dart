import 'package:flutter/material.dart';
import 'package:food_delivery/constants/colors.dart';
import 'package:food_delivery/screens/get_start_screen/get_start_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Delivery',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0
        ),
        fontFamily: "SF",
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontFamily: 'SF',
            fontSize: 64,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
          bodyText2: TextStyle(
            fontFamily: 'SF',
            fontSize: 14,
            color: SolidColors.buttonTextColorRed
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: SolidColors.buttonTextColorRed,
            shape: const StadiumBorder(),
          ),
        ),
        primarySwatch: Colors.red,
      ),
      home: const GetStartScreen(),
    );
  }
}




