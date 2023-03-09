import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xideng_flutter/common/extensions/string_extension.dart';
import 'package:xideng_flutter/common/utils.dart';
import 'package:xideng_flutter/models/account/account_dto.dart';
import 'package:xideng_flutter/models/account/register.dart';
import 'package:xideng_flutter/providers/account_provider.dart';
import 'package:xideng_flutter/providers/theme_provider.dart';
import 'package:xideng_flutter/services/service_response.dart';

import '../../services/account_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var txtUserNameController = TextEditingController();
  var txtEmailController = TextEditingController();
  var txtPasswordController = TextEditingController();
  var txtConfirmPasswordController = TextEditingController();
  var txtVerifyCodeController = TextEditingController();

  final double columnSpacer = 10;
  bool isRegisterPage = false;
  String pageTitle = '登录';
  ThemeMode? currentThemeModel;
  var accountService = AccountService();

  String sendVerifyCodeButtonText = '发送验证码';
  int lastSendSecond = -1;
  late Timer sendSecondCountDownTimer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        currentThemeModel =
            Provider
                .of<AppThemeProvider>(context, listen: false)
                .currentThemeMode;
      });
    });
    sendSecondCountDownTimer =
        Timer.periodic(const Duration(seconds: 1), (timer) {
          debugPrint((lastSendSecond > 0).toString());

          setState(() {
            if (lastSendSecond > 0) {
              lastSendSecond --;
              sendVerifyCodeButtonText = '$lastSendSecond秒后可发送验证码';
            } else {
              sendVerifyCodeButtonText = '发送验证码';
            }
          });
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    txtUserNameController.dispose();
    txtEmailController.dispose();
    txtPasswordController.dispose();
    txtConfirmPasswordController.dispose();
    txtVerifyCodeController.dispose();
    sendSecondCountDownTimer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            //logo
            const XiDengLogo(height: 100),
            const SizedBox(height: 30),
            if(isRegisterPage) Column(
              children: [
                buildOutlinedTextField(labelText: '用户名',
                    controller: txtUserNameController,
                    textInputAction: TextInputAction.next),
                SizedBox(height: columnSpacer)
              ],
            ),
            buildEmailField(),
            SizedBox(height: columnSpacer),
            buildPasswordField(controller: txtPasswordController, label: '密码'),
            SizedBox(height: columnSpacer),
            if (isRegisterPage) buildRegisterBody(),
            buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text(isRegisterPage ? '注册' : '登录'),
      actions: [
        ClipOval(
          child: TextButton(
              onPressed: () {
                switchRegister();
              },
              child: Text(
                isRegisterPage ? '登录' : '注册',
                style: TextStyle(
                    color: currentThemeModel == ThemeMode.light
                        ? Colors.yellow
                        : null),
              )),
        ),
      ],
    );
  }



  Widget buildEmailField() {
    return buildOutlinedTextField(
        controller: txtEmailController,
        labelText: '邮箱',
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next);
  }

  TextField buildPasswordField(
      {required TextEditingController controller, required String label}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
      ),
      obscureText: true,
      textInputAction: TextInputAction.next,
    );
  }

  Widget buildRegisterBody() {
    return Column(
      children: [
        buildPasswordField(
            controller: txtConfirmPasswordController, label: '确认密码'),
        SizedBox(height: columnSpacer),
        buildOutlinedTextField(
            controller: txtVerifyCodeController,
            labelText: '验证码',
            suffix: TextButton(
              onPressed: () {
                sendVerifyCode();
              },
              child: Text(sendVerifyCodeButtonText),
            )),
        SizedBox(height: columnSpacer),
      ],
    );
  }

  ElevatedButton buildSubmitButton() {
    return ElevatedButton(
      onPressed: isRegisterPage ? register : login,
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          isRegisterPage ? '注册' : '登录',
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  Widget buildOutlinedTextField({TextEditingController? controller,
    String? labelText,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    Widget? suffix}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
          suffixIcon: suffix),
      keyboardType: keyboardType,
      textInputAction: textInputAction,
    );
  }

  void switchRegister() {
    setState(() {
      isRegisterPage = !isRegisterPage;
    });
  }

  void login() async {
    if (txtEmailController.text.isEmpty || txtPasswordController.text.isEmpty) {
      context.showSnackBar('请输入邮箱和密码');
      return;
    }

    var loginTask = accountService.authenticate(
        txtEmailController.text, txtPasswordController.text);
    // var result = await context.showLoading<ServiceResponse<AccountDTO>>('登陆中...',loginTask);

    context.showLoading('登录中...');

    // var showMsgTask = context.showMsg('loading...');
    await Future.delayed(const Duration(seconds: 4));
    var result = await loginTask;

    // var result = (await Future.any([loginTask,showMsgTask])) as ServiceResponse<AccountDTO>;

    if (!mounted) {
      return;
    }

    context.closeLoading();
    debugPrint('login next..');

    if (result.isSuccess) {
      if (result.dataModel == null) {
        context.showMsg('获取账号信息失败！', title: '登录失败');
        return;
      }
      Provider.of<AccountProvider>(context, listen: false)
          .setCurrentUser(result.dataModel!);

      context.showSnackBar('登录成功！');
      Navigator.pop(context);
    } else {
      context.showSnackBar(result.msg);
    }
  }

  void sendVerifyCode() async {
    if (!txtEmailController.text.isEmail()) {
      context.showSnackBar('请输入正确邮箱地址');
      return;
    }
    if (lastSendSecond > 0) {
      context.showSnackBar('请等待$lastSendSecond秒后再尝试发送验证码');
      return;
    }

    context.showLoading('发送中...');
    await Future.delayed(Duration(milliseconds: 500));
    var result = await accountService.sendVerifyCode(txtEmailController.text);

    setState(() {
      lastSendSecond = result.dataModel!;
    });

    if (!mounted) return;
    context.closeLoading();
    context.showSnackBar(result.msg);
  }

  void register() async{
    if(txtUserNameController.text.isEmpty){
      context.showSnackBar('请输入用户名');
      return;
    }
    if (txtEmailController.text.isEmpty || txtPasswordController.text.isEmpty) {
      context.showSnackBar('请输入邮箱和密码');
      return;
    }
    if (!txtEmailController.text.isEmail()) {
      context.showSnackBar('请输入正确邮箱地址');
      return;
    }
    if (txtConfirmPasswordController.text.isEmpty) {
      context.showSnackBar('请输入确认密码');
      return;
    }
    if (txtVerifyCodeController.text.isEmpty) {
      context.showSnackBar('请输入验证码');
      return;
    }

    //register
    var result = await accountService.register(RegisterRequestBody(
        name: txtUserNameController.text,
        email: txtEmailController.text,
        password: txtPasswordController.text,
        confirmPassword: txtConfirmPasswordController.text,
        registerCode: txtVerifyCodeController.text));

    if(!mounted) return;

    context.showSnackBar(result.msg);
  }
}
