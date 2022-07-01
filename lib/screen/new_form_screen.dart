import 'package:flutter/material.dart';
import 'package:hogo_app/models/home.dart';
import 'package:hogo_app/utils/theme/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../models/date.dart';
import '../provider/content_provider.dart';
import '../screen/form_screen.dart';
import '../screen/last_form_with_imag.dart';
import '../screen/slide_screen.dart';
import '../widgets/drawer.dart';
import 'event_form.dart';
import 'home_page_screen.dart';

class NewForm extends StatelessWidget {
  static const roudName = "/NewForm";

  const NewForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = MediaQuery.of(context).size.height;
    var formType = Provider.of<ContentProvider>(context);

    return Scaffold(
      drawer: const DrawerScreen(),
      appBar: AppBar(
        backgroundColor: AppColors.scadryColor,
        title: Text("All Forms"),
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
      body: Container(
        margin: EdgeInsets.only(top: 15.h),
        child: ListView.builder(
            itemCount: addNewFormData.length,
            itemBuilder: (contxt, index) {
              return GestureDetector(
                onTap: () {
                  if (addNewFormData[index] == "Form for Commercials-Ads") {
                    formType.setFormType(addNewFormData[index]);

                    Navigator.pushNamed(context, LastFormWirhImag.roudName);
                  } else if (addNewFormData[index] == "Form for Events") {
                    formType.setFormType(addNewFormData[index]);
                    Navigator.pushNamed(context, EventForm.roudName);
                  } else {
                    formType.setFormType(addNewFormData[index]);
                    Navigator.pushNamed(context, FormScreen.roudName);
                  }
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  child: Container(
                    width: size.width * 0.7,
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        // borderRadius: const BorderRadius.all(
                        //     Radius.elliptical(9999.0, 9999.0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 1), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(30)),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          addNewFormData[index],
                          style: TextStyle(color: AppColors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
