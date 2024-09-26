part of 'checklist_cubit.dart';

sealed class ChecklistState extends Equatable {
  const ChecklistState();

  @override
  List<Object> get props => [];
}

final class ChecklistInitial extends ChecklistState {}

final class ChecklistOnLoading extends ChecklistState {}

final class ChecklistOnSuccess extends ChecklistState {}

final class ChecklistOnFailed extends ChecklistState {
  const ChecklistOnFailed({required this.message});
  final String message;

  @override
  List<Object> get props => ["message: $message"];
}

final class ChecklistOnError extends ChecklistState {
  const ChecklistOnError({required this.model});
  final AppReportModel model;

  @override
  List<Object> get props => ["model: $model"];
}
