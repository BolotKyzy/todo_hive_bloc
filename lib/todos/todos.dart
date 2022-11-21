import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_hive_bloc/services/todo.dart';
import 'package:todo_hive_bloc/todos/bloc/todos_bloc.dart';

class TodosPage extends StatelessWidget {
  final String username;
  const TodosPage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Todo list'),
        ),
        body: BlocProvider(
            create: (context) =>
                TodosBloc(RepositoryProvider.of<TodoService>(context))
                  ..add(LoadTodosEvent(username)),
            child: BlocBuilder<TodosBloc, TodosState>(
              builder: (context, state) {
                if (state is TodosLoadedState) {
                  return ListView(
                    children: state.tasks
                        .map(
                          (e) => ListTile(
                            title: Text(e.task),
                            trailing: Checkbox(
                              value: e.completed,
                              onChanged: (val) {},
                            ),
                          ),
                        )
                        .toList(),
                  );
                }
                return Container();
              },
            )));
  }
}
