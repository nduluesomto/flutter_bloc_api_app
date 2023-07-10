part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();
  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {}

class PostLoaded extends PostState {
  final List<PostDataModel> postModel;
  const PostLoaded({required this.postModel});
}

class ErrorState extends PostState {
  final String? errorMessage;
  const ErrorState({required this.errorMessage});
}
