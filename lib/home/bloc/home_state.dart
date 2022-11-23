part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  final String? error;
  HomeInitial({this.error});

  @override
  List<Object?> get props => [error];
}

class SuccesfullLoginState extends HomeState {
  final String username;

  SuccesfullLoginState(this.username);
  @override
  // TODO: implement props
  List<Object?> get props => [username];
}

class RegisteringServiceState extends HomeState {
  RegisteringServiceState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
