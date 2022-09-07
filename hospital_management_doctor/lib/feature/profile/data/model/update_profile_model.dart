class UpdateProfileModel {
  bool? success;
  Data? data;
  String? message;
  String? error;

  UpdateProfileModel({this.success, this.data, this.message, this.error});

  UpdateProfileModel.fromJson(Map<String, dynamic> json) {
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
  String? yearsOfExperience;
  String? specialistField;
  String? about;
  String? createAt;
  String? education;
  String? nextAvailableAt;
  String? inClinicAppointmentFees;
  String? password;
  String? profilePic;
  String? gender;
  String? bloodGroup;
  String? contactNumber;
  String? firstName;
  String? lastName;
  String? email;
  String? dateOfBirth;
  String? hospitalId;
  List<Feedbacks>? feedbacks;

  Data(
      {this.id,
        this.yearsOfExperience,
        this.specialistField,
        this.about,
        this.createAt,
        this.education,
        this.nextAvailableAt,
        this.inClinicAppointmentFees,
        this.password,
        this.profilePic,
        this.gender,
        this.bloodGroup,
        this.contactNumber,
        this.firstName,
        this.lastName,
        this.email,
        this.dateOfBirth,
        this.hospitalId,
        this.feedbacks});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    yearsOfExperience = json['years_of_experience'];
    specialistField = json['specialist_field'];
    about = json['about'];
    createAt = json['create_at'];
    education = json['education'];
    nextAvailableAt = json['next_available_at'];
    inClinicAppointmentFees = json['in_clinic_appointment_fees'];
    password = json['password'];
    profilePic = json['profile_pic'];
    gender = json['gender'];
    bloodGroup = json['blood_group'];
    contactNumber = json['contact_number'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    dateOfBirth = json['date_of_birth'];
    hospitalId = json['hospital_id'];
    if (json['feedbacks'] != null) {
      feedbacks = <Feedbacks>[];
      json['feedbacks'].forEach((v) {
        feedbacks!.add(new Feedbacks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['years_of_experience'] = this.yearsOfExperience;
    data['specialist_field'] = this.specialistField;
    data['about'] = this.about;
    data['create_at'] = this.createAt;
    data['education'] = this.education;
    data['next_available_at'] = this.nextAvailableAt;
    data['in_clinic_appointment_fees'] = this.inClinicAppointmentFees;
    data['password'] = this.password;
    data['profile_pic'] = this.profilePic;
    data['gender'] = this.gender;
    data['blood_group'] = this.bloodGroup;
    data['contact_number'] = this.contactNumber;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['date_of_birth'] = this.dateOfBirth;
    data['hospital_id'] = this.hospitalId;
    if (this.feedbacks != null) {
      data['feedbacks'] = this.feedbacks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Feedbacks {
  int? id;
  String? comment;
  String? rating;
  String? patientName;

  Feedbacks({this.id, this.comment, this.rating, this.patientName});

  Feedbacks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    rating = json['rating'];
    patientName = json['patient_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['comment'] = this.comment;
    data['rating'] = this.rating;
    data['patient_name'] = this.patientName;
    return data;
  }
}