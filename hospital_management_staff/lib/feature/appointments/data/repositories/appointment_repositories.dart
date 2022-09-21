import 'package:dartz/dartz.dart';
import 'package:hospital_management_staff/core/failure/error_object.dart';
import 'package:hospital_management_staff/core/failure/failure.dart';
import 'package:hospital_management_staff/core/strings/strings.dart';
import 'package:hospital_management_staff/feature/appointments/data/datasourse/appointment_data_sourse.dart';
import 'package:hospital_management_staff/feature/appointments/data/model/get_appointment_model.dart';
import 'package:hospital_management_staff/feature/appointments/data/model/get_appointment_status.dart';
import 'package:hospital_management_staff/feature/appointments/domain/repositories/appointment_repositories.dart';
import 'package:hospital_management_staff/feature/appointments/domain/usecases/get_appointment_status_usecase.dart';
import 'package:hospital_management_staff/feature/appointments/domain/usecases/get_appointment_usecase.dart';

class AppointmentRepositoriesImpl extends AppointmentRepositories{
  AppointmentDataSource? appointmentDataSource;
  AppointmentRepositoriesImpl({this.appointmentDataSource});


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
      print(Strings.kFail);
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
      print(Strings.kFail);
    }
  }

}