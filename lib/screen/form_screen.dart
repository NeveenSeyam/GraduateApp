import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:hogo_app/provider/auth_provider.dart';
import 'package:hogo_app/utils/theme/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../models/home.dart';
import '../provider/content_provider.dart';
import '../screen/slide_screen.dart';
import '../widgets/drawer.dart';

class FormScreen extends StatefulWidget {
  static const roudName = "/FormScreen";

  const FormScreen({Key? key}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  String? countryValue = "";
  String? stateValue = "";
  String? cityValue = "";
  String? address = "";

  bool init = true;
  List<String> listOfItrm = ["1", "2", "3", "4", "5"];
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

  String? dropdownButton;
  String? dropdownButton2;
  String? dropdownButton3;
  String? dropdownButton4;
  String? dropdownButton5;
  String? dropdownButton6;

  bool showRooms(BuildContext context) {
    var data =
        Provider.of<ContentProvider>(context, listen: false).getFormType();
    bool value = false;
    switch (data) {
      case "Form for House Rent":
        value = true;
        break;
      case "Form for House Sell":
        value = true;
        break;
      case "Form for Car Sell":
        value = false;
        break;
      default:
        value = false;
        break;
    }
    print("showRooms $value");
    print("showRooms $data");
    return value;
  }

  @override
  didChangeDependencies() {
    if (init) {
      listOfItrm = showData;
      listOfItrm2 = newYork;
      //  dropdownButton = listOfItrm[0];
      dropdownButton2 = listOfItrm2[0];
      dropdownButton3 = listOfItrm3[0];
      //  dropdownButton4 = listOfItrm[0];
      dropdownButton5 = listOfItrm5[0];
      dropdownButton6 = listOfItrm6[0];

      init = false;
    }
  }

  getCuntry() {
    //switch for country
    switch (clickedContent) {
      case "United States":
        return DefaultCountry.United_States;
      case "United Kingdom":
        return DefaultCountry.United_Kingdom;

      case "CANADA":
        return DefaultCountry.Canada;
      case "Italy":
        return DefaultCountry.Italy;

      case "Australia":
        return DefaultCountry.Australia;
    }
  }

  final text1 = TextEditingController();
  final text2 = TextEditingController();
  final phoneNumberOp = TextEditingController();
  final urlcontroller = TextEditingController();
  final text3 = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  saveForm(BuildContext context) {
    final contentProvider =
        Provider.of<ContentProvider>(context, listen: false);

    print('icslck');

    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    contentProvider
        .addForm(
          City: "Gaza",
          state: "Gaza",
          rooms: showRooms(context) ? dropdownButton3 : '',
          dropDwon4: dropdownButton4,
          Duration: dropdownButton5,
          paymentMethod: dropdownButton6,
          country: clickedContent,
          note1: text1.text,
          phoneNumber: text2.text,
          formUrl: urlcontroller.text,
          note2: text3.text,
        )
        .then(
          (value) => Navigator.of(context)
              .pushNamedAndRemoveUntil(SliderScreen.roudName, (route) => false),
        );

    _formKey.currentState!.save();

    if (isValid) {}
  }

  @override
  Widget build(BuildContext context) {
    final contentProvider =
        Provider.of<ContentProvider>(context, listen: false);

    final size = MediaQuery.of(context).size;
    final height = MediaQuery.of(context).size.height;

    Widget dropDown1(Size size, String? dropdownButton) {
      return Container(
        width: size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8, right: 8, left: 15),
          child: DropdownButton<String>(
            underline: const SizedBox(),
            isExpanded: true,
            focusColor: Colors.white,
            value: dropdownButton,
            //elevation: 5,
            style: const TextStyle(color: Colors.white),
            iconEnabledColor: Colors.black,
            items: <String>[
              'Wallet',
              'Wallet2',
              'Wallet3',
              'Wallet4',
              'Wallet5',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: const TextStyle(color: Colors.black),
                ),
              );
            }).toList(),
            hint: const Text(
              "Please choose a langauage",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
            onChanged: (String? value) {
              setState(() {
                dropdownButton = value;
              });
            },
          ),
        ),
      );
    }

    return Scaffold(
      drawer: const DrawerScreen(),
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(clickedContent),
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
                width: 8.w,
                height: 8.h,
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
      backgroundColor: Colors.grey[50],
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
                  if (showRooms(context))
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
                          value: dropdownButton3,
                          //elevation: 5,
                          style: const TextStyle(color: Colors.white),
                          iconEnabledColor: Colors.black,
                          items: listOfItrm3
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
                            "Please choose a langauage",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              dropdownButton3 = value!;
                            });
                          },
                        ),
                      ),
                    ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Container(
                    //  height: size.height * 0.15,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                          //    maxHeight: size.height * 0.15,
                          ),
                      child: Scrollbar(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          reverse: true,
                          child: SizedBox(
                            //  height: size.height * 0.15,
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
                            keyboardType: TextInputType.phone,
                            onFieldSubmitted: (term) {},
                            controller: text2,
                            maxLength: 10,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your phone number';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(0.0),
                              border: InputBorder.none,
                              hintText: "Enter Phone Number",
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
                            keyboardType: TextInputType.phone,
                            onFieldSubmitted: (term) {},
                            controller: phoneNumberOp,
                            maxLength: 10,

                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(0.0),
                              border: InputBorder.none,
                              hintText: "Enter Phone Number optional",
                            ),

                            //  maxLines: isPrograph == true ? 10 : 1,
                          ),
                        ),
                      ],
                    ),
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
                    //   height: size.height * 0.1,
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
                            //  height: size.height * 0.1,
                            child: TextFormField(
                              controller: text3,
                              maxLength: 30,
                              maxLines: 2,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Type your message..",
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
                          "Please choose a langauage",
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
                  if (Provider.of<Auth>(context).userEmail != "admin@admin.com")
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
                            "Please choose a langauage",
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

  Container dropDown(
    Size size,
    String? dropdownButton,
  ) {
    return Container(
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8, right: 8, left: 15),
        child: DropdownButton<String>(
          underline: const SizedBox(),
          isExpanded: true,
          focusColor: Colors.white,
          value: dropdownButton,
          //elevation: 5,
          style: const TextStyle(color: Colors.white),
          iconEnabledColor: Colors.black,
          items: listOfItrm.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: const TextStyle(color: Colors.black),
              ),
            );
          }).toList(),
          hint: const Text(
            "Please choose a langauage",
            style: TextStyle(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
          ),
          onChanged: (String? value) {
            setState(() {
              dropdownButton = value;
            });
          },
        ),
      ),
    );
  }
}
