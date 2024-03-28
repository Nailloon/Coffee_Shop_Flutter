part of 'loading_bloc.dart';

sealed class LoadingState {
  final List<CategoryData> categories;
  const LoadingState(this.categories);
}

class LoadingInitial extends LoadingState {
  const LoadingInitial(super.categories);
}

class LoadingCompleted extends LoadingState {

  const LoadingCompleted(super.categories);
}

class LoadingFailure extends LoadingState {
  final Object? exception;

  const LoadingFailure(super.categories, {required this.exception});
}
