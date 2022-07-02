import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hogo_app/utils/theme/app_colors.dart';
import 'package:hogo_app/widgets/bottom_navigation.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/form_data.dart';
import '../provider/content_provider.dart';
import '../screen/slide_screen.dart';
import '../widgets/drawer.dart';
import '../widgets/show_form.dart';

class ShowAllData extends StatefulWidget {
  static const roudName = "/ShowAllData";

  const ShowAllData({Key? key}) : super(key: key);

  @override
  State<ShowAllData> createState() => _ShowAllDataState();
}

class _ShowAllDataState extends State<ShowAllData> {
  bool init = true;
  List<FormData> data = [];
  List<FormData> adsData = [];
  List<FormData> finalAdsData = [];

  @override
  void didChangeDependencies() {
    if (init) {
      Provider.of<ContentProvider>(context, listen: false)
          .getContent()
          .then((value) {
        data =
            Provider.of<ContentProvider>(context, listen: false).loadedFormDate;

        finalAdsData = Provider.of<ContentProvider>(context, listen: false)
            .adsList
            .where((element) => element.status == 'Accepted')
            .toList();
        print("adsData  finalAdsData ${finalAdsData.length}");

        adsData = finalAdsData
            .where((element) => element.whereShowAds == 'Show with Item')
            .toList();

        print("adsData ${adsData.length}");
        setState(() {});
      });

      init = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = MediaQuery.of(context).size.height;
    var contentProv = Provider.of<ContentProvider>(context);
    return Scaffold(
      drawer: const DrawerScreen(),
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(contentProv.getFormType().substring(9)),
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
      body: Column(
        children: [
          // search by city textField
          SizedBox(
            height: 2.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2.w),
              child: TextFormField(
                onChanged: (value) async {
                  setState(() {
                    print(value);
                    data = [];
                    data = contentProv.getFormDataByState(value);
                  });
                },
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 1.h, horizontal: 10.w),
                    hintStyle: const TextStyle(
                      fontFamily: 'Cairo',
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2.w),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2.w),
                      borderSide: const BorderSide(
                        color: AppColors.scadryColor,
                      ),
                    ),
                    hintText: "Search by State",
                    prefixIcon: const Icon(
                      Icons.search,
                      color: AppColors.scadryColor,
                    )),
              ),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          if (contentProv.getFormType() != "Form for Events")
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(2.w),
                child: TextFormField(
                  onChanged: (value) async {
                    setState(() {
                      print(value);
                      data = [];
                      data = contentProv.getFormDataByCity(value);
                    });
                  },
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 1.h, horizontal: 10.w),
                      hintStyle: const TextStyle(
                        fontFamily: 'Cairo',
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2.w),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2.w),
                        borderSide: const BorderSide(
                          color: AppColors.scadryColor,
                        ),
                      ),
                      hintText: 'Search by city',
                      prefixIcon: const Icon(
                        Icons.search,
                        color: AppColors.scadryColor,
                      )),
                ),
              ),
            ),
          SizedBox(
            height: 2.h,
          ),

          if (contentProv.getFormType() == "Form for House Rent")
            SizedBox(
              height: 2.h,
            ),

          data.isEmpty
              ? const Center(
                  child: Text("No Data"),
                )
              : Expanded(
                  child: contentProv.getFormType() != "Form for Events"
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: (contxt, index) => Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: data[index].note2 != null &&
                                    data[index].phoneNumber != null
                                ? Showform(
                                    address: data[index].note1 ?? "",
                                    phoneNubmer: data[index].phoneNumber ?? "",
                                    state: data[index].state ?? "",
                                    room: data[index].rooms ?? "",
                                    city: data[index].city ?? "",
                                    title: data[index].note2 ?? "",
                                    url: data[index].formUrl ?? "",
                                    adsModel: adsData.isNotEmpty
                                        ? adsData[
                                            Random().nextInt(adsData.length)]
                                        : null,
                                    index: index + 1,
                                  )
                                : Container(),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: (contxt, index) => Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              //    color: AppColors.primaryColor,
                              child: Column(
                                children: [
                                  GestureDetector(
                                      onTap: () async {
                                        print(
                                            "item.formUrl ${data[index].formUrl}");
                                        if (data[index]
                                            .formUrl!
                                            .contains("https://")) {
                                          await launch(data[index].formUrl!);
                                        } else {
                                          await launch(
                                              "https://${data[index].formUrl}");
                                        }
                                      },
                                      child: Image.network(
                                          data[index].imageUrl ?? "")),
                                  if (index % 3 == 0 && index != 0)
                                    GestureDetector(
                                      onTap: () async {
                                        print(
                                            "item.formUrl ${adsData[Random().nextInt(adsData.length)].formUrl}");
                                        if (await canLaunch(adsData[Random()
                                                    .nextInt(adsData.length)]
                                                .formUrl ??
                                            '')) {
                                          await launch(adsData[Random()
                                                  .nextInt(adsData.length)]
                                              .formUrl!);
                                        } else {
                                          throw "Could not launch ${adsData[Random().nextInt(adsData.length)].formUrl}";
                                        }
                                      },
                                      child: SizedBox(
                                        //    width: width * 0.15,
                                        height: height * 0.1,
                                        child: Image.network(
                                          adsData[Random()
                                                      .nextInt(adsData.length)]
                                                  .imageUrl ??
                                              "https://firebasestorage.googleapis.com/v0/b/projectlab2-a5e52.appspot.com/o/image12022-03-08%2021:58:11.055203?alt=media&token=daca4ad3-b255-4138-b0c9-251f5eb31334",
                                          //width: 60.w,
                                          height: height * 0.3,
                                          //         fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                ),
        ],
      ),
    );
  }
}
