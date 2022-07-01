import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import 'package:sizer/sizer.dart';

import '../../utils/theme/app_colors.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/input.dart';
import '../../widgets/text_widget.dart';
import 'package:hogo_app/provider/auth_provider.dart';
import 'package:hogo_app/screen/http_excaption.dart';
import 'package:provider/provider.dart';
import '../home_page_screen.dart';
import 'sing_up_page.dart';

class SingInPage extends StatefulWidget {
  static const roudName = 'SingInPageScreen';
  const SingInPage({Key? key}) : super(key: key);

  @override
  _SingInPageState createState() => _SingInPageState();
}

class _SingInPageState extends State<SingInPage> {
  var userNameController = TextEditingController();
  var passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late Future _fetchStateFuture;

  @override
  void initState() {
    _fetchStateFuture = _fetchState();

    // _getUserVisitsFuture = _fetchGetFeaturedUserVisit();
    super.initState();
  }

  Future _fetchState() async {}

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
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      // Sign user up
      await Provider.of<Auth>(context, listen: false)
          .singin(userNameController.text, passwordController.text)
          .then((value) {
        if (value != null) {
          getData(userId: value);
        }
      });
    } on HttpException catch (error) {
      print("error $error");
      var errorrMasseage = 'Authenticate failed';
      if (error.toString().contains('INVALID_EMAIL')) {
        errorrMasseage = " This is not a valid email address";
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
                padding: EdgeInsets.symmetric(horizontal: 9.w),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    //  mainAxisAlignment: MainAxisAlignment.center,
                    physics: const ClampingScrollPhysics(),
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
                        height: 4.h,
                      ),
                      TextWidget(
                        'Sign In',
                        fontWeight: FontWeight.bold,
                        fontSize: 24.sp,
                        color: AppColors.primaryColor,
                      ),
                      SizedBox(
                        height: 1.5.h,
                      ),
                      TextWidget(
                        'Hello, Welcome Back!',
                        fontWeight: FontWeight.normal,
                        fontSize: 13.sp,
                        color: AppColors.primaryColor.withOpacity(0.7),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      TextWidget('Email',
                          fontWeight: FontWeight.normal,
                          fontSize: 13.sp,
                          color: AppColors.primaryColor),
                      RoundedInputField(
                        hintText: "Your Email",
                        onChanged: (value) {},
                        controller: userNameController,
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return "Please enter your Email";
                          }
                          return null;
                        },
                      ),
                      TextWidget('Password',
                          fontWeight: FontWeight.normal,
                          fontSize: 13.sp,
                          color: AppColors.primaryColor),
                      RoundedInputField(
                        hintText: "Enter Password",
                        isObscured: true,
                        onChanged: (value) {},
                        controller: passwordController,
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return "Please enter your password";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextWidget("Forgot Password?",
                            fontSize: 13.sp,
                            color: AppColors.white,
                            fontWeight: FontWeight.normal),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      SizedBox(
                        width: 80.w,
                        child: ButtonWidget(
                          onPressed: () {
                            _submit();
                          },
                          title: "SIGN IN",
                          textColor: AppColors.white,
                          backgroundColor: AppColors.scadryColor,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                          shapeRadius: 24,
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const TextWidget(
                            "Don't have an account?",
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                          GestureDetector(
                            onTap: () {
                              //       context.router.push(SingUpPageRoute());
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SingUpPage()),
                              );
                            },
                            child: const TextWidget(
                              " SIGN UP",
                              color: AppColors.scadryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 9.h,
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }
}

Widget buildSocialBtn(Function onTap, AssetImage logo) {
  return GestureDetector(
    onTap: () {},
    child: Container(
      height: 44.0,
      width: 44.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        image: DecorationImage(
          image: logo,
        ),
      ),
    ),
  );
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
