import 'package:flutter_architecture/domain/entities/question.dart';

abstract class QuizzRepository {
  Future<List<Question>> getQuestions({
    required int numQuestions,
    required int categoryId
  });
}