import 'package:flutter/material.dart';
import 'package:frontend/model/product.dart';
import 'package:frontend/view/screens/authentication_screens/detail/screen/product_detail_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductItemWidget extends StatelessWidget {
  final Product product;

  const ProductItemWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProductDetailScreen(product: product);
        }));
      },
      child: Container(
          width: 170,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.red,
            ),
          ),
          margin: EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 170,
                decoration: BoxDecoration(
                  color: Color(0xffF2F2F2),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Stack(
                  children: [
                    Image.network(
                      product.images[0],
                      height: 170,
                      width: 170,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 15,
                      right: 2,
                      child: Image.asset(
                        'assets/icons/love.png',
                        width: 26,
                        height: 26,
                        color: Colors.red,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Image.asset(
                        'assets/icons/cart.png',
                        color: Colors.red,
                        width: 26,
                        height: 26,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
              Text(
                overflow: TextOverflow.ellipsis,
                product.productName,
                style: GoogleFonts.roboto(
                  fontSize: 13,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                product.category,
                style: GoogleFonts.quicksand(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              Text(
                product.productPrice.toStringAsFixed(2),
                style: GoogleFonts.quicksand(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          )),
    );
  }
}
