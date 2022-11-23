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
    on<LoginEvent>((event, emit) async {
      final _user =
          await _auth.authenticationUser(event.username, event.password);
      if (_user != null) {
        emit(SuccesfullLoginState(_user));
        emit(HomeInitial());
      }

      // print(event);
    });
    on<RegisterAccountEvent>((event, emit) async {
      final result = await _auth.createUser(event.username, event.password);
      switch (result) {
        case UserCreationResult.success:
          emit(SuccesfullLoginState(event.username));
          break;
        case UserCreationResult.failuer:
          emit(HomeInitial(error: 'There is been an error '));
          break;
        case UserCreationResult.already_exits:
          emit(HomeInitial(error: 'User already exists'));

          break;
      }
    });

    on<RegisterServiceEvent>(((event, emit) async {
      await _auth.init();
      await _todo.init();
      emit(HomeInitial());
    }));
  }
}
