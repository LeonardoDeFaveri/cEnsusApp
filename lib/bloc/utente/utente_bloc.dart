import 'package:bloc/bloc.dart';
import 'package:census/classes/utente.dart';
import 'package:meta/meta.dart';

import 'package:equatable/equatable.dart';

part 'utente_event.dart';
part 'utente_state.dart';

class UtenteBloc extends Bloc<UtenteEvent, UtenteState> {
  bool isLoading;
  Utente credentials;

  UtenteBloc(this.credentials, this.isLoading) : super(UtenteInitial()) {
    on<Login>((event, emit) {
      isLoading = true;
      credentials = event.credentials;
      emit(UtenteLoggingIn(credentials));
    });
    on<Logout>((event, emit) {
      isLoading = false;
      credentials = credentials;
    });
  }
}
