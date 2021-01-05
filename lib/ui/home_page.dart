import 'package:belajar/blocs/user/user_bloc.dart';
import 'package:belajar/blocs/user/user_event.dart';
import 'package:belajar/blocs/user/user_state.dart';
import 'package:belajar/models/user_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  Widget _userLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _userLoaded({
    @required BuildContext context,
    UserListModel userListModel,
  }) {
    return Column(
      children: [
        RaisedButton(
          onPressed: () {
            BlocProvider.of<UserBloc>(context).add(UserRefresh());
          },
          child: Text("Update Data"),
        ),
        ListView.builder(
          itemCount: userListModel.data.length,
          itemBuilder: (context, i) {
            return Card(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  userListModel.data[i].firstName +
                      " " +
                      userListModel.data[i].lastName,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _userFailure({
    @required BuildContext context,
    @required String message,
  }) {
    return Column(
      children: [
        Text("Data Gagal ditarik"),
        RaisedButton(
          onPressed: () {
            BlocProvider.of<UserBloc>(context).add(UserRefresh());
          },
          child: Text("Refresh"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Belajar Flutter"),
      ),
      body: BlocProvider<UserBloc>(
        create: (context) {
          return UserBloc(initialState: UserInitial())..add(UserStarted());
        },
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoaded) {
              return _userLoaded(
                  context: context, userListModel: state.userListModel);
            }
            if (state is UserFailure) {
              return _userFailure(
                context: context,
                message: state.message,
              );
            }
            return _userLoading();
          },
        ),
      ),
    );
  }
}
