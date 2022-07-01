class FormData {
  String? dropDwon4;
  String? duration;
  String? country;
  String? state;
  String? status;
  String? imageUrl;
  String? paymentMethod;
  String? rooms;
  String? formType;
  String? note1;
  String? note2;
  String? phoneNumber;
  String? city;
  String? whereShowAds;
  String? formUrl;
  String? createdAt;
  String? endDate;
  String? adsType;
  String? key;

  FormData(
      {this.dropDwon4,
      this.duration,
      this.country,
      this.state,
      this.imageUrl,
      this.paymentMethod,
      this.rooms,
      this.formType,
      this.note1,
      this.adsType,
      this.note2,
      this.status,
      this.formUrl,
      this.whereShowAds,
      this.phoneNumber,
      this.city,
      this.key});

  FormData.fromJson(Map<dynamic, dynamic> json) {
    dropDwon4 = json['dropDwon4'];
    duration = json['Duration'];
    country = json['country'];
    state = json['state'];
    imageUrl = json['imageUrl'];
    paymentMethod = json['paymentMethod'];
    formUrl = json['url'];
    status = json['stats'];
    rooms = json['rooms'];
    formType = json['formType'];
    note1 = json['note1'];
    createdAt = json['createdAt'];
    whereShowAds = json['whereShowAds'];
    note2 = json['note2'];
    phoneNumber = json['phoneNumber'];
    adsType = json['adsType'];
    key = json['key'];
    endDate = json['endDate'];
    city = json['City'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dropDwon4'] = dropDwon4;
    data['Duration'] = duration;
    data['country'] = country;
    data['state'] = state;
    data['adsType'] = adsType;
    data['imageUrl'] = imageUrl;
    data['url'] = formUrl;
    data['createdAt'] = createdAt;
    data['paymentMethod'] = paymentMethod;
    data['rooms'] = rooms;
    data['whereShowAds'] = whereShowAds;
    data['formType'] = formType;
    data['note1'] = note1;
    data['stats'] = status;
    data['note2'] = note2;
    data['endDate'] = endDate;
    data['phoneNumber'] = phoneNumber;
    data['City'] = city;
    data['key'] = key;
    return data;
  }
}
