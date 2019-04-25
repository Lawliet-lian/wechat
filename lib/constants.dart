import 'package:flutter/material.dart';

/**
 * 配置类
 */
class AppColors{
	static const AppBarColor = 0xff303030;
	static const TabIconActive = 0xff46c11b;
	static const TapIconNormal = 0xff999999;
	static const AppBarPopupMenuColor = 0xFFFFFFFF;
	static const ConversationTitleColor = 0xFFFFFFFF;
	static const ConversationItemBg = 0xFFFFFFFF;
	static const TitleTextColor = 0xff353535;
	static const DesTextColor = 0xff9e9e9e;
	static const DividerColor = 0xffd9d9d9;
}

class Constants{
	//配置yaml文件中的字体库
	static const IconFontFamily = 'appIconFont';
	static const ConversationAvatarSize = 48.0;
	static const DividerWidth = 1.0;
}

class AppStyle{
	static const TitleStyle = TextStyle(
		fontSize: 14.0,
		color: Color(AppColors.TitleTextColor),
	);

	static const DesStyle = TextStyle(
		fontSize: 12.0,
		color: Color(AppColors.DesTextColor),
	);
}