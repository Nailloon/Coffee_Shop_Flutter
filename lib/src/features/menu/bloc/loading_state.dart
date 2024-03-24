part of 'loading_bloc.dart';

class LoadingState{

}

class LoadingInitial extends LoadingState{
  
}

class LoadingCompleted extends LoadingState{
  final List<CategoryData> categories;

  LoadingCompleted({required this.categories});
}

class LoadingFailure extends LoadingState{
  final Object? exception;
  
  LoadingFailure({required this.exception});
}