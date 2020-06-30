import 'package:doc_connect/services/app_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class IntroPage extends StatelessWidget {
  final String asset, title, description;

  const IntroPage({Key key, this.asset, this.title, this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Spacer(flex: 1),
        SizedBox(
          height: MediaQuery.of(context).size.height * .5,
          child: Image.asset(asset),
        ),
        SizedBox(height: 16.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            title,
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.headline4.apply(
                color: MediaQuery.of(context).platformBrightness == Brightness.light
                    ? Colors.black
                    : Colors.white,
//                color: Colors.white,
                fontWeightDelta: 2),
          ),
        ),
        SizedBox(height: 4.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            description,
            textAlign: TextAlign.left,
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .apply(fontSizeFactor: 1.25, color: Colors.grey),
          ),
        ),
        Spacer(flex: 2)
      ],
    );
  }
}
