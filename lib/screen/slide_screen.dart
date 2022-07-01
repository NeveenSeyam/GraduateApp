import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hogo_app/models/form_data.dart';
import 'package:hogo_app/models/home.dart';
import 'package:hogo_app/utils/theme/app_colors.dart';
import 'package:hogo_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../provider/content_provider.dart';
import '../widgets/drawer.dart';
import 'home_page_screen.dart';

class SliderScreen extends StatefulWidget {
  static const roudName = "/SliderScreen";

  @override
  State<SliderScreen> createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {
  List<FormData> adsData = [];
  List<FormData> finalAdsData = [];
  bool init = true;
  bool showDate = false;
  List<FormData> data = [];
  List<FormData> clothesAdsList = [];
  List<FormData> eatDrinkAdsList = [];
  List<FormData> electornicsAdsList = [];
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  void didChangeDependencies() {
    if (init) {
      Provider.of<ContentProvider>(context, listen: false).loadedFormDate = [];
      Provider.of<ContentProvider>(context, listen: false)
          .getContent(type: "Form for Events")
          .then((value) {
        data =
            Provider.of<ContentProvider>(context, listen: false).loadedFormDate;

        print("adsData ${adsData.length}");
        setState(() {
          showDate = true;
        });
      });
      //       "eat and drink",
      // "Clothes",
      // "electornics",
      // "candies",

      Provider.of<ContentProvider>(context, listen: false)
          .getAdsContent()
          .then((value) {
        setState(() {
          finalAdsData = Provider.of<ContentProvider>(context, listen: false)
              .adsList
              .where((element) => element.status == 'Accepted')
              .toList();

          clothesAdsList = Provider.of<ContentProvider>(context, listen: false)
              .adsList
              .where((element) =>
                  element.status == 'Accepted' && element.adsType == 'Clothes')
              .toList();

          eatDrinkAdsList = Provider.of<ContentProvider>(context, listen: false)
              .adsList
              .where((element) =>
                  element.status == 'Accepted' &&
                  element.adsType == 'eat and drink')
              .toList();

          electornicsAdsList =
              Provider.of<ContentProvider>(context, listen: false)
                  .adsList
                  .where((element) =>
                      element.status == 'Accepted' &&
                      element.adsType == 'electornics')
                  .toList();

          init = false;
          showDate = true;
        });
      });
      init = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      drawer: const DrawerScreen(),
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text("All Adds"),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  HomePageScreen.roudName, (route) => false);
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                width: 8.w,
                height: 8.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(getContryLogoByTitle())),
                ),
              ),
            ),
          ),
        ],
      ),
      body: showDate
          ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider(
                    items: finalAdsData
                        .map((item) => Container(
                              margin: const EdgeInsets.all(5.0),
                              child: GestureDetector(
                                onTap: () async {
                                  print("item.formUrl ${item.formUrl}");
                                  if (await canLaunch(item.formUrl ?? '')) {
                                    await launch(item.formUrl!);
                                  } else {
                                    throw "Could not launch ${item.formUrl}";
                                  }
                                },
                                child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5.0)),
                                    child: Stack(
                                      children: <Widget>[
                                        Image.network(item.imageUrl ?? "",
                                            fit: BoxFit.cover, width: 1000.0),
                                        Positioned(
                                          bottom: 0.0,
                                          left: 0.0,
                                          right: 0.0,
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Color.fromARGB(200, 0, 0, 0),
                                                  Color.fromARGB(0, 0, 0, 0)
                                                ],
                                                begin: Alignment.bottomCenter,
                                                end: Alignment.topCenter,
                                              ),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 20.0),
                                            child: Text(
                                              item.note2 ?? "",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ))
                        .toList(),
                    carouselController: _controller,
                    options: CarouselOptions(
                        autoPlay: true,
                        enlargeCenterPage: true,
                        aspectRatio: 2.0,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: finalAdsData.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () => _controller.animateToPage(entry.key),
                        child: Container(
                          width: 12.0,
                          height: 12.0,
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black)
                                  .withOpacity(
                                      _current == entry.key ? 0.9 : 0.4)),
                        ),
                      );
                    }).toList(),
                  ),
                  TextWidget("Clothes",
                      fontSize: 15.sp, fontWeight: FontWeight.bold),
                  if (clothesAdsList.isNotEmpty)
                    CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        aspectRatio: 2.0,
                        enlargeCenterPage: true,
                        autoPlayAnimationDuration: const Duration(seconds: 1),
                      ),
                      items: clothesAdsList
                          .map((item) => Container(
                                margin: const EdgeInsets.all(5.0),
                                child: GestureDetector(
                                  onTap: () async {
                                    print("item.formUrl ${item.formUrl}");
                                    if (await canLaunch(item.formUrl ?? '')) {
                                      await launch(item.formUrl!);
                                    } else {
                                      throw "Could not launch ${item.formUrl}";
                                    }
                                  },
                                  child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5.0)),
                                      child: Stack(
                                        children: <Widget>[
                                          Image.network(item.imageUrl ?? "",
                                              fit: BoxFit.cover, width: 1000.0),
                                          Positioned(
                                            bottom: 0.0,
                                            left: 0.0,
                                            right: 0.0,
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Color.fromARGB(
                                                        200, 0, 0, 0),
                                                    Color.fromARGB(0, 0, 0, 0)
                                                  ],
                                                  begin: Alignment.bottomCenter,
                                                  end: Alignment.topCenter,
                                                ),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10.0,
                                                      horizontal: 20.0),
                                              child: Text(
                                                item.note2 ?? "",
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                              ))
                          .toList(),
                    ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  TextWidget("Eat & Drink",
                      fontSize: 15.sp, fontWeight: FontWeight.bold),
                  if (eatDrinkAdsList.isNotEmpty)
                    CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        aspectRatio: 2.0,
                        enlargeCenterPage: true,
                        autoPlayAnimationDuration: const Duration(seconds: 1),
                      ),
                      items: eatDrinkAdsList
                          .map((item) => Container(
                                margin: const EdgeInsets.all(5.0),
                                child: GestureDetector(
                                  onTap: () async {
                                    print("item.formUrl ${item.formUrl}");
                                    if (await canLaunch(item.formUrl ?? '')) {
                                      await launch(item.formUrl!);
                                    } else {
                                      throw "Could not launch ${item.formUrl}";
                                    }
                                  },
                                  child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5.0)),
                                      child: Stack(
                                        children: <Widget>[
                                          Image.network(item.imageUrl ?? "",
                                              fit: BoxFit.cover, width: 1000.0),
                                          Positioned(
                                            bottom: 0.0,
                                            left: 0.0,
                                            right: 0.0,
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Color.fromARGB(
                                                        200, 0, 0, 0),
                                                    Color.fromARGB(0, 0, 0, 0)
                                                  ],
                                                  begin: Alignment.bottomCenter,
                                                  end: Alignment.topCenter,
                                                ),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8.0,
                                                      horizontal: 10.0),
                                              child: Text(
                                                item.note2 ?? "",
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 25.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                              ))
                          .toList(),
                    ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  TextWidget("Electronics",
                      fontSize: 15.sp, fontWeight: FontWeight.bold),
                  if (electornicsAdsList.isNotEmpty)
                    CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        aspectRatio: 2.0,
                        enlargeCenterPage: true,
                        autoPlayAnimationDuration: const Duration(seconds: 1),
                      ),
                      items: electornicsAdsList
                          .map((item) => Container(
                                margin: const EdgeInsets.all(5.0),
                                child: GestureDetector(
                                  onTap: () async {
                                    print("item.formUrl ${item.formUrl}");
                                    if (await canLaunch(item.formUrl ?? '')) {
                                      await launch(item.formUrl!);
                                    } else {
                                      throw "Could not launch ${item.formUrl}";
                                    }
                                  },
                                  child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5.0)),
                                      child: Stack(
                                        children: <Widget>[
                                          Image.network(item.imageUrl ?? "",
                                              fit: BoxFit.cover, width: 500.0),
                                          Positioned(
                                            bottom: 0.0,
                                            left: 0.0,
                                            right: 0.0,
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Color.fromARGB(
                                                        200, 0, 0, 0),
                                                    Color.fromARGB(0, 0, 0, 0)
                                                  ],
                                                  begin: Alignment.bottomCenter,
                                                  end: Alignment.topCenter,
                                                ),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10.0,
                                                      horizontal: 10.0),
                                              child: Text(
                                                item.note2 ?? "",
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                              ))
                          .toList(),
                    ),
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
