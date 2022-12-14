class UpdatePatientProfileModel {
  bool? success;
  String? message;
  String? error;

  UpdatePatientProfileModel({this.success, this.message,this.error});

  UpdatePatientProfileModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['error'] = this.error;
    return data;
  }
}