part of 'utente_bloc.dart';

@immutable
abstract class UtenteState extends Equatable {}

class UtenteInitial extends UtenteState {
  @override
  List<Object?> get props => [];
}

class UtenteLoggingIn extends UtenteState {
  final Utente credentials;

  UtenteLoggingIn(this.credentials);

  @override
  List<Object?> get props => [credentials];
}

class UtenteLogged extends UtenteState {
  final Utente credentials;

  UtenteLogged(this.credentials);

  @override
  List<Object?> get props => [credentials];
}
