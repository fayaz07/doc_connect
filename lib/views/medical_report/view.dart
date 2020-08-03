import 'package:doc_connect/views/medical_report/view_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:stacked/stacked.dart';
import '../../data_models/medical_report.dart';

class ViewMedicalReport extends StatelessWidget {
  final String id;

  const ViewMedicalReport({Key key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ViewMedicalReportViewModel>.reactive(
      viewModelBuilder: () => ViewMedicalReportViewModel(),
      onModelReady: (m) => m.init(context, id),
      builder: (context, model, child) => PlatformScaffold(
        appBar: PlatformAppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Medical report',
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
              color: Colors.black,
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.of(context).pop()),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: model.loading
              ? Center(child: CircularProgressIndicator())
              : model.hasError
                  ? Center(child: Text('Unable to load data'))
                  : _getReport(model),
        ),
      ),
    );
  }

  Widget _getReport(ViewMedicalReportViewModel model) {
    return Scrollbar(
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          MedicalReportChild(
            title: 'Physique',
            content: ' ',
            children: <Widget>[
              HeadingContent(
                title: "Height",
                content: "${model.medicalReport.height} cms",
              ),
              HeadingContent(
                title: "Weight",
                content: "${model.medicalReport.weight} kgs",
              ),
              HeadingContent(
                title: "BMI",
                content: "${model.medicalReport.bmi.toStringAsFixed(2)} kg/m²",
              ),
            ],
          ),
          MedicalReportChild(
            title: 'Blood Group',
            content: ' ',
            children: <Widget>[
              HeadingContent(
                title: "Group",
                content: "${model.medicalReport.bloodGroup.buttonText()}",
              ),
            ],
          ),
          MedicalReportChild(
            title: 'Vision',
            content: ' ',
            children: <Widget>[
              HeadingYesNo(
                title: "Vision defect",
                yes: model.medicalReport.visionDefect,
              ),
              HeadingYesNo(
                title: "Uses spectacles",
                yes: model.medicalReport.spectacles,
              ),
              HeadingYesNo(
                title: "Can see Red",
                yes: model.medicalReport.csRed,
              ),
              HeadingYesNo(
                title: "Can see Blue",
                yes: model.medicalReport.csBlue,
              ),
              HeadingYesNo(
                title: "Can see Green",
                yes: model.medicalReport.csGreen,
              ),
              HeadingYesNo(
                title: "Can see Text of size 8px",
                yes: model.medicalReport.cs8,
              ),
              HeadingYesNo(
                title: "Can see Text of size 12px",
                yes: model.medicalReport.cs12,
              ),
              HeadingYesNo(
                title: "Can see Text of size 16px",
                yes: model.medicalReport.cs16,
              ),
              HeadingYesNo(
                title: "Can see Text of size 20px",
                yes: model.medicalReport.cs20,
              ),
              HeadingYesNo(
                title: "Can see Text of size 24px",
                yes: model.medicalReport.cs24,
              ),
            ],
          ),
          MedicalReportChild(
            title: 'Hearing',
            content: ' ',
            children: <Widget>[
              HeadingYesNo(
                title: "Has hearing issues",
                yes: model.medicalReport.hearingIssues,
              ),
              HeadingYesNo(
                title: "Has hearing Aids",
                yes: model.medicalReport.hearingAids,
              ),
            ],
          ),
          MedicalReportChild(
            title: 'Physical deformity',
            content: ' ',
            children: <Widget>[
              HeadingYesNo(
                title: "Has physical disability",
                yes: model.medicalReport.physicalDisability,
              ),
              HeadingYesNo(
                title: "Uses mechanical assistance",
                yes: model.medicalReport.mechanicalAssistance,
              ),
            ],
          ),
          MedicalReportChild(
            title: 'Birth disease',
            content: ' ',
            children: <Widget>[
              HeadingYesNo(
                title: "Has congenital disorder",
                yes: model.medicalReport.congenitalDisorder,
              ),
            ],
          ),
          MedicalReportChild(
            title: 'Psychiatric issues',
            content: ' ',
            children: <Widget>[
              HeadingYesNo(
                title: "Has psychiatric issues",
                yes: model.medicalReport.psychiatricIssues,
              ),
            ],
          ),
          MedicalReportChild(
            title: 'Surgeries',
            content: ' ',
            children: <Widget>[
              HeadingYesNo(
                title: "Had any Surgeries",
                yes: model.medicalReport.hadSurgeries,
              ),
            ],
          ),
          MedicalReportChild(
            title: 'Alcohol & Smoking',
            content: ' ',
            children: <Widget>[
              HeadingYesNo(
                title: "Consume alcohol",
                yes: model.medicalReport.alcohol,
              ),
              HeadingYesNo(
                title: "Smokes",
                yes: model.medicalReport.smoke,
              ),
            ],
          ),
          MedicalReportChild(
            title: 'Sugar',
            content: ' ',
            children: <Widget>[
              HeadingYesNo(
                title: "Has sugar",
                yes: model.medicalReport.sugar,
              ),
              HeadingContent(
                title: 'No. of years as a sugar patient',
                content: model.medicalReport.yearsSugar == null
                    ? "0 years"
                    : "${model.medicalReport.yearsSugar} years",
              )
            ],
          ),
          MedicalReportChild(
            title: 'BP',
            content: ' ',
            children: <Widget>[
              HeadingYesNo(
                title: "High/low bp",
                yes: model.medicalReport.bp,
              ),
            ],
          ),
          MedicalReportChild(
            title: 'Cancer',
            content: ' ',
            children: <Widget>[
              HeadingYesNo(
                title: "Has cancer",
                yes: model.medicalReport.cancer,
              ),
            ],
          ),
          MedicalReportChild(
            title: 'Heart Diseases',
            content: ' ',
            children: <Widget>[
              HeadingYesNo(
                title: "Has heart diseases",
                yes: model.medicalReport.heartDiseases,
              ),
            ],
          ),
          MedicalReportChild(
            title: 'Tumour',
            content: ' ',
            children: <Widget>[
              HeadingYesNo(
                title: "Has any tumours",
                yes: model.medicalReport.tumour,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class HeadingYesNo extends StatelessWidget {
  final String title;
  final bool yes;

  const HeadingYesNo({Key key, this.title, this.yes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              title,
              style: TextStyle(color: Colors.black, fontSize: 18.0),
            ),
          ),
          SizedBox(width: 4.0),
          Text(
            yes ? "Yes" : "No",
            style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

class HeadingContent extends StatelessWidget {
  final String title, content;

  const HeadingContent({Key key, this.title, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            title,
            style: TextStyle(color: Colors.black, fontSize: 18.0),
          ),
        ),
        SizedBox(width: 4.0),
        Text(
          content,
          style: TextStyle(
              color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}

class MedicalReportChild extends StatelessWidget {
  final String title, content;
  final List<Widget> children;

  const MedicalReportChild({Key key, this.title, this.content, this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        content.length > 1
            ? Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      content,
                      style: TextStyle(color: Colors.black, fontSize: 18.0),
                    ),
                  ),
                ],
              )
            : SizedBox(),
      ]
        ..addAll(children)
        ..add(SizedBox(height: 16.0)),
    );
  }
}
