import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  static const String id = 'category-screen';
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  dynamic _image;
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

  @override
  Widget build(BuildContext context) {
    return Column(
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
        // category image, categoryname, cancel save buton
        Row(
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
                  child:_image!=null?Image.memory(_image): Text('Category Image'),
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
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(hintText: 'Enter Category name'),
                ),
              ),
            ),
            TextButton(onPressed: () {}, child: Text('Cancel')),
            SizedBox(
              width: 10,
            ),
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.deepPurple),
                  foregroundColor: WidgetStateProperty.all(Colors.white),
                ),
                onPressed: () {},
                child: Text('Submit')),
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
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  height: 150,
                  width: 150,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    'Category Image',
                  ),
                ),
                // Image.asset('assets/images/')
              ],
            )
          ],
        )
      ],
    );
  }
}
