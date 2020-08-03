import 'package:doc_connect/utils/colors.dart';
import 'package:doc_connect/views/appointment/appointment_detailed_view_model.dart';
import 'package:doc_connect/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:stacked/stacked.dart';
import '../../utils/validators.dart';

class AppointmentDetailed extends StatelessWidget {
  final String appointmentId;

  const AppointmentDetailed({Key key, this.appointmentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AppointmentDetailedViewModel>.reactive(
      viewModelBuilder: () => AppointmentDetailedViewModel(),
      onModelReady: (m) => m.init(context, appointmentId),
      builder: (context, model, child) => PlatformScaffold(
        appBar: PlatformAppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Appointment detailed',
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.black,
            onPressed: model.pop,
          ),
        ),
        backgroundColor: Colors.white,
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          children: <Widget>[
            ListTile(
              title: Text("Problem"),
              subtitle: Text("${model.appointment.problem}"),
            ),
            ListTile(
              title: Text("Problem Description"),
              subtitle: Text("${model.appointment.problemDescription}"),
            ),
            ListTile(
              title: Text("Status"),
              subtitle: Text(
                  "${AppointmentDetailedViewModel.getStatus(model.currentUser.isDoctor, model.appointment)}"),
            ),
            ListTile(
              title: Text("Pre medical report"),
              subtitle: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                        "${model.appointment.preMedicalReport.isNull() ? "Not submitted" : "Submitted"}"),
                  ),
                  SizedBox(width: 8.0),
                  model.appointment.preMedicalReport.isNull()
                      ? !model.currentUser.isDoctor
                          ? FlatButton(
                              onPressed: model.submitReport,
                              child: Text('Submit report'))
                          : SizedBox()
                      : FlatButton(
                          onPressed: model.viewMedicalReport,
                          child: Text('View'))
                ],
              ),
            ),
            ListTile(
              title: Text('Scheduled date'),
              subtitle: model.appointment.scheduledDate == null
                  ? Row(
                      children: <Widget>[
                        Expanded(child: Text('Not scheduled')),
                        FlatButton(
                          onPressed: model.changeDate,
                          child: Text('Pick date'),
                        )
                      ],
                    )
                  : Row(
                      children: <Widget>[
                        Expanded(
                            child: Text(
                                '${Helpers.generalizedDate(model.appointment.scheduledDate)}')),
                        FlatButton(
                            onPressed: model.changeDate,
                            child: Text('Change date'))
                      ],
                    ),
            ),
            model.appointment.cancelledByDoctor ||
                    model.appointment.cancelledByPatient
                ? Text(
                    'No further actions can take place as appointment is cancelled')
                : model.appointment.offered
                    ? model.currentUser.isDoctor
                        // you offered the appointment, so you can reject the offer
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                title: Text("Offered to"),
                                subtitle: Text(
                                    model.appointment.endUser.firstName +
                                        " " +
                                        model.appointment.endUser.lastName),
                              ),
                              !model.appointment.offerAccepted &&
                                      !model.appointment.cancelledByPatient &&
                                      !model.appointment.cancelledByDoctor
                                  ? AppPlatformButton(
                                      height: 45.0,
                                      width: double.infinity,
                                      text: 'Cancel appointment',
                                      onPressed: model.cancelAppointment,
                                      borderRadius: 8.0,
                                      color: Colors.red,
                                    )
                                  : SizedBox()
                            ],
                          )
                        //  appointment was offered to you
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                title: Text("Offered by"),
                                subtitle: Text(
                                    model.appointment.endUser.firstName +
                                        " " +
                                        model.appointment.endUser.lastName),
                              ),
                              !model.appointment.offerRejected &&
                                      !model.appointment.offerAccepted
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Expanded(
                                          flex: 2,
                                          child: AppPlatformButton(
                                            height: 45.0,
                                            width: double.infinity,
                                            text: 'Reject',
                                            onPressed: model.rejectOffer,
                                            borderRadius: 8.0,
                                            color: Colors.red,
                                          ),
                                        ),
                                        SizedBox(width: 8.0),
                                        Expanded(
                                          flex: 2,
                                          child: AppPlatformButton(
                                            height: 45.0,
                                            width: double.infinity,
                                            text: 'Accept',
                                            onPressed: model.acceptOffer,
                                            borderRadius: 8.0,
                                            color: AppColors.green,
                                          ),
                                        ),
                                      ],
                                    )
                                  : SizedBox()
                            ],
                          )
                    : model.currentUser.isDoctor
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                title: Text("Requested by"),
                                subtitle: Text(
                                    model.appointment.endUser.firstName +
                                        " " +
                                        model.appointment.endUser.lastName),
                              ),
                              !model.appointment.requestRejected &&
                                      !model.appointment.requestAccepted
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Expanded(
                                          flex: 2,
                                          child: AppPlatformButton(
                                            height: 45.0,
                                            width: double.infinity,
                                            text: 'Reject',
                                            onPressed: model.rejectRequest,
                                            borderRadius: 8.0,
                                            color: Colors.red,
                                          ),
                                        ),
                                        SizedBox(width: 8.0),
                                        Expanded(
                                          flex: 2,
                                          child: AppPlatformButton(
                                            height: 45.0,
                                            width: double.infinity,
                                            text: 'Accept',
                                            onPressed: model.acceptRequest,
                                            borderRadius: 8.0,
                                            color: AppColors.green,
                                          ),
                                        ),
                                      ],
                                    )
                                  : SizedBox()
                            ],
                          )
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                title: Text("Requested to"),
                                subtitle: Text(
                                    model.appointment.endUser.firstName +
                                        " " +
                                        model.appointment.endUser.lastName),
                              ),
                              !model.appointment.requestAccepted &&
                                      !model.appointment.cancelledByPatient &&
                                      !model.appointment.cancelledByDoctor
                                  ? AppPlatformButton(
                                      height: 45.0,
                                      width: double.infinity,
                                      text: 'Cancel request and appointment',
                                      onPressed: model.cancelAppointment,
                                      borderRadius: 8.0,
                                      color: Colors.red,
                                    )
                                  : SizedBox()
                            ],
                          )
          ],
        ),
      ),
    );
  }
}
