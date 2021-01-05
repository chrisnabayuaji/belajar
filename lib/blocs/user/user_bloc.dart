import 'package:belajar/blocs/user/user_event.dart';
import 'package:belajar/blocs/user/user_state.dart';
import 'package:belajar/models/user_list_model.dart';
import 'package:belajar/services/user_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({UserState initialState}) : super(initialState);
  UserService userService = new UserService();

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is UserStarted) {
      yield UserLoading();
      //tembak data dari api
      try {
        final UserListModel userListModel = await userService.getListUser();
        if (userListModel != null) {
          yield UserLoaded(userListModel: userListModel);
        } else {
          yield UserFailure(message: "Gagal tarik data");
        }
      } catch (e) {
        yield UserFailure(message: e.toString());
      }
    }

    if (event is UserRefresh) {
      yield UserLoading();
      //tembak data dari api
      try {
        final UserListModel userListModel = await userService.getListUser();
        if (userListModel != null) {
          yield UserLoaded(userListModel: userListModel);
        } else {
          yield UserFailure(message: "Gagal tarik data");
        }
      } catch (e) {
        yield UserFailure(message: e.toString());
      }
    }
  }
}
