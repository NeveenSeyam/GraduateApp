import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hogo_app/models/form_data.dart';
import 'package:hogo_app/models/home.dart';
import 'package:sizer/sizer.dart';

import '../constants.dart';

class Adsitem extends StatefulWidget {
  final FormData formData;
  const Adsitem({Key? key, required this.formData}) : super(key: key);

  @override
  _AdsitemState createState() => _AdsitemState();
}

class _AdsitemState extends State<Adsitem> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // show news item here with image and title

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        // height: size.height * 0.39,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  children: [
                    FadeInImage(
                      placeholder: const AssetImage('assets/images/icon.png'),
                      image: NetworkImage(widget.formData.imageUrl!),
                      height: size.height * 0.25,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.indigoAccent,
                          ),
                          height: size.height * 0.032,
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            child: Center(
                              child: Text(
                                widget.formData.country!,
                                style: boldTextwhite,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 2, top: 10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.88,
                  // height: size.height * 0.06,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      widget.formData.note1 ?? "For Test",
                      style: boldText,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 2, top: 10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.88,
                  // height: size.height * 0.06,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      "Phone: ${widget.formData.phoneNumber ?? "000000000"}",
                      style: boldText,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 2, top: 10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.88,
                  // height: size.height * 0.06,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      "rooms:  ${widget.formData.rooms ?? "For Test"}",
                      style: boldText,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 2, top: 10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.88,
                  // height: size.height * 0.06,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      "Duration:  ${widget.formData.duration ?? "For Test"}",
                      style: boldText,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 2, top: 10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.88,
                  // height: size.height * 0.06,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      "Location:  ${widget.formData.state} - ${widget.formData.city}",
                      style: boldText,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 2, top: 5),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  width: MediaQuery.of(context).size.width * 0.88,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.attach_money_sharp,
                            color: Colors.grey,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Payment:  ${widget.formData.paymentMethod ?? "For Test"}",
                            style: boldText,
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // accept button and reject button
                          GestureDetector(
                            onTap: () {
                              print("clicked");
                              print("clicked");
                              FirebaseDatabase.instance
                                  .ref(
                                      "form/$clickedContent/Form for Commercials-Ads/${widget.formData.key}")
                                  .remove();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.indigoAccent,
                                  width: 1,
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          GestureDetector(
                            onTap: () async {
                              print(widget.formData.key);
                              await FirebaseDatabase.instance
                                  .ref(
                                      "form/$clickedContent/Form for Commercials-Ads/${widget.formData.key}/stats")
                                  .set("Accepted");
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.indigoAccent,
                                  width: 1,
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Icon(
                                  Icons.done,
                                  color: Colors.indigoAccent,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
