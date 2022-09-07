class SignInDoctorModel {
  bool? success;
  Data? data;
  String? message;
  String? error;

  SignInDoctorModel({this.success, this.data, this.message, this.error});

  SignInDoctorModel.fromJson(Map<String, dynamic> json) {
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
  String? profilePic;
  String? gender;
  String? bloodGroup;
  String? contactNumber;
  String? firstName;
  String? lastName;
  String? email;
  String? dateOfBirth;
  String? hospitalId;
  AuthenticationToken? authenticationToken;

  Data(
      {this.id,
        this.profilePic,
        this.gender,
        this.bloodGroup,
        this.contactNumber,
        this.firstName,
        this.lastName,
        this.email,
        this.dateOfBirth,
        this.hospitalId,
        this.authenticationToken});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profilePic = json['profile_pic'];
    gender = json['gender'];
    bloodGroup = json['blood_group'];
    contactNumber = json['contact_number'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    dateOfBirth = json['date_of_birth'];
    hospitalId = json['hospital_id'];
    authenticationToken = json['authentication_token'] != null
        ? new AuthenticationToken.fromJson(json['authentication_token'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['profile_pic'] = this.profilePic;
    data['gender'] = this.gender;
    data['blood_group'] = this.bloodGroup;
    data['contact_number'] = this.contactNumber;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['date_of_birth'] = this.dateOfBirth;
    data['hospital_id'] = this.hospitalId;
    if (this.authenticationToken != null) {
      data['authentication_token'] = this.authenticationToken!.toJson();
    }
    return data;
  }
}

class AuthenticationToken {
  String? refresh;
  String? access;

  AuthenticationToken({this.refresh, this.access});

  AuthenticationToken.fromJson(Map<String, dynamic> json) {
    refresh = json['refresh'];
    access = json['access'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['refresh'] = this.refresh;
    data['access'] = this.access;
    return data;
  }
}