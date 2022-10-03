import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hospital_management_doctor/core/failure/failure.dart';
import 'package:hospital_management_doctor/core/usecase.dart';
import 'package:hospital_management_doctor/feature/appointments/data/model/update_appointment_model.dart';
import 'package:hospital_management_doctor/feature/appointments/domain/repositories/appointment_repositories.dart';

class UpdateAppointmentUsecase extends UseCase<UpdateAppointmentModel, UpdateAppointmentParams> {
  final AppointmentRepositories? appointmentRepositories;

  UpdateAppointmentUsecase({this.appointmentRepositories});

  @override
  Stream<Either<Failure, UpdateAppointmentModel>> call(UpdateAppointmentParams params) {
    return appointmentRepositories!.updateAppointmentCall(params);
  }

}

class UpdateAppointmentParams extends Equatable {
  String doctorId;
  String patientId;
  String appointmentId;
  String medicineId;
  String statusId;
  String hospitalId;
  List reportDescription;

  UpdateAppointmentParams({
    required this.doctorId,
    required this.hospitalId,
    required this.patientId,
    required this.appointmentId,
    required this.statusId,
    required this.medicineId,
    required this.reportDescription
  });

  @override
  List<Object> get props => [id];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['doctorId'] = this.doctorId;
    data['hospitalId'] = this.hospitalId;
    data['patientId'] = this.patientId;
    data['appointmentId'] = this.appointmentId;
    data['statusId'] = this.statusId;
    data['medicineId'] = this.medicineId;
    data['reportDescription'] = this.reportDescription;

    return data;
  }
}