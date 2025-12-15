import 'package:flutter/material.dart';
import 'package:web_app/controller/sub_category_controller.dart';
import 'package:web_app/models/sub_category.dart';

class SubCategoryWidget extends StatefulWidget {
  const SubCategoryWidget({super.key});

  @override
  State<SubCategoryWidget> createState() => _SubCategoryWidgetState();
}

class _SubCategoryWidgetState extends State<SubCategoryWidget> {
  late Future<List<SubCategory>> futureSubCategories;
  @override
  void initState() {
    super.initState();
    futureSubCategories = SubCategoryController().loadSubCategory();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futureSubCategories,
        builder: (context, snapshot) {
          // waiting
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          // error
          else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          // empty: no data found
          else if (!snapshot.hasData || snapshot.data == null) {
            return Center(
              child: Text('No data found'),
            );
          }
          // give show the ui
          else {
            final subcategories = snapshot.data!;
            return GridView.builder(
                shrinkWrap: true,
                itemCount: subcategories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  final subcategory = subcategories[index];
                  return Column(
                    children: [
                      Image.network(
                        subcategory.image,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                      Text(subcategory.subCategoryName),
                    ],
                  );
                });
          }
        });
  }
}
