

import 'package:flutter/material.dart';

import 'package:signin_sqflite/models/image_model.dart';
import 'package:signin_sqflite/views/details_screen.dart';
import 'package:signin_sqflite/views/home.dart';
import 'package:signin_sqflite/views/text_input.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}





class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx)=>ImageFile(),
      child: MaterialApp(
        title: "Flutter Notes",
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/':(context) => const HomePage(),
          MyInputScreen.route:(context) => const MyInputScreen(),
          DetailScreen.route:(context) => const DetailScreen()
         
         
        },
      ),
    );
  }
}
