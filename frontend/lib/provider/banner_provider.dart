import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/model/banner.dart';

class BannerProvider extends StateNotifier<List<BannerModel>> {
  BannerProvider() : super([]);

  // set the state
  void setBannerModel(List<BannerModel> banners) {
    state = banners;
  }
}

// access outside
final bannerProvider = StateNotifierProvider<BannerProvider, List<BannerModel>>(
    (ref) => BannerProvider());
