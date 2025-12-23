import 'package:flutter/material.dart';

class InnerBannerWidget extends StatelessWidget {
  final String image;
  const InnerBannerWidget({required this.image, super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: SizedBox(
        height: 170,
        width: MediaQuery.of(context).size.width,
        child: Image.network(
          image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}



