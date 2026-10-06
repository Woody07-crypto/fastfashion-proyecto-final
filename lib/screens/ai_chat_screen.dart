import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  final _controller = TextEditingController();
  final List<_Message> _messages = [
    const _Message(
      fromUser: false,
      text:
          'Hola, soy tu asistente de estilo. Prueba: '
          '"Hoy quiero usar una camisa azul con un pantalón blanco".',
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(_Message(fromUser: true, text: text));
      _messages.add(
        _Message(
          fromUser: false,
          text: _mockReply(text),
        ),
      );
      _controller.clear();
    });
  }

  String _mockReply(String prompt) {
    final lower = prompt.toLowerCase();
    if (lower.contains('azul') && lower.contains('blanco')) {
      return 'Encontré en tu closet: Camisa azul oxford + Pantalón chino beige '
          '(alternativa clara) + Zapatos café. ¿Quieres otra opción?';
    }
    if (lower.contains('formal')) {
      return 'Outfit formal sugerido: Camisa blanca lino + Pantalón negro vestir '
          '+ Zapatos café + Cinturón negro.';
    }
    return 'Busqué en tu closet y preparé una combinación acorde al clima '
        'de hoy (28°C, soleado). Toca Regenerar en Inicio si quieres otra.';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Pregunta a la IA',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.ink,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Describe lo que quieres usar; la IA busca en tu closet.',
                  style: TextStyle(color: AppTheme.ink.withValues(alpha: 0.65)),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              final msg = _messages[index];
              return Align(
                alignment:
                    msg.fromUser ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(14),
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.8,
                  ),
                  decoration: BoxDecoration(
                    color: msg.fromUser ? AppTheme.teal : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: msg.fromUser
                        ? null
                        : Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Text(
                    msg.text,
                    style: TextStyle(
                      color: msg.fromUser ? Colors.white : AppTheme.ink,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Escribe tu pedido de outfit…',
                    ),
                    onSubmitted: (_) => _send(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  onPressed: _send,
                  style: IconButton.styleFrom(backgroundColor: AppTheme.teal),
                  icon: const Icon(Icons.send, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Message {
  final bool fromUser;
  final String text;

  const _Message({required this.fromUser, required this.text});
}
