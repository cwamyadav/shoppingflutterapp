import 'package:flutter/material.dart';
import 'package:forntend/controller/banner_controller.dart';
import 'package:forntend/model/banner.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  late Future<List<BannerModel>> futurebanners;
  @override
  void initState() {
    super.initState();
    futurebanners = BannerController().loadbanners();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 170,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: FutureBuilder(
            future: futurebanners,
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
                  child: Text('error:${snapshot.error}'),
                );
              }
              // data not found: error
              else if (!snapshot.hasData || snapshot.data == null) {
                return Center(
                  child: Text('No data found'),
                );
              }
              // return data
              else {
                final banners = snapshot.data!;
                return PageView.builder(
                  itemCount: banners.length,
                  itemBuilder: (context, index) {
                    final banner = banners[index];
                    return Padding(
                      padding: EdgeInsets.all(8),
                      child: Image.network(
                        banner.image,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                );
              }
            }),
      ),
    );
  }
}
