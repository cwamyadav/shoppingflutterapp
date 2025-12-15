import 'package:flutter/material.dart';
import 'package:web_app/controller/banner_controller.dart';
import 'package:web_app/models/banner_model.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});
  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  late Future<List<BannerModel>> futureBanners;

  @override
  void initState() {
    super.initState();
    futureBanners = BannerController().loadbanners();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BannerModel>>(
      future: futureBanners,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text("Error: ${snapshot.error}"),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('No Banners'),
          );
        } else {
          final banners = snapshot.data!;
          return GridView.builder(
            shrinkWrap: true,
            itemCount: banners.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              final banner = banners[index];
              return Image.network(
                banner.image,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              );
            },
          );
        }
      },
    );
  }
}
