import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hogo_app/widgets/bottom_navigation.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../models/home.dart';
import '../provider/auth_provider.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class HomePageScreen extends StatefulWidget {
  static const roudName = "/HomePageScreen";

  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  void initState() {
    super.initState();
    getData(userId: Provider.of<Auth>(context, listen: false).userId);
  }

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
        // Provider.of<Auth>(context, listen: false).userId = userId;

        // Navigator.of(context).pushReplacementNamed(HomePageScreen.roudName);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => newStack(size, index, context),
                itemCount: homePageList.length),
          ],
        ),
      ),
    );
  }

  Stack newStack(Size size, int index, BuildContext context) {
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            clickedContent = homePageList[index].title;
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BottomNavigator()),
            );
          },
          child: SizedBox(
            child: Container(
              decoration: BoxDecoration(
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.grey.withOpacity(0.5),
                  //     spreadRadius: 5,
                  //     blurRadius: 7,
                  //     offset:
                  //         const Offset(0, 1), // changes position of shadow
                  //   ),
                  // ],
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(homePageList[index].imagePath)),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(3.w),
                      topRight: Radius.circular(10.w),
                      bottomLeft: Radius.circular(3.w),
                      bottomRight: Radius.circular(3.w))),
              height: size.height * 0.2,
              width: size.width,
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 2.h,
        left: 0,
        right: 0,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(104, 0, 0, 0),
            ),
            //  height: size.height * 0.2,
            width: size.width,
            child: Text(
              homePageList[index].title + " Street",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
                //   backgroundColor: Color.fromARGB(255, 255, 251, 220)
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
