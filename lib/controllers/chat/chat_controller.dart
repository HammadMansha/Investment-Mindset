import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:investment_mindset/utils/app_libraries.dart';

class ChatController extends GetxController {
  bool isLoading = true;

  final chatgroup = FirebaseFirestore.instance.collection("ChatGroup");

  TextEditingController message = TextEditingController();

  TextEditingController firstName = TextEditingController();

  TextEditingController lastName = TextEditingController();

  TextEditingController userId = TextEditingController();

  final storage = GetStorage();

  List messagelist = [];

  @override
  void onReady() async {
    firstName.text = await storage.read('firstname');
    lastName.text = await storage.read('lastname');
    userId.text = await storage.read('id');

    isLoading = false;
    update();
    super.onReady();
  }

  @override
  void onInit() {
    getMessage();
    super.onInit();
  }

  @override
  // ignore: unnecessary_overrides
  void onClose() {
    super.onClose();
  }

  Future<void> getMessage() async {
    Stream<QuerySnapshot> streambodytarget =
        chatgroup.orderBy("createdAt", descending: true).snapshots();
    await streambodytarget.forEach((e) {
      messagelist.clear();
      for (var value in e.docs) {
        if (kDebugMode) {
          print(value.data());
        }
        messagelist.add(value.data());
      }
      update();
    }).catchError((e) {
      if (kDebugMode) {
        print(e);
      }
    });
  }

  deleteChat(String docid) {
    chatgroup.where("docid", isEqualTo: docid).get().then((value) {
      // ignore: avoid_function_literals_in_foreach_calls
      value.docs.forEach((element) {
        chatgroup.doc(element.id).delete().then((value) {
          if (kDebugMode) {
            print("Success!");
          }
        });
      });
    });
  }

  String getMessageTime(String time) {
    final DateTime myDate = DateTime.parse(time);
    final int hour = myDate.hour;
    final int minute = myDate.minute;

    return "${hour.toString()}:${minute.toString()}";
  }

  String getInitials(String bankAccountName) => bankAccountName.isNotEmpty
      ? bankAccountName
          .trim()
          .split(RegExp(' +'))
          .map((s) => s[0])
          .take(2)
          .join()
      : '';

  Future<void> sendmessage() async {
    var c = chatgroup.doc();
    var docset = await c.get();
    await c.set({
      "senderid": userId.text,
      "type": "text",
      "message": message.text,
      "senderFirstName": firstName.text,
      "senderLastName": lastName.text,
      "sent": true,
      "docid": docset.reference.id,
      "createdAt": DateTime.now().toString(),
    }).then((value) {
      message.clear();
    });
  }
}
