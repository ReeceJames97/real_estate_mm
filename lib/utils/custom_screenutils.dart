import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' as screenUtil;

class CustomScreenUtil{

  bool isTablet = false ;
  bool isLandSpace = false;
  double screenWidth = screenUtil.ScreenUtil().screenWidth;
  double screenHeight = screenUtil.ScreenUtil().screenHeight;

  CustomScreenUtil(){
    // double ratio = WidgetsBinding.instance.window.physicalSize.width / WidgetsBinding.instance.window.physicalSize.height;
    // double ratio = screenUtil.ScreenUtil().screenWidth / screenUtil.ScreenUtil().scaleHeight;
    // if( (ratio >= 0.74) || (ratio < 1.5) ) {
    //   isTablet = true;
    //   logD("Tablet");
    // } else{
    //   isTablet = false;
    //   logD("NOT Tablet");
    // }


    final Size screenSize = MediaQueryData.fromView(WidgetsBinding.instance.window).size;

    // Calculate the diagonal size of the screen
    final double diagonalSize = sqrt(
      (screenSize.width * screenSize.width) + (screenSize.height * screenSize.height),
    );

    // Determine if the diagonal size exceeds a certain threshold (e.g., 7 inches)
    //logD("Sized Tablet=  "+ diagonalSize.toString());
      if(diagonalSize >= 1100.0){
        isTablet = true;
        // logD("Tablet");
      }else{

        /// Check Portrait or landSpace
        final Orientation currentOrientation = WidgetsBinding.instance.window.physicalSize.width > WidgetsBinding.instance.window.physicalSize.height
            ? Orientation.landscape : Orientation.portrait;
        if(currentOrientation == Orientation.landscape){
          isLandSpace = true;
          // logD("LandSpace");
        }else{
          isLandSpace = false;
          // logD("NOT LandSpace");
        }

        // logD("NOT Tablet");

    }


  }

  double setWidth(num width){

    if(kIsWeb){
      return getWebWidth(width);
    }else if(isTablet){
      return width*1.0;
    }else{
      if(isLandSpace){
        return screenUtil.ScreenUtil().setWidth(width/2);
      }else{
        return screenUtil.ScreenUtil().setWidth(width);
      }

    }
  }

  double setSp(num sp){
    if(kIsWeb){
      return getWebSp(sp);
    }else if(isTablet){
      return sp*1.0;
    }else{
      if(isLandSpace){
        return screenUtil.ScreenUtil().setSp(sp/2);
      }else{
        return screenUtil.ScreenUtil().setSp(sp);
      }
    }
  }

  double setHeight(num height){
    if(kIsWeb){
      return getWebHeight(height);
    }else if(isTablet){
      return height*1.0;
    }else{
      if(isLandSpace){
        return screenUtil.ScreenUtil().setHeight(height*1.2);
      }else{
        return screenUtil.ScreenUtil().setHeight(height);
      }
    }
  }


  double getWebScreenSize(){
    final Size screenSize = MediaQueryData.fromView(WidgetsBinding.instance.window).size;
    final double diagonalSize = sqrt(
      (screenSize.width * screenSize.width) + (screenSize.height * screenSize.height),
    );
    return diagonalSize;
  }

  double getWebHeight(num height){
    if(getWebScreenSize() >= 1100){
      return screenUtil.ScreenUtil().setHeight(height);
    }else{
      return screenUtil.ScreenUtil().setHeight(height*1.2);
    }
  }

  double getWebWidth(num width){
    if(getWebScreenSize() >= 1300){
      return screenUtil.ScreenUtil().setWidth(width/3);
    }else if(getWebScreenSize() >= 700){
      return screenUtil.ScreenUtil().setWidth(width/2);
    } else{
      return screenUtil.ScreenUtil().setWidth(width*1.0);
    }
  }

  double getWebSp(num sp){
    if(getWebScreenSize() >= 1300){
      return screenUtil.ScreenUtil().setSp(sp/4);
    }else if(getWebScreenSize() >= 700){
      return screenUtil.ScreenUtil().setSp(sp/2);
    } else{
      return screenUtil.ScreenUtil().setSp(sp*1.0);
    }
  }

  double getNavHeaderHeight(num height){
    if(kIsWeb){
      if(getWebScreenSize() >= 1100){
        return screenUtil.ScreenUtil().setHeight(height+200);
      }else{
        return screenUtil.ScreenUtil().setHeight(height*1.2);
      }
    }else if(isTablet){
      return height*1.0;
    }else{
      if(isLandSpace){
        return screenUtil.ScreenUtil().setHeight(height*1.2);
      }else{
        return screenUtil.ScreenUtil().setHeight(height);
      }
    }
  }

  int getCrossAxisCount(){
    if(kIsWeb){
      if(getWebScreenSize() >= 1100){
        return 4;
      }else if(getWebScreenSize() >= 900){
        return 3;
      } else{
        return 2;
      }
    }else{
      return 2;
    }
  }

}