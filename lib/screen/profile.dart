import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pepper_house/controller/user_controller.dart';
import 'package:pepper_house/services/storage_repo.dart';

import '../locator.dart';
import '../models/user_model.dart';
import '../services/fire_auth.dart';
import '../validation/validator.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordField = TextEditingController();
  final _passwordConfirmField = TextEditingController();
  final _emailField = TextEditingController();
  final _nameField = TextEditingController();
  final _phoneNumberField = TextEditingController();
  final _addressField = TextEditingController();
  bool _isProfileEditing = true;
  bool _isUploadingImage = false;
  final _imagePicker = ImagePicker();
  bool showError = true;
  bool _isSubmitting = false;
  String errorMessage = '';
  String? uid;
  UserModel _currentUser = locator.get<UserController>().currentUser;

  @override
  void initState() {
    setState(() {
      setUserData();
    });
    super.initState();
  }

  setUserData() {
    _nameField.text = _currentUser.displayName!;
    _emailField.text = _currentUser.email!;
    _phoneNumberField.text = _currentUser.phoneNumber!;
    _addressField.text = _currentUser.address!;
    uid = _currentUser.uid;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    final xFile = await _imagePicker.pickImage(
                        source: ImageSource.gallery);
                    if (xFile!.path.isNotEmpty) {
                      _isUploadingImage = true;
                      setState(() {});
                      try {
                        File file = File(xFile.path);
                        StorageRepo storageRepo = StorageRepo();
                        print(xFile.path);
                        print(_currentUser.photoURL.toString());
                        var uploadTask = await storageRepo.uploadFile(file);
                        /* uploadTask.onDone(() async{  
                         
                        }); */
                        _isUploadingImage = false;
                        _currentUser =
                            await locator.get<UserController>().initUser();

                        setState(() {});
                      } catch (e) {
                        print(e);
                      }
                    }
                  },
                  child: SizedBox(
                    height: 200,
                    width: 300,
                    child: CircleAvatar(
                      child: _isUploadingImage
                          ? const CircularProgressIndicator(
                              color: Colors.red,
                            )
                          : const Icon(Icons.camera_alt_rounded),
                      backgroundImage: NetworkImage(_currentUser.photoURL !=
                              null
                          ? _currentUser.photoURL.toString()
                          : 'https://4.bp.blogspot.com/-Jx21kNqFSTU/UXemtqPhZCI/AAAAAAAAh74/BMGSzpU6F48/s1600/funny-cat-pictures-047-001.jpg'),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                      padding: const EdgeInsets.only(
                        right: 8,
                      ),
                      child: TextButton(
                          onPressed: () => {
                                setState(() {
                                  _isProfileEditing = !_isProfileEditing;
                                })
                              },
                          child: Text(
                            _isProfileEditing
                                ? "Change Password"
                                : "Update Profile",
                            style: const TextStyle(color: Colors.white),
                          ))),
                )
              ],
            ),
            height: MediaQuery.of(context).size.height * 0.35,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
          ),
          const SizedBox(
            height: 29,
          ),
          _isProfileEditing
              ? Form(
                  key: _formKey,
                  child: Column(
                    children: [
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
                          decoration: const InputDecoration(
                            labelText: 'Full Name',
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: TextFormField(
                          enabled: false,
                          controller: _emailField,
                          validator: (value) {
                            return Validator.validateEmail(
                                email: _emailField.text);
                          },
                          decoration: const InputDecoration(
                            labelText: 'Email',
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: TextFormField(
                          controller: _phoneNumberField,
                          validator: (value) {
                            return Validator.validatePhoneNumber(
                                phoneNumber: _phoneNumberField.text);
                          },
                          decoration: const InputDecoration(
                            labelText: 'Phone Number',
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: TextFormField(
                          controller: _addressField,
                          decoration: const InputDecoration(
                            labelText: 'Address',
                          ),
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.red,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              elevation: 10,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(32.0)),
                              ),
                              fixedSize: Size(
                                  MediaQuery.of(context).size.width * 0.8, 50),
                            ),
                            onPressed: _isSubmitting
                                ? null
                                : () async {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        _isSubmitting = true;
                                        errorMessage = '';
                                      });
                                      String message = await locator
                                          .get<FireAuth>()
                                          .updateUser(
                                              name: _nameField.text,
                                              phoneNumber:
                                                  _phoneNumberField.text);
                                      if (message == "success") {
                                        errorMessage =
                                            'Profile updated successfully';
                                      } else {
                                        errorMessage =
                                            "Sorry Something went wrong";
                                      }
                                      _isSubmitting = false;
                                      setState(() {});
                                      await Future.delayed(
                                          const Duration(milliseconds: 3000),
                                          (() {
                                        errorMessage = '';
                                        setState(() {});
                                      }));
                                    }
                                  },
                            child: !_isSubmitting
                                ? const Text(
                                    'Update Profile',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 22),
                                  )
                                : const CircularProgressIndicator(
                                    color: Colors.white),
                          )),
                    ],
                  ))
              : Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(20),
                        child: Text("Change Password",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold)),
                      ),
                      Text(errorMessage,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.red,
                          )),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: TextFormField(
                          obscureText: true,
                          controller: _passwordField,
                          validator: (value) {
                            return Validator.validatePassword(password: value);
                          },
                          decoration: const InputDecoration(
                            labelText: 'Password',
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: TextFormField(
                          controller: _passwordConfirmField,
                          validator: (value) {
                            return Validator.validatePasswordConfirm(
                                password: _passwordField.text,
                                passwordConfirm: value);
                          },
                          decoration: const InputDecoration(
                            labelText: 'Password Confimation',
                          ),
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.red,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              elevation: 10,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(32.0)),
                              ),
                              fixedSize: Size(
                                  MediaQuery.of(context).size.width * 0.8, 50),
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

                                      String message = await locator
                                          .get<FireAuth>()
                                          .updatePassword(
                                              password: _passwordField.text);
                                      if (message == "success") {
                                        errorMessage =
                                            'Password updated successfully';
                                        _passwordConfirmField.text = '';
                                      } else {
                                        errorMessage =
                                            'Sorry something went wrong';
                                      }
                                      _isSubmitting = false;
                                      setState(() {});
                                      await Future.delayed(
                                          const Duration(milliseconds: 3000),
                                          (() {
                                        errorMessage = '';
                                        setState(() {});
                                      }));
                                    }
                                  },
                            child: !_isSubmitting
                                ? const Text(
                                    'Update Password',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 22),
                                  )
                                : const CircularProgressIndicator(
                                    color: Colors.white),
                          )),
                    ],
                  ))
        ],
      ),
    );
  }

  Future<void> getLostData() async {
    final LostDataResponse response = await _imagePicker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.files != null) {
      for (final XFile file in response.files!) {
        _handleFile(file);
      }
    } else {
      _handleError(response.exception);
    }
  }

  void _handleFile(file) {
    print(file);
  }

  void _handleError(response) {
    print(response);
  }
}
