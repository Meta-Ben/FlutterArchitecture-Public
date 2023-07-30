import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/presentation/common/widgets/custom_button.dart';
import 'package:flutter_architecture/presentation/quiz/providers/quiz_view_model_state_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../viewmodel/quiz_state.dart';

class QuizResult extends HookConsumerWidget {
  final QuizState state;
  final int nbQuestions;

  const QuizResult({
    required this.state,
    required this.nbQuestions,
}) : super();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '${state.nbCorrect} / $nbQuestions',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 60.0,
            fontWeight: FontWeight.w600
          ),
          textAlign: TextAlign.center,
        ),
        const Text(
          "CORRECT",
          style: TextStyle(
            color: Colors.white,
            fontSize: 48.0,
            fontWeight: FontWeight.bold
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        CustomButton(title: "New Quiz",
            onTap: () {
              ref.refresh(questionsProvider);
              ref.read(quizViewModelStateProvider.notifier).reset();
            })
      ],
    );
  }
  
}