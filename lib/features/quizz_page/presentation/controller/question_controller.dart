import 'dart:async';

import 'package:get/get.dart';
import 'package:quizz_app/features/quizz_page/data/models/question_model.dart';
import 'package:quizz_app/features/quizz_page/domain/repository/question_repository.dart';
import 'package:quizz_app/features/quizz_page/domain/usecase/question_pass_usecase.dart';

import '../../../../core/di/app_component.dart';
import '../../../../core/utils/status/status.dart';

class QuestionController extends GetxController {
  Rxn<QuizModel> quizModelData = Rxn<QuizModel>();
  var count = 0.obs;
  var isLoading = false.obs;
  var timerIsActive = false.obs;
  var totalScore = 0.obs;
  var secondsRemaining = 6.obs;
  void fetchAllApplicantData() async {
    count.value = 0;
    quizModelData.value?.questions?.clear();
    final questionPassUseCase =
    QuestionPassUseCase(locator<QuestionRepository>());
    isLoading(true);
    var response = await questionPassUseCase();
    try {
      if (response?.data != null && response!.data!.questions != null) {
        // Make sure quizModelData.value is not null

          print(count.value.toString());
          quizModelData.value ??= QuizModel(questions: []);

          // Add questions from response to quizModelData.value
          quizModelData.value?.questions?.addAll(response!.data!.questions!);

          // Exit the method to avoid starting a new timer


      }
    } catch (e) {
      logger.e(e.toString());
    } finally {
      isLoading.value = false;
      // isLoading2.value = false;
    }
  }
}