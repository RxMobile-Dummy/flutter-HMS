import 'package:hospital_management/features/profile/data/model/get_patient_profile_model.dart';
import 'package:hospital_management/features/profile/data/model/update_patient_profile_model.dart';

import '../../../../core/base/base_bloc.dart';

class GetPatientProfileEvent extends BaseEvent {
  int id;
  GetPatientProfileEvent({required this.id,});
}

class GetPatientProfileSuccessEvent extends BaseEvent {
  GetPatientProfileModel? model;

  GetPatientProfileSuccessEvent({this.model});
}

class UpdatePatientEvent extends BaseEvent {
  String? patient_id,first_name,last_name,contact_number,email,
      gender,date_of_birth,blood_group, marital_status,height,weight, emergency_contact_number,city, allergy,current_medication,
      past_injury,past_surgery, smoking_habits, alchol_consumption,activity_level, food_preference,occupation;
  String? profile_pic;
  UpdatePatientEvent({
    this.patient_id,
    this.profile_pic,
    this.weight,
    this.smoking_habits,
    this.past_surgery,
    this.past_injury,
    this.marital_status,
    this.gender,
    this.food_preference,
    this.emergency_contact_number,
    this.date_of_birth,
    this.current_medication,
    this.contact_number,
    this.city,this.blood_group,
    this.alchol_consumption,
    this.activity_level,
    this.height,
    this.occupation,
    this.last_name,
    this.first_name,
    this.allergy,
    this.email
  });
}

class UpdatePatientProfileSuccessEvent extends BaseEvent {
  UpdatePatientProfileModel? model;

  UpdatePatientProfileSuccessEvent({this.model});
}
