import 'dart:math';

import 'package:flutter_architecture/domain/repository/quizz_repository.dart';

import '../entities/question.dart';

class QuizUseCase {
  final QuizzRepository _repository;
  
  QuizUseCase(this._repository);

  Future<List<Question>> getQuestions() {
    return _repository.getQuestions(numQuestions: 5, categoryId: Random().nextInt(24) + 9);
  }
}