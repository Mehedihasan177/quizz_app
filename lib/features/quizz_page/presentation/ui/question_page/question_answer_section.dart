import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/utils/consts/app_sizes.dart';
import '../../controller/question_controller.dart';
import '../../controller/user_store_get_controller.dart';

class QuestionAnswerSection extends StatefulWidget {
   QuestionAnswerSection({super.key});

  @override
  State<QuestionAnswerSection> createState() => _QuestionAnswerSectionState();
}

class _QuestionAnswerSectionState extends State<QuestionAnswerSection> {
  QuestionController questionController = Get.put(QuestionController());

  UserCatchController userCatchController = Get.put(UserCatchController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionController>(
        id: "showNextQuestion",
        builder: (controller){
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            for (int i = 0; i < questionController.texts.value.length; i++)
              InkWell(
                onTap: questionController.isClickedOnOptions.value? null : () {
                  // Set the selected answer
                  setState(() {
                    questionController.selectedAnswer = i.obs;
                  });
                  questionController.isClickedOnOptions.value = true;
                  if (i == questionController.correctAnswer.value) {
                    questionController.totalScore.value = questionController.totalScore.value + int.parse(questionController.quizModelData.value?.questions?[questionController.count.value]?.score.toString() ?? '');
                    userCatchController.storeScore(questionController.totalScore.value.toString());
                    userCatchController.getScores.value = questionController.totalScore.value.toString();
                    questionController.whenCorrectThenTimerTwoSeconds(context);
                  }
                },
                child: Container(
                  height: AppSizes.newSize(4),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: questionController.selectedAnswer == i.obs
                        ? (i == questionController.correctAnswer.value
                        ? Colors.green
                        : Colors.red)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  margin: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 3),
                  child: Center(
                      child: Text(questionController.texts.value[i],
                          style: const TextStyle(fontSize: 20))),
                ),
              ),
            // Display the correct answer in green
            if (questionController.selectedAnswer != questionController.correctAnswer.value.obs &&
                questionController.selectedAnswer != null)
              Container(
                height: AppSizes.newSize(4),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(5),
                ),
                margin: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 3),
                child: Center(
                    child: Text(questionController.quizModelData.value?.questions?[questionController.count.value]?.correctAnswer ?? '',
                        style: const TextStyle(fontSize: 20))),
              ),
          ],
        ),
      );
    });
  }
}
