import 'package:ai_radio_app/pages/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

import '../reusables/reusable_widgets.dart';
import 'home_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Vx.orange400,
              Vx.purple500,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // logoWidget("assets/images/ai_radio.png"),
                  const LogoWidget(imageName: "assets/images/ai_radio.png"),
                  const SizedBox(
                    height: 30,
                  ),
                  ReusableTextField(
                      text: "Enter Username",
                      icon: Icons.person_outline_rounded,
                      isPasswordType: false,
                      controller: _emailTextController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  ReusableTextField(
                      text: "Enter Password",
                      icon: Icons.lock_outline,
                      isPasswordType: true,
                      controller: _passwordTextController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  _isLoading
                      ? const CircularProgressIndicator()
                      : SignInSignUpButton(
                    context: context,
                    isLogin: true,
                    onTap: _signIn,
                  ),
                  // SignInSignUpButton(
                  //   context: context,
                  //   isLogin: true,
                  //   onTap: _signIn,
                  // ),
                  signUpOption(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _signIn() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailTextController.text,
              password: _passwordTextController.text)
          .then((onValue) {
        setState(() {
          _isLoading = false;
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }).catchError((error) {
        setState(() {
          _isLoading = false;
        });
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              // icon: const Icon(Icons.error_outline),
              title: const Text(
                'Error!',
                textAlign: TextAlign.center,
              ),
              titleTextStyle: TextStyle(
                fontFamily: GoogleFonts.ubuntu().fontFamily,
                fontWeight: FontWeight.w900,
                fontSize: 30.0,
                color: Colors.black,
              ),
              content: Text(
                'Please enter a valid Email ID and Password!',
                style: TextStyle(
                  fontFamily: GoogleFonts.ubuntu().fontFamily,
                  // fontWeight: FontWeight.w900,
                  fontSize: 18.0,
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      });
    }
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account? ",
          style: TextStyle(
            color: Colors.white70,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignUpPage()));
          },
          child: const Text(
            'Sign Up',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
