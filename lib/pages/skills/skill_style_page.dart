import 'package:flutter/material.dart';
import 'package:xideng_flutter/components/skills/skill_style_item.dart';
import 'package:xideng_flutter/models/skill/skill_dto.dart';

import '../../models/skill/skill_style_dto.dart';

class SkillStylePage extends StatefulWidget {
  const SkillStylePage({Key? key, required this.skillModel}) : super(key: key);

  final SkillDTO skillModel;

  @override
  State<SkillStylePage> createState() => _SkillStylePageState();
}

class _SkillStylePageState extends State<SkillStylePage> {
  final List<SkillStyleDTO> _styleList = [];
  int currentIndex = 0;
  @override
  void initState() {

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      for (var i = 0; i < widget.skillModel.skillStyles.length; i++){
        await Future.delayed(const Duration(milliseconds: 400));
        _styleList.insert(i, widget.skillModel.skillStyles[i]);
        _listKey.currentState?.insertItem(i,duration: const Duration(milliseconds: 1000));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          buildAppBar(),
          buildSkillStyles()
        ],
      ),
    );
  }

  Widget buildAppBar() {
    return SliverAppBar(
      pinned: true,
      primary: true,
      elevation: 10,
      leading: IconButton(onPressed: (){
        Navigator.of(context).pop();
      },icon: const Icon(Icons.arrow_back),),
      expandedHeight: 190.0,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 45, bottom: 12),
        collapseMode: CollapseMode.parallax,
        title: Text(
          widget.skillModel.name,
          style: const TextStyle(
            shadows: [
              Shadow(color: Colors.blue, offset: Offset(1, 1), blurRadius: 2)
            ],
          ),
        ),
        background: Hero(
          tag: 'skill_cover_${widget.skillModel.imgUrl}',
          child: Image.asset(
            'images/${widget.skillModel.imgUrl}.jpg',
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  final _listKey = GlobalKey<SliverAnimatedListState>();
  Widget buildSkillStyles() {


    return SliverAnimatedList(

      key: _listKey,
        initialItemCount: _styleList.length,
        itemBuilder: (context, index, animation) {
      return FadeTransition(
        opacity: animation,
        child: SkillStyleItem(_styleList[index]),
      );
    });
  }
}
