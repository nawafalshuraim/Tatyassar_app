import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:loom_store/features/authentication/screens/login/login.dart';

class OnBoardingController extends GetxController{
  static OnBoardingController get instance => Get.find();

  //varibles
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  void updatePageIndicator(index) => currentPageIndex.value = index;

  void dotNavigaationClick(index){
    currentPageIndex.value = index;
    pageController.jumpTo(index);
  }

  void nextPage(){
    if(currentPageIndex.value == 2){
      Get.offAll( const LoginScreen());
    } else{
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    }
  }
  

  void skipPage(){
    //first page is 0
    
    currentPageIndex.value = 2;
    pageController.jumpToPage(2);
  }

}

