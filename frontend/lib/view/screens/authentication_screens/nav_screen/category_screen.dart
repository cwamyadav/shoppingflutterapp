import 'package:flutter/material.dart';
import 'package:forntend/controller/category_controller.dart';
import 'package:forntend/controller/sub_category_controller.dart';
import 'package:forntend/model/category.dart';
import 'package:forntend/model/sub_category.dart';
import 'package:forntend/view/screens/authentication_screens/detail/screen/widget/subcategory_tile_widget.dart';
import 'package:forntend/view/screens/authentication_screens/nav_screen/widget/header_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryScreen extends StatefulWidget {
  static const String id = 'category-screen';
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}
// what doing: display subcategories,
//

class _CategoryScreenState extends State<CategoryScreen> {
  late Future<List<Category>> futureCategories;
  late Future<List<SubCategory>> futureSubCategories;
  List<SubCategory> _subCategories = [];
  Category? selectedCategory;
  // String ?selectedCategoryName;
  @override
  void initState() {
    super.initState();
    futureCategories = CategoryController().loadCategories();
    // once the categories loaded process then
    futureCategories.then((categories) {
      // iterate through the categories the "fashion" categories
      for (var category in categories) {
        if (category.name == "mobile") {
          // if fashion category found set it selected category
          setState(() {
            selectedCategory = category;
          });
          // load the subcategories for the "fashion" category
          getsubCatetgories(category.name);
        }
      }
    });
  }

  //load the subcategories by categoryname
  Future<void> getsubCatetgories(String seledtedCategoryName) async {
    final futureSubCategories = await SubCategoryController()
        .loadSubCategorybyCategoryName(seledtedCategoryName);
    setState(() {
      _subCategories = futureSubCategories;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height * 20,
        ),
        child: HeaderWidget(),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // left side showing list of categories,
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.grey,
              child: FutureBuilder(
                future: futureCategories,
                builder: (context, snapshot) {
                  // rotating
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  // empty
                  else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('no data found'));
                  }
                  // error
                  else if (snapshot.hasError) {
                    return Center(
                      child: Text('error:${snapshot.error}'),
                    );
                  }
                  // loading
                  else {
                    final categories = snapshot.data!;
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return ListTile(
                          onTap: () async {
                            setState(() {
                              selectedCategory = category;
                            });
                            // function call to find categories
                            await getsubCatetgories(category.name);
                          },
                          focusColor: Colors.red,
                          title: Text(
                            category.name,
                            style: GoogleFonts.quicksand(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: selectedCategory == category
                                  ? Colors.blue
                                  : null,
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
          // showing category name, banner, and subacategories, subcategoryname,
          Expanded(
            flex: 5,
            child: selectedCategory != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        selectedCategory!.name,
                        style: GoogleFonts.quicksand(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.7),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Container(
                          height: 150,
                          child: Image.network(
                            selectedCategory!.banner,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // subcategories showing
                      _subCategories.isNotEmpty
                          ? Expanded(
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: _subCategories.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        mainAxisSpacing: 4,
                                        crossAxisSpacing: 8,
                                        childAspectRatio: 2 / 3),
                                itemBuilder: (context, index) {
                                  final _subcategory = _subCategories[index];

                                  return SubcategoryTileWidget(
                                    image: _subcategory.image,
                                    name: _subcategory.subCategoryName,
                                  );
                                },
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.all(8),
                              child: Center(
                                child: Text(
                                  'No Subcategories found',
                                  style: GoogleFonts.quicksand(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                    ],
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}
