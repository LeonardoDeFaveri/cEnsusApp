import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'utente.g.dart';

@JsonSerializable()
class Utente extends Equatable {
  final String email;
  final String password;

  const Utente(this.email, this.password);

  factory Utente.fromJson(Map<String, dynamic> json) => _$UtenteFromJson(json);
  Map<String, dynamic> toJson() => _$UtenteToJson(this);

  @override
  List<Object?> get props => [email, password];
}
