import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hospital_management_doctor/core/failure/failure.dart';
import 'package:hospital_management_doctor/core/usecase.dart';
import 'package:hospital_management_doctor/feature/patient/data/model/get_patient_model.dart';
import 'package:hospital_management_doctor/feature/patient/domain/repositories/patient_repositories.dart';

class GetPatientUsecase extends UseCase<GetPatientModel, GetPatientParams> {
  final PatientRepositories? patientRepositories;

  GetPatientUsecase({this.patientRepositories});

  @override
  Stream<Either<Failure, GetPatientModel>> call(GetPatientParams params) {
    return patientRepositories!.getPatientCall(params);
  }

}

class GetPatientParams extends Equatable {
  String doctorId;
  String search;


  GetPatientParams({required this.doctorId,required this.search});

  @override
  List<Object> get props => [id];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['doctorId'] = this.doctorId;
    data['search'] = this.search;
    return data;
  }
}