import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xideng_flutter/common/utils.dart';
import 'package:xideng_flutter/pages/account/login_page.dart';
import 'package:xideng_flutter/providers/account_provider.dart';

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
      /*if(Provider.of<AccountProvider>(context,listen: false).currentUser == null){
        showDialog<void>(
          context: context,
          barrierDismissible: true,
          // false = user must tap button, true = tap outside dialog
          builder: (BuildContext dialogContext) {
            return const LoginPage();
          },
        );
      }*/
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的'),
      ),
      body: Consumer<AccountProvider>(
        builder: (context, provider, child) {
          return Container(
            padding: const EdgeInsets.all(8),
            child: ListView(
              children: [
                Text(provider.currentUser?.name ?? "请登录"),
                LoginLogoutButton(provider.currentUser != null, provider)
              ],
            ),
          );
        },
      ),
    );
  }

  Widget LoginLogoutButton(bool isLogged, AccountProvider provider) {
    return ElevatedButton(
      onPressed: () async {
        if(isLogged){
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
      child: Text(isLogged ? '退出登录' : '去登录'
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(isLogged ? Colors.redAccent : Colors.blue)
      ),
    );
  }
}
