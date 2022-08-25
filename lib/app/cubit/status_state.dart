part of 'status_cubit.dart';

enum StatusTypes {
  active,
  inactive,
}

@immutable
abstract class StatusState {}

class StatusInitial extends StatusState {}

class ActiveStatus extends StatusState {}
