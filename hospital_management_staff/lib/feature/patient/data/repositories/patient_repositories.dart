import 'package:dartz/dartz.dart';
import 'package:hospital_management_staff/core/failure/error_object.dart';
import 'package:hospital_management_staff/core/failure/failure.dart';
import 'package:hospital_management_staff/core/strings/strings.dart';
import 'package:hospital_management_staff/feature/patient/data/datasourse/patient_data_sourse.dart';
import 'package:hospital_management_staff/feature/patient/data/model/get_patient_model.dart';
import 'package:hospital_management_staff/feature/patient/domain/repositories/patient_repositories.dart';
import 'package:hospital_management_staff/feature/patient/domain/usecases/get_patient_usecase.dart';

class PatientRepositoriesImpl extends PatientRepositories{
  PatientDataSource? patientDataSource;
  PatientRepositoriesImpl({this.patientDataSource});

  @override
  Stream<Either<Failure, GetPatientModel>> getPatientCall(GetPatientParams params) async* {
    try{
      var response = await patientDataSource!.getPatientCall(params);
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