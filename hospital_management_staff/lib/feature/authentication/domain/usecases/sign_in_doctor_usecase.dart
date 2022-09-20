import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hospital_management_staff/feature/authentication/data/model/sign_in_staff.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/usecase.dart';
import '../repositories/authentication_repositories.dart';

class SignInDoctorUsecase extends UseCase<SignInStaffModel, SignInParams> {
  final AuthenticationRepositories? authenticationRepositories;

  SignInDoctorUsecase({this.authenticationRepositories});

  @override
  Stream<Either<Failure, SignInStaffModel>> call(SignInParams params) {
    return authenticationRepositories!.signInDoctorCall(params);
  }

}

class SignInParams extends Equatable {
  String email;
  String password;

  SignInParams({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [id];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['email'] = this.email;
    data['password'] = this.password;

    return data;
  }
}