import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_hive_bloc/services/authentication.dart';
import 'package:todo_hive_bloc/services/todo.dart';

part 'home_state.dart';
part 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AuthenticationService _auth;
  final TodoService _todo;

  HomeBloc(this._auth, this._todo) : super(RegisteringServiceState()) {
    on<LoginEvent>((event, emitter) async {
      final _user =
          await _auth.authenticationUser(event.username, event.password);
      if (_user != null) {
        emit(SuccesfullLoginState(_user));
        emit(HomeInitial());
      }

      // print(event);
    });

    on<RegisterServiceEvent>(((event, emit) async {
      await _auth.init();
      await _todo.init();
      emit(HomeInitial());
    }));
  }
}
