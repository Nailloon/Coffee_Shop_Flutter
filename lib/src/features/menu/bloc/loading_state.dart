part of 'loading_bloc.dart';

sealed class LoadingState {
  final List<CategoryModel> categories;
  final Map<int, List<dynamic>> loadingCompleteForCategory;
  const LoadingState(this.categories, this.loadingCompleteForCategory);
}

final class LoadingInitial extends LoadingState {
  const LoadingInitial(super.categories, super.loadingCompleteForCategory);
}

final class LoadingCompleted extends LoadingState {
  const LoadingCompleted(super.categories, super.loadingCompleteForCategory);
}

final class LoadingFailure extends LoadingState {
  final Object? exception;

  const LoadingFailure(super.categories, super.loadingCompleteForCategory,
      {required this.exception});
}
