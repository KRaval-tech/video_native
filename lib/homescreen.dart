import 'package:flutter/material.dart';
import 'package:video_native/show_sheet.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async{
          bool exitApp = await _showRateUsBottomSheet(context);
          return exitApp;
        },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home Screen'),
    centerTitle: true,
        ),
        body: Center(
          child: Text("Press Back Button to see Sheets!!"),
        ),
      ),
    );
  }

  Future<bool> _showRateUsBottomSheet(BuildContext context) async {
    bool exitConfirmed = false;

    await showModalBottomSheet(
        context: context,
        isDismissible: false,
        builder: (context){
          return ShowSheet();
        },
    );

    return exitConfirmed;
  }

}
