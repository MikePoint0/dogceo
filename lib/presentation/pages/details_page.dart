import 'package:dogceo/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/services/dog_api_service.dart';

class DetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // getting the breed and subBreed from the arguments
    final Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String breed = args['breed'];
    final String? subBreed = args['subBreed'];

    // API path based on whether the sub-breed exists
    final String apiPath = subBreed != null ? '$breed/$subBreed' : breed;

    return Scaffold(
      appBar: AppBar(
        title: Text(
        capitalizeWords(breed),
          style: TextStyle(
            fontSize: 22.sp,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        iconTheme: IconThemeData(
          color: Colors.white, // Change the back arrow color here
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: FutureBuilder<String>(
          future: context.read<DogApiService>().fetchRandomImage(apiPath),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Error: ${snapshot.error}",
                  style: TextStyle(fontSize: 16.sp, color: Colors.red),
                ),
              );
            } else if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: Image.network(
                      snapshot.data!,
                      height: 300.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Breed: ${capitalizeWords(breed)}",
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  if (subBreed != null)
                    Text(
                      "Sub-breed: ${capitalizeWords(subBreed)}",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                      ),
                    ),
                  SizedBox(height: 10.h),
                  Text(
                    "Here is a random image of the $breed ${subBreed != null ? '(${capitalizeWords(subBreed)})' : ''} breed. If you want to see more, try exploring the Dog CEO API!",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.grey[700],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}