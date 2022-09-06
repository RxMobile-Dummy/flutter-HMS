class BookAppointmentModel {
  bool? success;
  Data? data;
  String? message;
  String? error;

  BookAppointmentModel({this.success, this.data, this.message, this.error});

  BookAppointmentModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? hospitalId;
  String? firstName;
  String? mobileNumber;
  String? bookingTime;
  String? staffId;
  String? patientId;
  String? doctorId;
  String? lastName;
  String? statusId;
  String? fileData;
  String? patientProfilePic;
  String? disease;

  Data(
      {this.id,
        this.hospitalId,
        this.firstName,
        this.mobileNumber,
        this.bookingTime,
        this.staffId,
        this.patientId,
        this.doctorId,
        this.lastName,
        this.statusId,
        this.fileData,
        this.patientProfilePic,
        this.disease
      });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hospitalId = json['hospital_id'];
    firstName = json['first_name'];
    mobileNumber = json['mobile_number'];
    bookingTime = json['booking_time'];
    staffId = json['staff_id'];
    patientId = json['patient_id'];
    doctorId = json['doctor_id'];
    lastName = json['last_name'];
    statusId = json['status_id'];
    fileData = json['file_data'];
    patientProfilePic = json['patient_profile_pic'];
    disease = json['disease'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['hospital_id'] = this.hospitalId;
    data['first_name'] = this.firstName;
    data['mobile_number'] = this.mobileNumber;
    data['booking_time'] = this.bookingTime;
    data['staff_id'] = this.staffId;
    data['patient_id'] = this.patientId;
    data['doctor_id'] = this.doctorId;
    data['last_name'] = this.lastName;
    data['status_id'] = this.statusId;
    data['file_data'] = this.fileData;
    data['patient_profile_pic'] = this.patientProfilePic;
    data['disease'] = this.disease;
    return data;
  }
}