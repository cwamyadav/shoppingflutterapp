import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/controller/auth_controller.dart';
import 'package:frontend/provider/uers_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class ShippingAddressScreen extends ConsumerStatefulWidget {
  const ShippingAddressScreen({super.key});

  @override
  _ShippingAddressScreenState createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends ConsumerState<ShippingAddressScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();

  late String state;
  late String city;
  late String locality;
  @override
  Widget build(BuildContext context) {
    final user = ref.read(userProvider);
    final updateUser = ref.read(userProvider.notifier);
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.96),
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.96),
        elevation: 0,
        title: Text(
          'Delievery',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.7,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Center(
                child: Text(
                  'where will your order\n will be shipped',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      letterSpacing: 1.7),
                ),
              ),
              TextFormField(
                onChanged: (value) {
                  state = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter state';
                  } else {
                    return null;
                  }
                },
                decoration:
                    InputDecoration(hintText: 'State', labelText: 'State'),
              ),
              TextFormField(
                onChanged: (value) {
                  city = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter city';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  hintText: 'City',
                  labelText: 'City',
                ),
              ),
              TextFormField(
                onChanged: (value) {
                  locality = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter locality';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Locality',
                  labelText: 'Locality',
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8),
        child: InkWell(
          onTap: () async {
            if (_formKey.currentState!.validate()) {
              await _authController
                  .updateUserLocation(
                context: context,
                state: state,
                city: city,
                locality: locality,
                id: user!.id,
              )
                  .whenComplete(() {
                updateUser.recreateUserState(
                    state: state, city: city, locality: locality);
                Navigator.pop(context); // close the dialog
                Navigator.pop(context);// go back to previouse screen
              });

              print('pass');
            } else {
              print('fail');
            }
          },
          child: Container(
            width: 200,
            height: 55,
            decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(15)),
            alignment: Alignment.center,
            child: Text(
              'Save',
              style: GoogleFonts.quicksand(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 17,
                letterSpacing: 1.3,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
