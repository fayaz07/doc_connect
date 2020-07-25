import 'package:cached_network_image/cached_network_image.dart';
import 'package:doc_connect/views/profile/profile_view_model.dart';
import 'package:doc_connect/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:stacked/stacked.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      onModelReady: (m) => m.init(context),
      builder: (context, model, child) => PlatformScaffold(
        backgroundColor: Colors.white,
        appBar: PlatformAppBar(
          backgroundColor: Colors.white,
          title: Text(
            'My Profile',
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: model.pop,
          ),
          material: (context, platform) => MaterialAppBarData(
            elevation: 4.0,
          ),
        ),
        body: SingleChildScrollView(
          child: _getBody(model),
        ),
      ),
    );
  }

  Widget _getBody(ProfileViewModel model) {
    List<CListTile> _userSpecificList = [];
    if (!model.user.isDoctor) {
      _userSpecificList
          .add(CListTile(title: 'Symptoms', content: model.user.symptoms));
    } else {
      _userSpecificList
          .add(CListTile(title: 'Hospital', content: model.user.hospitalName));
      _userSpecificList
          .add(CListTile(title: 'Workplace', content: model.user.workplace));
      _userSpecificList
          .add(CListTile(title: 'Website', content: model.user.website));
      _userSpecificList.add(
          CListTile(title: 'Availability', content: model.user.availability));
      _userSpecificList.add(CListTile(
          title: 'Available for chat',
          content: model.user.availableForChat ?? false ? "Yes" : "No"));
      _userSpecificList.add(CListTile(
          title: 'Available for call',
          content: model.user.availableForCall ?? false ? "Yes" : "No"));
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          /// profile picture
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 100.0,
              width: 100.0,
              child: InkWell(
                borderRadius: BorderRadius.circular(8.0),
                onTap: model.uploadProfilePicture,
                child: Hero(
                  tag: 'user-profile',
                  child: Material(
                    clipBehavior: Clip.antiAlias,
                    type: MaterialType.circle,
                    color: Colors.grey.withOpacity(0.3),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Material(
                        clipBehavior: Clip.antiAlias,
                        type: MaterialType.circle,
                        color: Colors.greenAccent,
                        child: model.user.photoUrl == null
                            ? Center(
                                child: Text(
                                  '${model.user.firstName?.substring(0, 1) ?? 'A'}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 32.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            : CachedNetworkImage(
                                imageUrl: model.user.photoUrl,
                                fadeInCurve: Curves.easeIn,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 4.0),

          /// full name
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "${model.user.firstName + " " + model.user.lastName}",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                width: 4.0,
              ),
              VerifiedTick()
            ],
          ),
          SizedBox(
            height: 8.0,
          ),
          Card(
            margin: const EdgeInsets.all(0.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 8.0),
                CListTile(
                    title: 'Profile type',
                    content: model.user.isDoctor ? "Doctor" : "Patient"),
                CListTile(title: "Profession", content: model.user.profession),
                CListTile(title: 'Email', content: model.user.email),
                CListTile(title: 'Gender', content: model.user.gender),
                CListTile(title: 'Age', content: model.user.age.toString()),
                CListTile(title: 'Location', content: model.user.location),
                CListTile(
                    title: 'Known Languages',
                    content: model.user.knownLanguages),
              ]
                ..addAll(_userSpecificList)
                ..add(
                  SizedBox(height: 8.0),
                ),
            ),
          )
        ],
      ),
    );
  }
}

const titleStyle =
    TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500, color: Colors.grey);
const contentStyle =
    TextStyle(fontSize: 17.0, fontWeight: FontWeight.w600, color: Colors.black);

class CListTile extends StatelessWidget {
  final String title;
  final String content;

  const CListTile({Key key, @required this.title, @required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(height: 6.0),
        Row(
          children: <Widget>[
            SizedBox(width: 16.0),
            Expanded(
              child: Text(
                title,
                style: titleStyle,
              ),
            ),
            SizedBox(width: 16.0),
          ],
        ),
        Row(
          children: <Widget>[
            SizedBox(width: 16.0),
            Expanded(
              child: Text(
                content ?? "-",
                style: contentStyle,
              ),
            ),
            SizedBox(width: 16.0),
          ],
        ),
        SizedBox(height: 6.0),
      ],
    );
  }
}
