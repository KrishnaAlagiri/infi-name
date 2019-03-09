import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Name Generator',
      home: RandomWords(),
    );
  }
}

class RandomWordState extends State<RandomWords> {
  @override
  final List<WordPair>_suggestions = <WordPair>[];
  final Set<WordPair> _saved = new Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Name Generator'),
      ),
      body: _buildSuggestions(),
    );
  }


  Widget _buildSuggestions() {
    Widget _buildRow(WordPair pair) {
      final bool alreadySaved = _saved.contains(pair);

      return new ListTile(
        title: new Text(
          pair.asPascalCase,
          style: _biggerFont,
        ),
        trailing: new Icon(
          alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.red : null,
        ),
      );
    }

    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(); /*2*/
          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(_suggestions[index]);
        });



  }
}

class RandomWords extends StatefulWidget {
  RandomWordState createState() => new RandomWordState();
}
