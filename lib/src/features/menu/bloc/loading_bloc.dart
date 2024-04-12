import 'package:bloc/bloc.dart';
import 'package:coffee_shop/src/common/network/repositories/category_repository/interface_category_repository.dart';
import 'package:coffee_shop/src/common/network/repositories/products_repository/interface_products_repository.dart';
import 'package:coffee_shop/src/features/menu/data/category_data.dart';

part 'loading_event.dart';
part 'loading_state.dart';

final class LoadingBloc extends Bloc<LoadingEvent, LoadingState> {
  LoadingBloc(this.categoryRepository, this.productRepository,
      this.categoriesForApp, this.categoryEnd)
      : super(const LoadingInitial([], {})) {
    on<LoadCategoriesEvent>(_handleLoadCategoriesEvent);
    on<LoadMoreProductsEvent>(_handleLoadMoreProductsEvent);
  }
  List<CategoryData> categoriesForApp;
  final ICategoryRepository categoryRepository;
  final IProductRepository productRepository;
  final Map<int, List<dynamic>> categoryEnd;

  void _handleLoadCategoriesEvent(
      LoadCategoriesEvent event, Emitter<LoadingState> emit) async {
    try {
      categoriesForApp = await categoryRepository.loadOnlyCategories();
      for (CategoryData category in categoriesForApp) {
        await productRepository.initialLoadProductsByCategory(category);
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
        final bool ended = await productRepository.loadMoreProductsByCategory(
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
