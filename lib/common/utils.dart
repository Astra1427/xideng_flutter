import 'package:flutter/material.dart';
import 'package:xideng_flutter/styles/main_style.dart';

import '../services/service_response.dart';

part 'common_components.dart';

class Util {}

extension ContextExtension on BuildContext {
  Future<bool?> showMsg(
    String content, {
    String title = '提示',
    List<Widget> actions = const [BoolTextButton(text: '好的',result: false,)],
  }) {
    return showDialog<bool>(
        context: this,
        builder: (context) => AlertDialog(
              title: Text(title),
              content: Text(content),
              actions: actions,
            ));
  }

  void showLoading(String title) async {
    await showDialog(
      context: this,
      barrierDismissible: false,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return LoadingDialog(title: title);
      },
    );
  }

  void closeLoading()async{
    if(_LoadingDialogState.isShown){
      Navigator.of(this).pop();
    }
  }

  showSnackBar(String msg) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(msg,style: TextStyle(color: Theme.of(this).textTheme.bodyText1?.color),),backgroundColor: Theme.of(this).backgroundColor,));
  }
}
