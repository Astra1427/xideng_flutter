import 'dart:typed_data';

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

  AppConfigModel configModel = AppConfigModel.getDefault();

  @override
  void initState() {
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
      scrollable: true,
      title: Text('音量设置'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Text('背景音乐音量：${configModel.backAudioVolume.toStringAsFixed(2)}'),
            Slider(
                value: configModel.backAudioVolume,
                onChanged: (value) {
                  setState(() {
                    configModel.backAudioVolume = value;
                  });
                }),
            Text('人声音量：${configModel.personAudioVolume.toStringAsFixed(2)}'),
            Slider(
                value: configModel.personAudioVolume,
                onChanged: (value) {
                  setState(() {
                    configModel.personAudioVolume = value;
                  });
                }),
          ],
        ),
      ),
      actions: [
        DialogResultButton(

          result: configModel,
          text: '保存',
        )
      ],
    );
  }
}
