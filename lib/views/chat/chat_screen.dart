import 'dart:core';
import 'package:investment_mindset/constants/app_colors.dart';
import 'package:investment_mindset/controllers/chat/chat_controller.dart';
import 'package:investment_mindset/utils/app_libraries.dart';
import 'package:investment_mindset/views/chat/chat_ui_package.dart';
import 'package:investment_mindset/widgets/common_textfield.dart';
import 'package:investment_mindset/widgets/common_toast.dart';

class GroupChatScreen extends StatelessWidget {
  const GroupChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: true,
        backgroundColor: AppColors.commonColor,
        centerTitle: true,
        title: const Text(
          "Chat Room",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: bodyData(context),
    );
  }

  Widget bodyData(context) {
    return GetBuilder<ChatController>(
      init: ChatController(),
      builder: (_) {
        {
          return Container(
            color: Colors.white,
            height: Get.height,
            width: Get.width,
            child: Column(
              children: [
                // Row(
                //   children: [
                //     const Flexible(
                //         child: Divider(
                //       color: Colors.grey,
                //       thickness: 2,
                //     )),
                //     Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: Text(
                //         '${DateTime.now().hour}:${DateTime.now().minute}',
                //         style: const TextStyle(
                //             fontWeight: FontWeight.w400,
                //             fontSize: 14,
                //             color: Colors.white),
                //       ),
                //     ),
                //     const Flexible(
                //         child: Divider(
                //       color: Colors.grey,
                //       thickness: 2,
                //     ))
                //   ],
                // ),

                Expanded(
                  child: messagebody(context, _),
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        width: Get.width / 1.3,
                        height: 47,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: AppColors.commonColor),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(5.0),
                            bottomLeft: Radius.circular(5.0),
                            bottomRight: Radius.circular(5.0),
                            topRight: Radius.circular(5.0),
                          ),
                        ),
                        child: Center(
                          child: CommonTextField2(
                            controller: _.message,
                            fillcolor: Colors.white,
                            hintText: 'Type a message...',
                            isTextHidden: false,
                            keyboardType: TextInputType.text,
                          ),
                        ),
                      ).marginOnly(
                        left: 16,
                        right: 5,
                        bottom: 20,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_.message.text.isEmpty) {
                          CommonToast.showToast(
                              title: "Type Something", isWarning: true);
                        } else {
                          _.sendmessage();
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(left: 10, bottom: 15),
                        child: Icon(
                          Icons.send,
                          size: 30,
                          color: AppColors.commonColor,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        }
      },
    );
  }

  Widget messagebody(BuildContext context, ChatController _) {
    return ListView.builder(
      shrinkWrap: true,
      reverse: true,
      itemCount: _.messagelist.length,
      itemBuilder: (c, i) {
        return ChatUi(
          onPressed: () {
            _.messagelist[i]['senderid'] == _.userId.text
                ? showDialog(
                    context: context,
                    barrierDismissible: true, // user must tap button!
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        title: const Text(
                          'Delete?',
                          textScaleFactor: 1.0,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            letterSpacing: 0.4,
                            fontFamily: 'Roboto',
                          ),
                        ),
                        content: SizedBox(
                          height: 100.0,
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Are you sure you want to delete this message?',
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                    letterSpacing: 0.4,
                                    fontFamily: 'Roboto'),
                              ),
                              const Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  MaterialButton(
                                    onPressed: () async {
                                      Get.back();
                                    },
                                    minWidth: Get.width / 3.5,
                                    height: 38,
                                    child: const Text(
                                      "CANCEL",
                                      textScaleFactor: 1.0,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  MaterialButton(
                                    // color: CommonColor.greenColorWithOpacity,
                                    shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                          color: AppColors.commonColor,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(9.0)),
                                    onPressed: () {
                                      _.deleteChat(_.messagelist[i]['docid']);
                                      Get.back();
                                      CommonToast.showToast(
                                          title: "Message Deleted Successfully",
                                          isWarning: false);
                                    },
                                    minWidth: Get.width / 3.5,
                                    height: 38,
                                    child: const Text(
                                      "Delete",
                                      textScaleFactor: 1.0,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                // ignore: avoid_print
                : print("object");
          },
          names: _.getInitials('${_.messagelist[i]['senderFirstName']}'
              '${_.messagelist[i]['senderLastName']}'),
          firstName: '${_.messagelist[i]['senderFirstName']}',
          lastName: '${_.messagelist[i]['senderLastName']}',
          time: _.getMessageTime('${_.messagelist[i]['createdAt']}'),
          delivered: true,
          seen: false,
          text: '${_.messagelist[i]['message']}',
          isSender:
              _.messagelist[i]['senderid'] == _.userId.text ? true : false,
          color: _.messagelist[i]['senderid'] == _.userId.text
              ? AppColors.commonColor
              : const Color(0xffDCDCDC),
          sent: true,
        );
      },
    );
  }
}
