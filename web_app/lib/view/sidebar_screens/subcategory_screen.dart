import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:web_app/controller/category_controller.dart';
import 'package:web_app/controller/sub_category_controller.dart';
import 'package:web_app/models/category.dart';
import 'package:web_app/view/sidebar_screens/widget/sub_category_widget.dart';

// drop down button, pick image button, save button,
// textfiled for the tille name writtern
class SubcategoryScreen extends StatefulWidget {
  static const String id = 'subSategoryScreen';
  const SubcategoryScreen({super.key});

  @override
  State<SubcategoryScreen> createState() => _SubcategoryScreenState();
}

class _SubcategoryScreenState extends State<SubcategoryScreen> {
  dynamic _image;
  late String subCategoryName;
  late Future<List<Category>> futureCategories;
  Category? selectedCategory;
  final _subCategoryController = SubCategoryController();

  // store the image from the device
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  pickSubCategoryImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    if (result != null) {
      setState(() {
        _image = result.files.first.bytes;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    futureCategories = CategoryController().loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkey,
        child: Padding(
          padding: EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SubCategories',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
              Padding(
                padding: EdgeInsets.all(4.0),
                child: Divider(
                  color: Colors.grey,
                  thickness: 1,
                  height: 1,
                ),
              ),
              FutureBuilder(
                  future: futureCategories,
                  builder: (context, snapshot) {
                    // waiting: rotate,
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    // errror
                    else if (snapshot.hasError) {
                      return Center(
                        child: Text("Error: ${snapshot.error}"),
                      );
                    }
                    // not present
                    else if (!snapshot.hasData || snapshot.data == null) {
                      return Center(
                        child: Text('No Data found'),
                      );
                    }
                    // show the ui
                    else {
                      return DropdownButton(
                          value: selectedCategory,
                          hint: Text('Select Category'),
                          items: snapshot.data!.map((Category category) {
                            return DropdownMenuItem(
                                value: category, child: Text(category.name));
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedCategory = value;
                            });
                            print(selectedCategory!.name);
                          });
                    }
                  }),
              Row(
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(5)),
                    child: _image != null
                        ? Image.memory(_image)
                        : Text('Category Image'),
                  ),
                  // tex field
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      width: 180,
                      child: TextFormField(
                        onChanged: (value) {
                          subCategoryName = value;
                        },
                        validator: (value) {
                          if (value!.isNotEmpty) {
                            return null;
                          } else {
                            return "Please enter subCategory name";
                          }
                        },
                        textAlign: TextAlign.center,
                        decoration:
                            InputDecoration(hintText: 'Enter SubCategory name'),
                      ),
                    ),
                  ),
                  // save button
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(Colors.blue)),
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
                          _subCategoryController.uploadSubCategory(
                            categoryId: selectedCategory!.id,
                            categoryName: selectedCategory!.name,
                            subCategoryName: subCategoryName,
                            subCategoyimage: _image,
                            context: context,
                          );
                        }
                        setState(() {
                          _formkey.currentState!.reset();
                          _image = null;
                        });
                      },
                      child: Text('save')),
                ],
              ),
              // button pickedimage,
              Padding(
                padding: EdgeInsets.all(4),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.blue)),
                  onPressed: () {
                    pickSubCategoryImage();
                  },
                  child: Text('picked image'),
                ),
              ),
              Divider(
                thickness: 1,
                color: Colors.red,
              ),
              SubCategoryWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
