import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hospital_management/features/appoinment/data/model/update_appointment_model.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/usecase.dart';
import '../repositories/appointment_repositories.dart';

class UpdateAppointmentUsecase extends UseCase<UpdateAppointmentModel, UpdateAppointmentParams> {
  final AppointmentRepositories? appointmentRepositories;

  UpdateAppointmentUsecase({this.appointmentRepositories});

  @override
  Stream<Either<Failure, UpdateAppointmentModel>> call(UpdateAppointmentParams params) {
    return appointmentRepositories!.updateAppointmentCall(params);
  }

}

class UpdateAppointmentParams extends Equatable {
  String? firstName;
  String? lastName;
  String? timeSlot;
  String? bookingTime;
  String? mobileNumber;
  String? patientId;
  String? doctorId;
  String? staffId;
  String? hospitalId;
  String? statusId;
  String? fileData;
  String? appointmentDate;
  String? disease;
  String? patientProfilePic;
  String? appointmentId;

  UpdateAppointmentParams({
    required this.doctorId,
    required this.lastName,
    required this.firstName,
    required this.patientId,
    required this.mobileNumber,
    required this.statusId,
    required this.appointmentDate,
    required this.bookingTime,
    required this.fileData,
    required this.hospitalId,
    required this.staffId,
    required this.timeSlot,
    required this.disease,
    required this.patientProfilePic,
    required this.appointmentId
  });

  @override
  List<Object> get props => [id];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['doctorId'] = this.doctorId;
    data['lastName'] = this.lastName;
    data['firstName'] = this.firstName;
    data['patientId'] = this.patientId;
    data['mobileNumber'] = this.mobileNumber;
    data['statusId'] = this.statusId;
    data['appointmentDate'] = this.appointmentDate;
    data['bookingTime'] = this.bookingTime;
    data['fileData'] = this.fileData;
    data['hospitalId'] = this.hospitalId;
    data['staffId'] = this.staffId;
    data['timeSlot'] = this.timeSlot;
    data['appointmentId'] = this.appointmentId;

    return data;
  }
}