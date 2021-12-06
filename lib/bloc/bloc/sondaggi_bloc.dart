import 'package:bloc/bloc.dart';
import 'package:census/classes/gestore_memoria_locale.dart';
import 'package:census/classes/sondaggio.dart';
import 'package:census/classes/utente.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'sondaggi_event.dart';
part 'sondaggi_state.dart';

class SondaggiBloc extends Bloc<SondaggiEvent, SondaggiState> {
  final GestoreMemoriaLocale _service = GestoreMemoriaLocale();
  final Utente somministratore;

  SondaggiBloc(this.somministratore) : super(SondaggiInitial()) {
    on<SondaggiCaricaSondaggi>((event, emit) async {
      emit(SondaggiLoading());
      final List<Sondaggio> sondaggi =
          await _service.prelevaSondaggi(somministratore);
      emit(SondaggiLoaded(sondaggi));
    });
  }
}
