import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/model/category.dart';

class CategoryProvider extends StateNotifier<List<Category>> {
  CategoryProvider() : super([]);

  // set/ update the state
  void setCategory(List<Category> category) {
    state = category;
  }
}

final categoryProvider =
    StateNotifierProvider<CategoryProvider, List<Category>>(
        (ref) => CategoryProvider());
