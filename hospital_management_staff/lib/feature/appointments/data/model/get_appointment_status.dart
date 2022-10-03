class GetAppointmentStatusModel {
  bool? success;
  List<Data>? data;
  String? message;
  String? error;

  GetAppointmentStatusModel({this.success, this.data, this.message});

  GetAppointmentStatusModel.fromJson(Map<String, dynamic> json) {
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
  int? aId;
  String? status;

  Data({this.aId, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    aId = json['a_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['a_id'] = this.aId;
    data['status'] = this.status;
    return data;
  }
}