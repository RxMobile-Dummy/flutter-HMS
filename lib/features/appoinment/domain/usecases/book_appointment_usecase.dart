import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hospital_management/features/appoinment/data/model/book_appointment_model.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/usecase.dart';
import '../repositories/appointment_repositories.dart';

class BookAppointmentUsecase extends UseCase<BookAppointmentModel, BookAppointmentParams> {
  final AppointmentRepositories? appointmentRepositories;

  BookAppointmentUsecase({this.appointmentRepositories});

  @override
  Stream<Either<Failure, BookAppointmentModel>> call(BookAppointmentParams params) {
    return appointmentRepositories!.bookAppointmentCall(params);
  }

}

class BookAppointmentParams extends Equatable {
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

  BookAppointmentParams({
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
    required this.patientProfilePic
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

    return data;
  }
}