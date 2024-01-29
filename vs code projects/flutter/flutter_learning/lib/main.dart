import 'package:flutter/material.dart';
import 'package:flutter_learning/container.dart';
import 'package:flutter_learning/row.dart';
import 'package:flutter_learning/column.dart';
import 'package:flutter_learning/image.dart';
import 'package:flutter_learning/button_and_onpressed_property.dart';
import 'package:flutter_learning/listview.dart';
import 'package:flutter_learning/add_values_to_listview.dart';
import 'package:flutter_learning/elevated_button_and_snackbar.dart';
import 'package:flutter_learning/custom_fonts.dart';
import 'package:flutter_learning/best_practise.dart';
import 'package:flutter_learning/onchange_onsubmit.dart';
import 'package:flutter_learning/drop_down_button.dart';
import 'package:flutter_learning/validator.dart';
import 'package:flutter_learning/list_view_builder.dart';
import 'package:flutter_learning/grid_view_builder.dart';
import 'package:flutter_learning/splash_screen.dart';
import 'package:flutter_learning/navigation.dart';
import 'package:flutter_learning/named_routes.dart';
import 'package:flutter_learning/tabbed_page.dart';
import 'package:flutter_learning/menu_bar_items.dart';
import 'package:flutter_learning/navigation_drawer.dart';
import 'package:flutter_learning/gesture_detector.dart';
import 'package:flutter_learning/await_and_async.dart';
import 'package:flutter_learning/progress_bar.dart';
import 'package:flutter_learning/alert_dialog_box.dart';
import 'package:flutter_learning/file_picker.dart';

void main() {
  runApp(
    //  const 
     MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: container1(),
      // home: rows2(),
      // home: columns3(),
      // home: image4(),
      // home: MyStatefulWidget(),
      // home: ListView6(),
      // home: ListView7(),
      // home: SnackBar8(),
    //   home: CustomFonts(),
    // home: CustomSplashScreen(),
    // home: CustomNavigation(),
    // home: CustomMenuBar(),
    // home: CustomNavigationDrawer(),
    // home: Gesture(),
    // home: Syncs(),
    // home: ProgressBar(),
    // home: CustomAlert(),
    home: PickerFile()
    ),

    // BestPractise(),
    // const OnchangeOnsubmit(),
    // const CustomDropDown(),
    // const CustomValidator(),
    // const CustomListView(),
    // const CustomGridView(),
    // CustomNamedRoutes(),
    // CustomTabs(),
  );
}
