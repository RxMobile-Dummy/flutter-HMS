import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hospital_management/features/profile/data/model/update_patient_profile_model.dart';
import 'package:hospital_management/features/profile/domain/repositories/patient_profile_repositories.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/usecase.dart';

class UpdatePatientUsecase extends UseCase<UpdatePatientProfileModel, UpdatePatientParams> {
   PatientProfileRepositories? patientProfileRepositories;

   UpdatePatientUsecase({this.patientProfileRepositories});

  @override
  Stream<Either<Failure, UpdatePatientProfileModel>> call(UpdatePatientParams params) {
    return patientProfileRepositories!.updatePatientProfileCall(params);
  }

}

class UpdatePatientParams extends Equatable {
  String patient_id;
  String first_name;
  String last_name;
  String contact_number;
  String email;
  String? profile_pic;
  String gender;
  String date_of_birth;
  String blood_group;
  String marital_status;
  String height;
  String weight;
  String emergency_contact_number;
  String city;
  String allergy;
  String current_medication;
  String past_injury;
  String past_surgery;
  String smoking_habits;
  String alchol_consumption;
  String activity_level;
  String food_preference;
  String occupation;

  UpdatePatientParams({
    required this.patient_id,
    required this.email,
    required this.allergy,
    required this.profile_pic,
    required this.first_name,
    required this.last_name,
    required this.occupation,
    required this.height,
    required this.activity_level,
    required this.alchol_consumption,
    required this.blood_group,
    required this.city,
    required this.contact_number,
    required this.current_medication,
    required this.date_of_birth,
    required this.emergency_contact_number,
    required this.food_preference,
    required this.gender,
    required this.marital_status,
    required this.past_injury,
    required this.past_surgery,
    required this.smoking_habits,
    required this.weight
  });

  @override
  List<Object> get props => [id];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['patient_id'] = this.patient_id;
    data['first_name'] = this.first_name;
    data['last_name'] = this.last_name;
    data['contact_number'] = this.contact_number;
    data['email'] = this.email;
    data['profile_pic'] = this.profile_pic;
    data['gender'] = this.gender;
    data['date_of_birth'] = this.date_of_birth;
    data['blood_group'] = this.blood_group;
    data['marital_status'] = this.marital_status;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['emergency_contact_number'] = this.emergency_contact_number;
    data['city'] = this.city;
    data['allergy'] = this.allergy;
    data['current_medication'] = this.current_medication;
    data['past_injury'] = this.past_injury;
    data['past_surgery'] = this.past_surgery;
    data['smoking_habits'] = this.smoking_habits;
    data['alchol_consumption'] = this.alchol_consumption;
    data['activity_level'] = this.activity_level;
    data['food_preference'] = this.food_preference;
    data['occupation'] = this.occupation;

    return data;
  }
}