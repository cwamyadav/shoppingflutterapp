import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubcategoryTileWidget extends StatelessWidget {
  final String image;
  final String name;
  const SubcategoryTileWidget(
      {required this.image, required this.name, super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(50)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              image,
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        SizedBox(
          width: 110,
          child: Text(
            name,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.quicksand(
                fontWeight: FontWeight.w600, fontSize: 12),
          ),
        )
      ],
    );
  }
}
