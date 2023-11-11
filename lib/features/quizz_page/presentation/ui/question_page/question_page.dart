import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizz_app/core/utils/consts/app_assets.dart';
import 'package:quizz_app/core/utils/consts/app_sizes.dart';
import 'package:quizz_app/core/utils/consts/textstyle.dart';
import 'package:quizz_app/core/utils/core/extensions/extensions.dart';
import 'package:quizz_app/features/quizz_page/presentation/controller/user_store_get_controller.dart';
import 'package:quizz_app/features/quizz_page/presentation/ui/question_page/question_answer_section.dart';
import 'package:quizz_app/features/quizz_page/presentation/ui/question_page/question_image_progressbar_section.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import '../../../../../core/routes/route_name.dart';
import '../../../../../core/routes/router.dart';
import '../../../../../core/utils/consts/app_colors.dart';
import '../../../../../main.dart';
import '../../controller/question_controller.dart';

class QuestionPage extends StatefulWidget {
  QuestionPage({Key? key}) : super(key: key);

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  QuestionController questionController = Get.put(QuestionController());
  UserCatchController userCatchController = Get.put(UserCatchController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<QuestionController>(
          initState: (state) {
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              questionController.totalScore.value = 0;
              questionController.selectedAnswer = null;
              questionController.texts.value.clear();
              userCatchController.storeScore("0");
              questionController.fetchAllApplicantData();
              Future.delayed(Duration.zero, () {
               questionController.showNextQuestion();

              });
            });
          },
          dispose: (state) {
            questionController.secondsRemaining.value = 0;
            questionController.quizModelData.value?.questions?.clear();
          },
          builder: (controller) {

            return WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: Obx(() {
                questionController.insertQuestionAnswer();
                return questionController.isLoading.value
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      20.ph,
                      QuestionImageProgressBarSection(),
                      20.ph,
                      QuestionAnswerSection()
                    ],
                  ),
                );
              }),
            );
          },
        ),
      ),
    );
  }
}
