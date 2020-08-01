import 'package:doc_connect/data_models/user.dart';
import 'package:doc_connect/views/appointment/new_appointment_view_model.dart';
import 'package:doc_connect/widgets/buttons.dart';
import 'package:doc_connect/widgets/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:stacked/stacked.dart';
import '../../utils/validators.dart';

class NewAppointmentScreen extends StatelessWidget {
  final User guestUser;

  const NewAppointmentScreen({Key key, this.guestUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NewAppointViewModel>.reactive(
      viewModelBuilder: () => NewAppointViewModel(),
      onModelReady: (m) => m.init(context),
      builder: (context, model, child) => PlatformScaffold(
        appBar: PlatformAppBar(
          backgroundColor: Colors.white,
          title: Text(
            '${guestUser.isDoctor ? "Request appointment" : "Offer appointment"}',
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.black,
            onPressed: model.pop,
          ),
        ),
        body: SafeArea(
          child: _getForm(model),
        ),
      ),
    );
  }

  Widget _getForm(NewAppointViewModel model) {
    final padding = EdgeInsets.symmetric(vertical: 8.0);
    return Form(
      key: model.formKey,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
        children: <Widget>[
          Text(
            'Fill out the details below to ${guestUser.isDoctor ? "Request" : "Offer"} an appointment',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 16.0),
          OutlinedTextField(
            initialValue:
                guestUser.symptoms.isNull() ? null : guestUser.symptoms,
            label: 'Problem',
            hint: 'Why appointment',
            padding: padding,
            maxLength: 128,
            validateLength: 3,
            save: (s) => model.appointment.problem = s,
          ),
          OutlinedTextField(
            label: 'Problem detailed',
            hint: 'Briefly explain the problem',
            maxLines: 5,
            maxLength: 1024,
            padding: padding,
            contentPadding: const EdgeInsets.all(16.0),
            validator: (s) => s != null && s.length > 50
                ? null
                : "Description must be at-least 50 characters long",
            save: (s) => model.appointment.problemDescription = s,
          ),
          SizedBox(height: 32.0),
          AppPlatformButton(
            height: 45.0,
            width: double.infinity,
            borderRadius: 32.0,
            text: '${guestUser.isDoctor ? "Request" : "Offer"}',
            onPressed: () => model.validateForm(guestUser),
          )
        ],
      ),
    );
  }
}
