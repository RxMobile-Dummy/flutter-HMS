import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hospital_management_doctor/core/failure/failure.dart';
import 'package:hospital_management_doctor/core/usecase.dart';
import 'package:hospital_management_doctor/feature/appointments/data/model/get_report_model.dart';
import 'package:hospital_management_doctor/feature/appointments/domain/repositories/appointment_repositories.dart';

class GetReportListUsecase extends UseCase<GetReportListModel, GetReportListParams> {
  final AppointmentRepositories? appointmentRepositories;

  GetReportListUsecase({this.appointmentRepositories});

  @override
  Stream<Either<Failure, GetReportListModel>> call(GetReportListParams params) {
    return appointmentRepositories!.getReportListCall(params);
  }

}

class GetReportListParams extends Equatable {

  GetReportListParams();

  @override
  List<Object> get props => [id];
}