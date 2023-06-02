import 'package:flutter/material.dart';
import 'package:flutter_image_search/data/pixabay_api.dart';
import 'package:flutter_image_search/ui/home_screen.dart';
import 'package:flutter_image_search/ui/home_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
        create: (_) => HomeViewModel(pixabayApi()),
        child: const HomeScreen(),
      ),
    );
  }
}
