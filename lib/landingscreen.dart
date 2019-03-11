import 'package:english_words/english_words.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Name Generator',
      theme: new ThemeData(
        primaryColor: Colors.red,
      ),
      home: /*Home(),*/ RandomWords(),
    );
  }
}

class RandomWordState extends State<RandomWords> {
  @override
  final List<WordPair> _suggestions = <WordPair>[];
  final Set<WordPair> _saved = new Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);
  static const String flutterUrl = 'https://flutter.io/';
  static const String githubUrl = 'https://github.com/KrishnaAlagiri/Infi-Name';
  TapGestureRecognizer _flutterTapRecognizer;
  TapGestureRecognizer _githubTapRecognizer;

  static const TextStyle linkStyle = const TextStyle(
    color: Colors.blue,
    decoration: TextDecoration.underline,
  );

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Name Generator'),
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved),
          new IconButton(icon: const Icon(Icons.info), onPressed: _showDialog),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  void _openUrl(String url) async {
    // Close the about dialog.
    Navigator.pop(context);

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => _buildAboutDialog(context),
    );
  }

  @override
  void initState() {
    super.initState();
    _flutterTapRecognizer = new TapGestureRecognizer()
      ..onTap = () => _openUrl(flutterUrl);
    _githubTapRecognizer = new TapGestureRecognizer()
      ..onTap = () => _openUrl(githubUrl);
  }

  @override
  Widget _buildAboutDialog(BuildContext context) {
    return new AlertDialog(
      title: const Text('About'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildAboutText(),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Okay, got it!'),
        ),
      ],
    );
  }

  Widget _buildAboutText() {
    return new RichText(
      text: new TextSpan(
        text:
            'A simple mobile app developed using Flutter that generates proposed names for Starups, Events etc. Supports both Android and iOS. \n\n',
        style: const TextStyle(color: Colors.black87),
        children: <TextSpan>[
          const TextSpan(
              text: 'The app was developed by Krishna Alagiri (KK) with '),
          new TextSpan(
            text: 'Flutter',
            recognizer: _flutterTapRecognizer,
            style: linkStyle,
          ),
          const TextSpan(
            text: ' and it\'s open source; check out the source '
                'code yourself from ',
          ),
          new TextSpan(
            text: 'https://github.com/KrishnaAlagiri/Infi-Name',
            recognizer: _githubTapRecognizer,
            style: linkStyle,
          ),
          const TextSpan(text: '.'),
        ],
      ),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
            (WordPair pair) {
              return new ListTile(
                title: new Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return new Scaffold(
            appBar: new AppBar(
              title: const Text('Saved Suggestions'),
            ),
            body: new ListView(children: divided),
          );
        },
      ),
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
          onTap: () {
            setState(() {
              if (alreadySaved) {
                _saved.remove(pair);
              } else {
                _saved.add(pair);
              }
            });
          });
    }

    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (BuildContext _context, int i) {
          if (i.isOdd) {
            return const Divider();
          }
          final int index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }
}

class RandomWords extends StatefulWidget {
  RandomWordState createState() => new RandomWordState();
}
