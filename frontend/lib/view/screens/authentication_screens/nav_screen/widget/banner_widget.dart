import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/controller/banner_controller.dart';
import 'package:frontend/model/banner.dart';
import 'package:frontend/provider/banner_provider.dart';

class BannerWidget extends ConsumerStatefulWidget {
  const BannerWidget({super.key});

  @override
  ConsumerState<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends ConsumerState<BannerWidget> {
  late Future<List<BannerModel>> futurebanners;

  Future<void> _fetchBanners() async {
    final BannerController bannerController = BannerController();
    try {
      final banners = await bannerController.loadbanners();
      ref.read(bannerProvider.notifier).setBannerModel(banners);
      ref.read(bannerProvider);
    } catch (e) {
      print('$e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchBanners();
  }

  @override
  Widget build(BuildContext context) {
    final banners = ref.watch(bannerProvider);
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
        child: PageView.builder(
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
        ),
      ),
    );
  }
}
