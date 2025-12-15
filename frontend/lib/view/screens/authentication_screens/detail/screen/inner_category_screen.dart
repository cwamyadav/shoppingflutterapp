import 'package:flutter/material.dart';
import 'package:forntend/controller/sub_category_controller.dart';
import 'package:forntend/model/category.dart';
import 'package:forntend/model/sub_category.dart';
import 'package:forntend/view/screens/authentication_screens/detail/screen/widget/inner_banner_widget.dart';
import 'package:forntend/view/screens/authentication_screens/detail/screen/widget/inner_header_widget.dart';
import 'package:forntend/view/screens/authentication_screens/detail/screen/widget/subcategory_tile_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class InnerCategoryScreen extends StatefulWidget {
  final Category category;
  const InnerCategoryScreen({required this.category, super.key});

  @override
  State<InnerCategoryScreen> createState() => _InnerCategoryScreenState();
}

class _InnerCategoryScreenState extends State<InnerCategoryScreen> {
  late Future<List<SubCategory>> futureSubCategories;

  @override
  void initState() {
    super.initState();
    futureSubCategories = SubCategoryController()
        .loadSubCategorybyCategoryName(widget.category.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.20),
        child: InnerHeaderWidget(),
      ),
      body: Column(
        children: [
          InnerBannerWidget(image: widget.category.image),
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
          Expanded(
            child: FutureBuilder(
              future: futureSubCategories,
              builder: (context, snapshot) {
                // waiting
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                // error
                else if (snapshot.hasError) {
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
                              // ✅ horizontal scroll per row
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
        ],
      ),
    );
  }
}
