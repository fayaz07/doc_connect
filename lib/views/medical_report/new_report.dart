import 'package:doc_connect/data_models/medical_report.dart';
import 'package:doc_connect/utils/assets.dart';
import 'package:doc_connect/views/medical_report/new_report_view_model.dart';
import 'package:doc_connect/widgets/buttons.dart';
import 'package:doc_connect/widgets/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:stacked/stacked.dart';

class NewMedicalReport extends StatelessWidget {
  final String appointmentId;

  const NewMedicalReport({Key key, this.appointmentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ViewModelBuilder<NewMedicalReportViewModel>.reactive(
      viewModelBuilder: () => NewMedicalReportViewModel(),
      onModelReady: (m) => m.init(context, appointmentId),
      builder: (BuildContext context, NewMedicalReportViewModel model,
              Widget child) =>
          PlatformScaffold(
        backgroundColor: Colors.white,
        appBar: PlatformAppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: model.handleBack,
          ),
          title: Text(
            'Fitness',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          material: (context, target) => MaterialAppBarData(elevation: 0.0),
        ),
        body: Stack(
          children: <Widget>[
            PageView(
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              controller: model.pageController,
              allowImplicitScrolling: false,
              onPageChanged: (int currentPage) {
                model.currentPage = currentPage;
              },
              children: _getChildren(model, context),
            ),
            Positioned(
              bottom: 16.0,
              left: 16.0,
              right: 16.0,
              child: AppPlatformButton(
                text: 'CONTINUE',
                width: size.width,
                height: 50.0,
                onPressed: model.handleNext,
                color: Colors.blue,
                borderRadius: 32.0,
              ),
            )
          ],
        ),
          ),
    );
  }

