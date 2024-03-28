import 'package:bloc/bloc.dart';
import 'package:coffee_shop/src/common/network/repositories/interface_repository.dart';
import 'package:coffee_shop/src/features/menu/data/category_data.dart';
import 'package:flutter/material.dart';

part 'loading_event.dart';
part 'loading_state.dart';

class LoadingBloc extends Bloc<LoadingEvent, LoadingState> {
  LoadingBloc(this.coffeeRepository) : super(const LoadingInitial([])) {
    on<LoadCategoriesEvent>(_handleLoadCategoriesEvent);
  }

  final IRepository coffeeRepository;

  void _handleLoadCategoriesEvent(
      LoadCategoriesEvent event, Emitter<LoadingState> emit) async {
    try {
      final categoriesForApp =
          await coffeeRepository.loadCategoriesWithProducts();
      debugPrint('Loading Categories');
      emit(LoadingCompleted(categoriesForApp));
    } catch (e) {
      emit(LoadingFailure(state.categories, exception: e));
    }
  }
}
