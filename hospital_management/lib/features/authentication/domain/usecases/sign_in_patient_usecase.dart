import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hospital_management/features/authentication/data/model/sign_in_model.dart';
import 'package:hospital_management/features/authentication/domain/repositories/authentication_repositories.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/usecase.dart';

class SignInPatientUsecase extends UseCase<SignInPatientModel, SignInParams> {
  final AuthenticationRepositories? authenticationRepositories;

  SignInPatientUsecase({this.authenticationRepositories});

  @override
  Stream<Either<Failure, SignInPatientModel>> call(SignInParams params) {
    return authenticationRepositories!.signInPatientCall(params);
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