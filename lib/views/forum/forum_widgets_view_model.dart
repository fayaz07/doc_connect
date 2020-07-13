import 'package:doc_connect/utils/navigation.dart';
import 'package:doc_connect/views/forum/forum_detailed.dart';
import 'package:flutter/cupertino.dart';

class ForumWidgetsViewModel extends ChangeNotifier {
  BuildContext _context;

  void init(BuildContext context) {
    _context = context;
  }

  void goToForumDetailed(String forumId) {
    Navigator.of(_context).push(AppNavigation.route(ForumDetailed()));
  }
}
