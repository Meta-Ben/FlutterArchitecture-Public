import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/presentation/quiz/providers/quiz_view_model_state_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:html_character_entities/html_character_entities.dart';

import '../../../domain/entities/question.dart';
import '../viewmodel/quiz_state.dart';
import 'answer_card.dart';

class QuizQuestions extends ConsumerWidget {
  final PageController pageController;
  final QuizState state;
  final List<Question> questions;

  const QuizQuestions(
      {required this.pageController,
      required this.state,
      required this.questions})
      : super();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageView.builder(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: questions.length,
        itemBuilder: (BuildContext context, int index) {
          final question = questions[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 60,
                decoration: const BoxDecoration(
                    color: Color(0xFF2E415A),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: Text(HtmlCharacterEntities.decode(question.category),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Spacer(),
                  Padding(
                      padding: EdgeInsets.only(right: 10, bottom: 5),
                      child: Text(
                        '${index + 1}/${questions.length}',
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal,
                        ),
                      )),
                ],
              ),
              Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: LinearProgressIndicator(
                    value: index / questions.length,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xFFE6812F)),
                    backgroundColor: Colors.white,
                  )),
              Container(
                height: 150.0,
                padding:
                    const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                child: Center(
                    child: Text(HtmlCharacterEntities.decode(question.question)
                    )),
              ),
              Expanded(
                  child: GridView.builder(
                itemCount: question.answers.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 1.4),
                itemBuilder: (BuildContext context, int index) {
                  final answer = question.answers[index];
                  return AnswerCard(
                    answer: answer,
                    isSelected: answer == state.selectedAnswer,
                    isCorrect: answer == question.correctAnswer,
                    isDisplayingAnswer: state.answered,
                    onTap: () => ref.read(quizViewModelStateProvider.notifier).submitAnswer(question, answer)
                  );
                },
              ))
            ],
          );
        });
  }
}
