import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizz_app/core/utils/consts/app_assets.dart';
import 'package:quizz_app/core/utils/consts/app_sizes.dart';
import 'package:quizz_app/core/utils/consts/textstyle.dart';
import 'package:quizz_app/core/utils/core/extensions/extensions.dart';

import '../../../../../core/routes/route_name.dart';
import '../../../../../core/routes/router.dart';
import '../../../../../core/utils/consts/app_colors.dart';
import '../../controller/question_controller.dart';

class QuestionPage extends StatefulWidget {
  QuestionPage({Key? key}) : super(key: key);

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  QuestionController questionController = Get.put(QuestionController());
  List<String> texts = [];
  Timer? timer;

  // Variable to track the selected answer
  int? selectedAnswer;
  int? correctAnswer;

  var length = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<QuestionController>(
          initState: (state) {
            questionController.count.value = 0;
            questionController.secondsRemaining.value = 0;
            questionController.timerIsActive.value = false;
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              questionController.fetchAllApplicantData();
              Future.delayed(Duration.zero, () {
                showNextQuestion();
              });
            });
          },
          dispose: (state) {
            questionController.count.value = 0;
            questionController.quizModelData.value?.questions = null;
          },
          builder: (controller) {
            return Obx(() {
              length = questionController.quizModelData.value?.questions?.length ?? 0;
              texts.clear();
              questionController.quizModelData.value
                  ?.questions?[questionController.count.value]?.answers?.a != null ? texts.add(questionController.quizModelData.value
                  ?.questions?[questionController.count.value]?.answers?.a ??
                  '') : null;
              questionController.quizModelData.value
                  ?.questions?[questionController.count.value]?.answers?.b != null ? texts.add(questionController.quizModelData.value
                  ?.questions?[questionController.count.value]?.answers?.b ??
                  '') : null;
              questionController.quizModelData.value
                  ?.questions?[questionController.count.value]?.answers?.c != null ? texts.add(questionController.quizModelData.value
                  ?.questions?[questionController.count.value]?.answers?.c ??
                  '') : null;
              questionController.quizModelData.value
                  ?.questions?[questionController.count.value]?.answers?.d != null ? texts.add(questionController.quizModelData.value
                  ?.questions?[questionController.count.value]?.answers?.d ??
                  '') : null;

              // Set correct answer based on the selected question
              correctAnswer = questionController.quizModelData.value
                  ?.questions?[questionController.count.value]?.correctAnswer == "A" ? 0 : questionController.quizModelData.value
                  ?.questions?[questionController.count.value]?.correctAnswer == "B" ? 1 : questionController.quizModelData.value
                  ?.questions?[questionController.count.value]?.correctAnswer == "C" ? 2 : 3;

              return questionController.isLoading.value
                  ? Center(
                child: CircularProgressIndicator(),
              )
                  : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    20.ph,
                    Text("${questionController.secondsRemaining.value}"),
                    Container(
                      height: AppSizes.newSize(40),
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: GlobalText(
                                  text:
                                  "${questionController.quizModelData.value?.questions?[questionController.count.value]?.score} Points",
                                  color: AppColors.white,
                                  fontSize: AppSizes.size18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: CachedNetworkImage(
                                imageUrl:
                                "${questionController.quizModelData.value?.questions?[questionController.count.value]?.questionImageUrl}",
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                            colorFilter: ColorFilter.mode(
                                                Colors.red, BlendMode.colorBurn)),
                                      ),
                                    ),
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Image.asset(AppAssets.imageNot),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GlobalText(
                              text:
                              "${questionController.quizModelData.value?.questions?[questionController.count.value]?.question} Points",
                              color: AppColors.white,
                              fontSize: AppSizes.size18,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    20.ph,
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          for (int i = 0; i < texts.length; i++)
                            InkWell(
                              onTap: () {
                                // Set the selected answer
                                setState(() {
                                  selectedAnswer = i;
                                });
                                if (i == correctAnswer) {

                                  whenCorrectThenTimerTwoSeconds();
                                }
                              },
                              child: Container(
                                height: AppSizes.newSize(4),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: selectedAnswer == i
                                      ? (i == correctAnswer
                                      ? Colors.green
                                      : Colors.red)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 3),
                                child: Center(
                                    child: Text(texts[i],
                                        style: const TextStyle(fontSize: 20))),
                              ),
                            ),
                          // Display the correct answer in green
                          if (selectedAnswer != correctAnswer &&
                              selectedAnswer != null)
                            Container(
                              height: AppSizes.newSize(4),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              child: Center(
                                  child: Text(correctAnswer.toString(),
                                      style: const TextStyle(fontSize: 20))),
                            ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            });
          },
        ),
      ),
    );
  }

  void showNextQuestion() {
    length = questionController.quizModelData.value?.questions?.length ?? 0;
    if (questionController.count.value <= length - 1) {
      Future.delayed(const Duration(seconds: 1), () {
        if (questionController.secondsRemaining.value == 0) {
          print("timer has not stopped ${questionController.count.value}");

          // Set timerIsActive to true when starting the timer
          questionController.timerIsActive.value = true;

          // Check if the timer is still active before updating the count
          if (questionController.timerIsActive.value) {
            // Increment the count only if it's not already at the last question
            if (questionController.count.value < length) {
              questionController.count.value++;
            } else{
              if (questionController.count.value >= length - 1) {
                RouteGenerator.pushNamed(context, Routes.homepage);
                questionController.count.value = 0;
              }
            }
          }

          selectedAnswer = null;
          if (questionController.count.value > length - 1) {
            // questionController.count.value = 0;
            // RouteGenerator.pushNamed(context, Routes.homepage);
            print("timer has stopped");

            // Set timerIsActive to false when the timer expires or is canceled
            questionController.timerIsActive.value = false;
          } else {
            questionController.secondsRemaining.value = 6;

            // Call the function recursively for the next question
            showNextQuestion();
          }
        } else {
          questionController.secondsRemaining.value--;

          // Call the function recursively while there's time remaining and count is not at the last question
          if (questionController.count.value <= length - 1) {
            showNextQuestion();
          }
        }
      });
    } else{
      RouteGenerator.pushNamed(context, Routes.homepage);
    }
  }

  void whenCorrectThenTimerTwoSeconds() {
    questionController.secondsRemaining.value = 2;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      timer?.cancel();
      if (questionController.secondsRemaining.value == 0) {
        print("timer has not stopped ${questionController.count.value}");
        questionController.count.value++;
        selectedAnswer = null;
        if (questionController.count.value > length - 1) {
          timer.cancel();
          questionController.count.value = 0;
          RouteGenerator.pushNamed(context, Routes.homepage);
          print("timer has stopped1111");
        }
      } else {
        questionController.secondsRemaining.value--;
      }
    });
  }


}
