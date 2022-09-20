class GetProfileModel {
  bool? success;
  Data? data;
  String? message;
  String? error;

  GetProfileModel({this.success, this.data, this.message, this.error});

  GetProfileModel.fromJson(Map<String, dynamic> json) {
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
  String? yearsOfExperience;
  String? education;
  int? id;
  String? profilePic;
  String? lastName;
  String? email;
  String? dateOfBirth;
  String? hospitalId;
  String? firstName;
  String? contactNumber;
  String? password;
  String? gender;
  String? bloodGroup;

  Data(
      {this.yearsOfExperience,
        this.education,
        this.id,
        this.profilePic,
        this.lastName,
        this.email,
        this.dateOfBirth,
        this.hospitalId,
        this.firstName,
        this.contactNumber,
        this.password,
        this.gender,
        this.bloodGroup});

  Data.fromJson(Map<String, dynamic> json) {
    yearsOfExperience = json['years_of_experience'];
    education = json['education'];
    id = json['id'];
    profilePic = json['profile_pic'];
    lastName = json['last_name'];
    email = json['email'];
    dateOfBirth = json['date_of_birth'];
    hospitalId = json['hospital_id'];
    firstName = json['first_name'];
    contactNumber = json['contact_number'];
    password = json['password'];
    gender = json['gender'];
    bloodGroup = json['blood_group'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['years_of_experience'] = this.yearsOfExperience;
    data['education'] = this.education;
    data['id'] = this.id;
    data['profile_pic'] = this.profilePic;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['date_of_birth'] = this.dateOfBirth;
    data['hospital_id'] = this.hospitalId;
    data['first_name'] = this.firstName;
    data['contact_number'] = this.contactNumber;
    data['password'] = this.password;
    data['gender'] = this.gender;
    data['blood_group'] = this.bloodGroup;
    return data;
  }
}