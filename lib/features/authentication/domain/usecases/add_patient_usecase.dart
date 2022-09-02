import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hospital_management/features/authentication/data/model/sign_up_model.dart';
import 'package:hospital_management/features/authentication/domain/repositories/authentication_repositories.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/usecase.dart';

class AddPatientUsecase extends UseCase<AddPatientModel, AddPatientParams> {
  final AuthenticationRepositories? authenticationRepositories;

  AddPatientUsecase({this.authenticationRepositories});

  @override
  Stream<Either<Failure, AddPatientModel>> call(AddPatientParams params) {
    return authenticationRepositories!.addPatientCall(params);
  }

}

class AddPatientParams extends Equatable {
  String firstName;
  String lastName;
  String contactNumber;
  String password;
  String email;
  String? profilePic;
  String gender;
  String dateOfBirth;
  String bloodGroup;
  String maritalStatus;
  String height;
  String weight;
  String emergencyContactNumber;
  String city;
  String allergy;
  String currentMedication;
  String pastInjury;
  String pastSurgery;
  String smokingHabits;
  String alcoholCunsumption;
  String activityLevel;
  String foodPreference;
  String occupation;

  AddPatientParams({
    required this.email,
    required this.password,
    required this.allergy,
    required this.profilePic,
    required this.firstName,
    required this.lastName,
    required this.occupation,
    required this.height,
    required this.activityLevel,
    required this.alcoholCunsumption,
    required this.bloodGroup,
    required this.city,
    required this.contactNumber,
    required this.currentMedication,
    required this.dateOfBirth,
    required this.emergencyContactNumber,
    required this.foodPreference,
    required this.gender,
    required this.maritalStatus,
    required this.pastInjury,
    required this.pastSurgery,
    required this.smokingHabits,
    required this.weight
  });

  @override
  List<Object> get props => [id];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['contact_number'] = this.contactNumber;
    data['password'] = this.password;
    data['email'] = this.email;
    data['profile_pic'] = this.profilePic;
    data['gender'] = this.gender;
    data['date_of_birth'] = this.dateOfBirth;
    data['blood_group'] = this.bloodGroup;
    data['marital_status'] = this.maritalStatus;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['emergency_contact_number'] = this.emergencyContactNumber;
    data['city'] = this.city;
    data['allergy'] = this.allergy;
    data['current_medication'] = this.currentMedication;
    data['past_injury'] = this.pastInjury;
    data['past_surgery'] = this.pastSurgery;
    data['smoking_habits'] = this.smokingHabits;
    data['alchol_consumption'] = this.alcoholCunsumption;
    data['activity_level'] = this.activityLevel;
    data['food_preference'] = this.foodPreference;
    data['occupation'] = this.occupation;

    return data;
  }
}