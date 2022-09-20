

import 'package:hospital_management_staff/feature/profile/data/model/get_profile_model.dart';
import 'package:hospital_management_staff/feature/profile/data/model/update_profile_model.dart';
import 'package:hospital_management_staff/feature/profile/domain/usecases/get_profile_usecase.dart';
import 'package:hospital_management_staff/feature/profile/domain/usecases/update_profile_usecase.dart';

abstract class ProfileDataSource {
  Future<GetProfileModel> getProfileCall(GetProfileParams params);
  Future<UpdateProfileModel> updateProfileCall(UpdateProfileParams params);
}