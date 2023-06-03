import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_image_search/data/source/result.dart';

import 'package:flutter_image_search/domain/repository/photo_api_repository.dart';
import 'package:flutter_image_search/domain/model/photo.dart';
import 'package:flutter_image_search/presentation/home/home_state.dart';
import 'package:flutter_image_search/presentation/home/home_ui_event.dart';

class HomeViewModel with ChangeNotifier {
  final PhotoApiRepository repository;
  HomeState _state = HomeState(false, []);
  HomeState get state => _state;

  final _eventController = StreamController<HomeUiEvent>();

  Stream<HomeUiEvent> get eventStream => _eventController.stream;

  HomeViewModel(
    this.repository,
  );

  Future<void> fetch(String query) async {
    _state = state.copy(isLoading: true);
    notifyListeners();
    final Result<List<Photo>> result = await repository.fetch(query);

    result.when(success: (photos) {
      _state = state.copy(photos: photos);
      notifyListeners();
    }, error: (message) {
      _eventController.add(HomeUiEvent.showSnackBar(message));
    });
    _state = state.copy(isLoading: false);
    notifyListeners();
  }
}
