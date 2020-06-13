import 'package:doc_connect/api/user.dart';
import 'package:doc_connect/data_models/result.dart';
import 'package:doc_connect/data_models/user.dart';
import 'package:doc_connect/providers/auth.dart';
import 'package:doc_connect/providers/user.dart';
import 'package:doc_connect/screens/doctor/doctor_home.dart';
import 'package:doc_connect/screens/patients/patient_home.dart';
import 'package:doc_connect/utils/colors.dart';
import 'package:doc_connect/utils/constants.dart';
import 'package:doc_connect/utils/dialogs/dialogs.dart';
import 'package:doc_connect/utils/labels.dart';
import 'package:doc_connect/utils/widgets/app_bar.dart';
import 'package:doc_connect/utils/widgets/login_signup_widgets.dart';
import 'package:doc_connect/utils/widgets/navigation.dart';
import 'package:doc_connect/utils/widgets/platform_widgets.dart';
import 'package:doc_connect/utils/widgets/text_field_register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ots/ots.dart';
import 'package:provider/provider.dart';

class FillProfile extends StatefulWidget {
  @override
  _FillProfileState createState() => _FillProfileState();
}

class _FillProfileState extends State<FillProfile>
    with SingleTickerProviderStateMixin {
  User user = User();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context).auth;

    user.is_doctor = auth.isDoctor;

    final deviceSize = MediaQuery.of(context).size;
    final userProvider = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: _getAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: _getPersonalDetailsFromUser(deviceSize, userProvider),
        ),
      ),
    );
  }

  var _formKey = GlobalKey<FormState>();

  Widget _getPersonalDetailsFromUser(Size deviceSize, User userProvider) =>
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            key: Key('personal-details'),
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TitleMessage(
                  title: 'Please tell us about yourself to help you better'),
              SizedBox(height: Constants.sixteenBy2),

              /// first name
              WrappedTextFieldWithCard(
                label: 'First name',
                initialValue: userProvider.first_name,
                validateLength: 2,
                save: (value) => user.first_name = value,
              ),
              SizedBox(height: 8.0),

              WrappedTextFieldWithCard(
                label: 'Last name',
                initialValue: userProvider.last_name,
                validateLength: 2,
                save: (value) => user.last_name = value,
              ),

              SizedBox(height: 8.0),

              /// location
              WrappedTextFieldWithCard(
                label: 'Location',
                validateLength: 2,
                save: (value) => user.location = value,
              ),

              user.is_doctor ? _getDoctorDetails() : _getPatientDetails(),

              SizedBox(height: 8.0),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '    Select your gender',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DropdownButton(
                  value: user.gender,
                  items: [
                    DropdownMenuItem(
                      child: Text('Male'),
                      value: 'Male',
                    ),
                    DropdownMenuItem(
                      child: Text('Female'),
                      value: 'Female',
                    ),
                    DropdownMenuItem(
                      child: Text('Prefer not to say'),
                      value: 'Prefer not to say',
                    ),
                  ],
                  onChanged: (String value) {
                    user.gender = value;
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  isExpanded: true,
                ),
              ),

              SizedBox(height: Constants.sixteenBy2),
              EnableDisableButton(
                text: Labels.save,
                onPressed: _createProfile,
                color: AppColors.primary,
                enabled: true,
              ),
            ],
          ),
        ),
      );

  _showModalSheet() async {
    await showLoader(isModal: true);
  }

  _hideModalSheet() async {
    await hideLoader();
  }

  _handleGoBack() {
    Navigator.of(context).pop();
  }

  Widget _getAppBar() => MyAppbar(
        handleGoBack: _handleGoBack,
        title: 'Complete Profile',
      );

  _createProfile() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    await _showModalSheet();
    user.popularity = 0;
    Result result = await UserAPI.saveUserDataForFirstTime(user);
    await _hideModalSheet();
    if (result.success) {
      Provider.of<UserProvider>(context, listen: false).user = result.data;
      if (user.is_doctor)
        Navigator.of(context)
            .pushReplacement(AppNavigation.route(DoctorHome()));
      else
        Navigator.of(context)
            .pushReplacement(AppNavigation.route(PatientHome()));
    } else {
      if (result.message.contains("already")) {
        showDialog(
          context: context,
          builder: (context) => WarningDialog(
            title: 'Oops',
            content: result.message,
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => ErrorDialog(
            title: 'Failed',
            content: result.message,
          ),
        );
      }
    }
  }

  _getPatientDetails() {
    return Column(
      children: <Widget>[
        SizedBox(height: 8.0),

        /// age
        WrappedTextFieldWithCard(
          label: 'Age',
          validateLength: 2,
          save: (value) => user.age = int.parse(value),
        ),

        SizedBox(height: 8.0),

        /// symptoms
        WrappedTextFieldWithCard(
          label: 'Symptoms',
          validateLength: 0,
          save: (value) => user.symptoms = value,
        ),
      ],
    );
  }

  _getDoctorDetails() {
    return Column(
      children: <Widget>[
        SizedBox(height: 8.0),

        /// age
        WrappedTextFieldWithCard(
          label: 'Age',
          validateLength: 2,
          save: (value) => user.age = int.parse(value),
        ),

        SizedBox(height: 8.0),

        /// speciality
        WrappedTextFieldWithCard(
          label: 'Speciality',
          validateLength: 2,
          save: (value) => user.profession = value,
        ),

        SizedBox(height: 8.0),

        /// availability
        WrappedTextFieldWithCard(
          label: 'When are you free',
          validateLength: 2,
          save: (value) => user.availability = value,
        ),
      ],
    );
  }
}
