class SendDoctorFeedbackModel {
  bool? success;
  Data? data;
  String? message;
  String? error;

  SendDoctorFeedbackModel({this.success, this.data, this.message, this.error});

  SendDoctorFeedbackModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    data['error'] = this.error;
    return data;
  }
}

class Data {
  String? doctorId;
  int? id;
  String? staffId;
  String? patientId;
  String? comment;
  String? rating;
  String? hospitalId;

  Data(
      {this.doctorId,
        this.id,
        this.staffId,
        this.patientId,
        this.comment,
        this.rating,
        this.hospitalId});

  Data.fromJson(Map<String, dynamic> json) {
    doctorId = json['doctor_id'];
    id = json['id'];
    staffId = json['staff_id'];
    patientId = json['patient_id'];
    comment = json['comment'];
    rating = json['rating'];
    hospitalId = json['hospital_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doctor_id'] = this.doctorId;
    data['id'] = this.id;
    data['staff_id'] = this.staffId;
    data['patient_id'] = this.patientId;
    data['comment'] = this.comment;
    data['rating'] = this.rating;
    data['hospital_id'] = this.hospitalId;
    return data;
  }
}