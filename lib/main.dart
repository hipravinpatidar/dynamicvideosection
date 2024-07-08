import 'package:dynamicvideosection/ui_helper/custom_colors.dart';
import 'package:dynamicvideosection/view/videosection_main.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const VideoSectionMain(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: CustomColors.clrwhite,
        ),
        tabBarTheme: const TabBarTheme(
            overlayColor: WidgetStateColor.transparent
        )
      ),
    );

  }
}
