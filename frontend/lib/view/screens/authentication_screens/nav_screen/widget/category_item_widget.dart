import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/controller/category_controller.dart';
import 'package:frontend/model/category.dart';
import 'package:frontend/provider/category_provider.dart';
import 'package:frontend/view/screens/authentication_screens/detail/screen/inner_category_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryItemWidget extends ConsumerStatefulWidget {
  const CategoryItemWidget({super.key});

  @override
  ConsumerState<CategoryItemWidget> createState() => _CategoryItemWidgetState();
}

class _CategoryItemWidgetState extends ConsumerState<CategoryItemWidget> {
  late Future<List<Category>> futurecategories;
  Future<void> _fetchCategories() async {
    final CategoryController categoryController = CategoryController();
    try {
      final List<Category> categories =
          await categoryController.loadCategories();
      ref.read(categoryProvider.notifier).setCategory(categories);
    } catch (e) {
      print('$e');
    }
  }

  @override
  void initState() {
    super.initState();
    // futurecategories = CategoryController().loadCategories();
    _fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoryProvider);
    return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount:categories.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              final category = categories[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              InnerCategoryScreen(category: category)));
                },
                child: Column(
                  children: [
                    Image.network(
                      category.image,
                      height: 47,
                      width: 47,
                    ),
                    Text(
                      category.name,
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              );
            }));
  }
}
