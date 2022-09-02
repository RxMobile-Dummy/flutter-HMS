class GetMedicationModel {
  bool? success;
  List<Data>? data;
  String? message;
  String? error;

  GetMedicationModel({this.success, this.data, this.message, this.error});

  GetMedicationModel.fromJson(Map<String, dynamic> json) {
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
  String? currentMedication;

  Data({this.id, this.currentMedication});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    currentMedication = json['current_medication'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['current_medication'] = this.currentMedication;
    return data;
  }
}