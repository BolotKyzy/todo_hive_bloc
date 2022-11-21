import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_hive_bloc/models/task.dart';
import 'package:todo_hive_bloc/services/todo.dart';

part 'todos_state.dart';
part 'todos_event.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final TodoService _todoService;

  TodosBloc(this._todoService) : super(TodosInitial()) {
    on<LoadTodosEvent>(((event, emit) {
      final todos = _todoService.getTasks(event.username);
      emit(TodosLoadedState(todos));
    }));
  }
}
