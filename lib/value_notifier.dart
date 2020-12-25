import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Very succint, low safety.
/// Any field can be modified from anywhere.
/// Setters are always public and cannot have side effects.
class ValueNotifierStateClass {
  final count = ValueNotifier<int>(0);
  final isAwesome = ValueNotifier<bool>(false);

  /// How do you subscribe to this? Most people would do two nested ValueListenableBuilders and then
  /// put the getter inline. Or you could do all these fields inside a data class with a single
  /// ValueNotifier.
  bool get is11AndAwesome => count.value == 11 && isAwesome.value == true;
}

class ValueNotifierScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// ValueNotifier
    final state = context.watch<ValueNotifierStateClass>();

    return Scaffold(
      appBar: AppBar(
        title: Text("ValueNotifier"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Count
              ValueListenableBuilder(
                valueListenable: state.count,
                builder: (context, value, child) {
                  return Text('Count: $value');
                },
              ),

              /// isAwsome
              ValueListenableBuilder(
                valueListenable: state.isAwesome,
                builder: (context, value, child) {
                  return Text('isAwesome: $value');
                },
              ),

              /// is11AndAwesome
              ValueListenableBuilder(
                valueListenable: state.isAwesome,
                builder: (context, _, child) {
                  return ValueListenableBuilder(
                    valueListenable: state.count,
                    builder: (context, _, child) {
                      return Text('is11AndAwesome: ${state.is11AndAwesome}');
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          /// Setter is always public.
          state.count.value++;
          state.isAwesome.value = !state.isAwesome.value;
        },
        child: Icon(Icons.plus_one),
      ),
    );
  }
}
