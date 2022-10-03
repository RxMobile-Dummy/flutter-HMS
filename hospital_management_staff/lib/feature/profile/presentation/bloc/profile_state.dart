

import 'package:hospital_management_staff/core/base/base_bloc.dart';
import 'package:hospital_management_staff/feature/profile/data/model/get_profile_model.dart';
import 'package:hospital_management_staff/feature/profile/data/model/update_profile_model.dart';

class GetProfileState extends BaseState {
  GetProfileModel? model;

  GetProfileState({this.model});
}

class UpdateProfileState extends BaseState {
  UpdateProfileModel? model;

  UpdateProfileState({this.model});
}
