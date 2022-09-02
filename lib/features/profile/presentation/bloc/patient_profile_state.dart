import 'package:hospital_management/features/profile/data/model/get_patient_profile_model.dart';

import '../../../../core/base/base_bloc.dart';
import '../../data/model/update_patient_profile_model.dart';

class GetPatientProfileState extends BaseState {
  GetPatientProfileModel? model;

  GetPatientProfileState({this.model});
}

class UpdatePatientProfileState extends BaseState {
  UpdatePatientProfileModel? model;

  UpdatePatientProfileState({this.model});
}