import 'package:flutter/material.dart';
import 'package:pepper_house/services/fire_auth.dart';
import 'package:pepper_house/screen/login.dart';
import 'package:pepper_house/shapes/loginpageshape.dart';
import 'package:pepper_house/validation/validator.dart';

import '../enum/auth_result_status.dart';
import '../exemption-handlers/auth_exemption_handler.dart';
import '../locator.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _passwordField = TextEditingController();
  final _passwordConfirmField = TextEditingController();
  final _emailField = TextEditingController();
  final _nameField = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _auth = locator.get<FireAuth>();
  bool showError = true;
  bool _isSubmitting = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.47,
              child: CustomPaint(
                foregroundPainter: LoginPagePainter(),
                child: const Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Text(
                      "Register",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            Text(errorMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.red,
                )),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: _nameField,
                validator: (value) {
                  return Validator.validateName(name: value);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.red, width: 2),
                  ),
                  labelText: 'Full Name',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: TextFormField(
                controller: _emailField,
                validator: (value) {
                  return Validator.validateEmail(email: _emailField.text);
                },
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
                obscureText: true,
                controller: _passwordField,
                validator: (value) {
                  return Validator.validatePassword(password: value);
                },
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: TextFormField(
                controller: _passwordConfirmField,
                validator: (value) {
                  return Validator.validatePasswordConfirm(
                      password: _passwordField.text, passwordConfirm: value);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.red, width: 2),
                  ),
                  labelText: 'Password Confimation',
                ),
              ),
            ),
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                    fixedSize:
                        Size(MediaQuery.of(context).size.width * 0.8, 50),
                  ),
                  onPressed: _isSubmitting
                      ? null
                      : () async {
                          /* _RegisterPageState().setState(() {
                                      _errorMessage = '';
                                    }); */

                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              _isSubmitting = true;
                              errorMessage = '';
                            });
                            _isSubmitting = true;
                            AuthResultStatus status =
                                await _auth.registerUsingEmailPassword(
                                    name: _nameField.text,
                                    email: _emailField.text,
                                    password: _passwordField.text);
                            _isSubmitting = false;
                            if (status == AuthResultStatus.successful) {
                              /* Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage())); */
                              alertDialog(context,
                                  message: "Registration Successful");
                            } else {
                              String message =
                                  AuthExceptionHandler.generateExceptionMessage(
                                      status);
                              errorMessage = message;
                              setState(() {});

                              /*  _RegisterPageState().setState(() {
                                       _errorMessage = message;
                                    }); */
                              /* setState(() {
                                _errorMessage = message;
                              }); */
                            }
                          }
                        },
                  child: !_isSubmitting
                      ? const Text(
                          'Register',
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
                        builder: (context) => const LoginPage()));
                  },
                  child: const Text(
                    "Sign in",
                    style: TextStyle(
                        color: Colors.red,
                        decoration: TextDecoration.underline),
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }

  Future alertDialog(BuildContext context, {required String message}) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Done'),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                  ),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                child: const Text(
                  'Ok',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const LoginPage()));
                },
              ),
            ],
          );
        });
  }
}
