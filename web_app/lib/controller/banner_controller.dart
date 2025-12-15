import 'dart:convert';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:web_app/global_varriable.dart';
import 'package:web_app/models/banner_model.dart';
import 'package:http/http.dart' as http;
import 'package:web_app/services/manage_http_response.dart';

class BannerController {
  // upload the image function,
  uploadBanner({
    // what upload image, wrt context,
    required dynamic pickedBannerImage,
    required BuildContext context,
  }) async {
    try {
      // create container where store it
      CloudinaryPublic cloudinary = CloudinaryPublic(
        dotenv.env['CLOUDINARY_CLOUD_NAME']!,
        dotenv.env['CLOUDINARY_UPLOAD_PRESET']!,
      );// upload that image
      CloudinaryResponse imageResponse =
          await cloudinary.uploadFile(CloudinaryFile.fromBytesData(
        pickedBannerImage,
        identifier: 'pickedBanner',
        folder: 'bannerImages',
      ));

      // create the url
      String bannerImageUrl = imageResponse.secureUrl;
      print(bannerImageUrl);
      // create the object
      BannerModel bannerModel = BannerModel(
        id: "",
        image: bannerImageUrl,
      );
      // sned to mongodb
      http.Response response = await http.post(Uri.parse('$uri/api/banner/'),
          body: bannerModel.tojson(),
          headers: <String, String>{
            "Content-Type": 'application/json; charset=UTF-8'
          });
      // get the response
      manageHttpResponse(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'banner uploaded');
          });
    } catch (e) {
      print(e);
    }
  }

  // fetch the uploaded data
  // whatever uploaded data return in to list format
  Future<List<BannerModel>> loadbanners() async {
    try {
      // send the url to check availabe or not
      http.Response response = await http.get(Uri.parse('$uri/api/banner/'),
          headers: <String, String>{
            "Content-Type": 'application/json; charset=UTF-8'
          });
      // if avialbe then convert into json then into object format and
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<BannerModel> banners =
            data.map((banner) => BannerModel.fromJson(banner)).toList();
        // store into list and return that
        return banners;
      } else {
        throw Exception('failed to load banners');
      }
      // if not availabe then return this is a error
    } catch (e) {
      throw Exception('failed to loading banners');
    }
  }
}
