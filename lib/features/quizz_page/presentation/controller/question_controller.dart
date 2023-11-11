import 'dart:async';

import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:quizz_app/features/quizz_page/data/models/question_model.dart';
import 'package:quizz_app/features/quizz_page/domain/repository/question_repository.dart';
import 'package:quizz_app/features/quizz_page/domain/usecase/question_pass_usecase.dart';

import '../../../../core/di/app_component.dart';
import '../../../../core/routes/route_name.dart';
import '../../../../core/routes/router.dart';
import '../../../../core/utils/status/status.dart';
import '../../../../main.dart';

class QuestionController extends GetxController {
  Rxn<QuizModel> quizModelData = Rxn<QuizModel>();
  var count = 0.obs;
  var isLoading = false.obs;
  var timerIsActive = false.obs;
  var isClickedOnOptions = false.obs;
  var totalScore = 0.obs;
  var secondsRemaining = 10.obs;
  var questionLength = 0.obs;
  var texts = [].obs;
  RxInt? selectedAnswer = 0.obs;
  var correctAnswer = 0.obs;
  Timer? timer;
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
  void whenCorrectThenTimerTwoSeconds(BuildContext context) {
    secondsRemaining.value = 2;
    if (count.value < questionLength.value - 1) {
      Future.delayed(const Duration(seconds: 1), () {
        if (secondsRemaining.value == 0) {
          isClickedOnOptions.value = false;
          timerIsActive.value = true;
          if (timerIsActive.value) {
            if (count.value < questionLength.value - 1) {
              count.value++;
            }
          }
          selectedAnswer = null;
          if (count.value <= questionLength.value - 1) {
            secondsRemaining.value = 10;
          } else {
            timerIsActive.value = false;
          }
        } else {
          secondsRemaining.value--;
        }
      });
    } else {
      RouteGenerator.pushNamedAndRemoveAll(navigatorKey.currentContext!, Routes.homepage);

    }
  }

  void showNextQuestion() {
    questionLength.value = quizModelData.value?.questions?.length ?? 0;
      if (count.value < questionLength.value - 1) {
        Future.delayed(const Duration(seconds: 1), () {
          if (secondsRemaining.value == 0) {
            isClickedOnOptions.value = false;
            timerIsActive.value = true;

            if (timerIsActive.value) {
              if (count.value < questionLength.value - 1) {
                count.value++;
              }
            }

            selectedAnswer = null;

            if (count.value <= questionLength.value - 1) {
              secondsRemaining.value = 10;

              showNextQuestion();
            } else {
              timerIsActive.value = false;
            }
          } else {
            secondsRemaining.value--;

            if (count.value <= questionLength.value - 1) {
              showNextQuestion();
            }
          }
        });
      } else {
        RouteGenerator.pushNamedAndRemoveAll(navigatorKey.currentContext!, Routes.homepage);
      }
    update(["showNextQuestion"]);
  }
  @override
  void onInit() {
    count.value = 0;
    super.onInit();
  }
  void insertQuestionAnswer(){
    print("count.value ${count.value}");
    texts.value.clear();
     quizModelData.value
        ?.questions?[ count.value]?.answers?.a != null ?  texts.value.add( quizModelData.value
        ?.questions?[ count.value]?.answers?.a ??
        '') : null;
     quizModelData.value
        ?.questions?[ count.value]?.answers?.b != null ?  texts.value.add( quizModelData.value
        ?.questions?[ count.value]?.answers?.b ??
        '') : null;
     quizModelData.value
        ?.questions?[ count.value]?.answers?.c != null ?  texts.value.add( quizModelData.value
        ?.questions?[ count.value]?.answers?.c ??
        '') : null;
     quizModelData.value
        ?.questions?[ count.value]?.answers?.d != null ?  texts.value.add( quizModelData.value
        ?.questions?[ count.value]?.answers?.d ??
        '') : null;

     correctAnswer.value =  quizModelData.value
        ?.questions?[ count.value]?.correctAnswer == "A" ? 0 :  quizModelData.value
        ?.questions?[ count.value]?.correctAnswer == "B" ? 1 :  quizModelData.value
        ?.questions?[ count.value]?.correctAnswer == "C" ? 2 : 3;
  }
}