import 'package:firebase_core/firebase_core.dart' as core;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hogo_app/screen/auth_screen.dart';
import 'package:hogo_app/screen/authentication/forgot_password_page.dart';
import 'package:hogo_app/screen/authentication/sing_in_page.dart';
import 'package:hogo_app/screen/authentication/sing_up_page.dart';
import 'package:hogo_app/screen/intro_page.dart';
import 'package:hogo_app/screen/setting.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../screen/home_page_screen.dart';
import 'provider/auth_provider.dart';
import 'provider/content_provider.dart';
import 'screen/ads_list_screen.dart';
import 'screen/event_form.dart';
import 'screen/form_screen.dart';
import 'screen/image_details_screen.dart';
import 'screen/last_form_with_imag.dart';
import 'screen/new_form_screen.dart';
import 'screen/show_all_data.dart';
import 'screen/slide_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await core.Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);

    return Listener(
      onPointerUp: (_) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild!.unfocus();
        }
      },
      child: MultiProvider(
        providers: [
          ListenableProvider<ContentProvider>(create: (_) => ContentProvider()),
          ListenableProvider<Auth>(create: (_) => Auth()),
        ],
        child: Consumer<Auth>(
          builder: (context, auth, _) =>
              Sizer(builder: (context, orientation, deviceType) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              home: //const SingInPage(),
                  auth.isAuth
                      ? const HomePageScreen()
                      : FutureBuilder(
                          future: auth.tryAutoLogin(),
                          builder: (context, authResultSnapshot) =>
                              authResultSnapshot.connectionState ==
                                      ConnectionState.waiting
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : const IntroPage(),
                        ),
              routes: {
                AdsLisstScreen.roudName: (cox) => const AdsLisstScreen(),
                SliderScreen.roudName: (cox) => SliderScreen(),
                HomePageScreen.roudName: (cox) => const HomePageScreen(),
                FormScreen.roudName: (cox) => const FormScreen(),
                ImageDetailsScreen.roudName: (cox) => ImageDetailsScreen(),
                ImageDetailsScreen.roudName: (cox) => ImageDetailsScreen(),
                SliderScreen.roudName: (cox) => SliderScreen(),
                LastFormWirhImag.roudName: (cox) => const LastFormWirhImag(),
                ShowAllData.roudName: (cox) => const ShowAllData(),
                AuthScreen.roudName: (cox) => AuthScreen(),
                EventForm.roudName: (cox) => const EventForm(),
                NewForm.roudName: (cox) => const NewForm(),
                SingInPage.roudName: (cox) => const NewForm(),
                SingUpPage.roudName: (cox) => const NewForm(),
                Setting.roudName: (cox) => const Setting(),
                ForgotPasswordPage.roudName: (cox) => const NewForm(),
                IntroPage.roudName: (cox) => const NewForm(),
                //   MapPickerPage.roudName: (cox) => MapPickerPage(),
              },
            );
          }),
        ),
      ),
    );
  }
}
