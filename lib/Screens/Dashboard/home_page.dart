import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:admin_medicall/Providers/auth_provider.dart';
import 'package:admin_medicall/Providers/local_data.dart';
import 'package:admin_medicall/Screens/Dashboard/insights.dart';
import 'package:admin_medicall/Screens/Dashboard/non_live.dart';
import 'package:admin_medicall/Utils/Constants/app_color.dart';
import 'package:admin_medicall/Utils/Constants/spacing.dart';
import 'package:admin_medicall/Utils/Constants/styles.dart';
import 'package:admin_medicall/Utils/primary_tab_buttons.dart';
import 'package:provider/provider.dart';

import 'master_details.dart';

class HomePage extends StatefulWidget {
  final int? tabScreen;
  HomePage({super.key, this.tabScreen});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ValueNotifier<int> _settingsButtonTrigger;

  var eventDetails = GetStorage().read("event_details") != ''
      ? GetStorage().read("event_details")
      : '';

  @override
  void initState() {
    super.initState();
    _settingsButtonTrigger = ValueNotifier(widget.tabScreen ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    // // Accessing eventId from LocalDataProvider
    // final localDataProvider = Provider.of<LocalDataProvider>(context);
    // int eventId = localDataProvider.eventId; // Fetching event ID from provider

    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: AppBar(
        backgroundColor: AppColor.secondary,
        automaticallyImplyLeading: false,
        title: Text(
          'My Events',
          style: AppTextStyles.header1,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: IconButton(
              tooltip: 'Logout',
              onPressed: () {
                AuthenticationProvider().logout();
              },
              icon: Icon(
                Icons.logout_rounded,
                size: 25,
              ),
              color: Colors.white,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              PrimaryTabButton(
                buttonText: "Live",
                itemIndex: 0,
                notifier: _settingsButtonTrigger,
                onTap: () {
                  // Update the local event ID to 54 when "Live" tab is pressed
                  Provider.of<LocalDataProvider>(context, listen: false)
                      .changeEventDetails(eventDetails['currentEventId'],
                          eventDetails['currentAndPreviousEvents'][0]['title']);
                },
              ),
              PrimaryTabButton(
                  buttonText: "Completed",
                  itemIndex: 1,
                  notifier: _settingsButtonTrigger),
              PrimaryTabButton(
                  buttonText: "Upcoming",
                  itemIndex: 2,
                  notifier: _settingsButtonTrigger),
              PrimaryTabButton(
                  buttonText: "Masters",
                  itemIndex: 3,
                  notifier: _settingsButtonTrigger)
            ],
          ),
          AppSpaces.verticalSpace20,
          ValueListenableBuilder(
              valueListenable: _settingsButtonTrigger,
              builder: (BuildContext context, _, __) {
                // Pass the eventId to Insights and NonLiveData widgets
                return _settingsButtonTrigger.value == 0
                    ? Insights() // Pass eventId
                    : _settingsButtonTrigger.value == 1
                        ? NonLiveData(
                            nonLiveEvent: 'Completed',
                          )
                        : _settingsButtonTrigger.value == 2
                            ? NonLiveData(
                                nonLiveEvent: 'Upcoming',
                              )
                            : MasterDetails();
              })
        ]),
      ),
    );
  }
}

// old code
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:admin_medicall/Providers/auth_provider.dart';
// import 'package:admin_medicall/Screens/Dashboard/insights.dart';
// import 'package:admin_medicall/Screens/Dashboard/non_live.dart';
// import 'package:admin_medicall/Utils/Constants/app_color.dart';
// import 'package:admin_medicall/Utils/Constants/spacing.dart';
// import 'package:admin_medicall/Utils/Constants/styles.dart';
// import 'package:admin_medicall/Utils/primary_tab_buttons.dart';
//
// class HomePage extends StatefulWidget {
//   final int? tabScreen;
//   HomePage({super.key, this.tabScreen});
//
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//
//   late final ValueNotifier<int> _settingsButtonTrigger;
//
//   @override
//   void initState() {
//     super.initState();
//     _settingsButtonTrigger = ValueNotifier(widget.tabScreen ?? 0);
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     ScreenUtil.init(context, designSize: Size(375, 812), minTextAdapt: true);
//
//     return Scaffold(
//       backgroundColor: AppColor.bgColor,
//       appBar: AppBar(
//         backgroundColor: AppColor.secondary,
//         automaticallyImplyLeading: false,
//         title: Text(
//           'My Events',
//           style: AppTextStyles.header1,
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(left: 10.0),
//             child: IconButton(
//               tooltip: 'Logout',
//               onPressed: () {
//                 print('5400 logout ---');
//                 AuthenticationProvider().logout();
//               },
//               icon: Icon(
//                 Icons.logout_rounded,
//                 size: 25,
//               ),
//               color: Colors.white,
//             ),
//           )
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               PrimaryTabButton(
//                   buttonText: "Live",
//                   itemIndex: 0,
//                   notifier: _settingsButtonTrigger),
//               PrimaryTabButton(
//                   buttonText: "Completed",
//                   itemIndex: 1,
//                   notifier: _settingsButtonTrigger),
//               PrimaryTabButton(
//                   buttonText: "Upcoming",
//                   itemIndex: 2,
//                   notifier: _settingsButtonTrigger)
//             ],
//           ),
//           AppSpaces.verticalSpace20,
//           ValueListenableBuilder(
//               valueListenable: _settingsButtonTrigger,
//               builder: (BuildContext context, _, __) {
//                 return _settingsButtonTrigger.value == 0
//                     ? Insights()
//                     : _settingsButtonTrigger.value == 1
//                         ? NonLiveData(
//                             nonLiveEvent: 'Completed',
//                           )
//                         : NonLiveData(nonLiveEvent: 'Upcoming');
//               })
//         ]),
//       ),
//     );
//   }
// }
