import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Removes complexity from the view layer, puts it in the state layer.

/// More boilerplate (solved with VSCode snippets), high safety.
/// Any getter is inherintly reactive because the class is dispatching events, not the fields.
/// Can inline persistance getters on the field getter.
/// Can set a default value that is a fallback if state or persisted values don't exist.
/// Setters optionally public and can have side effects.
class ChangeNotifierStateClass extends ChangeNotifier {
  int _count;
  int get count => _count ?? /* persistance.getInt('count') ??*/ 0;
  set count(int e) {
    _count = e;
    // persistance.setInt('count', e)
    notifyListeners();
  }

  bool _isAwesome;
  bool get isAwesome =>
      _isAwesome /* persistance.getBool('isAwesome') ??*/ ?? false;
  set isAwesome(bool e) {
    _isAwesome = e;
    // persistance.setBool('isAwesome', e)
    notifyListeners();
  }

  /// This is fully reactive because listeners subscribe to [ChangeNotifierStateClass],
  /// not to individual fields.
  bool get is11AndAwesome => count == 11 && isAwesome == true;
}

class ChangeNotifierScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// Watching a [ChangeNotifier] with `provider` tags this [BuildContext]
    /// to rebuild any time there is a change. Doesn't matter if this is a
    /// [StatelessWidget] or a [StatefulWidget].
    final state = context.watch<ChangeNotifierStateClass>();

    return Scaffold(
      appBar: AppBar(
        title: Text("ChangeNotifier"),
        actions: [
          IconButton(
            icon: Icon(Icons.swap_calls),
            onPressed: () => Navigator.of(context).pushNamed('valueNotifier'),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// No builders required because the ancestor context has been tagged
              /// for rebuilds.
              Text('Count: ${state.count}'),
              Text('isAwesome: ${state.isAwesome}'),
              Text('is11AndAwesome: ${state.is11AndAwesome}'),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          /// Setter is optionally public and can trigger side effects like useage metrics.
          state.count++;
          state.isAwesome = !state.isAwesome;
        },
        child: Icon(Icons.plus_one),
      ),
    );
  }
}
