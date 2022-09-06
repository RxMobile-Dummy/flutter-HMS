class SignInPatientModel {
  bool? success;
  Data? data;
  String? message;
  String? error;

  SignInPatientModel({this.success, this.data, this.message, this.error});

  SignInPatientModel.fromJson(Map<String, dynamic> json) {
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
  String? firstName;
  String? lastName;
  String? profilePic;
  String? gender;
  String? hospitalId;
  String? contactNumber;
  int? id;
  String? email;
  String? dateOfBirth;
  String? bloodGroup;
  AuthenticationToken? authenticationToken;

  Data(
      {this.firstName,
        this.lastName,
        this.profilePic,
        this.gender,
        this.hospitalId,
        this.contactNumber,
        this.id,
        this.email,
        this.dateOfBirth,
        this.bloodGroup,
        this.authenticationToken});

  Data.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    profilePic = json['profile_pic'];
    gender = json['gender'];
    hospitalId = json['hospital_id'];
    contactNumber = json['contact_number'];
    id = json['id'];
    email = json['email'];
    dateOfBirth = json['date_of_birth'];
    bloodGroup = json['blood_group'];
    authenticationToken = json['authentication_token'] != null
        ? new AuthenticationToken.fromJson(json['authentication_token'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['profile_pic'] = this.profilePic;
    data['gender'] = this.gender;
    data['hospital_id'] = this.hospitalId;
    data['contact_number'] = this.contactNumber;
    data['id'] = this.id;
    data['email'] = this.email;
    data['date_of_birth'] = this.dateOfBirth;
    data['blood_group'] = this.bloodGroup;
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