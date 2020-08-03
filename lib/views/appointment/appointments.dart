import 'package:doc_connect/data_models/appointment.dart';
import 'package:doc_connect/views/appointment/appointment_detailed_view_model.dart';
import 'package:doc_connect/views/appointment/appointments_view_model.dart';
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
        appBar: PlatformAppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Your appointments',
            style: TextStyle(color: Colors.black),
          ),
          material: (context, target) => MaterialAppBarData(centerTitle: true),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: model.loading
              ? Center(child: CircularProgressIndicator())
              : model.hasError
                  ? Center(
                      child: Text('Unable to load data'),
                    )
                  : model.appointments.length == 0
                      ? Center(
                          child: Text('Nothing scheduled'),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(8.0),
                          itemCount: model.appointments.length,
                          itemBuilder: (context, i) =>
                              _appointmentWidget(model.appointments[i], model),
                        ),
        ),
      ),
    );
  }

  Widget _appointmentWidget(
      Appointment appointment, AppointmentsViewModel model) {
    return InkWell(
      onTap: () => model.appointmentTap(appointment),
      child: AppointmentWidget(
        appointment: appointment,
        isCurrentUserADoctor: model.user?.isDoctor ?? false,
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
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
                    "${appointment.endUser.firstName + " " +
                    appointment.endUser.lastName}")
                : Text(
                "${appointment.offered ? 'Offered by: ' : 'Requested to: '} "
                    "${appointment.endUser.firstName + " " +
                    appointment.endUser.lastName}"),
            SizedBox(height: 4.0),
            Text(
                "Status: ${AppointmentDetailedViewModel.getStatus(
                    isCurrentUserADoctor, appointment)}"),
          ],
        ),
      ),
    );
  }
}
