part of 'utils.dart';

class BoolTextButton extends StatelessWidget {
  const BoolTextButton({
    Key? key,
    required this.result,
    this.text = '取消',
  }) : super(key: key);

  final String text;
  final bool result;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pop(result);
      },
      child: Text(text),
    );
  }
}

class LoadingDialog extends StatefulWidget {
  const LoadingDialog(
      {Key? key,
      required this.title,
      this.successText = '操作成功',
      this.failText = '操作失败'})
      : super(key: key);

  final String title;
  final String successText;
  final String failText;

  @override
  State<LoadingDialog> createState() => _LoadingDialogState();
}

class _LoadingDialogState extends State<LoadingDialog> {

  @override
  void initState() {
    super.initState();
    isShown = true;
  }

  static bool isShown = false;

  @override
  void dispose() {
    super.dispose();
    isShown = false;
  }

  @override
  Widget build(BuildContext context) {
    final EdgeInsets effectivePadding = MediaQuery.of(context).viewInsets + (EdgeInsets.zero);
    return MediaQuery.removeViewInsets(
        context: context,
        removeBottom: true,
        removeLeft: true,
        removeRight: true,
        removeTop: true,
        child: Container(

          constraints: const BoxConstraints(minWidth: 280.0),
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 300,horizontal: 50),
          width: double.minPositive,
          height: double.minPositive,
          child: Material(
            type: MaterialType.card,
            borderRadius: BorderRadius.circular(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 36,
                  height: 36,
                  child: CircularProgressIndicator(),
                ),
                Text(widget.title),
              ],
            ),
          ),
        ));
  }
}
