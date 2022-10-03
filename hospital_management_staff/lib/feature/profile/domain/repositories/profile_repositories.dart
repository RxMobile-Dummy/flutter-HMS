import 'package:dartz/dartz.dart';
import 'package:hospital_management_staff/core/failure/failure.dart';
import 'package:hospital_management_staff/feature/profile/data/model/get_profile_model.dart';
import 'package:hospital_management_staff/feature/profile/data/model/update_profile_model.dart';
import 'package:hospital_management_staff/feature/profile/domain/usecases/get_profile_usecase.dart';
import 'package:hospital_management_staff/feature/profile/domain/usecases/update_profile_usecase.dart';

abstract class ProfileRepositories {
  Stream<Either<Failure, GetProfileModel>> getProfileCall(GetProfileParams params);
  Stream<Either<Failure, UpdateProfileModel>> updateProfileCall(UpdateProfileParams params);
}