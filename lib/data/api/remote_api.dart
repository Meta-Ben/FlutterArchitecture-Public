import 'dart:io';

import 'package:flutter_architecture/data/models/request/question_request.dart';
import 'package:flutter_architecture/data/models/response/question_response.dart';
import 'package:dio/dio.dart';

import '../../core/error/failure.dart';

class RemoteApi {
  static const String url = 'https://opentdb.com/api.php';

  Future<List<QuestionResponse>> getQuestions(QuestionRequest request) async {
    try {
      //Appel WS
      final response = await Dio().get(url, queryParameters: request.toMap());


      //Récuperer la réponse
      if (response.statusCode == 200) {
        final data = Map<String, dynamic>.from(response.data);
        final results = List<Map<String, dynamic>>.from(data['results']);
        if (results.isNotEmpty) {
          return results.map((e) => QuestionResponse.fromMap(e)).toList();
        }
      }
      return [];
    } on DioError catch (err) {
      //Gérer les erreurs
      print(err);
      throw Failure(
          message: err.response?.statusMessage ?? "Something went wrong");
    } on SocketException catch (err) {
      //Socket exception == pas internet
      print(err);
      throw Failure(message: "Please check your connection");
    }
  }
}
