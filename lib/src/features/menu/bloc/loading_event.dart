part of 'loading_bloc.dart';

sealed class LoadingEvent {
  const LoadingEvent();
}

final class LoadCategoriesEvent extends LoadingEvent {}

final class LoadMoreProductsEvent extends LoadingEvent {
  final CategoryModel category;
  const LoadMoreProductsEvent(this.category);
}
