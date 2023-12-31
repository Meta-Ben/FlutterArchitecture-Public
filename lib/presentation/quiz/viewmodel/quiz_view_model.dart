import 'package:flutter_architecture/domain/entities/question.dart';
import 'package:flutter_architecture/domain/usecase/quiz_usecase.dart';
import 'package:flutter_architecture/presentation/quiz/viewmodel/quiz_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QuizViewModel extends StateNotifier<QuizState> {
  final QuizUseCase _useCase;

  //StateNotifier necessite un objet de base à la construction
  QuizViewModel(this._useCase) : super(QuizState.initial());


  Future<List<Question>> getQuestions() {
    return _useCase.getQuestions();
  }

  void submitAnswer(Question currentQuestion, String answer) {
    if(state.answered) return;
    if(currentQuestion.correctAnswer == answer) {
      state = state.copyWith(selectedAnswer: answer, correct: state.nbCorrect + 1, status: QuizStatus.correct);
    } else {
      state = state.copyWith(selectedAnswer: answer, status: QuizStatus.incorrect);
    }
  }

  void nextQuestion(List<Question> questions, int currentIndex) {
    state = state.copyWith(selectedAnswer: "", status: currentIndex + 1 < questions.length ? QuizStatus.initial : QuizStatus.complete);
  }

  void reset() {
    state = QuizState.initial();
  }

}