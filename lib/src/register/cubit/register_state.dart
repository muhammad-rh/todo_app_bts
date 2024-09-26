part of 'register_cubit.dart';

sealed class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

final class RegisterInitial extends RegisterState {}

final class RegisterOnSuccess extends RegisterState {}

final class RegisterOnLoading extends RegisterState {}

final class RegisterOnFailed extends RegisterState {
  const RegisterOnFailed({required this.message});
  final String message;

  @override
  List<Object> get props => ["message: $message"];
}

final class RegisterOnError extends RegisterState {
  const RegisterOnError({required this.model});
  final AppReportModel model;

  @override
  List<Object> get props => ["model: $model"];
}
