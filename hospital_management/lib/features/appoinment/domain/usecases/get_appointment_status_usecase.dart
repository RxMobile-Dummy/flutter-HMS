import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hospital_management/core/failure/failure.dart';
import 'package:hospital_management/core/usecase.dart';
import 'package:hospital_management/features/appoinment/data/model/get_appointment_status_model.dart';
import 'package:hospital_management/features/appoinment/domain/repositories/appointment_repositories.dart';

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