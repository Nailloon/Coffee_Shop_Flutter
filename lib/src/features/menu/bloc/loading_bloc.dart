import 'package:bloc/bloc.dart';
import 'package:coffee_shop/src/common/network/repositories/interface_repository.dart';
import 'package:coffee_shop/src/features/menu/data/category_data.dart';
import 'package:flutter/material.dart';

part 'loading_event.dart';
part 'loading_state.dart';

class LoadingBloc extends Bloc<LoadingEvent, LoadingState> {
  LoadingBloc(this.coffeeRepository) : super(LoadingInitial()) {
    on<LoadingEvent>((event, emit) async {
      try {
        final categoriesForApp =
            await coffeeRepository.fetchCategoriesWithProducts();
        debugPrint('fdffff');
        emit(LoadingCompleted(categories: categoriesForApp));
      } catch (e) {
       emit(LoadingFailure(exception: e));
      }
    });
  }

  final IRepository coffeeRepository;
}
