import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xideng_flutter/common/utils.dart';
import 'package:xideng_flutter/models/account/account_dto.dart';
import 'package:xideng_flutter/pages/account/login_page.dart';
import 'package:xideng_flutter/providers/account_provider.dart';
import 'package:xideng_flutter/styles/main_style.dart';

import '../services/account_service.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      debugPrint('post frame callback...');
    });
  }
  var accountService = AccountService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的'),
      ),
      body: Consumer<AccountProvider>(
        builder: (context, provider, child) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: ListView(
              children: [
                buildUserInfoPanel(provider.currentUser,provider),
                const SizedBox(
                  height: 30,
                ),
                buildLoginLogoutButton(provider.currentUser != null, provider)
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildLoginLogoutButton(bool isLogged, AccountProvider provider) {
    return ElevatedButton(
      onPressed: () async {
        if (isLogged) {
          var result = await context.showMsg('退出？', actions: [
            const BoolTextButton(
              text: '确定',
              result: true,
            ),
            const BoolTextButton(
              text: '取消',
              result: false,
            ),
          ]);
          if (result != null && result) {
            print(provider.currentUser);
            //logout
            provider.setCurrentUser(null);
          }
          return;
        }
        // goto login page
        // Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginPage()));
        showDialog<void>(
          context: context,
          // false = user must tap button, true = tap outside dialog
          builder: (BuildContext dialogContext) {
            return const LoginPage();
          },
        );
      },
      child: Text(isLogged ? '退出登录' : '去登录'),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
              isLogged ? Colors.redAccent : Colors.blue)),
    );
  }

  Widget buildUserInfoPanel(AccountDTO? user,AccountProvider provider) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: Theme.of(context).primaryColor),
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          buildUserAvatar(user?.photoUrl),
          const SizedBox(
            width: 10,
          ),
          Expanded(child: buildUserInfo(user)),
          const SizedBox(width: 10,),
          ElevatedButton(
            onPressed: (){
              sync(provider);
            },
            child: const Text('同步'),
          ),
          const SizedBox(width: 10,)
        ],
      ),
    );
  }

  Widget buildUserAvatar(String? photoUrl) {
    if (photoUrl == null) {
      return const XiDengLogo(height: 75);
    } else {
      return Image.network(
        photoUrl,
        height: 75,
        width: 75,
        fit: BoxFit.cover,
      );
    }
  }

  Widget buildUserInfo(AccountDTO? user) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          user?.name ?? "请登录",
          style: const TextStyle(fontSize: 18),
        ),
        Text(user?.introduce ?? ''),
      ],
    );
  }

  Widget buildMyList() {
    return Column();
  }

  void sync(AccountProvider provider) async{
    /*var result = await context.showSelectionDialog("同步", [
                "下载云端数据到本地",
                "上传本地数据到云端"
              ]);
              if(!mounted){
                return;
              }
              // await context.showMsg(result?.toString() ?? 'test');
              if(result == "下载云端数据到本地"){

              }*/

    context.showLoading("同步中...");
    var result =await accountService.cloudToLocal(provider.currentUser?.jwtToken ?? "");
    if(!mounted){
      return;
    }
    context.closeLoading();
    if(result.isSuccess){
      context.showMsg(result.msg);
      if(result.dataModel == null){
        context.showMsg("同步失败:\n获取数据失败！");
        return;
      }
      provider.setCurrentUser(result.dataModel?.account);
      context.showMsg(result.dataModel?.exercisePlans.first.name ?? "");
    }else{
      context.showMsg(result.msg);
    }

  }
}
