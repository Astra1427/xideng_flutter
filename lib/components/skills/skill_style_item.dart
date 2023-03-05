import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xideng_flutter/models/skill/skill_style_dto.dart';
import 'package:xideng_flutter/pages/skills/style_detail_page.dart';

class SkillStyleItem extends StatelessWidget {
  const SkillStyleItem(this.skillStyleModel, {Key? key}) : super(key: key);

  final SkillStyleDTO skillStyleModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: InkWell(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>StyleDetailPage(styleModel: skillStyleModel)));
        },
        child:  Container(

          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start ,
            children: [
              const SizedBox(width: 10,),
              Expanded(child: Text(skillStyleModel.name,style: TextStyle(fontSize: 20),),
              ),
              Image.asset('images/${skillStyleModel.img2Url}.png',fit: BoxFit.fill,width: 250,height: 150,)
            ],
          ),
        ),
      ),
    );
  }
}
