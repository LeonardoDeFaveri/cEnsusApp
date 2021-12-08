part of 'sondaggi_bloc.dart';

@immutable
abstract class SondaggiEvent extends Equatable {}

class SondaggiPrelevaSondaggi extends SondaggiEvent {
  @override
  List<Object?> get props => [];
}

class SondaggiSalvaSondaggio extends SondaggiEvent {
  final Sondaggio sondaggio;

  SondaggiSalvaSondaggio(this.sondaggio);

  @override
  List<Object?> get props => [sondaggio];
}
