import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hospital_management_doctor/core/failure/failure.dart';
import 'package:hospital_management_doctor/core/usecase.dart';
import 'package:hospital_management_doctor/feature/appointments/data/model/get_appointment_model.dart';
import 'package:hospital_management_doctor/feature/appointments/domain/repositories/appointment_repositories.dart';

class GetAppointmentUsecase extends UseCase<GetAppointmentModel, GetAppointmentParams> {
  final AppointmentRepositories? appointmentRepositories;

  GetAppointmentUsecase({this.appointmentRepositories});

  @override
  Stream<Either<Failure, GetAppointmentModel>> call(GetAppointmentParams params) {
    return appointmentRepositories!.getAppointmentCall(params);
  }

}

class GetAppointmentParams extends Equatable {
  String id;
  String date;

  GetAppointmentParams({
    required this.id,
    required this.date,
  });

  @override
  List<Object> get props => [id];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['date'] = this.date;

    return data;
  }
}