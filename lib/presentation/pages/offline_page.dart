import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OfflinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "No Internet Connection",
          style: TextStyle(fontSize: 22.sp, color: Colors.white),
        ),
        automaticallyImplyLeading: false, // Disable the back button
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.signal_wifi_off, size: 100.w, color: Colors.redAccent),
            SizedBox(height: 20.h),
            Text(
              "You are offline",
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 10.h),
            Text(
              "Please check your internet connection",
              style: TextStyle(fontSize: 16.sp, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: () {
                // Optionally add a refresh function
              },
              child: Text("Try Again", style: TextStyle(fontSize: 18.sp)),
            ),
          ],
        ),
      ),
    );
  }
}