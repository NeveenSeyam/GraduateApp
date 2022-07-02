import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:hogo_app/models/form_data.dart';
import 'package:hogo_app/models/home.dart';
import 'package:hogo_app/screen/slide_screen.dart';
import 'package:hogo_app/widgets/ads_item.dart';
import 'package:sizer/sizer.dart';

import '../utils/theme/app_colors.dart';
import '../widgets/bottom_navigation.dart';

class AdsLisstScreen extends StatefulWidget {
  static const roudName = 'AdsLisstScreen';
  const AdsLisstScreen({Key? key}) : super(key: key);

  @override
  State<AdsLisstScreen> createState() => _AdsLisstScreenState();
}

class _AdsLisstScreenState extends State<AdsLisstScreen> {
  Query? _ref;
  FirebaseDatabase database = FirebaseDatabase.instance;

  DatabaseReference? ref;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    _ref = FirebaseDatabase.instance
        .ref("form/$clickedContent/Form for Commercials-Ads")
        .orderByChild("stats")
        .equalTo("Unknow");
// Get the Stream
    Query query = _ref!.limitToFirst(10);

    //   print(event.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text("Ads List"),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.popAndPushNamed(context, BottomNavigator.roudName);
            },
            child: SizedBox(
              //    width: width * 0.15,
              //  height: height * 0.05,
              child: Container(
                width: 8.w,
                height: 8.h,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/deal.png")),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SizedBox(
        height: double.infinity,
        child: FirebaseAnimatedList(
          query: _ref!,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            var contact = snapshot.value as Map<dynamic, dynamic>;
            var obj = FormData.fromJson(contact);
            print(contact);
            obj.key = snapshot.key;

            print(obj.key);
            contact['key'] = snapshot.key;
            // print(contact);
            return Adsitem(
              formData: obj,
            );
          },
        ),
      ),
    );
  }
}
