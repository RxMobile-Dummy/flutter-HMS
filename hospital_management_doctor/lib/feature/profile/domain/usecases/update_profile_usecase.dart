import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hospital_management_doctor/core/failure/failure.dart';
import 'package:hospital_management_doctor/core/usecase.dart';
import 'package:hospital_management_doctor/feature/profile/data/model/update_profile_model.dart';
import 'package:hospital_management_doctor/feature/profile/domain/repositories/profile_repositories.dart';

class UpdateProfileUsecase extends UseCase<UpdateProfileModel, UpdateProfileParams> {
  final ProfileRepositories? profileRepositories;

  UpdateProfileUsecase({this.profileRepositories});

  @override
  Stream<Either<Failure, UpdateProfileModel>> call(UpdateProfileParams params) {
    return profileRepositories!.updateProfileCall(params);
  }

}

class UpdateProfileParams extends Equatable {
  String? doctorId,firstName,lastName,email,mobileNumber,profilePic,gender,dateOfBirth,
  bloodGroup,yearOfExperience,nextAvailableAt,specialistField,about,education,hospitalId,fees,rating;

  UpdateProfileParams({
    this.lastName,
    this.about,
    this.education,
    this.nextAvailableAt,
    this.doctorId,
    this.rating,
    this.hospitalId,
    this.dateOfBirth,
    this.bloodGroup,
    this.firstName,
    this.profilePic,
    this.mobileNumber,
    this.gender,
    this.email,
    this.fees,
    this.yearOfExperience,
    this.specialistField
  });

  @override
  List<Object> get props => [id];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['lastName'] = this.lastName;
    data['about'] = this.about;
    data['education'] = this.education;
    data['nextAvailableAt'] = this.nextAvailableAt;
    data['doctorId'] = this.doctorId;
    data['rating'] = this.rating;
    data['hospitalId'] = this.hospitalId;
    data['dateOfBirth'] = this.dateOfBirth;
    data['bloodGroup'] = this.bloodGroup;
    data['firstName'] = this.firstName;
    data['profilePic'] = this.profilePic;
    data['mobileNumber'] = this.mobileNumber;
    data['gender'] = this.gender;
    data['email'] = this.email;
    data['fees'] = this.fees;
    data['yearOfExperience'] = this.yearOfExperience;
    data['specialistField'] = this.specialistField;

    return data;
  }
}