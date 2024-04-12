import 'package:coffee_shop/src/common/network/data_sources/category_data_source/interface_category_data_source.dart';
import 'package:coffee_shop/src/features/database/database/coffee_database.dart';
import 'package:coffee_shop/src/features/menu/data/category_data.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';

abstract interface class ISavableCategoryDataSource
    implements ICategoryDataSource {
  void saveCategory(CategoryData category);
}

class SavableCategoryDataSource implements ISavableCategoryDataSource {
  final AppDatabase database;
  const SavableCategoryDataSource(this.database);
  @override
  Future<List<CategoryData>> fetchOnlyCategories() async {
    List<Category> allItems = await database.select(database.categories).get();
    List<CategoryData> categories = [];
    debugPrint('items in database: $allItems');
    for (var category in allItems) {
      categories.add(
          CategoryData(id: category.id, name: category.name, products: []));
    }
    debugPrint('Categories: $categories');
    return categories;
  }

  @override
  void saveCategory(CategoryData category) {
    database.into(database.categories).insertOnConflictUpdate(
        CategoriesCompanion(
            id: Value(category.id), name: Value(category.name)));
  }
}
