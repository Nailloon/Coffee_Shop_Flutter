part of 'loading_bloc.dart';

sealed class LoadingEvent {
  const LoadingEvent();
}

class LoadCategoriesEvent extends LoadingEvent {}
