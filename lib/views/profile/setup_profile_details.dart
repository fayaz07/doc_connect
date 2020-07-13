import 'package:doc_connect/utils/constants.dart';
import 'package:doc_connect/views/profile/profile_view_model.dart';
import 'package:doc_connect/widgets/buttons.dart';
import 'package:doc_connect/widgets/text_fields.dart';
import 'package:doc_connect/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:stacked/stacked.dart';

class SetupProfileDetails extends StatelessWidget {
  final padding = EdgeInsets.only(top: 8.0, bottom: 8.0);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      onModelReady: (m) => m.init(context),
      builder: (context, model, child) => PlatformScaffold(
        body: SafeArea(child: _getBody(model)),
      ),
    );
  }

  Widget _getBody(ProfileViewModel model) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: model.formKey,
          child: SingleChildScrollView(
            child: Column(
              key: Key('personal-details'),
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TitleText(
                  title: 'Please tell us about yourself to help you better',
                ),
                SizedBox(height: 16.0),

                /// first name
                OutlinedTextField(
                  label: 'First name',
                  hint: 'John',
                  initialValue: model.user.firstName,
                  validateLength: 2,
                  padding: padding,
                  save: (value) => model.user.firstName = value,
                ),

                OutlinedTextField(
                  label: 'Last name',
                  hint: 'Doe',
                  initialValue: model.user.lastName,
                  validateLength: 2,
                  padding: padding,
                  save: (value) => model.user.lastName = value,
                ),

                /// location
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: OutlinedTextField(
                        label: 'Location',
                        hint: 'Hyderabad, India',
                        validateLength: 2,
                        padding: padding,
                        save: (value) => model.user.location = value,
                      ),
                    ),
//                    IconButton(
//                      onPressed: model.fetchLocation,
//                      icon: Icon(Icons.my_location),
//                    ),
                  ],
                ),

                SizedBox(height: 8.0),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Select your gender',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: <Widget>[
                    RadioButton(
                      value: 0,
                      groupValue: model.genderKey,
                      onChanged: model.handleGenderSelection,
                      text: 'Male',
                    ),
                    RadioButton(
                      value: 1,
                      groupValue: model.genderKey,
                      onChanged: model.handleGenderSelection,
                      text: 'Female',
                    ),
                    RadioButton(
                      value: 2,
                      groupValue: model.genderKey,
                      onChanged: model.handleGenderSelection,
                      text: 'Do not wish to say',
                    ),
                  ],
                ),

                OutlinedTextField(
                  label: 'Age',
                  padding: padding,
                  validateLength: 2,
                  save: (value) => model.user.age = int.parse(value),
                ),

                model.user.isDoctor
                    ? _getDoctorDetails(model)
                    : _getPatientDetails(model),

                SizedBox(height: Constants.sixteenBy2),
                AppPlatformButton(
                  text: 'SAVE',
                  width: double.infinity,
                  height: 50.0,
                  borderRadius: 8.0,
                  color: Colors.greenAccent,
                  onPressed: model.validateDetails,
                ),
                SizedBox(height: Constants.sixteenBy2),
              ],
            ),
          ),
        ),
      );

  _getPatientDetails(ProfileViewModel model) {
    return OutlinedTextField(
      label: 'Symptoms',
      padding: padding,
      validateLength: 0,
      save: (value) => model.user.symptoms = value,
    );
  }

  _getDoctorDetails(ProfileViewModel model) {
    return Column(
      children: <Widget>[
        /// speciality
        OutlinedTextField(
          label: 'Speciality',
          validateLength: 2,
          padding: padding,
          save: (value) => model.user.speciality = value,
        ),

        /// availability
        OutlinedTextField(
          label: 'When are you free',
          validateLength: 2,
          padding: padding,
          save: (value) => model.user.availability = value,
        ),
      ],
    );
  }
}
