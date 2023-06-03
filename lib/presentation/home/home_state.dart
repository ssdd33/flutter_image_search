import 'package:flutter_image_search/domain/model/photo.dart';

class HomeState {
  final bool isLoading;
  final List<Photo> photos;
  HomeState(this.isLoading, this.photos);
  HomeState copy({bool? isLoading, List<Photo>? photos}) {
    return HomeState(isLoading ??= this.isLoading, photos ??= this.photos);
  }
}
