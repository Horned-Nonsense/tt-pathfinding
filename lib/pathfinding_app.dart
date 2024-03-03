import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/home_page.dart';

class PathfindingApp extends StatelessWidget {
  const PathfindingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Pathfinding App",
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(useMaterial3: false),
    );
  }
}
