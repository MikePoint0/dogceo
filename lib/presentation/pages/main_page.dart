import 'package:dogceo/presentation/bloc/dog_state.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:connectivity_plus/connectivity_plus.dart'; // Import connectivity package
import '../bloc/dog_bloc.dart';
import 'offline_page.dart'; // Import the OfflinePage
import 'dart:async'; // Import for StreamSubscription

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int? _currentExpandedIndex; // Store the currently expanded accordion index
  DateTime? _lastPressedAt; // Track the last back button press
  late Connectivity _connectivity; // Connectivity instance
  late StreamSubscription<List<ConnectivityResult>>
      _subscription; // Correct type for subscription

  @override
  void initState() {
    super.initState();
    _connectivity = Connectivity();

    // Listen for network changes and update based on connectivity result
    _subscription = _connectivity.onConnectivityChanged
        .listen((List<ConnectivityResult> results) {
      if (results.contains(ConnectivityResult.none)) {
        // If no connection, navigate to the offline page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OfflinePage()),
        );
      }
    });
  }

  @override
  void dispose() {
    _subscription.cancel(); // Cancel the subscription when the page is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final now = DateTime.now();
        final maxDuration = Duration(seconds: 2);
        final isExitWarning = _lastPressedAt == null ||
            now.difference(_lastPressedAt!) > maxDuration;

        if (isExitWarning) {
          _lastPressedAt = now;
          Fluttertoast.showToast(
            msg: "Press back again to exit",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
          return false; // Don't exit the app yet
        }
        return true; // Exit the app
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Dog Breeds",
            style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          backgroundColor: Colors.deepPurple,
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: BlocBuilder<DogBloc, DogState>(
            builder: (context, state) {
              if (state is DogLoadingState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is DogLoadedState) {
                return ListView.builder(
                  itemCount: state.breeds.length,
                  itemBuilder: (context, index) {
                    final breed = state.breeds[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 3,
                      margin: EdgeInsets.only(bottom: 10.h),
                      child: ExpansionTile(
                        title: Text(
                          breed.breed,
                          style: TextStyle(
                              fontSize: 18.sp, fontWeight: FontWeight.w600,
                          color: breed.subBreeds.isNotEmpty ? Colors.deepPurple: Colors.red),
                        ),
                        // trailing: breed.subBreeds.isNotEmpty
                        //     ? Icon(Icons.arrow_drop_down) // Indicator for breeds with content
                        //     : null, // No indicator if there's no sub-breeds
                        initiallyExpanded: _currentExpandedIndex ==
                            index, // Managing the expanded state
                        onExpansionChanged: (bool expanded) {
                          setState(() {
                            if (expanded) {
                              _currentExpandedIndex =
                                  index; // Expand the selected accordion
                            } else {
                              _currentExpandedIndex =
                                  null; // Close if none is selected
                            }
                          });
                        },
                        children: breed.subBreeds.isEmpty
                            ? [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text("No sub-breeds",
                                      style: TextStyle(fontSize: 14.sp)),
                                ),
                              ]
                            : breed.subBreeds.map((subBreed) {
                                return ListTile(
                                  title: Text(
                                    subBreed,
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.deepPurple),
                                  ),
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/details',
                                      arguments: {
                                        'breed': breed.breed,
                                        'subBreed': subBreed.isNotEmpty
                                            ? subBreed
                                            : null
                                      },
                                    );
                                  },
                                );
                              }).toList(),
                      ),
                    );
                  },
                );
              } else if (state is DogErrorState) {
                return Center(
                  child: Text(
                    "Failed to load dog breeds. Please try again later.",
                    style: TextStyle(fontSize: 16.sp, color: Colors.red),
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
