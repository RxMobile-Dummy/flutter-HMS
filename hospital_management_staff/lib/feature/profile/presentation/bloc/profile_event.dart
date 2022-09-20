

import 'package:hospital_management_staff/core/base/base_bloc.dart';
import 'package:hospital_management_staff/feature/profile/data/model/get_profile_model.dart';
import 'package:hospital_management_staff/feature/profile/data/model/update_profile_model.dart';

class GetProfileEvent extends BaseEvent {
  int id;
  GetProfileEvent({required this.id,});
}

class GetProfileSuccessEvent extends BaseEvent {
  GetProfileModel? model;

  GetProfileSuccessEvent({this.model});
}

class UpdateProfileEvent extends BaseEvent {
  String? staffId,firstName,lastName,contactNumber,email,profilePic,gender,dateOfBirth, bloodGroup, yearOfExperience, education, hospitalId;

  UpdateProfileEvent({required this.staffId,
  this.hospitalId,
  this.education,
  this.yearOfExperience,
  this.bloodGroup,
  this.dateOfBirth,
  this.gender,
  this.email,
  this.contactNumber,
  this.lastName,
  this.firstName,
  this.profilePic});
}

class UpdateProfileSuccessEvent extends BaseEvent {
  UpdateProfileModel? model;

  UpdateProfileSuccessEvent({this.model});
}
