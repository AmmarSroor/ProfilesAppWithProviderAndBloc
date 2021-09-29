import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import 'package:profiles_app/blocs/events/accountCubit.dart';
import 'package:profiles_app/classes/profileClass.dart';
import 'package:profiles_app/widgets/customText.dart';

class ViewProfile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ProfileData? _profileData = BlocProvider.of<AccountCubit>(context)
        .getProfileDate();

    return Center(
      child: Container(
        child: Column(
          children: [
            CircleAvatar(
              child: Image.file(
                File(
                  _profileData!.imageUrl),
                  fit: BoxFit.cover,
                  errorBuilder:(BuildContext context, Object error, StackTrace? stackTrace) {
                    return Icon(Icons.person,size: 80);
                  },
              ),
              radius: 40,
            ),
            CustomText(title: "Name:",
                value: _profileData.firstName + ' ' + _profileData.lastName),
            CustomText(title: "Email:", value: _profileData.email),
            CustomText(title: "Phone:", value: _profileData.phone),
            CustomText(title: "Name:", value: _profileData.firstName),
          ],
        ),
      ),
    );
  }
}
