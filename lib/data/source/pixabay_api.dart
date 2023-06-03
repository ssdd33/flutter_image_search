import 'dart:convert';

import 'package:flutter_image_search/data/source/result.dart';
import 'package:http/http.dart' as http;

class PixabayApi {
  final http.Client client;

  PixabayApi(
    this.client,
  );

  static const baseUrl = 'https://pixabay.com/api/';
  static const apiKey = '35947055-4ef644451f941ac78110df829';

  Future<Result<Iterable>> fetch(String query) async {
    try {
      final response = await client
          .get(Uri.parse('$baseUrl?key=$apiKey&q=$query&image_type=photo'));
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      Iterable hits = jsonResponse['hits'];
      return Result.success(hits);
    } catch (e) {
      return const Result.error('이미지 로딩 실패');
    }
  }
}
