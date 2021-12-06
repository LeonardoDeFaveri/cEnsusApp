part of 'sondaggi_bloc.dart';

@immutable
abstract class SondaggiState extends Equatable {}

class SondaggiInitial extends SondaggiState {
  @override
  List<Object?> get props => [];
}

class SondaggiLoading extends SondaggiState {
  @override
  List<Object?> get props => [];
}

class SondaggiLoaded extends SondaggiState {
  final List<Sondaggio> sondaggi;

  SondaggiLoaded(this.sondaggi);

  @override
  List<Object?> get props => [sondaggi];
}
