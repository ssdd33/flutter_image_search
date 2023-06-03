import 'package:flutter/material.dart';
import 'package:flutter_image_search/data/repository/photo_api_repository_impl.dart';
import 'package:flutter_image_search/data/source/pixabay_api.dart';
import 'package:flutter_image_search/presentation/home/home_screen.dart';
import 'package:flutter_image_search/presentation/home/home_view_model.dart';
import 'package:http/http.dart' as http;
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
      home: ChangeNotifierProvider<HomeViewModel>(
        create: (_) =>
            HomeViewModel(PhotoApiRepositoryImpl(PixabayApi(http.Client()))),
        child: const HomeScreen(),
      ),
    );
  }
}
