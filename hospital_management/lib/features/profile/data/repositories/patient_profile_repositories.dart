import 'package:dartz/dartz.dart';
import 'package:hospital_management/core/failure/failure.dart';
import 'package:hospital_management/core/strings/strings.dart';
import 'package:hospital_management/features/profile/data/datasource/patient_profile_data_source.dart';
import 'package:hospital_management/features/profile/data/model/get_patient_profile_model.dart';
import 'package:hospital_management/features/profile/data/model/update_patient_profile_model.dart';
import 'package:hospital_management/features/profile/domain/repositories/patient_profile_repositories.dart';
import 'package:hospital_management/features/profile/domain/usecases/get_patient_profile_usecase.dart';
import 'package:hospital_management/features/profile/domain/usecases/update_patient_profile_usecase.dart';

import '../../../../core/failure/error_object.dart';

class PatientProfileRepositoriesImpl extends PatientProfileRepositories{
  PatientProfileDataSource? profileDataSource;
  PatientProfileRepositoriesImpl({this.profileDataSource});

  @override
  Stream<Either<Failure, GetPatientProfileModel>> getPatientProfileCall(GetPatientProfileParams params) async*{
    try{
      var response = await profileDataSource!.getPatientProfileCall(params);
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
  Stream<Either<Failure, UpdatePatientProfileModel>> updatePatientProfileCall(UpdatePatientParams params) async* {
    try{
      var response = await profileDataSource!.updatePatientProfileCall(params);
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