part of 'utente_bloc.dart';

@immutable
abstract class UtenteEvent extends Equatable {}

class Login extends UtenteEvent {
  final Utente credentials;

  Login(this.credentials);

  @override
  List<Object?> get props => [credentials];
}

class Logout extends UtenteEvent {
  Logout();

  @override
  List<Object?> get props => [];
}
