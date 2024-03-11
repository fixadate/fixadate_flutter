import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widget/w_preivous.dart';

class ThirdSignUpScreen extends StatefulWidget {
  const ThirdSignUpScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ThirdSignUpScreenState();


}

class _ThirdSignUpScreenState extends State<ThirdSignUpScreen>{
  XFile? _profileImg;
  AssetImage _defaultProfileImage = AssetImage('assets/default_profile_image.png');
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _profileImg = pickedFile!;
      _defaultProfileImage = _profileImg as AssetImage;
    });
  }

  Future<String> _getPresignedUrl() async {
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 30.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 120),
              PreviousPageArrow(),
              // CustomProfileTitleText(),
              SizedBox(height: 30),
              CircleAvatar(
                radius: 62,
                // backgroundColor: ProfileImageBorderColor,
                child: GestureDetector(
                  onTap: () {
                    print("wokring fineeee");
                    _pickImage();
                    _getPresignedUrl();

                  },
                  child: CircleAvatar(
                      radius: 58,
                      backgroundImage: _defaultProfileImage
                  ),
                ),

              ),
            ],
          ),
        ),
      ),
    );
  }

}