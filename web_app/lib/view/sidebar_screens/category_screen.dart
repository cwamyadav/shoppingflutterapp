import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:web_app/controller/category_controller.dart';
import 'package:web_app/view/sidebar_screens/widget/category_widget.dart';

class CategoryScreen extends StatefulWidget {
  static const String id = 'category-screen';
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  dynamic _image;
  dynamic _bannerImage;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  late String categoryName;
  CategoryController _categoryController = CategoryController();
  pickImage() async {
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

  pickCategoryImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    if (result != null) {
      setState(() {
        _bannerImage = result.files.first.bytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(4.0),
                child: Divider(
                  color: Colors.grey,
                  thickness: 1,
                  height: 1,
                ),
              ),
              // category image, categoryname, cancel, save buton
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Column(
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
                        SizedBox(
                          height: 5,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              pickImage();
                            },
                            child: Text('Pick Image')),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: SizedBox(
                        width: 180,
                        child: TextFormField(
                          onChanged: (value){
                            categoryName = value;
                          },
                          validator: (value) {
                            if (value!.isNotEmpty) {
                              return null;
                            } else {
                              return "Please enter category name";
                            }
                          },
                          textAlign: TextAlign.center,
                          decoration:
                              InputDecoration(hintText: 'Enter Category name'),
                        ),
                      ),
                    ),
                    TextButton(onPressed: () {}, child: Text('Cancel')),
                    SizedBox(
                      width: 10,
                    ),
                    // save button
                    ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(Colors.deepPurple),
                          foregroundColor:
                              WidgetStateProperty.all(Colors.white),
                        ),
                        onPressed: () {
                          // print(_categoryText.text);
                          if (_formkey.currentState!.validate()) {
                            _categoryController.uploadCategory(
                              pickedImage: _image,
                              pickedBanner: _bannerImage,
                              name: categoryName,
                              context: context,
                            );
                          }
                        },
                        child: Text('save')),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.all(4.0),
                child: Divider(
                  color: Colors.grey,
                  thickness: 1,
                  height: 1,
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Category',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      // SizedBox(
                      //   width: 20,
                      // ),
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            height: 150,
                            width: 150,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10)),
                            child: _bannerImage != null
                                ? Image.memory(_bannerImage)
                                : Text(
                                    'Category Banner',
                                  ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              pickCategoryImage();
                            },
                            child: Text('Pick Image'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 2,
                    color: Colors.red,
                  ),
                  CategoryWidget(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
