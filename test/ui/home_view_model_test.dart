import 'package:flutter_image_search/data/source/result.dart';
import 'package:flutter_image_search/domain/repository/photo_api_repository.dart';
import 'package:flutter_image_search/domain/model/photo.dart';
import 'package:flutter_image_search/domain/use_case/get_photos_use_case.dart';
import 'package:flutter_image_search/presentation/home/home_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('check stream', () async {
    final viewModel = HomeViewModel(GetPhotosUseCase(FakePhotoApiRepository()));
    // await viewModel.fetch('apple');

    await viewModel.fetch('apple');

    final List<Photo> result = fakeJson.map((e) => Photo.fromJson(e)).toList();
    expect(viewModel.state.photos, result);
  });
}

class FakePhotoApiRepository extends PhotoApiRepository {
  @override
  Future<Result<List<Photo>>> fetch(String query) async {
    Future.delayed(const Duration(milliseconds: 500));
    return Result.success(fakeJson.map((e) => Photo.fromJson(e)).toList());
  }
}

List<Map<String, dynamic>> fakeJson = [
  {
    "id": 634572,
    "pageURL":
        "https://pixabay.com/photos/apples-fruits-red-ripe-vitamins-634572/",
    "type": "photo",
    "tags": "apples, fruits, red",
    "previewURL":
        "https://cdn.pixabay.com/photo/2015/02/13/00/43/apples-634572_150.jpg",
    "previewWidth": 100,
    "previewHeight": 150,
    "webformatURL":
        "https://pixabay.com/get/ge73655a5e91434ade5b5b2c197a6bfc39a7be89bca1956f6f3f4575c529ddb701d665cf847f7c32d1bb17fbebbf32513_640.jpg",
    "webformatWidth": 427,
    "webformatHeight": 640,
    "largeImageURL":
        "https://pixabay.com/get/ga2e7cbf1c067d1b6b5e999f6b621f8cdd7b0a7cce5f3f7681e74c3c07b5442d172e8adf5ecce9294e0871fd07f7e3ae785a1faa498102eb6ec5342549fe5d451_1280.jpg",
    "imageWidth": 3345,
    "imageHeight": 5017,
    "imageSize": 811238,
    "views": 503847,
    "downloads": 300713,
    "collections": 1297,
    "likes": 2383,
    "comments": 197,
    "user_id": 752536,
    "user": "Desertrose7",
    "userImageURL":
        "https://cdn.pixabay.com/user/2016/03/14/13-25-18-933_250x250.jpg"
  },
  {
    "id": 1868496,
    "pageURL":
        "https://pixabay.com/photos/apple-computer-desk-workspace-1868496/",
    "type": "photo",
    "tags": "apple, computer, desk",
    "previewURL":
        "https://cdn.pixabay.com/photo/2016/11/29/08/41/apple-1868496_150.jpg",
    "previewWidth": 150,
    "previewHeight": 99,
    "webformatURL":
        "https://pixabay.com/get/g03f12d5b65d13cc5ae4e548ab76da696a9fc6927c9d055b11d1cf777ba617281e507bf4bd1b7ce3666efb819d061476f25608f207adcb0398e8cb32599619b8f_640.jpg",
    "webformatWidth": 640,
    "webformatHeight": 426,
    "largeImageURL":
        "https://pixabay.com/get/g83bd6e1b28d0d72d2e5a21d48e2eef26d63ef3a98c46013307635e166fba572d29f78386bc1e1db80a30779af894595427ec7a7c83e92e2e7357c030c9720bce_1280.jpg",
    "imageWidth": 5184,
    "imageHeight": 3456,
    "imageSize": 2735519,
    "views": 729518,
    "downloads": 535468,
    "collections": 1404,
    "likes": 1054,
    "comments": 282,
    "user_id": 2286921,
    "user": "Pexels",
    "userImageURL":
        "https://cdn.pixabay.com/user/2016/03/26/22-06-36-459_250x250.jpg"
  },
];
