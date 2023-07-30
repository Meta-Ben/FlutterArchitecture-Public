import 'package:flutter_architecture/data/api/remote_api.dart';
import 'package:flutter_architecture/data/models/request/question_request.dart';
import 'package:flutter_architecture/domain/entities/question.dart';
import 'package:flutter_architecture/domain/repository/quizz_repository.dart';


class QuizzRepositoryImpl extends QuizzRepository {
  final RemoteApi _remoteApi;

  QuizzRepositoryImpl(this._remoteApi);

  @override
  Future<List<Question>> getQuestions(
      {required int numQuestions, required int categoryId}) {
    return _remoteApi.getQuestions(
        QuestionRequest(
            type: 'multiple', amount: numQuestions, category: categoryId))
        .then((value) => value.map((e) => e.toEntity()).toList());
  }
}
