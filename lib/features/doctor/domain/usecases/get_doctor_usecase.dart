import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hospital_management/features/doctor/data/model/get_doctor_model.dart';
import 'package:hospital_management/features/doctor/domain/repositories/doctor_repositories.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/usecase.dart';

class GetDoctorUsecase extends UseCase<GetDoctorModel,GetDoctorParams> {
  final DoctorRepositories? doctorRepositories;

  GetDoctorUsecase({this.doctorRepositories});

  @override
  Stream<Either<Failure, GetDoctorModel>> call(GetDoctorParams params) {
    return doctorRepositories!.getDoctorCall(params);
  }

}

class GetDoctorParams extends Equatable {
  String specialistField;
  GetDoctorParams({
    required this.specialistField
});

  @override
  List<Object> get props => [id];
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['specialistField'] = this.specialistField;

    return data;
  }

}