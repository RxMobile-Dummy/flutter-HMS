import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/usecase.dart';
import '../../data/model/delete_appointment_model.dart';
import '../repositories/appointment_repositories.dart';

class DeleteAppointmentUsecase extends UseCase<DeleteAppointmentModel, DeleteAppointmentParams> {
  final AppointmentRepositories? appointmentRepositories;

  DeleteAppointmentUsecase({this.appointmentRepositories});

  @override
  Stream<Either<Failure, DeleteAppointmentModel>> call(DeleteAppointmentParams params) {
    return appointmentRepositories!.deleteAppointmentCall(params);
  }

}

class DeleteAppointmentParams extends Equatable {
  String appointmentId;

  DeleteAppointmentParams({
    required this.appointmentId,
  });

  @override
  List<Object> get props => [id];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['appointmentId'] = this.appointmentId;

    return data;
  }
}