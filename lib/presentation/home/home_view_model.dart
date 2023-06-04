import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_image_search/data/source/result.dart';

import 'package:flutter_image_search/domain/model/photo.dart';
import 'package:flutter_image_search/domain/use_case/get_photos_use_case.dart';
import 'package:flutter_image_search/presentation/home/home_state.dart';
import 'package:flutter_image_search/presentation/home/home_ui_event.dart';

class HomeViewModel with ChangeNotifier {
  GetPhotosUseCase getPhotosUseCase;
  HomeState _state = HomeState(false, []);
  HomeState get state => _state;

  final _eventController = StreamController<HomeUiEvent>();
  Stream<HomeUiEvent> get eventStream => _eventController.stream;

  HomeViewModel(
    this.getPhotosUseCase,
  );

  Future<void> fetch(String query) async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();
    final Result<List<Photo>> result = await getPhotosUseCase.excute(query);

    result.when(success: (photos) {
      _state = state.copyWith(photos: photos);
      notifyListeners();
    }, error: (message) {
      _eventController.add(HomeUiEvent.showSnackBar(message));
    });
    _state = state.copyWith(isLoading: false);
    notifyListeners();
  }
}
