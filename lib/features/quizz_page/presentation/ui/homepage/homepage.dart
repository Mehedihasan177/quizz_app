import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizz_app/core/utils/consts/app_colors.dart';
import 'package:quizz_app/core/utils/consts/app_sizes.dart';
import 'package:quizz_app/core/utils/consts/textstyle.dart';
import 'package:quizz_app/core/utils/core/extensions/extensions.dart';
import 'package:quizz_app/features/quizz_page/presentation/ui/question_page/question_page.dart';

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
              RouteGenerator.pushNamed(context, Routes.questionpage);
            }, child: const Text("data"))
          ],
        ),
      ),
    );
  }
}
