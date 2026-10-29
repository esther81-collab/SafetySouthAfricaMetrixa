import 'package:flutter/material.dart';

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<ChatMessage> _messages = [
    ChatMessage(
      text:
          "Hello! I'm your Metrixa Safety & Support Companion. I'm here to offer motivation, safety guidance, and a listening ear. How can I support you today?",
      isUser: false,
    ),
  ];

  bool _isTyping = false;

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _handleSubmitted(String text) async {
    if (text.trim().isEmpty) return;

    _controller.clear();
    setState(() {
      _messages.add(ChatMessage(text: text, isUser: true));
      _isTyping = true;
    });
    _scrollToBottom();

    // Simulate AI thinking delay
    await Future.delayed(const Duration(milliseconds: 1000));

    final response = _generateBotResponse(text);

    if (mounted) {
      setState(() {
        _isTyping = false;
        _messages.add(ChatMessage(text: response, isUser: false));
      });
      _scrollToBottom();
    }
  }

  String _generateBotResponse(String query) {
    final q = query.toLowerCase();

    if (q.contains('motivate') || q.contains('sad') || q.contains('alone') || q.contains('fear') || q.contains('scared')) {
      return "You are stronger than you know, and you are never alone. Taking things one step at a time takes immense courage. Remember to breathe, trust your instincts, and reach out to trusted loved ones or our emergency tools whenever you need support.";
    } else if (q.contains('walk') || q.contains('night') || q.contains('transport') || q.contains('safety') || q.contains('tip')) {
      return "Here is a quick safety tip: When walking or traveling, stay in well-lit areas, keep your phone charged and easily accessible, walk with confidence, and let someone trusted know your ETA and route.";
    } else if (q.contains('abuse') || q.contains('gbv') || q.contains('violence') || q.contains('help') || q.contains('hotline')) {
      return "If you or someone you know is facing abuse or danger, please remember professional help is available 24/7:\n• National GBV Command Centre: 0800 428 428\n• Emergency Services: 10111\n• Use the Emergency tab in Metrixa for instant SOS location sharing.";
    } else if (q.contains('contact') || q.contains('sos') || q.contains('emergency')) {
      return "You can add trusted family members or friends in the Emergency tab. Taping 'Share Live Location' instantly sends your exact GPS coordinates via Google Maps to help responders find you quickly.";
    } else {
      return "I hear you, and your safety and well-being are our top priorities. Whether you need guidance on safety tips, emotional encouragement, or emergency tools, I am here to help. What else is on your mind?";
    }
  }

  void _sendPreset(String text) {
    _controller.text = text;
    _handleSubmitted(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xFF5B3FD0),
              child: const Icon(Icons.support_agent, color: Colors.white, size: 22),
            ),
            const SizedBox(width: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Metrixa Assistant', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text('Online • Safety & Support', style: TextStyle(fontSize: 11, color: Colors.grey)),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Column(
        children: [
          // Preset suggestions
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            color: Colors.grey.shade100,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ActionChip(
                    label: const Text('💪 I need motivation'),
                    onPressed: () => _sendPreset('I need some motivation today'),
                  ),
                  const SizedBox(width: 8),
                  ActionChip(
                    label: const Text('🚶‍♀️ Walking safety tips'),
                    onPressed: () => _sendPreset('Give me safety tips for walking alone'),
                  ),
                  const SizedBox(width: 8),
                  ActionChip(
                    label: const Text('🆘 Emergency resources'),
                    onPressed: () => _sendPreset('Where can I get emergency help or GBV support?'),
                  ),
                ],
              ),
            ),
          ),

          // Messages list
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length + (_isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _messages.length) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                          SizedBox(width: 8),
                          Text('Assistant is typing...', style: TextStyle(color: Colors.grey, fontSize: 13)),
                        ],
                      ),
                    ),
                  );
                }

                final msg = _messages[index];
                return Align(
                  alignment: msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                    decoration: BoxDecoration(
                      color: msg.isUser ? const Color(0xFF5B3FD0) : Colors.white,
                      borderRadius: BorderRadius.circular(18).copyWith(
                        bottomRight: msg.isUser ? const Radius.circular(0) : const Radius.circular(18),
                        bottomLeft: !msg.isUser ? const Radius.circular(0) : const Radius.circular(18),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(13),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      msg.text,
                      style: TextStyle(
                        color: msg.isUser ? Colors.white : Colors.black87,
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Input bar
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      hintText: 'Type your message or ask for advice...',
                      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onSubmitted: _handleSubmitted,
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: const Color(0xFF5B3FD0),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white, size: 18),
                    onPressed: () => _handleSubmitted(_controller.text),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
