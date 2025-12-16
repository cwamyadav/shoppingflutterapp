import 'package:flutter/material.dart';

class InnerHeaderWidget extends StatelessWidget {
  const InnerHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.20,
      child: Stack(
        children: [
          Image.asset(
            'assets/icons/searchBanner.jpeg',
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.20,
          ),
          Positioned(
              left: 55,
              top: 90,
              child: SizedBox(
                height: 50,
                width: 230,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter Text',
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 16,
                    ),
                    fillColor: Colors.grey.shade200,
                    focusColor: Colors.black,
                    filled: true,
                    prefixIcon: Image.asset(
                      'assets/icons/search.png',
                    ),
                    suffixIcon: Image.asset('assets/icons/cam.png'),
                  ),
                ),
              )),
          Positioned(
              left: 315,
              top: 95,
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(
                  onTap: () {},
                  overlayColor: WidgetStateProperty.all(
                    Colors.green,
                  ),
                  child: Ink(
                    width: 31,
                    height: 31,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                      'assets/icons/bell.png',
                    ))),
                  ),
                ),
              )),
          Positioned(
            left: 290,
            top: 95,
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: () {},
                overlayColor: WidgetStateProperty.all(
                  Colors.green,
                ),
                child: Ink(
                  width: 31,
                  height: 31,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/icons/message.png'))),
                ),
              ),
            ),
          ),
          Positioned(
            left: 5,
            top: 85,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                size: 40,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
