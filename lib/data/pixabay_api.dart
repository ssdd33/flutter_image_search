import 'dart:convert';

import 'package:flutter_image_search/data/photo_api_repository.dart';
import 'package:flutter_image_search/model/photo.dart';
import 'package:http/http.dart' as http;

class pixabayApi extends PhotoApiRepository {
  final baseUrl = 'https://pixabay.com/api/';
  final apiKey = '35947055-4ef644451f941ac78110df829';

  @override
  Future<List<Photo>> fetch(String query) async {
    final response = await http
        .get(Uri.parse('$baseUrl?key=$apiKey&q=$query&image_type=photo'));

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    Iterable hits = jsonResponse['hits'];
    return hits.map((e) => Photo.fromJson(e)).toList();
  }
}
