import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hospital_management_staff/core/failure/failure.dart';
import 'package:hospital_management_staff/core/usecase.dart';
import 'package:hospital_management_staff/feature/profile/data/model/get_profile_model.dart';
import 'package:hospital_management_staff/feature/profile/domain/repositories/profile_repositories.dart';

class GetProfileUsecase extends UseCase<GetProfileModel, GetProfileParams> {
  final ProfileRepositories? profileRepositories;

  GetProfileUsecase({this.profileRepositories});

  @override
  Stream<Either<Failure, GetProfileModel>> call(GetProfileParams params) {
    return profileRepositories!.getProfileCall(params);
  }

}

class GetProfileParams extends Equatable {
  int id;

  GetProfileParams({
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