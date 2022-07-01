import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:hogo_app/models/home.dart';
import 'package:hogo_app/provider/auth_provider.dart';
import 'package:hogo_app/provider/content_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../screen/slide_screen.dart';
import '../utils/theme/app_colors.dart';
import '../widgets/drawer.dart';

import 'home_page_screen.dart';

class LastFormWirhImag extends StatefulWidget {
  static const roudName = "/LastFormWirhImag";

  const LastFormWirhImag({Key? key}) : super(key: key);

  @override
  State<LastFormWirhImag> createState() => _LastFormWirhImagState();
}

class _LastFormWirhImagState extends State<LastFormWirhImag> {
  List<XFile>? selectedPics = [];
  File? _imageFile;
  final picker = ImagePicker();
  String? imageUrl;
  final ImagePicker _picker = ImagePicker();
  bool isEmpty = true;

  final _formKey = GlobalKey<FormState>();

  saveForm(BuildContext context) {
    final contentProvider =
        Provider.of<ContentProvider>(context, listen: false);

    print('icslck');

    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    if (_imageFile == null) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Error"),
              content: const Text("Please choose an image"),
              actions: <Widget>[
                FlatButton(
                  child: const Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    } else {
      uploadImageToFirebase(context);
      return;
    }

    _formKey.currentState!.save();

    if (isValid) {}
  }

  var urlcontroller = TextEditingController();
  Future uploadImageToFirebase(BuildContext context) async {
    showLoaderDialog(context);

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("image1" + DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(_imageFile!);
    print("uploadTask");
    uploadTask.then((res) {
      res.ref.getDownloadURL().then((value) {
        print("getDownloadURL $value");
        Provider.of<ContentProvider>(context, listen: false)
            .addFormAds(
          City: cityValue,
          state: stateValue,
          rooms: dropdownButton3,
          dropDwon4: "none",
          Duration: dropdownButton5,
          paymentMethod: dropdownButton6 ?? "none",
          country: clickedContent,
          note1: text1.text,
          formUrl: urlcontroller.text,
          whereShowAds: dropdownButton7,
          adsType: dropdownButton8,
          imageUrl: value,
        )
            .then(
          (value) {
            if (value) {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  SliderScreen.roudName, (route) => false);
            }
          },
        );
      });

      print("aaaaaaaaaaaa");
    });
  }

  String? countryValue = "";
  String? stateValue = "";
  String? cityValue = "";
  String? address = "";

  bool init = true;
  List<String> listOfItrm = [];
  List<String> listOfItrm2 = [];
  List<String> listOfItrm5 = ["1 weeks", "2 weeks", "3 weeks", "4 weeks"];
  List<String> listOfItrm6 = ["Onilne", "cash Money"];
  List<String> listOfItrm3 = [
    "1 bedroom",
    "2 bedroom",
    "3 bedroom",
    "4 bedroom",
    "studio",
    "basement"
  ];
  List<String> listOfItrm4 = [
    "Show in Home Page Slider",
    "Show with Item",
  ];
  List<String> adsType = [
    "eat and drink",
    "Clothes",
    "electornics",
    "candies",
  ];
  final text1 = TextEditingController();

  String? dropdownButton;
  String? dropdownButton2;
  String? dropdownButton3;
  String? dropdownButton4;
  String? dropdownButton5;
  String? dropdownButton6;
  String? dropdownButton7;
  String? dropdownButton8;

  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = File(pickedFile!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    String? dropdownButton = "Wallet";
    final size = MediaQuery.of(context).size;
    final height = MediaQuery.of(context).size.width;
    final contentProvider =
        Provider.of<ContentProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      drawer: const DrawerScreen(),
      appBar: AppBar(
        backgroundColor: AppColors.scadryColor,
        title: Text("Ads Form"),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  SliderScreen.roudName, (route) => false);
            },
            child: SizedBox(
              //    width: width * 0.15,
              //  height: height * 0.05,
              child: Container(
                width: 10.w,
                height: 10.h,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/deal.png"),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),

                  SizedBox(
                    height: size.height * 0.02,
                  ),

                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  //=========================================================================

                  _imageFile == null
                      ? GestureDetector(
                          onTap: () {
                            print("clicked");
                            pickImage();
                          },
                          child: Container(
                            // alignment: Alignment.center,
                            margin: const EdgeInsets.only(
                                right: 35, left: 35, bottom: 15, top: 15),

                            height: 140,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                            ),
                            child: DottedBorder(
                                color: Colors.grey.shade400,
                                strokeWidth: 2,
                                child: Container(
                                    padding: const EdgeInsets.only(top: 30),
                                    alignment: Alignment.center,
                                    child: Column(children: [
                                      Icon(Icons.add_a_photo_outlined,
                                          size: 50,
                                          color: Colors.grey.shade500),
                                      Text("Add Photos",
                                          style: TextStyle(
                                              color: Colors.grey.shade600))
                                    ]))),
                          ),
                        )
                      : Stack(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 16.0, bottom: 16),
                              child: SizedBox(
                                height: height * 0.4,
                                width: double.infinity,
                                child: Image.file(
                                  File(_imageFile!.path),
                                ),
                              ),
                            ),
                            Positioned(
                                bottom: 5,
                                left: 8,
                                child: GestureDetector(
                                  onTap: () {
                                    print("clicked");
                                    pickImage();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        //  color: kPrimaryColor,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    height: 40,
                                    width: 40,
                                    child: const Icon(Icons.add,
                                        color: Colors.white),
                                  ),
                                )),
                          ],
                        ),

                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Container(
                    height: size.height * 0.1,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: size.height * 0.1,
                      ),
                      child: Scrollbar(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          reverse: true,
                          child: SizedBox(
                            height: size.height * 0.1,
                            child: TextFormField(
                              controller: text1,
                              maxLength: 60,
                              maxLines: 3,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Type your address..',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Container(
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: size.width * 0.03,
                        ),
                        SizedBox(
                          width: size.width * 0.02,
                        ),
                        Expanded(
                          child: TextFormField(
                            //   textCapitalization: TextCapitalization.words,
                            keyboardType: TextInputType.text,
                            onFieldSubmitted: (term) {},
                            controller: urlcontroller,
                            //   maxLength: 10,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(0.0),
                              border: InputBorder.none,
                              hintText: "Enter Url",
                            ),

                            //  maxLines: isPrograph == true ? 10 : 1,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Container(
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8, bottom: 8, right: 8, left: 15),
                      child: DropdownButton<String>(
                        underline: const SizedBox(),
                        isExpanded: true,
                        focusColor: Colors.white,
                        value: dropdownButton5,
                        //elevation: 5,
                        style: const TextStyle(color: Colors.white),
                        iconEnabledColor: Colors.black,
                        items: listOfItrm5
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                        hint: const Text(
                          "Please choose a duration",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            dropdownButton5 = value!;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  if (!Provider.of<Auth>(context).userEmail!.contains("@admin"))
                    Container(
                      width: size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 8, bottom: 8, right: 8, left: 15),
                        child: DropdownButton<String>(
                          underline: const SizedBox(),
                          isExpanded: true,
                          focusColor: Colors.white,
                          value: dropdownButton6,
                          //elevation: 5,
                          style: const TextStyle(color: Colors.white),
                          iconEnabledColor: Colors.black,
                          items: listOfItrm6
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(color: Colors.black),
                              ),
                            );
                          }).toList(),
                          hint: const Text(
                            "Please choose a payment method",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              dropdownButton6 = value!;
                            });
                          },
                        ),
                      ),
                    ),

                  SizedBox(
                    height: 1.h,
                  ),
                  Container(
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8, bottom: 8, right: 8, left: 15),
                      child: DropdownButton<String>(
                        underline: const SizedBox(),
                        isExpanded: true,
                        focusColor: Colors.white,
                        //elevation: 5,
                        style: const TextStyle(color: Colors.white),
                        iconEnabledColor: Colors.black,
                        value: dropdownButton7,
                        items: listOfItrm4
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                        hint: const Text(
                          "Please choose a where Ads appear",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            dropdownButton7 = value!;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8, bottom: 8, right: 8, left: 15),
                      child: DropdownButton<String>(
                        underline: const SizedBox(),
                        isExpanded: true,
                        focusColor: Colors.white,
                        //elevation: 5,
                        style: const TextStyle(color: Colors.white),
                        iconEnabledColor: Colors.black,
                        value: dropdownButton8,
                        items: adsType
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                        hint: const Text(
                          "Please choose a Ads Type",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            dropdownButton8 = value!;
                          });
                        },
                      ),
                    ),
                  ),

                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GestureDetector(
                      onTap: () {
                        saveForm(context);
                      },
                      child: Container(
                        width: size.width,
                        height: size.height * 0.06,
                        decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(25)),
                        child: const Center(
                          child: Text(
                            "Submit",
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
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

  void selectImages() async {
    print("select clicked");
    if (selectedPics != null) {
      //  selectedPics!.clear();
    }
    selectedPics!.addAll(await _picker.pickMultiImage() as List<XFile>);

    if (selectedPics != null) {
      selectedPics = selectedPics!.reversed.toList();
      print(selectedPics);
      setState(() {
        if (selectedPics!.isNotEmpty) {
          isEmpty = false;
        }
      });
    }
  }
}
