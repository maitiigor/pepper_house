import 'package:flutter/material.dart';
import 'package:pepper_house/locator.dart';
import 'package:pepper_house/repository/shared_ref.dart';
import 'package:pepper_house/services/fire_auth.dart';
import 'package:pepper_house/screen/register.dart';
import 'package:pepper_house/shapes/loginpageshape.dart';
import 'package:pepper_house/validation/validator.dart';

import '../enum/auth_result_status.dart';
import '../exemption-handlers/auth_exemption_handler.dart';
import 'dashboard.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _passwordField = TextEditingController();
  final _emailField = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _auth = locator.get<FireAuth>();
  bool _isSubmitting = false;
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SingleChildScrollView(
            child: Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.47,
            decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(50))),
            child: CustomPaint(
              foregroundPainter: LoginPagePainter(),
              child: const Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          Text(_errorMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.red,
              )),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: TextFormField(
              controller: _emailField,
              validator: (value) =>
                Validator.validateEmail(email: _emailField.text),
              
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.red, width: 2),
                ),
                labelText: 'Email',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: TextFormField(
              controller: _passwordField,
              validator: (value) =>
                Validator.validatePassword(password: _passwordField.text)
              ,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.red, width: 2),
                ),
                labelText: 'Password',
              ),
            ),
          ),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  elevation: 10,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  fixedSize: Size(MediaQuery.of(context).size.width * 0.8, 50),
                ),
                onPressed: _isSubmitting
                    ? null
                    : () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _errorMessage = '';
                            _isSubmitting = true;
                          });
                          AuthResultStatus status =
                              await _auth.signInUsingEmailPassword(
                                  email: _emailField.text,
                                  password: _passwordField.text,
                                  context: context);
                          if (status == AuthResultStatus.successful) {
                            _isSubmitting = false;
                            _errorMessage = 'Login Successful';
                            setState(() {});

                            await locator.get<SharedRefRepo>().saveUserCredential(
                                _emailField.text, _passwordField.text);

                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const DashboardPage()));
                          } else {
                            String message =
                                AuthExceptionHandler.generateExceptionMessage(
                                    status);
                            _errorMessage = message;
                            setState(() {});
                          }
                        }
                      },
                child: !_isSubmitting
                    ? const Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      )
                    : const CircularProgressIndicator(color: Colors.white),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have an account? "),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const RegisterPage()));
                },
                child: const Text(
                  "Sign Up",
                  style: TextStyle(
                      color: Colors.red, decoration: TextDecoration.underline),
                ),
              )
            ],
          )
        ],
      ),
    )));
  }
}
