import 'package:doc_connect/utils/assets.dart';
import 'package:doc_connect/views/intro_screens/page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class IntroScreensViewModel extends ChangeNotifier {
  BuildContext _context;

  IntroScreensViewModel();

  int _currentPage = 0;
  final PageController pageController = PageController(
    initialPage: 0,
  );

  final pages = <IntroPage>[
    IntroPage(
      asset: Assets.appointment,
      title: 'Meet doctor',
      description: 'Meet doctor description',
    ),
    IntroPage(
      asset: Assets.health_tips,
      title: 'Meet patient',
      description: 'Meet doctor description',
    ),
    IntroPage(
      asset: Assets.treatment,
      title: 'Forum',
      description: 'Meet doctor description',
    ),
  ];

  void onPageChanged(int page) {
    currentPage = page;
  }

  initialise(BuildContext context) {
    _context = context;
  }

  navigateToLoginScreen(){

  }

  ///--------------------------------- getters and setters----------------------

  int get currentPage => _currentPage;

  set currentPage(int value) {
    _currentPage = value;
    notifyListeners();
  }
}