  List<Widget> _getChildren(NewMedicalReportViewModel model,
      BuildContext context) {
    return <Widget>[
      // Height & Weight details
      PageBuilder(
        opacity: 1.0,
        next: model.handleNext,
        image: Assets.height,
        title: 'Tell us about your physique',
        description: 'We need your body details for better understanding',
        children: SizedBox(
          width: 200.0,
          child: Form(
            key: model.formKey,
            child: Wrap(
              runSpacing: 12.0,
              children: <Widget>[
                OutlinedTextField(
                  label: 'Height',
                  suffix: Text('cms'),
                  initialValue: model.report.height?.toString(),
                  onChange: (String height) {
                    model.report.height = double.parse(height);
                    model.notifyFFitness();
                  },
                  textInputType: TextInputType.number,
                  validator: (String height) {
                    if (height == null || height.length == 0) {
                      return "Invalid height";
                    }
                    double d = double.parse(height);
                    if (d != null && d > 30.0 && d < 250) {
                      return null;
                    }
                    return "Invalid height";
                  },
                  save: (String height) {
                    model.report.height = double.parse(height);
                  },
                ),
                OutlinedTextField(
                  label: 'Weight',
                  suffix: Text('kgs'),
                  initialValue: model.report.weight?.toString(),
                  textInputType: TextInputType.number,
                  onChange: (String weight) {
                    model.report.weight = double.parse(weight);
                    model.notifyFFitness();
                  },
                  validator: (String weight) {
                    if (weight == null || weight.length == 0) {
                      return "Invalid weight";
                    }
                    double d = double.parse(weight);
                    if (d != null && d > 15.0 && d < 250) {
                      return null;
                    }
                    return "Invalid weight";
                  },
                  save: (String weight) {
                    model.report.weight = double.parse(weight);
                  },
                ),
                Text(
                  'Your BMI is: ${getBMI(model.report)} kg/m²',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 64.0)
              ],
            ),
          ),
        ),
      ),

      // Blood group
      PageBuilder(
        opacity: 1.0,
        next: model.handleNext,
        image: Assets.bloodTest,
        title: 'Select your blood group',
        description: 'We need blood group for better understanding',
        children: SizedBox(
          width: 250.0,
          child: Wrap(
            runSpacing: 4.0,
            children: <Widget>[]..addAll(
                List.generate(
                  BloodGroup.values.length,
                  (index) => Selectable(
                    text: BloodGroup.values[index].buttonText(),
                    selected:
                    model.report.bloodGroup == BloodGroup.values[index],
                    onPressed: () {
                      model.selectBloodGroup(BloodGroup.values[index]);
                      model.notifyFFitness();
                    },
                  ),
                ),
              ),
          ),
        ),
      ),

      // Vision details
      PageBuilder(
        left: 64.0,
        right: 64.0,
        opacity: 0.15,
        top: 0.0,
        bottom: 0.0,
        next: model.handleNext,
        image: Assets.vision,
        title: 'Test your vision',
        description: 'We need your vision details for better understanding',
        children: Wrap(
          runSpacing: 4.0,
          alignment: WrapAlignment.center,
          children: <Widget>[
            SelectableColorOrText(
              color: Colors.red,
              selected: model.report.csRed,
              onPressed: () {
                model.report.csRed = !model.report.csRed;
                model.notifyFFitness();
              },
            ),
            SelectableColorOrText(
              color: Colors.blue,
              selected: model.report.csBlue,
              onPressed: () {
                model.report.csBlue = !model.report.csBlue;
                model.notifyFFitness();
              },
            ),
            SelectableColorOrText(
              color: Colors.green,
              selected: model.report.csGreen,
              onPressed: () {
                model.report.csGreen = !model.report.csGreen;
                model.notifyFFitness();
              },
            ),
            SelectableColorOrText(
              selected: model.report.cs24,
              text: 'Check',
              fontSize: 24.0,
              fontWeight: FontWeight.normal,
              onPressed: () {
                model.report.cs24 = !model.report.cs24;
                model.notifyFFitness();
              },
            ),
            SelectableColorOrText(
              selected: model.report.cs20,
              text: 'Check',
              fontSize: 20.0,
              fontWeight: FontWeight.normal,
              onPressed: () {
                model.report.cs20 = !model.report.cs20;
                model.notifyFFitness();
              },
            ),
            SelectableColorOrText(
              selected: model.report.cs16,
              text: 'Check',
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
              onPressed: () {
                model.report.cs16 = !model.report.cs16;
                model.notifyFFitness();
              },
            ),
            SelectableColorOrText(
              selected: model.report.cs12,
              text: 'Check',
              fontSize: 12.0,
              fontWeight: FontWeight.normal,
              onPressed: () {
                model.report.cs12 = !model.report.cs12;
                model.notifyFFitness();
              },
            ),
            SelectableColorOrText(
              selected: model.report.cs8,
              text: 'Check',
              fontSize: 8.0,
              fontWeight: FontWeight.normal,
              onPressed: () {
                model.report.cs8 = !model.report.cs8;
                model.notifyFFitness();
              },
            ),
            CheckboxListTile(
              title: Text(
                'Do you use spectacles?',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
              ),
              value: model.report.spectacles,
              onChanged: (bool selected) {
                model.report.spectacles = selected;
                model.notifyFFitness();
              },
            ),
            CheckboxListTile(
              title: Text(
                'Do you have any other vision defect?',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
              ),
              value: model.report.visionDefect,
              onChanged: (bool selected) {
                model.report.visionDefect = selected;
                model.notifyFFitness();
              },
            ),
          ],
        ),
      ),

      // Hearing
      PageBuilder(
        left: 64.0,
        right: 64.0,
        opacity: 0.60,
        top: 0.0,
        bottom: 0.0,
        next: model.handleNext,
        image: Assets.hearing,
        title: 'Test your hearing',
        description: 'We need your hearing details for better understanding',
        children: Wrap(
          runSpacing: 4.0,
          children: <Widget>[
            CheckboxListTile(
              title: Text(
                'Do you have any hearing issues?',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
              ),
              value: model.report.hearingIssues,
              onChanged: (bool selected) {
                model.report.hearingIssues = selected;
                model.notifyFFitness();
              },
            ),
            CheckboxListTile(
              title: Text(
                'Do you use any hearing aid?',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
              ),
              value: model.report.hearingAids,
              onChanged: (bool selected) {
                model.report.hearingAids = selected;
                model.notifyFFitness();
              },
            ),
          ],
        ),
      ),

      // Physical disability
      PageBuilder(
        left: 64.0,
        right: 64.0,
        opacity: 0.60,
        top: 0.0,
        bottom: 0.0,
        next: model.handleNext,
        image: Assets.disability,
        title: 'Physical disability',
        description:
            'We need your physical disability details for better understanding',
        children: Wrap(
          runSpacing: 4.0,
          children: <Widget>[
            CheckboxListTile(
              title: Text(
                'Do you have any physical disability?',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
              ),
              value: model.report.physicalDisability,
              onChanged: (bool selected) {
                model.report.physicalDisability = selected;
                model.notifyFFitness();
              },
            ),
            CheckboxListTile(
              title: Text(
                'Do you use any mechanical assistance?',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
              ),
              value: model.report.mechanicalAssistance,
              onChanged: (bool selected) {
                model.report.mechanicalAssistance = selected;
                model.notifyFFitness();
              },
            ),
          ],
        ),
      ),

      // By birth diseases
      PageBuilder(
        left: 64.0,
        right: 64.0,
        opacity: 0.60,
        top: 0.0,
        bottom: 0.0,
        next: model.handleNext,
        image: Assets.baby,
        title: 'By birth disease',
        description: 'We need your birth details for better understanding',
        children: Wrap(
          runSpacing: 4.0,
          children: <Widget>[
            CheckboxListTile(
              title: Text(
                'Do you have any congenital disorder?',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
              ),
              value: model.report.congenitalDisorder,
              onChanged: (bool selected) {
                model.report.congenitalDisorder = selected;
                model.notifyFFitness();
              },
            ),
          ],
        ),
      ),

      // By birth diseases
      PageBuilder(
        left: 64.0,
        right: 64.0,
        opacity: 0.60,
        top: 0.0,
        bottom: 0.0,
        next: model.handleNext,
        image: Assets.psychiatric,
        title: 'Psychological issues',
        description:
            'We need your Psychological details for better understanding',
        children: Wrap(
          runSpacing: 4.0,
          children: <Widget>[
            CheckboxListTile(
              title: Text(
                'Do you have any Psychological issues?',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
              ),
              value: model.report.psychiatricIssues,
              onChanged: (bool selected) {
                model.report.psychiatricIssues = selected;
                model.notifyFFitness();
              },
            ),
          ],
        ),
      ),

      // Any Surgery
      PageBuilder(
        left: 64.0,
        right: 64.0,
        opacity: 0.60,
        top: 0.0,
        bottom: 0.0,
        next: model.handleNext,
        image: Assets.surgery,
        title: 'Surgeries/Operations',
        description: 'We need your surgical details for better understanding',
        children: Wrap(
          runSpacing: 4.0,
          children: <Widget>[
            CheckboxListTile(
              title: Text(
                'Do you had any Surgeries?',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
              ),
              value: model.report.hadSurgeries,
              onChanged: (bool selected) {
                model.report.hadSurgeries = selected;
                model.notifyFFitness();
              },
            ),
          ],
        ),
      ),

      // Alcohol & smoke
      PageBuilder(
        left: 64.0,
        right: 64.0,
        opacity: 0.60,
        top: 0.0,
        bottom: 0.0,
        next: model.handleNext,
        image: Assets.smokeAndAlcohol,
        title: 'Smoking/Alcohol habits',
        description: 'We need your details for better understanding',
        children: Wrap(
          runSpacing: 4.0,
          children: <Widget>[
            CheckboxListTile(
              title: Text(
                'Do you smoke?',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
              ),
              value: model.report.smoke,
              onChanged: (bool selected) {
                model.report.smoke = selected;
                model.notifyFFitness();
              },
            ),
            CheckboxListTile(
              title: Text(
                'Do you consume alcohol?',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
              ),
              value: model.report.alcohol,
              onChanged: (bool selected) {
                model.report.alcohol = selected;
                model.notifyFFitness();
              },
            ),
          ],
        ),
      ),

      // Other diseases
      PageBuilder(
        left: 64.0,
        right: 64.0,
        opacity: 0.40,
        top: 0.0,
        bottom: 0.0,
        next: model.handleNext,
        image: Assets.diseases,
        title: 'Other diseases',
        description: 'We need your details for better understanding',
        children: Wrap(
          runSpacing: 4.0,
          children: <Widget>[
            CheckboxListTile(
              title: Text(
                'Do you suffer from diabetes?',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
              ),
              value: model.report.sugar,
              onChanged: (bool selected) {
                model.report.sugar = selected;
                model.notifyFFitness();
              },
            ),
            CheckboxListTile(
              title: Text(
                'Do you suffer from Blood Pressure?',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
              ),
              value: model.report.bp,
              onChanged: (bool selected) {
                model.report.bp = selected;
                model.notifyFFitness();
              },
            ),
            CheckboxListTile(
              title: Text(
                'Do you suffer from Cancer?',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
              ),
              value: model.report.cancer,
              onChanged: (bool selected) {
                model.report.cancer = selected;
                model.notifyFFitness();
              },
            ),
            CheckboxListTile(
              title: Text(
                'Do you suffer from Heart diseases?',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
              ),
              value: model.report.heartDiseases,
              onChanged: (bool selected) {
                model.report.heartDiseases = selected;
                model.notifyFFitness();
              },
            ),
            CheckboxListTile(
              title: Text(
                'Do you suffer from any Tumours?',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
              ),
              value: model.report.tumour,
              onChanged: (bool selected) {
                model.report.tumour = selected;
                model.notifyFFitness();
              },
            ),
          ],
        ),
      ),
    ];
  }

