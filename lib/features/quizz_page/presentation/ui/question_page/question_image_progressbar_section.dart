import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/consts/app_assets.dart';
import '../../../../../core/utils/consts/app_colors.dart';
import '../../../../../core/utils/consts/app_sizes.dart';
import '../../../../../core/utils/consts/textstyle.dart';
import '../../controller/question_controller.dart';
import '../../controller/user_store_get_controller.dart';

class QuestionImageProgressBarSection extends StatelessWidget {
   QuestionImageProgressBarSection({super.key});
  QuestionController questionController = Get.put(QuestionController());
  UserCatchController userCatchController = Get.put(UserCatchController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GlobalText(text: "Question: ${questionController.count.value} / ${questionController.questionLength.value - 1}", color: AppColors.black, fontSize: AppSizes.size17, fontWeight: FontWeight.bold),
                // 50.pw,
                GlobalText(text: "Score: ${questionController.totalScore.value}", color: AppColors.black, fontSize: AppSizes.size17, fontWeight: FontWeight.bold),
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(),
                      color: Colors.white
                  ),
                  child: Center(
                    child: GlobalText(text: "${questionController.secondsRemaining.value}s", color: Colors.red, fontSize: AppSizes.size17, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: LinearProgressIndicator(
            value: questionController.secondsRemaining.value / 6,
            color: Colors.blue,
            backgroundColor: Colors.grey[300],
          ),
        ),
        Container(
          height: AppSizes.newSize(44),
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
                      "${questionController.quizModelData.value?.questions?[questionController.count.value]?.score } Points",
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
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        Image.asset(AppAssets.imageNot),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Center(
                    child: GlobalText1(
                      text:
                      "${questionController.quizModelData.value?.questions?[questionController.count.value]?.question} Points",
                      color: AppColors.white,
                      fontSize: AppSizes.size17,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),);
  }
}
