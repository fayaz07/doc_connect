import 'package:doc_connect/data_models/fitness.dart';
import 'package:doc_connect/services/users.dart';
import 'package:doc_connect/utils/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class FitnessViewModel extends ChangeNotifier {
  BuildContext _context;
  int currentPage = 0;
  Fitness _fFitness = Fitness();

  final PageController pageController = PageController();
  final formKey = GlobalKey<FormState>();

  void init(BuildContext context) {
    _context = context;
    fFitness = Provider.of<UsersProvider>(context, listen: false).fitness;
  }

  void handleBack() {
    if (currentPage == 0) {
      AppToast.show(text: "wait");
    } else {
      pageController.animateToPage(currentPage - 1,
          duration: Duration(milliseconds: 400), curve: Curves.easeInOutCirc);
    }
  }

  void handleNext() {
    FocusScope.of(_context).requestFocus(FocusNode());
    switch (currentPage) {
      // height, weight
      case 0:
        updatePhysiqueDetails();
        break;
      // blood
      case 1:
        _goToNextPage();
        break;
      // vision
      case 2:
        _goToNextPage();
        break;
      // hearing
      case 3:
        _goToNextPage();
        break;
      // physical disability
      case 4:
        _goToNextPage();
        break;
      // by birth diseases
      case 5:
        _goToNextPage();
        break;
      // psychological issues
      case 6:
        _goToNextPage();
        break;
      // surgeries
      case 7:
        _goToNextPage();
        break;
      // alcohol and smoking
      case 8:
        _goToNextPage();
        break;
    }
  }

  selectBloodGroup(BloodGroup group) {
    Provider.of<UsersProvider>(_context, listen: false).fitness.bloodGroup =
        group;
    notifyFFitness();
  }

  updatePhysiqueDetails() {
    if (!formKey.currentState.validate()) return;
    formKey.currentState.save();
    fFitness.bmi =
        (fFitness.weight / ((fFitness.height / 100) * (fFitness.height / 100)));
    _goToNextPage();
    notifyFFitness();
  }

  _goToNextPage() {
    pageController.nextPage(
        duration: Duration(milliseconds: 400), curve: Curves.easeInOutCirc);
  }

  notifyFFitness() {
    fFitness = fFitness;
  }

//  Fitness get fitness => _context == null
//      ? Fitness()
//      : Provider.of<UsersProvider>(_context).fitness;

  Fitness get fFitness => _fFitness;

  set fFitness(Fitness value) {
    _fFitness = value;
    notifyListeners();
  }
}
