// import 'package:crypto/controllers/search/search_screen_controller.dart';
// import 'package:crypto/utils/app_libraries.dart';

// class SearchEventsScreen extends StatelessWidget {
//   const SearchEventsScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<SearchEventsController>(
//         init: SearchEventsController(),
//         builder: (_) {
//           return CommonScaffold(
//             showAppBar: true,
//             appbarTitle: _.search,
//             extendBodyBehindAppBar: false,
//             appbarcolor: Colors.transparent,
//             appbarelevation: 0.0,
//             bodyData: bodyData(context, _),
//           );
//         });
//   }

//   // --------------------- Main part of the class ----------------------
//   Widget bodyData(BuildContext context, SearchEventsController _) {
//     return _.isLoading
//         ? Center(
//             child: Image.asset(
//               "assets/images/GIF.gif",
//               height: 125.0,
//               width: 125.0,
//             ),
//           )
//         : SafeArea(
//             child: eventview(context, _),
//           );
//   }

// // ----------------------- event view container -----------------------------------
//   Widget eventview(BuildContext context, SearchEventsController _) {
//     return GridView.builder(
//       itemCount: _.searchEventList.length,
//       scrollDirection: Axis.vertical,
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           childAspectRatio: MediaQuery.of(context).size.width /
//               (MediaQuery.of(context).size.height / 1.31),
//           crossAxisCount: 2,
//           crossAxisSpacing: 0.0,
//           mainAxisSpacing: 10.0),
//       padding: const EdgeInsets.all(0),
//       shrinkWrap: true,
//       primary: true,
//       physics: const ScrollPhysics(),
//       itemBuilder: (c, i) {
//         return Column(children: [
          
//         ],);
//       },
//     );
//   }
// }
