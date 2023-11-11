import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizz_app/core/utils/consts/app_colors.dart';
import 'package:quizz_app/core/utils/consts/app_sizes.dart';
import 'package:quizz_app/core/utils/consts/textstyle.dart';
import 'package:quizz_app/core/utils/core/extensions/extensions.dart';
import '../../../../../core/routes/route_name.dart';
import '../../../../../core/routes/router.dart';
import '../../controller/question_controller.dart';
import '../../controller/user_store_get_controller.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});
  QuestionController questionController = Get.put(QuestionController());
  UserCatchController userCatchController = Get.put(UserCatchController());
  @override
  Widget build(BuildContext context) {
    userCatchController.getScore();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GlobalText(text: "Gorgeous Bangladesh Ltd.", color: AppColors.black, fontSize: AppSizes.size24, fontWeight: FontWeight.bold),
            10.ph,
            GlobalText(text: "Quizz", color: AppColors.black, fontSize: AppSizes.size22, fontWeight: FontWeight.bold),
            30.ph,
            GlobalText(text: "Highscore", color: AppColors.black, fontSize: AppSizes.size22, fontWeight: FontWeight.bold),
            20.ph,
            Obx(() => GlobalText(text:  "${questionController.totalScore.value != 0 ? questionController.totalScore.value : userCatchController.getScores  } Points", color: AppColors.black, fontSize: AppSizes.size22, fontWeight: FontWeight.bold),),
            40.ph,
            ElevatedButton(onPressed: (){
              dialogBuilder(context);
            }, child: const Text("Start Quizz"))
          ],
        ),
      ),
    );
  }
  Future<void> dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: const Text('Start Q'),
          content: const Text(
            'Want to start the quiz? \nTake a deep breath to start the quiz.',
          ),
          contentTextStyle: TextStyle(fontSize: AppSizes.size17, fontWeight: FontWeight.w400, color: Colors.black),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop();
                questionController.count.value = 0;
                RouteGenerator.pushNamedAndRemoveAll(context, Routes.questionpage);
              },
            ),
          ],
        );
      },
    );
  }

}
