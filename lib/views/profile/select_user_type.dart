import 'package:doc_connect/views/profile/profile_view_model.dart';
import 'package:doc_connect/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:stacked/stacked.dart';

class SelectUserType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      onModelReady: (m) => m.init(context),
      builder: (context, model, child) => PlatformScaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Choose what you are',
                style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 8.0),
              Text(
                'I am a',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 16.0),
              _getButtons(model),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getButtons(ProfileViewModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        PictureButton(
          image: 'assets/doctor.png',
          onPressed: () => model.selectDoctor(true),
          text: 'Doctor',
        ),
        PictureButton(
          image: 'assets/patient.png',
          onPressed: () => model.selectDoctor(false),
          text: 'Patient',
        ),
      ],
    );
  }
}
