import 'package:flutter/material.dart';
import 'package:forntend/controller/category_controller.dart';
import 'package:forntend/model/category.dart';
import 'package:forntend/view/screens/authentication_screens/detail/screen/inner_category_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryItemWidget extends StatefulWidget {
  const CategoryItemWidget({super.key});

  @override
  State<CategoryItemWidget> createState() => _CategoryItemWidgetState();
}

class _CategoryItemWidgetState extends State<CategoryItemWidget> {
  late Future<List<Category>> futurecategories;
  @override
  void initState() {
    super.initState();
    futurecategories = CategoryController().loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: FutureBuilder(
          future: futurecategories,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            // error
            else if (snapshot.hasError) {
              return Center(
                child: Text('error: ${snapshot.error}'),
              );
            }
            //empty
            else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Text('no Data found'),
              );
            }
            // show the ui
            else {
              final categories = snapshot.data!;
              return GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: categories.length,
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
                  });
            }
          }),
    );
  }
}
