import 'package:equatable/equatable.dart';

class UserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UserStarted extends UserEvent {}

class UserRefresh extends UserEvent {}
