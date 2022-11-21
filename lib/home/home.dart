import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_hive_bloc/home/bloc/home_bloc.dart';
import 'package:todo_hive_bloc/services/authentication.dart';
import 'package:todo_hive_bloc/services/todo.dart';
import 'package:todo_hive_bloc/todos/todos.dart';

class HomePage extends StatelessWidget {
  final usernameField = TextEditingController();
  final passwordField = TextEditingController();
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login to Todo App'),
      ),
      body: BlocProvider(
        create: (context) => HomeBloc(
            RepositoryProvider.of<AuthenticationService>(context),
            RepositoryProvider.of<TodoService>(context))
          ..add(RegisterServiceEvent()),
        child: BlocConsumer<HomeBloc, HomeState>(listener: ((context, state) {
          if (state is SuccesfullLoginState) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => TodosPage(username: state.username)));
          }
        }), builder: (context, state) {
          if (state is HomeInitial) {
            return Column(
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Username'),
                  controller: usernameField,
                ),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Password'),
                  controller: passwordField,
                ),
                ElevatedButton(
                    onPressed: () => BlocProvider.of<HomeBloc>(context).add(
                        LoginEvent(usernameField.text, passwordField.text)),
                    child: Text('LOGIN'))
              ],
            );
          }
          return Container();
        }),
      ),
    );
  }
}
