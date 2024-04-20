import 'package:coffee_shop/src/common/network/data_sources/category_data_source/interface_category_data_source.dart';
import 'package:coffee_shop/src/features/database/database/coffee_database.dart';
import 'package:coffee_shop/src/features/menu/data/category_dto.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';

abstract interface class ISavableCategoryDataSource
    implements ICategoryDataSource {
  void saveCategory(CategoryDTO category);
}

class SavableCategoryDataSource implements ISavableCategoryDataSource {
  final AppDatabase database;
  const SavableCategoryDataSource(this.database);
  @override
  Future<List<CategoryDTO>> fetchOnlyCategories() async {
    List<Category> allItems = await database.select(database.categories).get();
    List<CategoryDTO> categories = [];
    debugPrint('items in database: $allItems');
    for (var category in allItems) {
      categories.add(CategoryDTO.fromDB(category));
    }
    debugPrint('Categories: $categories');
    return categories;
  }

  @override
  void saveCategory(CategoryDTO category) {
    database.into(database.categories).insertOnConflictUpdate(
        CategoriesCompanion(
            id: Value(category.id), name: Value(category.name)));
  }
}
