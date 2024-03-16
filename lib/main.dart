import 'package:fends_mobile/pages/index.dart';
import 'package:fends_mobile/widgets/navbar.dart';
import 'package:fends_mobile/pages/home/start_screen.dart';
import 'package:flutter/material.dart';




void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      supportedLocales: const [
        Locale('en', 'US'),
        // Add other supported locales as needed
      ],
      theme: ThemeData(

          scaffoldBackgroundColor: Colors.white
      ),
      color: Colors.white,
      home: MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
