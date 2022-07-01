import 'package:flutter/material.dart';
import 'package:hogo_app/screen/slide_screen.dart';
import '../widgets/drawer.dart';

class ImageDetailsScreen extends StatelessWidget {
  static const roudName = "/ImageDetailsScreen";
  String? dropDwon,
      dropDwon2,
      dropDwon3,
      dropDwon4,
      dropDwon5,
      dropDwon6,
      text1,
      text2,
      text3;

  ImageDetailsScreen({
    this.dropDwon,
    this.dropDwon2,
    this.dropDwon3,
    this.dropDwon4,
    this.dropDwon5,
    this.dropDwon6,
    this.text1,
    this.text2,
    this.text3,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    final size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: const DrawerScreen(),
      appBar: AppBar(
        title: const FlutterLogo(
          size: 40,
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  SliderScreen.roudName, (route) => false);
            },
            child: SizedBox(
              //    width: width * 0.15,
              height: height * 0.1,
              child: Image.asset(
                'assets/images/logo.png',
                //    width: width * 0.15,
                height: height * 0.1,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: size.width,
                  height: size.height * 0.1,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(dropDwon!),
                      Text("Saint Joseph Rome 20032"),
                      Text("Ph: 123456789"),
                      Text("Ncer Primary School"),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Container(
                  width: size.width,
                  height: size.height * 0.1,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(dropDwon2!),
                      Text("Saint Joseph Rome 20032"),
                      Text("Ph: 123456789"),
                      Text("Ncer Primary School"),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Container(
                  width: size.width,
                  height: size.height * 0.1,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(dropDwon3!),
                      Text("Saint Joseph Rome 20032"),
                      Text("Ph: 123456789"),
                      Text("Ncer Primary School"),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                // Image.network(
                //   'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
                // ),
                // SizedBox(
                //   height: size.height * 0.02,
                // ),
                Container(
                  width: size.width,
                  height: size.height * 0.1,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(dropDwon4!),
                      Text(text1!),
                      Text("Ph: 123456789"),
                      Text("Ncer Primary School"),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Container(
                  width: size.width,
                  height: size.height * 0.1,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(dropDwon5!),
                      Text(text2!),
                      Text("Ph: 123456789"),
                      Text("Ncer Primary School"),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Container(
                  width: size.width,
                  height: size.height * 0.1,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(dropDwon6!),
                      Text(text3!),
                      Text("Ph: 123456789"),
                      Text("Ncer Primary School"),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                // Image.network(
                //   'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
