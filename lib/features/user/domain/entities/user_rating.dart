import 'package:instituto_o_caminho/features/history/domain/entities/history.dart';
import 'package:instituto_o_caminho/features/punishments/domain/entities/punishment.dart';

class UserRating {
  UserRating({
    required this.history,
    required this.punishments,
  });

  final List<History> history;
  final List<Punishment> punishments;
}
