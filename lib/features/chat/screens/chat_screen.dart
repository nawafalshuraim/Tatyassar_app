import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:tatyassar/data/repositories/authentication/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:tatyassar/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:tatyassar/features/chat/screens/widgets/bot_message.dart';
import 'package:tatyassar/features/chat/screens/widgets/chat_appbar.dart';
import 'package:tatyassar/features/chat/screens/widgets/user_message.dart';
import 'package:tatyassar/utils/constants/colors.dart';
import 'widgets/typing_indicator.dart';

const String _idssBaseUrl = 'http://localhost:8000';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, String>> messages = [];

  bool _isTyping = false;

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      messages.add({"role": "user", "text": text});
      _controller.clear();
      _isTyping = true;
    });

    _saveMessage(text, "user");
    _scrollToBottom();
    _callIDSS(text);
  }

  Future<void> _callIDSS(String userText) async {
    try {
      final response = await http.post(
        Uri.parse('$_idssBaseUrl/chat'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'message': userText}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final reply = data['reply'] as String? ?? '...';
        setState(() {
          messages.add({"role": "bot", "text": reply});
          _isTyping = false;
        });
        _saveMessage(reply, "bot");
      } else {
        _showError();
      }
    } catch (_) {
      _showError();
    }
    _scrollToBottom();
  }

  void _showError() {
    setState(() {
      messages.add({
        "role": "bot",
        "text": "Sorry, I couldn't connect to the server. Please try again."
      });
      _isTyping = false;
    });
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _saveMessage(String text, String role) async {
    final userId = AuthenticationRepository.instance.authUser.uid;
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('chats')
        .add({
      'text': text,
      'role': role,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CPrimaryHeaderContainer(
            child: Column(
              children: const [
                CChatAppBar(),
                SizedBox(height: 20),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      return message["role"] == "user"
                          ? UserMessage(text: message["text"]!)
                          : BotMessage(text: message["text"]!);
                    },
                  ),
                ),
                if (_isTyping) const TypingIndicator(),
                _inputBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(top: BorderSide(color: Theme.of(context).dividerColor)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              minLines: 1,
              maxLines: 4,
              onSubmitted: (_) => _sendMessage(),
              decoration: InputDecoration(
                hintText: "Share how you're feeling...",
                hintStyle: TextStyle(color: Theme.of(context).hintColor),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      BorderSide(color: CColors.primary.withValues(alpha: 0.2)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                      color: CColors.primary.withValues(alpha: 0.8), width: 2),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              scrollPhysics: const BouncingScrollPhysics(),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send_rounded),
            onPressed: _isTyping ? null : _sendMessage,
            color: CColors.primary,
          ),
        ],
      ),
    );
  }
}
