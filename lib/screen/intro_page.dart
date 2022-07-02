import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../models/intro_model.dart';
import '../utils/constants/constants.dart';
import '../utils/theme/app_colors.dart';
import '../widgets/button_widget.dart';
import '../widgets/slider_widget.dart';
import '../widgets/text_widget.dart';
import 'authentication/sing_in_page.dart';
import 'authentication/sing_up_page.dart';

class IntroPage extends StatefulWidget {
  static const roudName = 'IntroPageScreen';
  const IntroPage({Key? key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(86, 0, 79, 248),
      body: Column(
        children: [
          // Text("data"),

          SliderWidget(
            data: introData,
          ),
          //const Spacer(),
          SizedBox(
            height: 8.h,
          ),
          SizedBox(
            width: 80.w,
            child: ButtonWidget(
              title: "SIGN UP",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SingUpPage()),
                );
                //         context.router.push(BottomNavigationPageRoute());
                //   context.router.push(SingInPageRoute());
              },
              backgroundColor: const Color.fromARGB(255, 255, 213, 25),
              textColor: AppColors.white,
              shapeRadius: Constants.padding * 2,
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          GestureDetector(
            onTap: () {
              //       context.router.push(SingUpPageRoute());
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SingInPage()),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                TextWidget(
                  "Already have account?",
                  color: AppColors.white,
                ),
                TextWidget(
                  " SIGN IN",
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
        ],
      ),
    );
  }
}
