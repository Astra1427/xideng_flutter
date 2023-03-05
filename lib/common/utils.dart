
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xideng_flutter/styles/main_style.dart';

import '../services/service_response.dart';

part 'common_components.dart';

class Util {

}

extension ContextExtension on BuildContext {
  Future<bool?> showMsg(
    String content, {
    String title = '提示',
    List<Widget> actions = const [
      BoolTextButton(
        text: '好的',
        result: false,
      )
    ],
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

  Future<String?> showSelectionDialog(String title, List<String> items) async {
    return await showDialog<String>(
        context: this,
        builder: (dialogContext) {
          return AlertDialog(
            title: Text(title),
            content: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 300
              ),


              child: ListView(
                shrinkWrap: true,
                children: [
                  for (var item in items)
                    InkWell(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(item),
                      ),
                      onTap: () {
                        Navigator.of(dialogContext).pop(item);
                      },
                    )
                ],
              ),
            ),
            actions: const [DialogResultButton(result: "")],
          );
        });
  }

  void closeLoading() async {
    if (_LoadingDialogState.isShown) {
      Navigator.of(this).pop();
    }
  }

  showSnackBar(String msg) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(
        msg,
        style: TextStyle(color: Theme.of(this).textTheme.bodyText1?.color),
      ),
      backgroundColor: Theme.of(this).backgroundColor,
    ));
  }

  showOverlayDialog(){

  }
}
