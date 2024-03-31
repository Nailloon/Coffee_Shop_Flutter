import 'package:bloc/bloc.dart';
import 'package:coffee_shop/src/common/network/repositories/interface_repository.dart';
import 'package:coffee_shop/src/features/menu/data/category_data.dart';

part 'loading_event.dart';
part 'loading_state.dart';

final class LoadingBloc extends Bloc<LoadingEvent, LoadingState> {
  LoadingBloc(this.coffeeRepository, this.categoriesForApp, this.categoryEnd)
      : super(const LoadingInitial([], {})) {
    on<LoadCategoriesEvent>(_handleLoadCategoriesEvent);
    on<LoadMoreProductsEvent>(_handleLoadMoreProductsEvent);
  }
  List<CategoryData> categoriesForApp;
  final IRepository coffeeRepository;
  final Map<int, List<dynamic>> categoryEnd;

  void _handleLoadCategoriesEvent(
      LoadCategoriesEvent event, Emitter<LoadingState> emit) async {
    try {
      categoriesForApp = await coffeeRepository.loadCategoriesWithProducts();
      for (CategoryData category in categoriesForApp) {
        categoryEnd.addAll({
          category.id: [false, 1]
        });
      }
      emit(LoadingCompleted(categoriesForApp, categoryEnd));
    } catch (e) {
      emit(LoadingFailure(state.categories, state.loadingCompleteForCategory,
          exception: e));
    }
  }

  void _handleLoadMoreProductsEvent(
      LoadMoreProductsEvent event, Emitter<LoadingState> emit) async {
    try {
      if (categoryEnd[event.category.id]![0] == false) {
        final bool ended = await coffeeRepository.loadMoreProductsByCategory(
            event.category, categoryEnd[event.category.id]![1]);
        categoryEnd[event.category.id]![1] += 1;
        categoryEnd[event.category.id]![0] = ended;
      }
      emit(LoadingCompleted(categoriesForApp, categoryEnd));
    } catch (e) {
      emit(LoadingFailure(state.categories, categoryEnd, exception: e));
    }
  }
}
