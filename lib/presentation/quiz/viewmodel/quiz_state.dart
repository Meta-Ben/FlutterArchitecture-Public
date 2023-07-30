
import 'package:equatable/equatable.dart';

enum QuizStatus { initial, correct, incorrect, complete }

class QuizState extends Equatable {
  final String selectedAnswer;
  final int nbCorrect;
  final QuizStatus status;

  const QuizState({
    required this.selectedAnswer,
    required this.nbCorrect,
    required this.status
  });

  @override
  List<Object?> get props => [
    selectedAnswer,
    nbCorrect,
    status
  ];

  //Factory Retourne un objet statique
  factory QuizState.initial() {
    return const QuizState(selectedAnswer: "", nbCorrect: 0, status: QuizStatus.initial);
  }

  bool get answered => status == QuizStatus.correct || status == QuizStatus.incorrect;

  QuizState copyWith({String? selectedAnswer, int? correct, QuizStatus? status}) {
    return QuizState(selectedAnswer: selectedAnswer ?? this.selectedAnswer, nbCorrect: correct ?? nbCorrect, status: status ?? this.status);
  }
}