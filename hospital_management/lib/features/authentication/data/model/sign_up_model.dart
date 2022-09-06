class AddPatientModel {
  bool? success;
  Data? data;
  String? message;
  String? error;

  AddPatientModel({this.success, this.data, this.message, this.error});

  AddPatientModel.fromJson(Map<String, dynamic> json) {
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
  String? maritalStatus;
  String? height;
  String? weight;
  String? emergencyContactNumber;
  String? city;
  String? smokingHabits;
  String? alcholConsumption;
  String? activityLevel;
  String? occupation;
  String? firstName;
  String? lastName;
  String? contactNumber;
  String? password;
  String? email;
  String? gender;
  String? dateOfBirth;
  String? bloodGroup;
  String? hospitalId;
  String? profilePic;
  AuthenticationToken? authenticationToken;

  Data(
      {this.id,
        this.maritalStatus,
        this.height,
        this.weight,
        this.emergencyContactNumber,
        this.city,
        this.smokingHabits,
        this.alcholConsumption,
        this.activityLevel,
        this.occupation,
        this.firstName,
        this.lastName,
        this.contactNumber,
        this.password,
        this.email,
        this.gender,
        this.dateOfBirth,
        this.bloodGroup,
        this.hospitalId,
        this.profilePic,
        this.authenticationToken});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    maritalStatus = json['marital_status'];
    height = json['height'];
    weight = json['weight'];
    emergencyContactNumber = json['emergency_contact_number'];
    city = json['city'];
    smokingHabits = json['smoking_habits'];
    alcholConsumption = json['alchol_consumption'];
    activityLevel = json['activity_level'];
    occupation = json['occupation'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    contactNumber = json['contact_number'];
    password = json['password'];
    email = json['email'];
    gender = json['gender'];
    dateOfBirth = json['date_of_birth'];
    bloodGroup = json['blood_group'];
    hospitalId = json['hospital_id'];
    profilePic = json['profile_pic'];
    authenticationToken = json['authentication_token'] != null
        ? new AuthenticationToken.fromJson(json['authentication_token'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['marital_status'] = this.maritalStatus;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['emergency_contact_number'] = this.emergencyContactNumber;
    data['city'] = this.city;
    data['smoking_habits'] = this.smokingHabits;
    data['alchol_consumption'] = this.alcholConsumption;
    data['activity_level'] = this.activityLevel;
    data['occupation'] = this.occupation;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['contact_number'] = this.contactNumber;
    data['password'] = this.password;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['date_of_birth'] = this.dateOfBirth;
    data['blood_group'] = this.bloodGroup;
    data['hospital_id'] = this.hospitalId;
    data['profile_pic'] = this.profilePic;
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