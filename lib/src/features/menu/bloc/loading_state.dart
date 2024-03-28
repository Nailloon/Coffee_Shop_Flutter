part of 'loading_bloc.dart';

sealed class LoadingState {
  const LoadingState();
}

class LoadingInitial extends LoadingState {}

class LoadingCompleted extends LoadingState {
  final List<CategoryData> categories;

  const LoadingCompleted({required this.categories});
}

class LoadingFailure extends LoadingState {
  final Object? exception;

  const LoadingFailure({required this.exception});
}
