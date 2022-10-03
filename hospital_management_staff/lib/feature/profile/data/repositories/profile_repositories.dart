import 'package:dartz/dartz.dart';
import 'package:hospital_management_staff/core/failure/error_object.dart';
import 'package:hospital_management_staff/core/failure/failure.dart';
import 'package:hospital_management_staff/core/strings/strings.dart';
import 'package:hospital_management_staff/feature/profile/data/datasourse/profile_data_sourse.dart';
import 'package:hospital_management_staff/feature/profile/data/model/get_profile_model.dart';
import 'package:hospital_management_staff/feature/profile/data/model/update_profile_model.dart';
import 'package:hospital_management_staff/feature/profile/domain/repositories/profile_repositories.dart';
import 'package:hospital_management_staff/feature/profile/domain/usecases/get_profile_usecase.dart';
import 'package:hospital_management_staff/feature/profile/domain/usecases/update_profile_usecase.dart';

class ProfileRepositoriesImpl extends ProfileRepositories{
  ProfileDataSource? profileDataSource;
  ProfileRepositoriesImpl({this.profileDataSource});

  @override
  Stream<Either<Failure, GetProfileModel>> getProfileCall(GetProfileParams params) async* {
    try{
      var response = await profileDataSource!.getProfileCall(params);
      if (response != null) {
        yield Right(response);
      }
    }catch(e,s){
      Failure error = await ErrorObject.checkErrorState(e);
      yield Left(FailureMessage(error.message.toString()));
      print(e);
      print(Strings.kFail);
    }
  }

  @override
  Stream<Either<Failure, UpdateProfileModel>> updateProfileCall(UpdateProfileParams params) async* {
    try{
      var response = await profileDataSource!.updateProfileCall(params);
      if (response != null) {
        yield Right(response);
      }
    }catch(e,s){
      Failure error = await ErrorObject.checkErrorState(e);
      yield Left(FailureMessage(error.message.toString()));
      print(e);
      print(Strings.kFail);
    }
  }



}