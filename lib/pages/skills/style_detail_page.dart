import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xideng_flutter/common/utils.dart';
import 'package:xideng_flutter/components/skills/sounds_settings_dialog.dart';
import 'package:xideng_flutter/models/app_config.dart';
import 'package:xideng_flutter/pages/webview_page.dart';
import 'package:xideng_flutter/providers/app_config_provider.dart';

import '../../models/skill/skill_style_dto.dart';

class StyleDetailPage extends StatefulWidget {
  const StyleDetailPage({Key? key, required this.styleModel}) : super(key: key);
  final SkillStyleDTO styleModel;

  @override
  State<StyleDetailPage> createState() => _StyleDetailPageState();
}

class _StyleDetailPageState extends State<StyleDetailPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        children: [
          Expanded(
              child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            children: [
              buildVideo(),
              const SizedBox(
                height: 10,
              ),
              buildSkillStyleContent(),
            ],
          )),
          buildTrainingButton()
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text(widget.styleModel.name),
      actions: [
        IconButton(
            onPressed: () async {
              var configModel = await showDialog<AppConfigModel>(
                context: context,
                builder: (BuildContext dialogContext) {
                  return const SoundsSettingsDialog();
                },
              );
              if (!mounted) {
                return;
              }
              await Provider.of<AppConfigProvider>(context, listen: false)
                  .setAppConfigModel(configModel);
            },
            icon: const Icon(Icons.music_note)),
        buildDropDownButton(),
      ],
    );
  }

  Widget buildDropDownButton() {
    return PopupMenuButton(
      offset: const Offset(0, 60),
      itemBuilder: (context) {
        return [const PopupMenuItem(child: Text('text1'), value: 1)];
      },
      onSelected: (value) {
        context.showMsg(value.toString());
      },
    );
    /*
    DropdownButton(
            underline: const DropdownButtonHideUnderline(
              child: Text(''),
            ),
            icon: const Icon(Icons.more_vert_rounded),
            items: const [
              DropdownMenuItem(
                value: 1,
                child: Text('text1'),
              ),
              DropdownMenuItem(
                value: 2,
                child: Text('text2'),
              ),
              DropdownMenuItem(
                value: 3,
                child: Text('text3'),
              ),
            ],
            onChanged: (item) {})
    * */
  }

  Widget buildVideo() {
    return SizedBox(
      height: 220,
      child: Ink(
          color: Theme.of(context).backgroundColor,
          child: InkWell(
            onTap: () {
              if (widget.styleModel.videoUrl == null) {
                context.showMsg("很抱歉，没有找到该动作的视频教程！");
                return;
              }
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => WebViewPage(
                      uri: Uri.parse(widget.styleModel.videoUrl!),
                      title: widget.styleModel.name)));
            },
            child: const Center(
              child: Text(
                '观看视频',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          )),
    );
  }

  Widget buildSkillStyleContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '训练部位',
          style: TextStyle(color: Colors.grey[400]),
        ),
        Text('${widget.styleModel.traningPart}\n'),
        Text(
          '动作要点',
          style: TextStyle(color: Colors.grey[400]),
        ),
        Text('${widget.styleModel.actionDescription}\n'),
        Text(
          '动作解析',
          style: TextStyle(color: Colors.grey[400]),
        ),
        Text('${widget.styleModel.analysis}\n'),
        Text(
          '稳扎稳打',
          style: TextStyle(color: Colors.grey[400]),
        ),
        Text('${widget.styleModel.slowSteady}\n'),
      ],
    );
  }

  Widget buildTrainingButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(onPressed: () {}, child: const Text('开始训练')),
    );
  }
}
