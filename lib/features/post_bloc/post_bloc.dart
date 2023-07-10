import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_fetch_api/resources/api_repository.dart';
import 'package:meta/meta.dart';

import '../../models/post_models.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial()) {
    on<GetPostList>(_getPostList);
  }

  final ApiRepository _apiRepository = ApiRepository();

  Future<void> _getPostList(GetPostList event, Emitter<PostState> emit) async {
    try {
      emit(PostInitial());

      final List<PostDataModel> postList = await _apiRepository.fetchPosts();
      emit(PostLoaded(postModel: postList));
      if (postList[0].error != null) {
        emit(ErrorState(errorMessage: postList[0].error));
      }
    } on NetworkError {
      emit(const ErrorState(errorMessage: "Failed to fetch Data"));
    }
  }
}
