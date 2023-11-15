import 'package:flutter_bloc/flutter_bloc.dart';


abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String username;
  final String password;

  LoginEvent({required this.username, required this.password});
}


abstract class AuthState {}

class AuthInitial extends AuthState {}

class Authenticated extends AuthState {}

class AuthenticationBloc extends Bloc<AuthEvent, AuthState> {
  AuthenticationBloc() : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is LoginEvent) {
      
      if (event.username == 'admin' && event.password == 'admin') {
        yield Authenticated();
      }
    }
  }
}
