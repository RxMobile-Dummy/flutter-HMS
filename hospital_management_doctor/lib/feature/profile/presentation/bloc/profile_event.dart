import 'package:hospital_management_doctor/core/base/base_bloc.dart';
import 'package:hospital_management_doctor/feature/profile/data/model/get_profile_model.dart';
import 'package:hospital_management_doctor/feature/profile/data/model/update_profile_model.dart';

class GetProfileEvent extends BaseEvent {
  int id;
  GetProfileEvent({required this.id,});
}

class GetProfileSuccessEvent extends BaseEvent {
  GetProfileModel? model;

  GetProfileSuccessEvent({this.model});
}

class UpdateProfileEvent extends BaseEvent {
  String? doctorId,firstName,lastName,email,mobileNumber,profilePic,gender,dateOfBirth,
      bloodGroup,yearOfExperience,nextAvailableAt,specialistField,about,education,hospitalId,fees,rating;
  UpdateProfileEvent({
    this.profilePic,
    this.rating,
    this.fees,
    this.hospitalId,
    this.about,
    this.education,
    this.specialistField,
    this.nextAvailableAt,
    this.yearOfExperience,
    this.bloodGroup,
    this.dateOfBirth,
    this.gender,
    this.mobileNumber,
    this.lastName,
    this.doctorId,
    this.firstName,
    this.email
});
}

class UpdateProfileSuccessEvent extends BaseEvent {
  UpdateProfileModel? model;

  UpdateProfileSuccessEvent({this.model});
}