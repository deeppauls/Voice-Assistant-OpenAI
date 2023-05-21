import 'package:flutter/material.dart';
import 'package:sammy/screens/home-screen.dart';
import 'models/color-model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sammy',
      theme: ThemeData.light(useMaterial3: true).copyWith(
          scaffoldBackgroundColor: ColorPallete.whiteColor,
          appBarTheme: AppBarTheme(
            backgroundColor: ColorPallete.whiteColor,
          )),
      home: HomeScreen(),
    );
  }
}
