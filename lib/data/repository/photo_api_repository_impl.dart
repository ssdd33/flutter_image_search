import 'package:flutter_image_search/data/source/pixabay_api.dart';
import 'package:flutter_image_search/data/source/result.dart';
import 'package:flutter_image_search/domain/repository/photo_api_repository.dart';
import 'package:flutter_image_search/domain/model/photo.dart';

class PhotoApiRepositoryImpl implements PhotoApiRepository {
  PixabayApi api;
  PhotoApiRepositoryImpl(this.api);

  @override
  Future<Result<List<Photo>>> fetch(String query) async {
    final Result<Iterable> response = await api.fetch(query);
    return response.when(success: (iterable) {
      return Result.success(iterable.map((e) => Photo.fromJson(e)).toList());
    }, error: (message) {
      return Result.error(message);
    });
  }
}
