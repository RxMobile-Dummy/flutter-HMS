class GetInjuriesModel {
  bool? success;
  List<Data>? data;
  String? message;
  String? error;

  GetInjuriesModel({this.success, this.data, this.message, this.error});

  GetInjuriesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['error'] = this.error;
    return data;
  }
}

class Data {
  int? id;
  String? pastInjury;

  Data({this.id, this.pastInjury});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pastInjury = json['past_injury'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['past_injury'] = this.pastInjury;
    return data;
  }
}