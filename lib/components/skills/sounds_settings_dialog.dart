import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xideng_flutter/common/utils.dart';
import 'package:xideng_flutter/providers/app_config_provider.dart';

import '../../models/app_config.dart';

class SoundsSettingsDialog extends StatefulWidget {
  const SoundsSettingsDialog({Key? key}) : super(key: key);

  @override
  State<SoundsSettingsDialog> createState() => _SoundsSettingsDialogState();
}

class _SoundsSettingsDialogState extends State<SoundsSettingsDialog> {
  late final AppConfigProvider appProvider;
  AppConfigModel configModel  =AppConfigModel(
      numberSecond: 1200,
      sleepSecond: 45,
      isRespiratoryRhythm: 0,
      startContinueSecond: 3,
      backAudioVolume: 1,
      personAudioVolume: 1,
      // TODO:get version
      // versionNumber: VersionTracking.CurrentVersion,
      versionNumber: '0.0.1',
      upNumberSecond: 2000,
      downNumberSecond: 3000,
      isOffline: false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      appProvider = Provider.of<AppConfigProvider>(context, listen: false);
      await appProvider.loadAppConfigModel();
      setState(() {
        if (appProvider.appConfigModel != null) {
          configModel = appProvider.appConfigModel!;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('设置'),
      content: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 300),
        child: ListView(
          shrinkWrap: true,
          children: [
            Text('背景音乐音量：${configModel.backAudioVolume.toStringAsFixed(2)}'),
            Slider(
                value: configModel.backAudioVolume,
                onChanged: (value) {
                  setState(() {
                    configModel.backAudioVolume = value;
                  });
                })
          ],
        ),
      ),
      actions: [DialogResultButton(result: configModel,text: '保存',)],
    );
  }
}
