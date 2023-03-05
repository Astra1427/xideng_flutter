import 'package:flutter/material.dart';
import 'package:xideng_flutter/models/skill/skill_dto.dart';
import 'package:xideng_flutter/pages/skills/skill_style_page.dart';

class SkillItem extends StatelessWidget {
  const SkillItem({Key? key, required this.skillModel,})
      : super(key: key);
  final SkillDTO skillModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SkillStylePage(skillModel: skillModel)));
      },
      child:
      Stack(
        children: [
          Hero(
            tag: 'skill_cover_${skillModel.imgUrl}',
            child: Image.asset('images/${skillModel.imgUrl ?? 'series1'}.jpg',fit: BoxFit.fill,height: 125,),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  skillModel.name,
                  style: const TextStyle(fontSize: 20,color: Colors.white),
                ),
                Text(skillModel.description ?? "",style: TextStyle(color: Colors.white),),
              ],
            ),
          )
        ],
      )
     ,
    );
  }
}
