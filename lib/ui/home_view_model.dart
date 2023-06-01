import 'dart:async';

import 'package:flutter_image_search/data/photo_api_repository.dart';
import 'package:flutter_image_search/model/photo.dart';

class HomeViewModel {
  final PhotoApiRepository repository;
  HomeViewModel(
    this.repository,
  );

  final _PhotoStreamController = StreamController<List<Photo>>()..add([]);
  Stream<List<Photo>> get photoStream => _PhotoStreamController.stream;

  Future<void> fetch(String query) async {
    final result = await repository.fetch(query);
    _PhotoStreamController.add(result);
  }
}
