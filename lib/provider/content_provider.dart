import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/form_data.dart';
import '../models/home.dart';

class ContentProvider with ChangeNotifier {
  // List<Task> _task = [];
  String formType = 'Form for Events';

  setFormType(String type) {
    formType = type;
    notifyListeners();
  }

  String getFormType() {
    return formType;
  }

  List<FormData> loadedFormDate = [];
  List<FormData> adsList = [];

  // search in loadedFormDate list  by city
  List<FormData> getFormDataByCity(String city) {
    List<FormData> formData = [];
    for (var i = 0; i < loadedFormDate.length; i++) {
      if (loadedFormDate[i].city!.toLowerCase().contains(city.toLowerCase())) {
        formData.add(loadedFormDate[i]);
      }
    }
    return formData;
  }

  // search in loadedFormDate list  by city
  List<FormData> getFormDataByState(String state) {
    List<FormData> formData = [];
    for (var i = 0; i < loadedFormDate.length; i++) {
      if (loadedFormDate[i]
          .state!
          .toLowerCase()
          .contains(state.toLowerCase())) {
        formData.add(loadedFormDate[i]);
      }
    }
    return formData;
  }

  // search in loadedFormDate list  by room number
  List<FormData> getFormDataByRooms(String room) {
    List<FormData> formData = [];
    for (var i = 0; i < loadedFormDate.length; i++) {
      if (loadedFormDate[i].rooms!.toLowerCase().contains(room.toLowerCase())) {
        formData.add(loadedFormDate[i]);
      }
    }
    return formData;
  }

  Future<void> addForm({
    String? state,
    City,
    rooms,
    dropDwon4,
    Duration,
    paymentMethod,
    country,
    note1,
    formUrl,
    note2,
    phoneNumberOp,
    phoneNumber,
  }) async {
    print('formType$formType');

    final url = Uri.parse(
        'https://projectlab2-a5e52.firebaseio.com/form/$clickedContent/$formType.json');
    try {
      final value = await http.post(
        url,
        body: json.encode({
          "state": state,
          "City": City,
          "rooms": rooms,
          "dropDwon4": dropDwon4,
          "Duration": Duration,
          "paymentMethod": paymentMethod,
          "country": clickedContent,
          "note1": note1,
          "phoneNumber": phoneNumber,
          "phoneNumberOp": phoneNumberOp,
          "url": formUrl,
          "note2": note2,
          "createdAt": DateTime.now().toString(),
          "endDate": addDays(DateTime.now(), getData(Duration)).toString(),
          "formType": formType,
        }),
      );

      notifyListeners();
    } catch (onError) {
      print(onError);
      rethrow;
    }
  }

  Future<List<FormData>> getContent({String? type}) async {
    print('formType$formType');
    final url = Uri.parse(
        'https://projectlab2-a5e52.firebaseio.com/form/$clickedContent/${type ?? formType}.json');
    try {
      final value = await http.get(url);
      log("url : $url");
      final extractedData = json.decode(value.body) as Map<String, dynamic>;
      // print("extractedData${value.body}");
      //    print("extractedData$extractedData");
      log("url : $extractedData");

      loadedFormDate.clear();

      extractedData.forEach((taskId, taskData) {
        print("taskData : $taskData");
        var data = FormData.fromJson(taskData);
        // check if the form time is not expired
        print("data ${data.endDate}");
        print(
            "data ${DateTime.parse(data.endDate ?? "").isAfter(DateTime.now())}");
        if (DateTime.parse(data.endDate ?? "").isAfter(DateTime.now())) {
          loadedFormDate.add(data);
        }

        //loadedFormDate.add(FormData.fromJson(taskData));
      });
      print("loadedFormDate ${loadedFormDate.length}");
      notifyListeners();

      return loadedFormDate;
    } catch (onError) {
      print(onError);
      return [];
    }
  }

  // fuction for add day to DateTime
  DateTime addDays(DateTime date, int days) {
    return date.add(Duration(days: days));
  }

//"1 weeks", "2 weeks", "3 weeks", "4 weeks"
  // fuction for Duration to DateTime
  int getData(String data) {
    switch (data) {
      case '1 week':
        return 7;
      case '2 weeks':
        return 14;
      case '3 weeks':
        return 21;
      case '4 weeks':
        return 28;

      default:
        return 7;
    }
  }

  Future<bool> addFormAds(
      {String? state,
      City,
      rooms,
      dropDwon4,
      Duration,
      formUrl,
      paymentMethod,
      country,
      note1,
      note2,
      phoneNumberOp,
      phoneNumber,
      imageUrl,
      adsType,
      whereShowAds}) async {
    print('formType$formType');

    final url = Uri.parse(
        'https://projectlab2-a5e52.firebaseio.com/form/$clickedContent/$formType.json');
    try {
      final value = await http.post(
        url,
        body: json.encode({
          "state": state,
          "City": City,
          "rooms": rooms,
          "dropDwon4": dropDwon4,
          "Duration": Duration,
          "paymentMethod": paymentMethod,
          "country": clickedContent,
          "note1": note1,
          "url": formUrl,
          "phoneNumber": phoneNumber,
          "note2": note2,
          "adsType": adsType,
          "imageUrl": imageUrl,
          "stats": "Unknow",
          "whereShowAds": whereShowAds,
          "createdAt": DateTime.now().toString(),
          "endDate": addDays(DateTime.now(), getData(Duration)).toString(),
          "formType": formType,
        }),
      );

      notifyListeners();
      return true;
    } catch (onError) {
      print(onError);
      rethrow;
    }
  }

  Future<bool> addFormEvent({
    String? state,
    City,
    rooms,
    dropDwon4,
    Duration,
    formUrl,
    paymentMethod,
    country,
    note1,
    note2,
    phoneNumberOp,
    phoneNumber,
    imageUrl,
  }) async {
    print('formType$formType');

    final url = Uri.parse(
        'https://projectlab2-a5e52.firebaseio.com/form/$clickedContent/$formType.json');
    try {
      final value = await http.post(
        url,
        body: json.encode({
          "state": state,
          "City": City,
          "rooms": rooms,
          "dropDwon4": dropDwon4,
          "Duration": Duration,
          "paymentMethod": paymentMethod,
          "country": clickedContent,
          "note1": note1,
          "url": formUrl,
          "phoneNumber": phoneNumber,
          "note2": note2,
          "imageUrl": imageUrl,
          "stats": "Unknow",
          "createdAt": DateTime.now().toString(),
          "endDate": addDays(DateTime.now(), getData(Duration)).toString(),
          "formType": formType,
        }),
      );

      notifyListeners();
      return true;
    } catch (onError) {
      print(onError);
      rethrow;
    }
  }

  Future<List<FormData>> getAdsContent() async {
    print('formType$formType');
    final url = Uri.parse(
        'https://projectlab2-a5e52.firebaseio.com/form/$clickedContent/Form for Commercials-Ads.json');

    print("url : $url");
    try {
      final value = await http.get(url);
      final extractedData = json.decode(value.body) as Map<String, dynamic>;
      print("extractedData${value.body}");
      //   print("extractedData$extractedData");
      adsList.clear();
      print("adsList ${value.body}");
      print("adsList $url");

      extractedData.forEach((taskId, taskData) {
        var data = FormData.fromJson(taskData);

        if (DateTime.parse(data.endDate ?? "").isAfter(DateTime.now())) {
          adsList.add(FormData.fromJson(taskData));
        }
      });
      print("adsList ${adsList.length}");
      notifyListeners();

      return adsList;
    } catch (onError) {
      print(onError);
      return [];
    }
  }
}
