import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Image logoWidget(imageName){
//   return Image.asset(
//     imageName,
//     fit: BoxFit.fitWidth,
//     width: 240,
//     height: 240,
//     //color: Colors.white,
//   );
// }

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key, required this.imageName});

  final String imageName;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imageName,
      fit: BoxFit.fitWidth,
      width: 240,
      height: 240,
    );
  }
}

class ReusableTextField extends StatefulWidget {
  const ReusableTextField({
    super.key,
    required this.text,
    required this.icon,
    required this.isPasswordType,
    required this.controller,
    this.validator,
  });

  final String text;
  final IconData icon;
  final bool isPasswordType;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  _ReusableTextFieldState createState() => _ReusableTextFieldState();
}

class _ReusableTextFieldState extends State<ReusableTextField> {
  bool _isObscured = true;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.isPasswordType;
  }

  void _toggleVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPasswordType ? _isObscured : false,
      enableSuggestions: !widget.isPasswordType,
      autocorrect: !widget.isPasswordType,
      cursorColor: Colors.white,
      style: TextStyle(
        color: Colors.white.withOpacity(0.9),
      ),
      validator: widget.validator,
      decoration: InputDecoration(
        prefixIcon: Icon(
          widget.icon,
          color: Colors.white70,
        ),
        suffixIcon: widget.isPasswordType
            ? IconButton(
                icon: Icon(
                  _isObscured ? Icons.visibility_off : Icons.visibility,
                  color: Colors.white70,
                ),
                onPressed: _toggleVisibility,
              )
            : null,
        labelText: widget.text,
        labelStyle: TextStyle(
          color: Colors.white.withOpacity(0.9),
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
          fontFamily: GoogleFonts.openSans().fontFamily,
        ),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: Colors.white.withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none),
        ),
      ),
      keyboardType: widget.isPasswordType
          ? TextInputType.visiblePassword
          : TextInputType.emailAddress,
    );
  }
}

class SignInSignUpButton extends StatefulWidget {
  const SignInSignUpButton(
      {super.key,
      required this.context,
      required this.isLogin,
      required this.onTap});

  final BuildContext context;
  final bool isLogin;
  final Function onTap;

  @override
  State<SignInSignUpButton> createState() => _SignInSignUpButtonState();
}

class _SignInSignUpButtonState extends State<SignInSignUpButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(90),
      ),
      child: ElevatedButton(
        onPressed: () {
          widget.onTap();
        },
        style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.pressed)) {
                return Colors.black26;
              }
              return Colors.white;
            }),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)))),
        child: Text(
          widget.isLogin ? "LOG IN" : "SIGN UP",
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
