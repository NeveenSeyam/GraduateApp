import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:hogo_app/screen/authentication/sing_in_page.dart';
import 'package:hogo_app/screen/home_page_screen.dart';
import 'package:hogo_app/widgets/button_widget.dart';
import 'package:hogo_app/widgets/input.dart';
import 'package:provider/provider.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import 'package:sizer/sizer.dart';

import '../../provider/auth_provider.dart';
import '../../utils/theme/app_colors.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/input.dart';
import '../../widgets/text_widget.dart';
import '../http_excaption.dart';

class SingUpPage extends StatefulWidget {
  static const roudName = 'SingUpPageScreen';

  const SingUpPage({Key? key}) : super(key: key);

  @override
  _SingUpPageState createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  var _isLoading = false;

  Future<dynamic> getData({required String userId}) async {
    final DocumentReference document =
        FirebaseFirestore.instance.collection("users").doc(userId);

    await document.get().then<dynamic>((DocumentSnapshot snapshot) async {
      setState(() {
        print("snapshot.data ${snapshot.data()}");
        var doc = snapshot.data();
        // cover snapshot.data() to  types.User
        var user = types.User.fromJson(doc as Map<String, dynamic>);
        // var data = types.User.fromJson(json.decode(snapshot.data()  ));
        Provider.of<Auth>(context, listen: false).user = user;
        Provider.of<Auth>(context, listen: false).userId = userId;

        Navigator.of(context).pushReplacementNamed(HomePageScreen.roudName);
      });
    });
  }

  Future<void> _submit() async {
    if (!formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (nameController.text.contains("@admin")) {
        _showErrorrDialog("Admin account is not allowed to create");
        setState(() {
          _isLoading = false;
        });
        return;
      }

      // Sign user up
      await Provider.of<Auth>(context, listen: false)
          .singup(emailController.text, passwordController.text)
          .then((value) {
        if (value != null) {
          _register(
              email: emailController.text,
              firstName: firstNameController.text,
              imageUrl: "imageUrl",
              userId: value,
              lastName: lastNameController.text);

          getData(userId: value);
        }
      });
    } on HttpException catch (error) {
      var errorrMasseage = 'Authenticate failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorrMasseage = "This email addrees is already in use,";
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorrMasseage = " This is not a valid email address";
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorrMasseage = 'This password is to weak .';
      } else if (error.toString().contains('RMAIL_NOT_FOUND')) {
        errorrMasseage = 'Could not found a user with that email .';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorrMasseage = 'Invakid password .';
      }
      _showErrorrDialog(errorrMasseage);
    } catch (error) {
      print(error.toString());
      const errorrMasseage =
          "Could not authenticate you. Please try again later.";
      _showErrorrDialog(errorrMasseage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _register({
    required String email,
    required String userId,
    required String firstName,
    required String lastName,
    required String imageUrl,
  }) async {
    FocusScope.of(context).unfocus();

    try {
      await FirebaseChatCore.instance.createUserInFirestore(
        types.User(
          firstName: firstName,
          id: userId,
          imageUrl: imageUrl,
          email: email,
          lastName: lastName,
        ),
      );
    } catch (e) {
      //   Navigator.of(context).pop();

      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
          content: Text(
            e.toString(),
          ),
          title: const Text('Error'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/signp1.png'),
                  fit: BoxFit.fill),
            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Form(
                  key: formKey,
                  child: ListView(
                    physics:
                        const ClampingScrollPhysics(), // remove unnecessary scroll
                    children: [
                      SizedBox(height: 2.h),
                      Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          child: Container(
                            height: 5.h,
                            width: 15.w,
                            decoration: BoxDecoration(
                                shape: BoxShape
                                    .circle, // remove  Border Radius and  put  shape: BoxShape.circle

                                color: AppColors.primaryColor.withOpacity(0.1)),
                            child: const Icon(
                              Icons.arrow_back,
                              size: 24,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      TextWidget(
                        'Create \nAccount',
                        fontWeight: FontWeight.bold,
                        fontSize: 26.sp,
                        color: AppColors.primaryColor,
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      TextWidget('Your First Name',
                          fontWeight: FontWeight.w500,
                          fontSize: 13.sp,
                          color: AppColors.primaryColor),
                      RoundedInputField(
                        hintText: "John Smith",
                        onChanged: (value) {},
                        controller: firstNameController,
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return "Name is required";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      TextWidget('Your Last Name',
                          fontWeight: FontWeight.w500,
                          fontSize: 13.sp,
                          color: AppColors.primaryColor),
                      RoundedInputField(
                        hintText: "Smith",
                        onChanged: (value) {},
                        controller: lastNameController,
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return "Name is required";
                          }
                          return null;
                        },
                      ),
                      TextWidget('Email Address',
                          fontWeight: FontWeight.w500,
                          fontSize: 13.sp,
                          color: AppColors.primaryColor),
                      RoundedInputField(
                        hintText: "example@gmail.com",
                        onChanged: (value) {},
                        controller: emailController,
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return "Email is required";
                          }
                          return null;
                        },
                      ),
                      TextWidget('Password',
                          fontWeight: FontWeight.w500,
                          fontSize: 13.sp,
                          color: AppColors.primaryColor),
                      RoundedInputField(
                        hintText: "Enter Password",
                        onChanged: (value) {},
                        controller: passwordController,
                        isObscured: true,
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return "Password is required";
                          }
                          return null;
                        },
                      ),
                      TextWidget('Confirms Password',
                          fontWeight: FontWeight.w500,
                          fontSize: 13.sp,
                          color: AppColors.primaryColor),
                      RoundedInputField(
                        hintText: "Confirm Password",
                        onChanged: (value) {},
                        isObscured: true,
                        controller: confirmPasswordController,
                        validator: (p0) {
                          if (p0 != passwordController.text) {
                            return " Password not match";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      SizedBox(
                        width: 80.w,
                        child: ButtonWidget(
                          onPressed: () {
                            _submit();
                          },
                          title: "SIGN UP",
                          textColor: AppColors.white,
                          backgroundColor: AppColors.scadryColor,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                          shapeRadius: 24,
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20.w,
                            child: const Divider(
                              color: AppColors.white,
                              thickness: 2,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3.w),
                            child: const TextWidget(
                              "Or SIGN IN with",
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 20.w,
                            child: const Divider(
                              color: AppColors.white,
                              thickness: 2,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const TextWidget(
                            "Already have account?",
                            color: AppColors.primaryColor,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SingInPage()),
                              );
                            },
                            child: const TextWidget(
                              " SIGN IN",
                              color: AppColors.scadryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      )
                    ],
                  ),
                ),
              ),
            )));
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _showErrorrDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('An Error Occurred!'),
        content: Text(message),
        actions: [
          FlatButton(
            child: const Text(' Okay'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}
