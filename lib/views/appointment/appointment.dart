import 'package:doc_connect/data_models/appointment.dart';
import 'package:doc_connect/views/appointment/appointment_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:stacked/stacked.dart';

class AppointmentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AppointmentsViewModel>.reactive(
      onModelReady: (m) => m.init(context),
      viewModelBuilder: () => AppointmentsViewModel(),
      builder: (context, model, child) => PlatformScaffold(
        body: SafeArea(
          child: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: model.appointments.length,
            itemBuilder: (context, i) => AppointmentWidget(
              appointment: model.appointments[i],
              isCurrentUserADoctor: model.user?.isDoctor ?? false,
            ),
          ),
        ),
      ),
    );
  }
}

class AppointmentWidget extends StatelessWidget {
  final Appointment appointment;
  final bool isCurrentUserADoctor;

  const AppointmentWidget(
      {Key key, this.appointment, this.isCurrentUserADoctor = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '${appointment.problem}',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4.0),
            isCurrentUserADoctor
                ? Text(
                    "${appointment.offered ? 'Offered to: ' : 'Requested by: '} "
                    "${appointment.endUser.firstName + " " + appointment.endUser.lastName}")
                : Text(
                    "${appointment.offered ? 'Offered by: ' : 'Requested to: '} "
                    "${appointment.endUser.firstName + " " + appointment.endUser.lastName}"),
            SizedBox(height: 4.0),
            Text("Status: ${_getStatus()}"),
          ],
        ),
      ),
    );
  }

  String _getStatus() {
    // if the user is a doctor
    if (isCurrentUserADoctor) {
      // if doctor offered the appointment
      if (appointment.offered) {
        if (appointment.offerAccepted) {
          return "Patient accepted the offer";
        }
        if (appointment.offerRejected) {
          return "Patient rejected the offer";
        }
        return "Patient didn\'t respond";
      }

      // patient has requested the doctor
      if (appointment.requestAccepted) {
        return "You accepted the request";
      }

      if (appointment.requestRejected) {
        return "You rejected the request";
      }
      return "You didn\t respond";
    }

    // if the user is patient
    if (appointment.offered) {
      if (appointment.offerAccepted) {
        return "You accepted the offer";
      }
      if (appointment.offerRejected) {
        return "You rejected the offer";
      }
      return "You didn\'t respond to the offer";
    }

    if (appointment.requestAccepted) {
      return "You request was accepted by the doctor";
    }

    if (appointment.requestRejected) {
      return "You request was rejected by the doctor";
    }

    return "Doctor didn\'t respond to your offer";
  }
}
