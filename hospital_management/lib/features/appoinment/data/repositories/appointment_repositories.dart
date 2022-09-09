import 'package:dartz/dartz.dart';
import 'package:hospital_management/core/failure/failure.dart';
import 'package:hospital_management/features/appoinment/data/datasource/appointment_data_source.dart';
import 'package:hospital_management/features/appoinment/data/model/book_appointment_model.dart';
import 'package:hospital_management/features/appoinment/data/model/delete_appointment_model.dart';
import 'package:hospital_management/features/appoinment/data/model/get_appointment_model.dart';
import 'package:hospital_management/features/appoinment/data/model/get_appointment_status_model.dart';
import 'package:hospital_management/features/appoinment/data/model/update_appointment_model.dart';
import 'package:hospital_management/features/appoinment/domain/repositories/appointment_repositories.dart';
import 'package:hospital_management/features/appoinment/domain/usecases/book_appointment_usecase.dart';
import 'package:hospital_management/features/appoinment/domain/usecases/delete_appointment_usecase.dart';
import 'package:hospital_management/features/appoinment/domain/usecases/get_appointment_status_usecase.dart';
import 'package:hospital_management/features/appoinment/domain/usecases/get_appointment_usecase.dart';
import 'package:hospital_management/features/appoinment/domain/usecases/update_appointment_usecase.dart';

import '../../../../core/failure/error_object.dart';

class AppointmentRepositoriesImpl extends AppointmentRepositories{
  AppointmentDataSource? appointmentDataSource;
  AppointmentRepositoriesImpl({this.appointmentDataSource});

  @override
  Stream<Either<Failure, BookAppointmentModel>> bookAppointmentCall(BookAppointmentParams params) async*{
    try{
      var response = await appointmentDataSource!.bookAppointmentCall(params);
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
  Stream<Either<Failure, GetAppointmentModel>> getAppointmentCall(GetAppointmentParams params) async* {
    try{
      var response = await appointmentDataSource!.getAppointmentCall(params);
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
  Stream<Either<Failure, DeleteAppointmentModel>> deleteAppointmentCall(DeleteAppointmentParams params) async*{
    try{
      var response = await appointmentDataSource!.deleteAppointmentCall(params);
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
  Stream<Either<Failure, UpdateAppointmentModel>> updateAppointmentCall(UpdateAppointmentParams params) async* {
    try{
      var response = await appointmentDataSource!.updateAppointmentCall(params);
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
  Stream<Either<Failure, GetAppointmentStatusModel>> getAppointmentStatusCall(GetAppointmentStatusParams params)async* {
    try{
      var response = await appointmentDataSource!.getAppointmentStatusCall(params);
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