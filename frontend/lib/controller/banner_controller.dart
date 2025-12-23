import 'dart:convert';
import 'package:frontend/global_varriables.dart';
import 'package:frontend/model/banner.dart';
import 'package:http/http.dart' as http;

class BannerController {
  // upload the image function,
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
