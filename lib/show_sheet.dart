import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_native/native_video.dart';

class ShowSheet extends StatefulWidget {
  @override
  State<ShowSheet> createState() => _ShowSheetState();
}

class _ShowSheetState extends State<ShowSheet> {
  bool? hasRated;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkIfUserHasRated();
  }

  Future<void> _checkIfUserHasRated() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? rated = prefs.getBool('hasRated');
    setState(() {
      hasRated = rated ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text("Bottom Sheet Example")),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              if(hasRated == false){
                // Show the rating bottom sheet if the user has not rated
                showRatingBottomSheet(context);
              }
            },
            child: Text("Show Bottom Sheet"),
          ),
        ),
      ),
    );
  }
}

void showRatingBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
    ),
    builder: (context) {
      return RatingBottomSheet();
    },
  );
}

class RatingBottomSheet extends StatefulWidget {
  @override
  State<RatingBottomSheet> createState() => _RatingBottomSheetState();
}

class _RatingBottomSheetState extends State<RatingBottomSheet> {
  int selectedRating = 0;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Close Button
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          // "Rate Us" Image
          Image.asset("assets/rate_us.jpg", height: 100),

          // Title
          Text(
            "Rating App...?",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),

          // Subtitle
          Text(
            "Do you like our app?",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          SizedBox(height: 12),

          // Star Rating Row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              5,
                (index) => IconButton(
                    onPressed: (){
                      setState(() {
                        selectedRating = index + 1;
                      });
                    },
                    icon: Icon(
                      Icons.star,
                      color: index < selectedRating ? Colors.orange : Colors.grey,
                      size: 32,
                    ),
                ),
            ),
          ),
          SizedBox(height: 16),

          // Yes/No Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  if(selectedRating > 0){
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setBool('hasRated', true);
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: BorderSide(color: Colors.blue),
                ),
                child: Text("No", style: TextStyle(color: Colors.blue)),
              ),
              SizedBox(width: 16),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: Text("Yes", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
          SizedBox(height: 16),

          // Native Ad Section
          NativeVideoAdWidget(),
        ],
      ),
    );
  }
}
