import 'package:cctalk/Global.dart';
import 'package:cctalk/util/share_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

///
abstract class BaseStatelessPage extends StatelessWidget{
  const BaseStatelessPage({ Key key }) : super(key: key);
}

///
abstract class BaseStatefulPage extends StatefulWidget{
  const BaseStatefulPage({ Key key }) : super(key: key);
}

///
abstract class BaseState<T extends BaseStatefulPage> extends State<T>{
  String tag="BaseStatelessPage";
  String title="BaseStatelessPage";

  ///
  SharedPreferences get sharedPref => ShareUtil.getInstance();

  ///
  String get userId => sharedPref?.getString(Global.USER_ID);

  ///
  String get imToken => sharedPref?.getString(Global.IM_TOKEN);

  ///
  String get userName => sharedPref?.getString(Global.USER_NAME);

  @mustCallSuper
  @override
  void initState() {
    super.initState();

    debugPrint("initState:$tag");
  }

  @mustCallSuper
  @override
  void dispose() {
    super.dispose();
    debugPrint("dispose:$tag");
  }

}