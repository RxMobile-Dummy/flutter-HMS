import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hospital_management/features/doctor/data/model/filter_doctor_model.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/usecase.dart';
import '../repositories/doctor_repositories.dart';

class FilterDoctorUsecase extends UseCase<FilterDoctorModel, FilterDoctorParams> {
  final DoctorRepositories? doctorRepositories;

  FilterDoctorUsecase({this.doctorRepositories});

  @override
  Stream<Either<Failure, FilterDoctorModel>> call(FilterDoctorParams params) {
    return doctorRepositories!.filterDoctorCall(params);
  }

}

class FilterDoctorParams extends Equatable {
  String specialistField;

  FilterDoctorParams({
    required this.specialistField,
  });

  @override
  List<Object> get props => [id];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['specialistField'] = this.specialistField;

    return data;
  }
}