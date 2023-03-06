import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xideng_flutter/common/extensions/map_extension.dart';
import 'package:xideng_flutter/providers/app_config_provider.dart';

import '../../models/skill/standard_dto.dart';

class StandardTrainingPage extends StatefulWidget {
  const StandardTrainingPage({Key? key,required this.standardModel}) : super(key: key);
  final StandardDTO standardModel;
  @override
  State<StandardTrainingPage> createState() => _StandardTrainingPageState();
}

class _StandardTrainingPageState extends State<StandardTrainingPage> {
  String content = '';
  @override
  void initState() {

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        content = Provider.of<AppConfigProvider>(context,listen: false).appConfigModel?.toJson().toRawJson() ?? '';
        content += '\n\n123';
        content += widget.standardModel.toJson().toRawJson();
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.standardModel.getSkillStyleDTO()?.name ?? ''} ${widget.standardModel.toString()}'),
      ),
      body: Center(
        child: Text(content),
      ),
    );
  }
}
