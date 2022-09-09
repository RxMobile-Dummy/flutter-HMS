import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hospital_management_doctor/core/failure/failure.dart';
import 'package:hospital_management_doctor/core/usecase.dart';
import 'package:hospital_management_doctor/feature/appointments/data/model/get_appointment_status.dart';
import 'package:hospital_management_doctor/feature/appointments/domain/repositories/appointment_repositories.dart';

class GetAppointmentStatusUsecase extends UseCase<GetAppointmentStatusModel, GetAppointmentStatusParams> {
  final AppointmentRepositories? appointmentRepositories;

  GetAppointmentStatusUsecase({this.appointmentRepositories});

  @override
  Stream<Either<Failure, GetAppointmentStatusModel>> call(GetAppointmentStatusParams params) {
    return appointmentRepositories!.getAppointmentStatusCall(params);
  }

}

class GetAppointmentStatusParams extends Equatable {
  String id;

  GetAppointmentStatusParams({
    required this.id,
  });

  @override
  List<Object> get props => [id];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    return data;
  }
}