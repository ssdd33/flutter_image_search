import 'package:flutter_image_search/data/repository/photo_api_repository_impl.dart';
import 'package:flutter_image_search/data/source/pixabay_api.dart';
import 'package:flutter_image_search/domain/repository/photo_api_repository.dart';
import 'package:flutter_image_search/domain/use_case/get_photos_use_case.dart';
import 'package:flutter_image_search/presentation/home/home_view_model.dart';
import 'package:provider/single_child_widget.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

// 1. provider 전체
List<SingleChildWidget> globalProviders = [
  ...independantModel,
  ...dependantModel,
  ...viewModels
];
//2.독립적인 객체
List<SingleChildWidget> independantModel = [
  Provider<http.Client>(create: (context) => http.Client())
];
//3.2에 의존성있는 객체
List<SingleChildWidget> dependantModel = [
  ProxyProvider<http.Client, PixabayApi>(
      update: (context, client, _) => PixabayApi(client)),
  ProxyProvider<PixabayApi, PhotoApiRepository>(
      update: (context, api, _) => PhotoApiRepositoryImpl(api)),
  ProxyProvider<PhotoApiRepository, GetPhotosUseCase>(
      update: (context, repository, _) => GetPhotosUseCase(repository)),
];

List<SingleChildWidget> viewModels = [
  ChangeNotifierProvider<HomeViewModel>(
      create: (context) => HomeViewModel(context.read<GetPhotosUseCase>()))
];
