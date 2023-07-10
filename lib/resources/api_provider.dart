import 'package:dio/dio.dart';

import '../models/post_models.dart';

class ApiProvider {
  Dio dio = Dio();
  final String _postsUrl = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<PostDataModel>> fetchPostList() async {
    try {
      Response response = await dio.get(_postsUrl);
      List<dynamic> value = response.data;
      return value.map((e) => PostDataModel.fromJson(e)).toList();
    } catch (e) {
      if (e.toString().contains("SocketException")) {
        return [PostDataModel.withError('Check your internet connection')];
      }
      return [PostDataModel.withError(e.toString())];
    }
  }
}
