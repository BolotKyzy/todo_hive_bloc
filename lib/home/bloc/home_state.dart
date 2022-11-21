part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  HomeInitial();

  @override
  List<Object?> get props => [];
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