  String getBMI(MedicalReport fitness) {
    double height = fitness.height ?? 0.0;
    double weight = fitness.weight ?? 0.0;
//    print((height/100)*(height/100));
//    print(weight);
//    print((weight / ((height / 100) * (height / 100))).abs());

    return height == 0.0 || weight == 0.0
        ? "0.0"
        : (weight / ((height / 100) * (height / 100))).toStringAsFixed(2);
  }
}

class PageBuilder extends StatelessWidget {
  final String image, title, description;
  final Widget children;
  final double opacity;
  final VoidCallback next;
  final double top, bottom, left, right, height;

  const PageBuilder(
      {Key key,
      this.image,
      this.title,
      this.description,
      this.children,
      this.opacity = 0.7,
      this.next,
      this.top = 100.0,
      this.bottom,
      this.left,
      this.right = 4.0,
      this.height = 200.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // background image
        Positioned(
          right: right,
          top: top,
          bottom: bottom,
          left: left,
          child: Opacity(
            opacity: opacity,
            child: Image.asset(
              image,
              height: height,
              repeat: ImageRepeat.noRepeat,
            ),
          ),
        ),
        Positioned.fill(
          top: 10.0,
          bottom: 50.0,
          right: 16.0,
          left: 16.0,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        description,
                        style: TextStyle(color: Colors.black, fontSize: 18.0),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32.0),
              ]
                ..add(children)
                ..add(SizedBox(height: 32.0)),
            ),
          ),
        )
      ],
    );
  }
}
