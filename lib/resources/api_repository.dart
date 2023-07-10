import 'package:flutter_bloc_fetch_api/features/post_bloc/post_bloc.dart';
import 'package:flutter_bloc_fetch_api/models/post_models.dart';
import 'package:flutter_bloc_fetch_api/resources/api_provider.dart';

class ApiRepository {
  final ApiProvider _apiProvider = ApiProvider();

  Future<List<PostDataModel>> fetchPosts() {
    return _apiProvider.fetchPostList();
  }
}

class NetworkError extends ErrorState {
  const NetworkError({required super.errorMessage});
}
