class SignInStaffModel {
  bool? success;
  Data? data;
  String? message;
  String? error;

  SignInStaffModel({this.success, this.data, this.message, this.error});

  SignInStaffModel.fromJson(Map<String, dynamic> json) {
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
  String? profilePic;
  int? id;
  String? lastName;
  String? email;
  String? dateOfBirth;
  String? hospitalId;
  String? firstName;
  String? contactNumber;
  String? gender;
  String? bloodGroup;
  AuthenticationToken? authenticationToken;

  Data(
      {this.profilePic,
        this.id,
        this.lastName,
        this.email,
        this.dateOfBirth,
        this.hospitalId,
        this.firstName,
        this.contactNumber,
        this.gender,
        this.bloodGroup,
        this.authenticationToken});

  Data.fromJson(Map<String, dynamic> json) {
    profilePic = json['profile_pic'];
    id = json['id'];
    lastName = json['last_name'];
    email = json['email'];
    dateOfBirth = json['date_of_birth'];
    hospitalId = json['hospital_id'];
    firstName = json['first_name'];
    contactNumber = json['contact_number'];
    gender = json['gender'];
    bloodGroup = json['blood_group'];
    authenticationToken = json['authentication_token'] != null
        ? new AuthenticationToken.fromJson(json['authentication_token'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profile_pic'] = this.profilePic;
    data['id'] = this.id;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['date_of_birth'] = this.dateOfBirth;
    data['hospital_id'] = this.hospitalId;
    data['first_name'] = this.firstName;
    data['contact_number'] = this.contactNumber;
    data['gender'] = this.gender;
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