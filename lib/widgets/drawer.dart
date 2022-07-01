import 'package:flutter/material.dart';
import 'package:hogo_app/models/home.dart';
import 'package:hogo_app/provider/auth_provider.dart';
import 'package:hogo_app/screen/ads_list_screen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../provider/content_provider.dart';
import '../screen/authentication/sing_in_page.dart';
import '../screen/last_form_with_imag.dart';
import '../screen/new_form_screen.dart';
import '../screen/show_all_data.dart';
import '../screen/slide_screen.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    var formType = Provider.of<ContentProvider>(context);
    print(Provider.of<Auth>(context).userEmail);

    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          SliderScreen.roudName, (route) => false);
                    },
                    child: SizedBox(
                      height: height * 0.1,
                      child: Image.asset(
                        getContryLogoByTitle(),
                        height: height * 0.1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          getDrawerItem(Icons.house, "House Rent", callback: () {
            formType.setFormType("Form for House Rent");

            formType.loadedFormDate.clear();
            formType.loadedFormDate.clear();
            Navigator.popAndPushNamed(context, ShowAllData.roudName);

            print("account clicked");
          }),
          getDrawerItem(Icons.house_siding_rounded, "House Sell", callback: () {
            formType.loadedFormDate.clear();
            formType.setFormType("Form for House Sell");
            Navigator.popAndPushNamed(context, ShowAllData.roudName);
          }),
          // getDrawerItem(Icons.car_rental, "Car Sell", callback: () {
          //   formType.setFormType("Form for Car Sell");

          //   formType.loadedFormDate.clear();

          //   Navigator.popAndPushNamed(context, ShowAllData.roudName);
          // }),
          getDrawerItem(Icons.event, "Events", callback: () {
            formType.setFormType("Form for Events");

            formType.loadedFormDate.clear();

            Navigator.popAndPushNamed(context, ShowAllData.roudName);
          }),
          getDrawerItem(Icons.event, "Desi Business and more", callback: () {
            formType.setFormType("Form for Desi Business and more");

            formType.loadedFormDate.clear();

            Navigator.popAndPushNamed(context, ShowAllData.roudName);
          }),
          getDrawerItem(Icons.restaurant, "Restaurants", callback: () {
            formType.setFormType("Form for Restaurants");

            formType.loadedFormDate.clear();

            Navigator.popAndPushNamed(context, ShowAllData.roudName);
          }),
          // getDrawerItem(Icons.store, "Store Address", callback: () {
          //   formType.setFormType("Form for Store Address");

          //   formType.loadedFormDate.clear();

          //   Navigator.popAndPushNamed(context, ShowAllData.roudName);
          // }),
          getDrawerItem(Icons.store, "Jobs", callback: () {
            formType.setFormType("Form for Jobs");

            formType.loadedFormDate.clear();

            Navigator.popAndPushNamed(context, ShowAllData.roudName);
          }),
          // getDrawerItem(Icons.person, "Doctor Office", callback: () {
          //   formType.setFormType("Form for Doc’s Office");

          //   formType.loadedFormDate.clear();

          //   Navigator.popAndPushNamed(context, ShowAllData.roudName);
          // }),
          getDrawerItem(Icons.person, "Desi Shops", callback: () {
            formType.setFormType("Form for Desi Shops");

            formType.loadedFormDate.clear();

            Navigator.popAndPushNamed(context, ShowAllData.roudName);
          }),
          getDrawerItem(Icons.person, "Commercials-Ads", callback: () {
            formType.setFormType("Form for Commercials-Ads");

            formType.loadedFormDate.clear();

            Navigator.popAndPushNamed(context, ShowAllData.roudName);
          }),
          // getDrawerItem(Icons.file_present_outlined, "Lawyer’s Offic",
          //     callback: () {
          //   formType.loadedFormDate.clear();
          //   formType.setFormType("Form for Lawyer’s Office");
          //   Navigator.popAndPushNamed(context, ShowAllData.roudName);
          // }),
          if (Provider.of<Auth>(context).token != null)
            getDrawerItem(Icons.contact_page_outlined, "All Forms",
                callback: () {
              Navigator.popAndPushNamed(context, NewForm.roudName);
            }),
          if (Provider.of<Auth>(context).token != null &&
              Provider.of<Auth>(context).userEmail!.contains("@admin"))
            getDrawerItem(Icons.contact_page_outlined, "Admin List",
                callback: () {
              Navigator.popAndPushNamed(context, AdsLisstScreen.roudName);
            }),
          getDrawerItem(Icons.contact_page, "Contact Us", callback: () {
            Navigator.popAndPushNamed(context, LastFormWirhImag.roudName);
          }),
          if (Provider.of<Auth>(context).token != null)
            getDrawerItem(Icons.login, "Logout", callback: () {
              Provider.of<Auth>(context, listen: false).logout();

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SingInPage()),
              );
            }),
          if (Provider.of<Auth>(context).token == null)
            getDrawerItem(Icons.login, "Login", callback: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SingInPage()),
              );
            }),
        ],
      ),
    );
  }

  Widget getDrawerItem(IconData? icon, String itemName,
      {VoidCallback? callback}) {
    return InkWell(
      onTap: callback,
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
        child: Row(
          children: <Widget>[
            Icon(icon, size: 20),
            const SizedBox(width: 20),
            Text(
              itemName,
              style: TextStyle(color: Colors.black, fontSize: 10.sp),
            ),
          ],
        ),
      ),
    );
  }
}
