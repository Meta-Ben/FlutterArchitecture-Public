import 'package:flutter_architecture/data/providers/quiz_repository_provider.dart';
import 'package:flutter_architecture/domain/usecase/quiz_usecase.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final quizUseCaseProvider = Provider<QuizUseCase>((ref) => QuizUseCase(ref.read(quizRepositoryProvider)));