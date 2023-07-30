import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_architecture/domain/entities/question.dart';
import 'package:flutter_architecture/presentation/common/widgets/custom_button.dart';
import 'package:flutter_architecture/presentation/common/widgets/error.dart';
import 'package:flutter_architecture/presentation/quiz/providers/quiz_view_model_state_provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../viewmodel/quiz_state.dart';
import '../widgets/quiz_questions.dart';
import '../widgets/quiz_result.dart';

class QuizScreen extends HookConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = usePageController();
    final viewModelState = ref.watch(quizViewModelStateProvider);
    final questionsFuture = ref.watch(questionsProvider);
    final viewModel = ref.read(quizViewModelStateProvider.notifier);

    return Container(decoration:
      BoxDecoration(color: Color(0xFF22293E)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: questionsFuture.when(
            data: (data) => _buildBody(ref, viewModelState, pageController, data),
            error: (error, _) => Error(message: error.toString(), callback: () => refreshAll(ref)),
            loading: ()=> const Center(child: CircularProgressIndicator())
            ),
        bottomSheet: questionsFuture.maybeWhen(
          data: (questions) {
            if(!viewModelState.answered) return const SizedBox.shrink();
            var currentIndex = pageController.page?.toInt() ?? 0;
            return CustomButton(title: currentIndex + 1 < questions.length ? "Next Question" : "See results", onTap: () {
              viewModel.nextQuestion(questions, currentIndex);
              if(currentIndex + 1 < questions.length) {
                pageController.nextPage(duration: const Duration(milliseconds: 250), curve: Curves.linear);
              }
            });
          },
          orElse: () => const SizedBox.shrink()
        ),
        ),
      );
  }

  void refreshAll(WidgetRef ref) {
    ref.refresh(questionsProvider);
    ref.read(quizViewModelStateProvider.notifier).reset();
  }

  Widget _buildBody(
      WidgetRef ref,
      QuizState state,
      PageController pageController,
      List<Question> questions) {

      if(questions.isEmpty) {
        return Error(message: "No questions found", callback: () => refreshAll(ref));
      }

      return state.status == QuizStatus.complete ? QuizResult(state: state, nbQuestions: questions.length) : QuizQuestions(pageController: pageController, state: state, questions: questions);
  }

}