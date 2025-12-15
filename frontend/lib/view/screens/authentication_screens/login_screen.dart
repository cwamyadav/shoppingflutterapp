import 'package:flutter/material.dart';
import 'package:forntend/controller/auth_controller.dart';
import 'package:forntend/view/screens/authentication_screens/register_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // const LoginScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();
  late String email;
  late String password;
  bool isloading = false;
  Future<void> loginUser() async {
    setState(() {
      isloading = true;
    });
    await _authController
        .signinUser(context: context, email: email, password: password)
        .whenComplete(() {
      _formKey.currentState!.reset();
      setState(() {
        isloading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(
        0.95,
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Login your account',
                    style: GoogleFonts.getFont(
                      'Lato',
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.2,
                      fontSize: 23,
                    ),
                  ),
                  Text(
                    'To explore the world exclusives',
                    style: GoogleFonts.getFont(
                      'Lato',
                      color: Colors.black,
                      letterSpacing: 0.2,
                      fontSize: 14,
                    ),
                  ),
                  Image.asset(
                    'assets/images/Illustration.png',
                    width: 200,
                    height: 200,
                  ),
                  Text(
                    'Email',
                    style: GoogleFonts.getFont(
                      'Lato',
                      color: Colors.black,
                      letterSpacing: 0.2,
                      fontSize: 18,
                    ),
                  ),
                  TextFormField(
                    onChanged: (value) {
                      email = value;
                    },
                    validator: (validate) {
                      if (validate!.isEmpty) {
                        return 'enter your email';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'Enter your email',
                        labelStyle: GoogleFonts.getFont(
                          "Nunito Sans",
                          fontSize: 14,
                          letterSpacing: 0.1,
                        ),
                        fillColor: Colors.white,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(10),
                          child: Image.asset(
                            'assets/icons/email.png',
                            width: 20,
                            height: 20,
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      password = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'enter password';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'Enter your password',
                        labelStyle: GoogleFonts.getFont(
                          "Nunito Sans",
                          fontSize: 14,
                          letterSpacing: 0.1,
                        ),
                        fillColor: Colors.white,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(10),
                          child: Image.asset(
                            'assets/icons/password.png',
                            width: 20,
                            height: 20,
                          ),
                        ),
                        suffixIcon: Icon(Icons.visibility)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        loginUser();
                        print('pass ');
                      } else {
                        print('failed');
                      }
                    },
                    child: Card(
                      elevation: 10,
                      child: Container(
                        height: 50,
                        width: 319,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            gradient: LinearGradient(colors: [
                              Color(0xFF102DE1),
                              Color(0XCC0D6EFF),
                            ])),
                        alignment: Alignment.center,
                        child: isloading
                            ? CircularProgressIndicator()
                            : Text(
                                'Sign in',
                                style: GoogleFonts.getFont(
                                  'Lato',
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Need an account?',
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterScreen()));
                        },
                        child: Text(
                          'Signup',
                          style: GoogleFonts.roboto(
                            color: Color(0xFF103DE5),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
