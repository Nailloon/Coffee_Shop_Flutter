part of 'loading_bloc.dart';

sealed class LoadingState {
  final List<CategoryData> categories;
  const LoadingState(this.categories);
}

final class LoadingInitial extends LoadingState {
  const LoadingInitial(super.categories);
}

final class LoadingCompleted extends LoadingState {
  final Map<int, List<dynamic>> loadingCompleteForCategory;
  const LoadingCompleted(super.categories, this.loadingCompleteForCategory);
}

final class LoadingFailure extends LoadingState {
  final Object? exception;

  const LoadingFailure(super.categories, {required this.exception});
}
