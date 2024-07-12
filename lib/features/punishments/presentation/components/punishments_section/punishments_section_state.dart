part of 'punishments_section_cubit.dart';

@immutable
abstract class PunishmentsSectionState {}

class PunishmentsSectionLoading extends PunishmentsSectionState {}

class PunishmentsSectionError extends PunishmentsSectionState {}

class PunishmentsSectionDone extends PunishmentsSectionState {
  PunishmentsSectionDone({
    required this.punishments,
  });

  final List<Punishment> punishments;
}
