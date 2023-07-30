import 'package:flutter_architecture/domain/providers/quiz_usecase_provider.dart';
import 'package:flutter_architecture/presentation/quiz/viewmodel/quiz_state.dart';
import 'package:flutter_architecture/presentation/quiz/viewmodel/quiz_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/entities/question.dart';

final quizViewModelStateProvider = StateNotifierProvider.autoDispose<QuizViewModel, QuizState>((ref) => QuizViewModel(ref.read(quizUseCaseProvider)));

//Petit hack pour récuperer un call sur la liste des questions
final questionsProvider = FutureProvider.autoDispose<List<Question>>((ref) => ref.watch(quizViewModelStateProvider.notifier).getQuestions());