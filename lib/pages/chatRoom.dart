import 'package:chat_app/provider/chat_provider.dart';
import 'package:chat_app/widgets/emojiPickerMenu.dart';
import 'package:chat_app/widgets/messageInputField.dart';
import 'package:chat_app/widgets/userProfileBar.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_reactions/flutter_chat_reactions.dart';
import 'package:flutter_chat_reactions/model/menu_item.dart';
import 'package:flutter_chat_reactions/utilities/hero_dialog_route.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter_chat_reactions/flutter_chat_reactions.dart';
import 'package:flutter_chat_reactions/utilities/hero_dialog_route.dart';
import 'package:flutter_chat_reactions/widgets/stacked_reactions.dart';
import 'package:provider/provider.dart';
import 'package:swipe_to/swipe_to.dart';

class ChatScreen extends StatefulWidget {
  // final List<UserChatModel> messagesList;
  final int userid;
  final String username;

  const ChatScreen(
      {super.key,
      // required this.messagesList,
      required this.userid,
      required this.username});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ChatProvider>().fetchMessagesList(widget.userid);
  }

  @override
  Widget build(BuildContext context) {
    // late String reactions;
    List<String> list = [];
    // Screen start
    return Consumer<ChatProvider>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.black,
        appBar: UserProfileBar(),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: value.messagesList.length,
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                itemBuilder: (context, index) {
                  final message = value.messagesList[index];
                  final isMe = message.senderId == widget.userid;
                  return SwipeTo(
                    iconColor: Colors.white,
                    iconSize: 18,
                    iconOnRightSwipe: Icons.reply,
                    onRightSwipe: (details) {
                      print('Callback from Swipe To Right');
                    },
                    child: Consumer<ChatProvider>(
                      builder: (context, value, child) => GestureDetector(
                        onLongPress: () {
                          // navigate with a custom [HeroDialogRoute] to [ReactionsDialogWidget]
                          Navigator.of(context).push(
                            HeroDialogRoute(
                              builder: (context) {
                                return ReactionsDialogWidget(
                                  id: "${message.id}", // unique id for message
                                  messageWidget: BubbleSpecialOne(
                                      text: message.content,
                                      delivered: isMe,
                                      isSender: isMe,
                                      color: isMe
                                          ? Color.fromARGB(255, 153, 55, 156)
                                          : Colors
                                              .grey.shade800), // message widget
                                  onReactionTap: (reaction) {
                                    print('reaction: $reaction');
                                    // reactions = reaction;
                                    list.add(reaction ?? "");

                                    if (reaction == '➕') {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => EmojiPickerMenu(),
                                      ));
                                      // show emoji picker container
                                    } else {
                                      // add reaction to message
                                    }
                                  },
                                  onContextMenuTap: (MenuItem menuItem) async {
                                    print('menu item: ${menuItem.label}');

                                    if (menuItem.label == "Delete") {
                                      var r = await value.deleteMessageFromChat(
                                          message.id, message.senderId);
                                      print(
                                          "the result on deleteting the msg $r");
                                    }

                                    // handle context menu item
                                  },
                                );
                              },
                            ),
                          );
                        },
                        child: Stack(
                          children: [
                            // your message
                            Hero(
                              tag: message.id,
                              child: BubbleSpecialOne(
                                  text: message.content,
                                  delivered: isMe,
                                  isSender: isMe,
                                  color: isMe
                                      ? Color.fromARGB(255, 153, 55, 156)
                                      : Colors.grey.shade800),
                            ),

                            // reactions
                            Positioned(
                              // the position where to show your reaction
                              bottom: 4,
                              right: 20,
                              child: StackedReactions(
                                // reactions widget
                                size: 10,
                                reactions: list, // list of reaction strings
                                stackedValue:
                                    1.0, // Value used to calculate the horizontal offset of each reaction
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            MessageInputField(recipientId: widget.userid),
          ],
        ),
      ),
    );
  }
}
