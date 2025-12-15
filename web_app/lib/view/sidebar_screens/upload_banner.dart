import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:web_app/controller/banner_controller.dart';
import 'package:web_app/view/sidebar_screens/widget/banner_widget.dart';

class UploadBannerScreen extends StatefulWidget {
  static const String id = 'upload-screen';
  const UploadBannerScreen({super.key});

  @override
  State<UploadBannerScreen> createState() => _UploadBannerScreenState();
}

class _UploadBannerScreenState extends State<UploadBannerScreen> {
  dynamic _bannerImage;
  BannerController _bannerController = BannerController();
  pickImage() async {
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner screen text
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.all(8),
              child: Text(
                'Banners',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            // devider
            Divider(
              color: Colors.grey,
              thickness: 2,
            ),
            // container upload save button
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    alignment: Alignment.center,
                    child: _bannerImage != null
                        ? Image.memory(_bannerImage)
                        : Text('upload banner'),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(Colors.lightBlue)),
                  onPressed: () async {
                    await _bannerController.uploadBanner(
                      pickedBannerImage: _bannerImage,
                      context: context,
                    );
                  },
                  child: Text('save'),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.lightBlue)),
                onPressed: () {
                  pickImage();
                },
                child: Text('Upload Image'),
              ),
            ),
            // devider
            Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            BannerWidget(),
          ],
        ),
      ),
    );
  }
}
