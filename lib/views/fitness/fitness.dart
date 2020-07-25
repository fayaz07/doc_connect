import 'package:doc_connect/data_models/fitness.dart';
import 'package:doc_connect/services/users.dart';
import 'package:doc_connect/utils/assets.dart';
import 'package:doc_connect/views/fitness/fitness_view_model.dart';
import 'package:doc_connect/widgets/buttons.dart';
import 'package:doc_connect/widgets/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

void main() => runApp(
      ChangeNotifierProvider(
        create: (context) => UsersProvider(),
        child: PlatformApp(
          home: FitnessScreen(),
        ),
      ),
    );

class FitnessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ViewModelBuilder<FitnessViewModel>.reactive(
      viewModelBuilder: () => FitnessViewModel(),
      onModelReady: (m) => m.init(context),
      builder: (BuildContext context, FitnessViewModel model, Widget child) =>
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

  List<Widget> _getChildren(FitnessViewModel model, BuildContext context) {
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
                  initialValue: model.fFitness.height?.toString(),
                  onChange: (String height) {
                    model.fFitness.height = double.parse(height);
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
                    model.fFitness.height = double.parse(height);
                  },
                ),
                OutlinedTextField(
                  label: 'Weight',
                  suffix: Text('kgs'),
                  initialValue: model.fFitness.weight?.toString(),
                  textInputType: TextInputType.number,
                  onChange: (String weight) {
                    model.fFitness.weight = double.parse(weight);
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
                    model.fFitness.weight = double.parse(weight);
                  },
                ),
                Text(
                  'Your BMI is: ${getBMI(model.fFitness)} kg/m²',
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
                        model.fFitness.bloodGroup == BloodGroup.values[index],
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
              selected: model.fFitness.csRed,
              onPressed: () {
                model.fFitness.csRed = !model.fFitness.csRed;
                model.notifyFFitness();
              },
            ),
            SelectableColorOrText(
              color: Colors.blue,
              selected: model.fFitness.csBlue,
              onPressed: () {
                model.fFitness.csBlue = !model.fFitness.csBlue;
                model.notifyFFitness();
              },
            ),
            SelectableColorOrText(
              color: Colors.green,
              selected: model.fFitness.csGreen,
              onPressed: () {
                model.fFitness.csGreen = !model.fFitness.csGreen;
                model.notifyFFitness();
              },
            ),
            SelectableColorOrText(
              selected: model.fFitness.cs24,
              text: 'Check',
              fontSize: 24.0,
              fontWeight: FontWeight.normal,
              onPressed: () {
                model.fFitness.cs24 = !model.fFitness.cs24;
                model.notifyFFitness();
              },
            ),
            SelectableColorOrText(
              selected: model.fFitness.cs20,
              text: 'Check',
              fontSize: 20.0,
              fontWeight: FontWeight.normal,
              onPressed: () {
                model.fFitness.cs20 = !model.fFitness.cs20;
                model.notifyFFitness();
              },
            ),
            SelectableColorOrText(
              selected: model.fFitness.cs16,
              text: 'Check',
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
              onPressed: () {
                model.fFitness.cs16 = !model.fFitness.cs16;
                model.notifyFFitness();
              },
            ),
            SelectableColorOrText(
              selected: model.fFitness.cs12,
              text: 'Check',
              fontSize: 12.0,
              fontWeight: FontWeight.normal,
              onPressed: () {
                model.fFitness.cs12 = !model.fFitness.cs12;
                model.notifyFFitness();
              },
            ),
            SelectableColorOrText(
              selected: model.fFitness.cs8,
              text: 'Check',
              fontSize: 8.0,
              fontWeight: FontWeight.normal,
              onPressed: () {
                model.fFitness.cs8 = !model.fFitness.cs8;
                model.notifyFFitness();
              },
            ),
            CheckboxListTile(
              title: Text(
                'Do you use spectacles?',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
              ),
              value: model.fFitness.spectacles,
              onChanged: (bool selected) {
                model.fFitness.spectacles = selected;
                model.notifyFFitness();
              },
            ),
            CheckboxListTile(
              title: Text(
                'Do you have any other vision defect?',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
              ),
              value: model.fFitness.visionDefect,
              onChanged: (bool selected) {
                model.fFitness.visionDefect = selected;
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
              value: model.fFitness.hearingIssues,
              onChanged: (bool selected) {
                model.fFitness.hearingIssues = selected;
                model.notifyFFitness();
              },
            ),
            CheckboxListTile(
              title: Text(
                'Do you use any hearing aid?',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
              ),
              value: model.fFitness.hearingAids,
              onChanged: (bool selected) {
                model.fFitness.hearingAids = selected;
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
              value: model.fFitness.physicalDisability,
              onChanged: (bool selected) {
                model.fFitness.physicalDisability = selected;
                model.notifyFFitness();
              },
            ),
            CheckboxListTile(
              title: Text(
                'Do you use any mechanical assistance?',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
              ),
              value: model.fFitness.mechanicalAssistance,
              onChanged: (bool selected) {
                model.fFitness.mechanicalAssistance = selected;
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
              value: model.fFitness.congenitalDisorder,
              onChanged: (bool selected) {
                model.fFitness.congenitalDisorder = selected;
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
              value: model.fFitness.psychiatricIssues,
              onChanged: (bool selected) {
                model.fFitness.psychiatricIssues = selected;
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
              value: model.fFitness.hadSurgeries,
              onChanged: (bool selected) {
                model.fFitness.hadSurgeries = selected;
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
              value: model.fFitness.smoke,
              onChanged: (bool selected) {
                model.fFitness.smoke = selected;
                model.notifyFFitness();
              },
            ),
            CheckboxListTile(
              title: Text(
                'Do you consume alcohol?',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
              ),
              value: model.fFitness.alcohol,
              onChanged: (bool selected) {
                model.fFitness.alcohol = selected;
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
              value: model.fFitness.sugar,
              onChanged: (bool selected) {
                model.fFitness.sugar = selected;
                model.notifyFFitness();
              },
            ),
            CheckboxListTile(
              title: Text(
                'Do you suffer from Blood Pressure?',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
              ),
              value: model.fFitness.bp,
              onChanged: (bool selected) {
                model.fFitness.bp = selected;
                model.notifyFFitness();
              },
            ),
            CheckboxListTile(
              title: Text(
                'Do you suffer from Cancer?',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
              ),
              value: model.fFitness.cancer,
              onChanged: (bool selected) {
                model.fFitness.cancer = selected;
                model.notifyFFitness();
              },
            ),
            CheckboxListTile(
              title: Text(
                'Do you suffer from Heart diseases?',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
              ),
              value: model.fFitness.heartDiseases,
              onChanged: (bool selected) {
                model.fFitness.heartDiseases = selected;
                model.notifyFFitness();
              },
            ),
            CheckboxListTile(
              title: Text(
                'Do you suffer from any Tumours?',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
              ),
              value: model.fFitness.tumour,
              onChanged: (bool selected) {
                model.fFitness.tumour = selected;
                model.notifyFFitness();
              },
            ),
          ],
        ),
      ),
    ];
  }

  String getBMI(Fitness fitness) {
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
