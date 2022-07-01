import 'package:flutter/material.dart';
import 'package:hogo_app/models/form_data.dart';
import 'package:url_launcher/url_launcher.dart';

class Showform extends StatelessWidget {
  final String title;
  final String address;
  final String phoneNubmer;
  final String state;
  final String city;
  final String url;
  final String room;
  final int index;
  final FormData? adsModel;
  const Showform(
      {Key? key,
      required this.title,
      required this.address,
      required this.phoneNubmer,
      required this.index,
      required this.url,
      required this.adsModel,
      required this.room,
      required this.city,
      required this.state})
      : super(key: key);

  Future<void> _makePhoneCall(String phoneNumber, scheme) async {
    // Use `Uri` to ensure that `phoneNumber` is properly URL-encoded.
    // Just using 'tel:$phoneNumber' would create invalid URLs in some cases,
    // such as spaces in the input, which would cause `launch` to fail on some
    // platforms.
    final Uri launchUri = Uri(
      scheme: scheme,
      path: phoneNumber,
    );
    print("$launchUri");
    await launch(launchUri.toString());
  }

  @override
  Widget build(BuildContext context) {
    print("title is $title");
    print("address is $address");
    print("phoneNubmer is $phoneNubmer");
    print("state is $state");
    print("city is $city");
    final size = MediaQuery.of(context).size;
    final height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: Container(
            width: size.width,
            //  height: size.height * 0.1,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: const Offset(0, 1), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (room.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text("Rooms: $room"),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(address.trim()),
                  ),
                  if (state.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text('${state.trim()} - ${city.trim()}'),
                    ),
                  if (phoneNubmer.isNotEmpty)
                    GestureDetector(
                      onTap: () {
                        _makePhoneCall(phoneNubmer, 'tel');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          "Ph: $phoneNubmer",
                          style: const TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(title.trim()),
                  ),
                  if (url.isNotEmpty)
                    GestureDetector(
                      onTap: () async {
                        print("item.formUrl url");
                        if (url.contains("https://")) {
                          await launch(url);
                        } else {
                          await launch("https://$url");
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          "URL: $url",
                          style: const TextStyle(color: Colors.pink),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        if (index % 3 == 0 && index != 0)
          SizedBox(
            height: height * 0.03,
          ),
        if (adsModel != null)
          if (index % 3 == 0 && index != 0)
            GestureDetector(
              onTap: () async {
                print("item.formUrl ${adsModel!.formUrl}");
                if (adsModel!.formUrl!.contains("https://")) {
                  await launch(adsModel!.formUrl!);
                } else {
                  await launch("https://${adsModel!.formUrl}");
                }
              },
              child: SizedBox(
                //    width: width * 0.15,
                height: height * 0.3,
                child: Image.network(
                  adsModel!.imageUrl ??
                      "https://firebasestorage.googleapis.com/v0/b/projectlab2-a5e52.appspot.com/o/image12022-03-08%2021:58:11.055203?alt=media&token=daca4ad3-b255-4138-b0c9-251f5eb31334",
                  //width: 60.w,
                  height: height * 0.3,
                  //         fit: BoxFit.cover,
                ),
              ),
            ),
      ],
    );
  }
}
