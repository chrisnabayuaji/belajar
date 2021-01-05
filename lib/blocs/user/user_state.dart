import 'package:belajar/models/user_list_model.dart';
import 'package:equatable/equatable.dart';

class UserState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final UserListModel userListModel;

  UserLoaded({this.userListModel});
}

class UserFailure extends UserState {
  final String message;

  UserFailure({this.message});
}
