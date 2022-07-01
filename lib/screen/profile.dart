import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hogo_app/provider/auth_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import 'authentication/sing_in_page.dart';

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  DocumentReference? document;

  types.User? user;
  @override
  void didChangeDependencies() {
    user = Provider.of<Auth>(context).user;

    super.didChangeDependencies();
  }

  final ImagePicker _picker = ImagePicker();
  XFile? imageFile;
  selectImage() async {
    imageFile = await _picker.pickImage(source: ImageSource.gallery);

    if (imageFile != null) {}
    setState(() {
      uploadImageToFirebase(context).then((value) {
        Navigator.of(context).pop();
      });
    });
  }

  Future uploadImageToFirebase(BuildContext context) async {
    showLoaderDialog(context);
    print("imageFile!.path ${imageFile!.path}");
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("image1" + DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(File(imageFile!.path));
    print("uploadTask");
    uploadTask.then((res) {
      res.ref.getDownloadURL().then((value) {
        document = FirebaseFirestore.instance
            .collection("users")
            .doc(Provider.of<Auth>(context, listen: false).userId);

        document!.update({'imageUrl': value}).then((value) {
          getData(userId: Provider.of<Auth>(context, listen: false).userId);
        });
      }).onError((error, stackTrace) {
        //  Navigator.of(context).pop();
      });
    }).onError((error, stackTrace) {
      Navigator.of(context).pop();
    });
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
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // print("imageFile!.path ${imageFile!.path}");
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            width: 100.w,
            height: 15.h,
            decoration: BoxDecoration(
              color: const Color(0xff423310),
              borderRadius: BorderRadius.circular(22.0),
            ),
            child: SizedBox(
              height: 15.h,
              child: const Center(
                child: Text(
                  'Profile',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    color: Color(0xfff0aa05),
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          GestureDetector(
            onTap: () {
              selectImage();
            },
            child: SizedBox(
              //  margin: const EdgeInsets.only(top: 200),
              width: MediaQuery.of(context).size.width,
              child: Consumer<Auth>(builder: (context, auth, _) {
                var user = auth.user;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (user?.imageUrl != null && user?.imageUrl != "imageUrl")
                      Container(
                        decoration: BoxDecoration(
                          //  borderRadius: BorderRadius.circular(50),
                          color: const Color(0xff423310),
                          border: Border.all(
                            color: const Color(0xff423310),
                            width: 5,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(
                            user?.imageUrl ?? "",
                            //fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    if (user?.imageUrl == null || user?.imageUrl == "imageUrl")
                      if (imageFile?.path != null)
                        Container(
                          decoration: BoxDecoration(
                            //  borderRadius: BorderRadius.circular(50),
                            color: const Color(0xff423310),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xff423310),
                              width: 5,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: FileImage(
                              File(imageFile!.path),
                              //   fit: BoxFit.cover,
                            ),
                          ),
                        ),
                    if (user?.imageUrl == null || user?.imageUrl == "imageUrl")
                      if (imageFile?.path == null)
                        Container(
                          decoration: BoxDecoration(
                            //  borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                              color: const Color(0xff423310),
                              width: 5,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: const CircleAvatar(
                            radius: 60,
                            backgroundImage: AssetImage(
                              'assets/images/man.jpeg',
                              //   fit: BoxFit.cover,
                            ),
                          ),
                        ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${user?.firstName ?? ''} ${user?.lastName ?? ''}',
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16,
                        color: Color(0xfff0aa05),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              }),
            ),
          ),
          Container(
            width: 800,
            padding: const EdgeInsets.all(16),
            // height: MediaQuery.of(context).size.height * 0.43,
            decoration: BoxDecoration(
              color: const Color(0xfff9f9f9),
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xffffffff),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: const Icon(
                                Icons.email,
                                color: Colors.amber,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => const Setting(),
                            //   ),
                            // );
                          },
                          child: Text(
                            'EMAIL : ${user?.email ?? ''}',
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              color: Color(0xff423310),
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Container(
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xffffffff),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Image.asset("assets/images/settings.png"),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => const Setting(),
                            //   ),
                            // );
                          },
                          child: const Text(
                            'SETTINGS',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              color: Color(0xff423310),
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Row(
                    children: [
                      Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xffffffff),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Image.asset("assets/images/payment.png"),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      const Text(
                        'PAYMENT METHODS',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 16,
                          color: Color(0xff423310),
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Row(
                    children: [
                      Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xffffffff),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Image.asset("assets/images/Path 2940.png"),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      const Text(
                        'ABOUT APP',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 16,
                          color: Color(0xff423310),
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  SvgPicture.string(
                    '<svg viewBox="36.0 638.0 303.0 1.0" ><path transform="translate(36.0, 638.0)" d="M 0 0 L 303 0" fill="none" stroke="#dadadc" stroke-width="1" stroke-miterlimit="4" stroke-linecap="round" /></svg>',
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Row(
                    children: [
                      Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xffffffff),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Image.asset("assets/images/Path 2939.png"),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      GestureDetector(
                        onTap: () {
                          Provider.of<Auth>(context, listen: false).logout();

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SingInPage()),
                          );
                        },
                        child: const Text(
                          'LOG OUT',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16,
                            color: Color(0xff423310),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // bottomNavigationBar: BottomNavigator(),
    );
  }
}
