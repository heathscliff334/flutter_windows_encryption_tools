import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_encryption_app/src/res/dimens.dart';

class DefaultContentLayout extends StatelessWidget {
  const DefaultContentLayout(
      {Key? key, required this.contentHeader, required this.contentWidget})
      : super(key: key);

  final Widget contentHeader;
  final Widget contentWidget;
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      padding: const EdgeInsets.all(20),
      header: Padding(padding: PAD_SYM_V20, child: contentHeader),
      content: SingleChildScrollView(
        child: Container(padding: PAD_ASYM_H20_V20, child: contentWidget),
      ),
    );
  }
}
