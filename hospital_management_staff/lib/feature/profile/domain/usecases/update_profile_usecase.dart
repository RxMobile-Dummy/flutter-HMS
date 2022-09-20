import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hospital_management_staff/core/failure/failure.dart';
import 'package:hospital_management_staff/core/usecase.dart';
import 'package:hospital_management_staff/feature/profile/data/model/update_profile_model.dart';
import 'package:hospital_management_staff/feature/profile/domain/repositories/profile_repositories.dart';

class UpdateProfileUsecase extends UseCase<UpdateProfileModel, UpdateProfileParams> {
  final ProfileRepositories? profileRepositories;

  UpdateProfileUsecase({this.profileRepositories});

  @override
  Stream<Either<Failure, UpdateProfileModel>> call(UpdateProfileParams params) {
    return profileRepositories!.updateProfileCall(params);
  }

}

class UpdateProfileParams extends Equatable {
  String? staffId,firstName,lastName,contactNumber,email,profilePic,gender,dateOfBirth, bloodGroup, yearOfExperience, education, hospitalId;

  UpdateProfileParams({
     this.contactNumber,
     this.education,
     this.bloodGroup,
     this.profilePic,
     this.email,
     this.dateOfBirth,
     this.hospitalId,
     this.yearOfExperience,
     this.gender,
     this.firstName,
     this.lastName,
    required this.staffId
  });

  @override
  List<Object> get props => [id];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['contactNumber'] = this.contactNumber;
    data['education'] = this.education;
    data['bloodGroup'] = this.bloodGroup;
    data['profilePic'] = this.profilePic;
    data['email'] = this.email;
    data['dateOfBirth'] = this.dateOfBirth;
    data['hospitalId'] = this.hospitalId;
    data['yearOfExperience'] = this.yearOfExperience;
    data['gender'] = this.gender;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['staffId'] = this.staffId;

    return data;
  }
}