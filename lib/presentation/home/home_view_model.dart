import 'dart:async';
import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter_image_search/data/source/result.dart';

import 'package:flutter_image_search/domain/repository/photo_api_repository.dart';
import 'package:flutter_image_search/domain/model/photo.dart';

class HomeViewModel with ChangeNotifier {
  final PhotoApiRepository repository;

  List<Photo> _photos = [];
  UnmodifiableListView<Photo> get photos => UnmodifiableListView(_photos);

  HomeViewModel(
    this.repository,
  );

  Future<void> fetch(String query) async {
    final Result<List<Photo>> result = await repository.fetch(query);

    result.when(success: (photos) {
      _photos = photos;
      notifyListeners();
    }, error: (message) {
      print(message);
    });
  }
}
