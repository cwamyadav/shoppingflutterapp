import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/provider/cart_provider.dart';
import 'package:frontend/view/screens/authentication_screens/detail/screen/checkout_screen.dart';
import 'package:frontend/view/screens/authentication_screens/main_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartdata = ref.watch(cartProvider);
    final _cartProvider = ref.read(cartProvider.notifier);
    final totalAmount = ref.read(cartProvider.notifier).calculateTotalAmount();
    return Scaffold(
      // appbar --------->
      //size*20, 118 height, positions(20, 20, 12 radius),
      //51,
      //
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height * 20,
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 118,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/icons/cartb.png',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 322,
                top: 52,
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/icons/not.png',
                      height: 25,
                      width: 25,
                    ),
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(15)),
                      clipBehavior: Clip.hardEdge,
                      alignment: Alignment.center,
                      child: Text(
                        cartdata.length.toString(),
                        style: GoogleFonts.quicksand(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                  left: 61,
                  top: 51,
                  child: Text(
                    'My Cart',
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  )),
            ],
          ),
        ),
      ),
      body: cartdata.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'your shoping cart is empty\n you can add product cart from the button below',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    fontSize: 15,
                    letterSpacing: 1.7,
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainScreen()));
                    },
                    child: Text('Shop Now')),
              ],
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 49,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.blue.shade100,
                    child: Stack(
                      children: [
                        Positioned(
                            left: 20,
                            top: 20,
                            child: Container(
                              height: 10,
                              width: 10,
                              color: Colors.black,
                            )),
                        Positioned(
                            left: 40,
                            top: 15,
                            child: Text(
                                '${cartdata.length} item in your shoping cart')),
                      ],
                    ),
                  ),
                  ListView.builder(
                      itemCount: cartdata.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final cartItem = cartdata.values.toList()[index];
                        return Card(
                            child: SizedBox(
                          height: 200,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 100,
                                width: 100,
                                child: Image.network(
                                  cartItem.image[0],
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cartItem.productName,
                                    style: GoogleFonts.lato(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    cartItem.category,
                                    style: GoogleFonts.roboto(
                                      fontSize: 13,
                                    ),
                                  ),
                                  Text(
                                    "\$${cartItem.productPrice.toStringAsFixed(2)}",
                                    style: GoogleFonts.lato(
                                      color: Colors.pink,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 40,
                                        width: 120,
                                        decoration: BoxDecoration(
                                          color: Colors.deepPurpleAccent,
                                        ),
                                        child: Row(
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  _cartProvider
                                                      .incrementCartItem(
                                                          cartItem.productId);
                                                },
                                                icon: Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                )),
                                            Text(
                                              cartItem.quantity.toString(),
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  _cartProvider
                                                      .decrementCartItem(
                                                    cartItem.productId,
                                                  );
                                                },
                                                icon: Icon(
                                                  Icons.minimize,
                                                  color: Colors.white,
                                                )),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        _cartProvider
                                            .removeCartItem(cartItem.productId);
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ));
                      }),
                ],
              ),
            ),
      bottomNavigationBar: Container(
        width: 416,
        height: 89,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 416,
                height: 89,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.red.shade300)),
              ),
            ),
            Align(
              alignment: const Alignment(-0.63, -0.26),
              child: Text(
                'SubTotal',
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),
            Align(
              alignment: Alignment(-0.19, -0.31),
              child: Text(
                "\$${totalAmount.toStringAsFixed(2)}",
                style: GoogleFonts.roboto(
                    fontSize: 16, color: Colors.red.shade400),
              ),
            ),
            Align(
              alignment: Alignment(.83, -1),
              child: InkWell(
                onTap: totalAmount == 0
                    ? null
                    : () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CheckOutScreen()));
                      },
                child: Container(
                  width: 166,
                  height: 71,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: totalAmount == 0
                        ? Colors.grey
                        : Colors.deepPurpleAccent,
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Checkout",
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
