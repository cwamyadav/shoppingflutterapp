import 'package:flutter/material.dart';
import 'package:frontend/controller/product_controller.dart';
import 'package:frontend/controller/sub_category_controller.dart';
import 'package:frontend/model/category.dart';
import 'package:frontend/model/product.dart';
import 'package:frontend/model/sub_category.dart';
import 'package:frontend/view/screens/authentication_screens/detail/screen/widget/inner_banner_widget.dart';
import 'package:frontend/view/screens/authentication_screens/detail/screen/widget/inner_header_widget.dart';
import 'package:frontend/view/screens/authentication_screens/detail/screen/widget/subcategory_tile_widget.dart';
import 'package:frontend/view/screens/authentication_screens/nav_screen/widget/product_item_widget.dart';
import 'package:frontend/view/screens/authentication_screens/nav_screen/widget/reusable_text_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class InnerCategoryContentWidget extends StatefulWidget {
  final Category category;
  const InnerCategoryContentWidget({required this.category, super.key});

  @override
  State<InnerCategoryContentWidget> createState() =>
      _InnerCategoryContentWidgetState();
}

class _InnerCategoryContentWidgetState
    extends State<InnerCategoryContentWidget> {
  late Future<List<SubCategory>> futureSubCategories;
  late Future<List<Product>> futureProductsByCategory;

  @override
  void initState() {
    super.initState();
    futureSubCategories = SubCategoryController()
        .loadSubCategorybyCategoryName(widget.category.name);
    futureProductsByCategory =
        ProductController().loadProductsByCategory(widget.category.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          PreferredSize(
            preferredSize:
                Size.fromHeight(MediaQuery.of(context).size.height * 0.20),
            child: InnerHeaderWidget(),
          ),
          InnerBannerWidget(image: widget.category.banner),
          Center(
            child: Text(
              'Shop by Subcategories',
              style: GoogleFonts.quicksand(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.7,
              ),
            ),
          ),
          // aim: find the subcategory by name(which click at main screen),
          SizedBox(
            child: FutureBuilder(
              future: futureSubCategories,
              builder: (context, snapshot) {
                // waiting
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error:${snapshot.error}'),
                  );
                }
                // empty
                else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text('no data found'),
                  );
                }
                // loading
                else {
                  final subCategories = snapshot.data!;
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: List.generate(
                        (subCategories.length / 7).ceil(),
                        (setIndex) {
                          final start = setIndex * 7;
                          final end = (setIndex + 1) * 7;
      
                          return Padding(
                            padding: const EdgeInsets.all(8.9),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: subCategories
                                    .sublist(
                                      start,
                                      end > subCategories.length
                                          ? subCategories.length
                                          : end,
                                    )
                                    .map(
                                      (subcategory) => SubcategoryTileWidget(
                                        image: subcategory.image,
                                        name: subcategory.subCategoryName,
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
              },
            ),
          ),
          ReusableTextWidget(title: 'products', subtitle: 'view all'),
          FutureBuilder(
        future: futureProductsByCategory,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error:${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('Empty data '),
            );
          } else {
            final productsbyCategory = snapshot.data!;
            return SizedBox(
              height: 250,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: productsbyCategory.length,
                  itemBuilder: (context, index) {
                    final prodcut = productsbyCategory[index];
                    return ProductItemWidget(product: prodcut);
                  }),
            );
          }
        }),
  
        ],
      ),
    );
  }
}
