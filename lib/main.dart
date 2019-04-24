import 'package:flutter/material.dart';
import 'package:flutter_wechat/constants.dart';

import './home/home_screen.dart';

void main() => runApp(
  MaterialApp(
    title: '微信',
    //设置整体暗黑主题
    theme: ThemeData.dark().copyWith(
      primaryColor: Color(AppColors.AppBarColor),
    ),
    home: HomeScreen(),
  )
);