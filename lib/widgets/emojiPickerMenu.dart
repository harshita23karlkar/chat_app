import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EmojiPickerMenu extends StatefulWidget {
  const EmojiPickerMenu({super.key});

  @override
  State<EmojiPickerMenu> createState() => _EmojiPickerMenuState();
}

class _EmojiPickerMenuState extends State<EmojiPickerMenu> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  bool _emojiShowing = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: ValueListenableBuilder(
                valueListenable: _controller,
                builder: (context, text, child) {
                  return Text(
                    _controller.text,
                  );
                },
              ),
            ),
          ),
          Offstage(
            offstage: !_emojiShowing,
            child: EmojiPicker(
              textEditingController: _controller,
              scrollController: _scrollController,
              config: const Config(
                height: 256,
                checkPlatformCompatibility: true,
                viewOrderConfig: ViewOrderConfig(),
                emojiViewConfig: EmojiViewConfig(),
                skinToneConfig: SkinToneConfig(),
                categoryViewConfig: CategoryViewConfig(),
                bottomActionBarConfig: BottomActionBarConfig(),
                searchViewConfig: SearchViewConfig(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
