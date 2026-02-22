import 'package:flutter/material.dart';
import '../models/baseball_card.dart';
import 'add_card_screen.dart';

class CardListScreen extends StatefulWidget {
  const CardListScreen({super.key});

  @override
  State<CardListScreen> createState() => _CardListScreenState();
}

class _CardListScreenState extends State<CardListScreen> {
  final List<BaseballCard> _cards = [];

  void _addCard(BaseballCard card) {
    setState(() {
      _cards.add(card);
    });
  }

  Future<void> _openAddCard() async {
    final newCard = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddCardScreen()),
    );

    if (newCard != null && newCard is BaseballCard) {
      _addCard(newCard);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Baseball Cards')),
      body: _cards.isEmpty
          ? const Center(child: Text('No cards yet ⚾'))
          : ListView.builder(
              itemCount: _cards.length,
              itemBuilder: (context, index) {
                final card = _cards[index];
                return Card(
                  child: ListTile(
                    title: Text(card.playerName),
                    subtitle: Text('${card.year} • ${card.team}'),
                    trailing: Text(card.condition),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddCard,
        child: const Icon(Icons.add),
      ),
    );
  }
}
