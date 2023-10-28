import '../../constants/app_assets.dart';
import '../../constants/app_colors.dart';
import '../../controllers/scaling/scaling_controller.dart';
import '../../utils/app_libraries.dart';
import '../../widgets/common_loader.dart';

class ScalingScreen extends StatelessWidget {
  const ScalingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // showAppBar: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppColors.commonColor,
        title: const Text(
          "Scaling Details",
          style: TextStyle(color: AppColors.whiteColor),
        ),
      ),
      // appbarelevation: 0.0,
      // appbarcolor: AppColors.transparentColor,
      body: bodyData(),
    );
  }

  Widget bodyData() {
    return GetBuilder<ScalingController>(
        init: ScalingController(),
        builder: (_) {
          return _.isLoading
              ? const Center(
                  child: AppLoaders.appLoader,
                )
              : Column(
                  children: [
                    Container(
                      height: Get.height / 3.0,
                      width: Get.width,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(AppImage.background)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: _.details['photoPath'] == null
                                          ? const AssetImage(AppImage.bitcoin)
                                          : NetworkImage(_.details['photoPath'])
                                              as ImageProvider),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _.details['title'],
                                    style: const TextStyle(
                                        color: AppColors.whiteColor,
                                        fontSize: 28,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    _.details['company'],
                                    style: const TextStyle(
                                        color: AppColors.whiteColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  if (_.isStarred == false) {
                                    _.isStarred = true;
                                    _.update();
                                  } else {
                                    _.isStarred = false;
                                    _.update();
                                  }
                                },
                                child: Icon(
                                    _.isStarred == false
                                        ? FontAwesomeIcons.star
                                        : Icons.star,
                                    color: AppColors.whiteColor),
                              )
                            ],
                          ).marginSymmetric(
                            horizontal: 40,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: ListView(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      children: checkProgree(_.details['analysis']),
                    ).marginOnly(bottom: 15)),
                  ],
                );
        });
  }

  List<Widget> checkProgree(Map c) {
    List<Widget> w = [];
    for (var e in c.entries) {
      w.add(Column(
        children: [
          Row(
            children: [
              Text(
                e.key.toUpperCase(),
                style: const TextStyle(
                  color: AppColors.progressBarTextColor,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Text(
                (e.value).toStringAsFixed(0),
                style: const TextStyle(
                  color: AppColors.progressBarTextColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ).marginOnly(left: 30, right: 30, bottom: 10, top: 10),
          SizedBox(
            height: 30,
            width: double.infinity,
            child: LiquidLinearProgressIndicator(
              value: e.value / 100,
              direction: Axis.horizontal,
              backgroundColor: AppColors.loadingColor,
              valueColor:
                  const AlwaysStoppedAnimation(AppColors.progressBarColor),
              borderRadius: 5.0,
              center: Text(
                "${e.value}}%",
                style: const TextStyle(
                  color: AppColors.transparentColor,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ).marginSymmetric(horizontal: 25),
        ],
      ));
    }
    return w;
  }

  Widget commonButton(
      ScalingController _, String name, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 35,
        width: 130,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          color: AppColors.whiteColor,
          borderRadius: const BorderRadius.all(Radius.circular(3)),
        ),
        child: Center(
          child: Text(
            name,
            style: const TextStyle(
                color: AppColors.textColor,
                fontSize: 15,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  Widget commonprogressBar(
      ScalingController _, double progressValue, String name) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              name,
              style: const TextStyle(
                color: AppColors.progressBarTextColor,
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Text(
              (progressValue * 100).toStringAsFixed(0),
              style: const TextStyle(
                color: AppColors.progressBarTextColor,
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ).marginOnly(left: 10, right: 10),
        SizedBox(
          height: 30,
          width: double.infinity,
          child: LiquidLinearProgressIndicator(
            value: progressValue,
            direction: Axis.horizontal,
            backgroundColor: AppColors.loadingColor,
            valueColor:
                const AlwaysStoppedAnimation(AppColors.progressBarColor),
            borderRadius: 5.0,
            center: Text(
              "$progressValue%",
              style: const TextStyle(
                color: AppColors.transparentColor,
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    ).marginOnly(bottom: 15);
  }
}
