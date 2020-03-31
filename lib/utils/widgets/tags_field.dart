import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

/// Copyright
/// Mohammad Fayaz(https://github.com/fayaz07/awesome_widgets)
///
// ignore: must_be_immutable
class TagsField extends StatefulWidget {
  Function(List<String>) onTagAdded;
  Function(List<String>) onTagRemoved;
  String label;
  bool tags;

  TagsField(
      {@required this.onTagAdded,
      @required this.onTagRemoved,
      this.label = "Add your tags",
      this.tags = true});

  @override
  _TagsFieldState createState() => _TagsFieldState();
}

class _TagsFieldState extends State<TagsField> {
  List<String> _tags = [];
  TextEditingController _controller = TextEditingController();

  PublishSubject<List<String>> _publishSubject = PublishSubject();

  @override
  void dispose() {
    _publishSubject.close();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          widget.label,
          style: TextStyle(
              color: Colors.pinkAccent,
              fontSize: 14.0,
              fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 4.0),
        StreamBuilder<List<String>>(
            stream: _publishSubject.stream,
            initialData: List<String>(),
            builder: (context, snapshot) {
              return Wrap(
                runSpacing: 4.0,
                spacing: 4.0,
                runAlignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                alignment: WrapAlignment.start,
                direction: Axis.horizontal,
                children: List.generate(_tags.length, (int i) {
                  return Material(
                    borderRadius: BorderRadius.circular(4.0),
                    color: Colors.grey.withOpacity(0.4),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            ' ${_tags[i]} ',
                            style: TextStyle(color: Colors.black),
                          ),
                          InkWell(
                            onTap: () {
                              _tags.removeAt(i);
                              widget.onTagRemoved(_tags);
                              _publishSubject.sink.add(_tags);
                            },
                            child: Icon(
                              Icons.close,
                              size: 16.0,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
              );
            }),
        SizedBox(height: 8.0),
        Material(
          type: MaterialType.card,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
              side: BorderSide(color: Colors.grey)),
          child: Row(
            children: <Widget>[
              SizedBox(width: 8.0),
              Expanded(
                flex: 8,
                child: TextFormField(
                  controller: _controller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: FlatButton(
                  onPressed: () {
                    if (widget.tags) {
                      _controller.text.split(" ").forEach((String value) {
                        if (value != null && value.length > 0) {
                          if (!_tags.contains(value)) _tags.add(value);
                        }
                      });
                    } else {
                      String value = _controller.text;
                      if (value != null && value.length > 3) {
                        if (!_tags.contains(value)) _tags.add(value);
                      }
                    }
                    _controller.clear();
                    _publishSubject.sink.add(_tags);
                    widget.onTagAdded(_tags);
                  },
                  color: Colors.indigo,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0)),
                  child: Center(
                    child: Text('ADD',
                        style: Theme.of(context)
                            .textTheme
                            .button
                            .apply(color: Colors.white)),
                  ),
                ),
              ),
              SizedBox(width: 4.0)
            ],
          ),
        )
      ],
    );
  }
}
