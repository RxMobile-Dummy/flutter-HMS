class GetSurgeryModel {
  bool? success;
  List<Data>? data;
  String? message;
  String? error;

  GetSurgeryModel({this.success, this.data, this.message, this.error});

  GetSurgeryModel.fromJson(Map<String, dynamic> json) {
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
  String? pastSurgery;
  int? id;

  Data({this.pastSurgery, this.id});

  Data.fromJson(Map<String, dynamic> json) {
    pastSurgery = json['past_surgery'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['past_surgery'] = this.pastSurgery;
    data['id'] = this.id;
    return data;
  }
}