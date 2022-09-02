import 'package:dartz/dartz.dart';
import 'package:hospital_management/core/failure/failure.dart';
import 'package:hospital_management/features/doctor/data/datasource/doctor_data_source.dart';
import 'package:hospital_management/features/doctor/data/model/filter_doctor_model.dart';
import 'package:hospital_management/features/doctor/data/model/get_doctor_model.dart';
import 'package:hospital_management/features/doctor/domain/repositories/doctor_repositories.dart';
import 'package:hospital_management/features/doctor/domain/usecases/filter_doctor_usecase.dart';
import 'package:hospital_management/features/doctor/domain/usecases/get_doctor_usecase.dart';

import '../../../../core/failure/error_object.dart';

class DoctorRepositoriesImpl extends DoctorRepositories{
  DoctorDataSource? doctorDataSource;
  DoctorRepositoriesImpl({this.doctorDataSource});

  @override
  Stream<Either<Failure, GetDoctorModel>> getDoctorCall(GetDoctorParams params) async* {
    try{
      var response = await doctorDataSource!.getDoctorCall(params);
      if (response != null) {
        yield Right(response);
      }
    }catch(e,s){
      Failure error = await ErrorObject.checkErrorState(e);
      yield Left(FailureMessage(error.message.toString()));
      print(e);
      print("Fail");
    }
  }

  @override
  Stream<Either<Failure, FilterDoctorModel>> filterDoctorCall(FilterDoctorParams params) async*{
    try{
      var response = await doctorDataSource!.filterDoctorCall(params);
      if (response != null) {
        yield Right(response);
      }
    }catch(e,s){
      Failure error = await ErrorObject.checkErrorState(e);
      yield Left(FailureMessage(error.message.toString()));
      print(e);
      print("Fail");
    }
  }




}