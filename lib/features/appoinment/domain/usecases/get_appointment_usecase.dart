import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hospital_management/features/appoinment/data/model/get_appointment_model.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/usecase.dart';
import '../repositories/appointment_repositories.dart';

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