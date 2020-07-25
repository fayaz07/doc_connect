import 'package:carousel_slider/carousel_slider.dart';
import 'package:doc_connect/services/forums.dart';
import 'package:doc_connect/services/users.dart';
import 'package:doc_connect/views/forum/forum_widgets.dart';
import 'package:doc_connect/views/home/home_view_model.dart';
import 'package:doc_connect/widgets/avatar.dart';
import 'package:doc_connect/widgets/buttons.dart';
import 'package:doc_connect/widgets/doctor.dart';
import 'package:doc_connect/widgets/patient.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeScreenViewModel>.reactive(
      viewModelBuilder: () => HomeScreenViewModel(),
      onModelReady: (m) => m.instantiate(context),
      builder: (context, model, child) => SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _getHeader(model),
                SizedBox(height: 16.0),
                TitleWithButton(
                  title: 'Tips of the day',
                  onPressed: () {
                    print("Hello");
                  },
                ),
                SizedBox(height: 8.0),
                TipsCarousel(model: model),
                SizedBox(height: 16.0),
                TitleWithButton(
                  title:
                      'Nearby ${model.user.isDoctor ? "Patients" : "Doctors"}',
                  onPressed: () {
                    print("Hello");
                  },
                ),
                SizedBox(height: 4.0),
                model.user.isDoctor ? NearbyPatients() : NearbyDoctors(),
                SizedBox(height: 8.0),
                TitleWithButton(
                  title: 'Forums',
                  onPressed: model.goToForums,
                ),
                SizedBox(height: 4.0),
                TopForums(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getHeader(HomeScreenViewModel model) => Row(
        children: <Widget>[
          Text(
            'Hey\n${model.user.firstName ?? " "}',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          InkWell(
            onTap: model.goToProfileScreen,
            child: Hero(
              tag: 'user-profile',
              child: GetAvatar(
                firstName: model.user.firstName,
                photoUrl: model.user.photoUrl,
              ),
            ),
          )
        ],
      );
}

class TipsCarousel extends StatelessWidget {
  final HomeScreenViewModel model;

  const TipsCarousel({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 150.0,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 4),
      ),
      items: [1, 2, 3, 4, 5].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Card(
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              color: Colors.accents[Colors.accents.length % i],
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'Tip $i',
                      style: TextStyle(fontSize: 24.0, color: Colors.white),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

class NearbyDoctors extends StatelessWidget {
  final HomeScreenViewModel model;

  const NearbyDoctors({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nearByDoctors =
    Provider
        .of<UsersProvider>(context)
        .doctors
        .keys
        .toList();
    return SizedBox(
      height: 150.0,
      child: nearByDoctors.length == 0
          ? Center(
        child: Text('No doctors here'),
      )
          : ListView.builder(
        itemCount: nearByDoctors.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, i) =>
            DoctorWidget(
                i: i,
                doctorId: nearByDoctors[i],
              ),
            ),
    );
  }
}

class NearbyPatients extends StatelessWidget {
  final HomeScreenViewModel model;

  const NearbyPatients({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nearByPatients =
    Provider
        .of<UsersProvider>(context)
        .patients
        .keys
        .toList();
    return SizedBox(
      height: 150.0,
      child: nearByPatients.length == 0
          ? Center(
        child: Text('No patients here'),
      )
          : ListView.builder(
        itemCount: nearByPatients.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, i) =>
            PatientWidget(
                i: i,
                patientId: nearByPatients[i],
              ),
            ),
    );
  }
}

class TopForums extends StatelessWidget {
  final HomeScreenViewModel model;

  const TopForums({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final forumQuestions =
        Provider.of<ForumsProvider>(context).forumQuestions.keys.toList();
    return SizedBox(
      height: 120.0,
      child: ListView.builder(
          itemCount: forumQuestions.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, i) => ForumQuestionTile(
                id: i + 1,
                forumId: forumQuestions[i].toString(),
              )),
    );
  }
}
