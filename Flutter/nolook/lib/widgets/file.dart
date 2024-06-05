import 'package:flutter/material.dart';

// File 아이콘에 대한 클래스
class File extends StatelessWidget {
  final bool isSelectionMode;
  final int index;
  final bool isSelected;
  final ValueChanged<bool?> onChanged;

  const File({
    super.key,
    required this.isSelectionMode,
    required this.index,
    required this.isSelected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.15,
          child: Column(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.folder,
                  size: MediaQuery.of(context).size.width * 0.2,
                  color: Colors.blue,
                ),
              ),
              const Text('fcf'),
            ],
          ),
        ),
        if (isSelectionMode)
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.03,
            left: MediaQuery.of(context).size.width * 0.06,
            child: Checkbox(
              fillColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return const Color.fromARGB(255, 8, 12, 204);
                }
                return null;
              }),
              value: isSelected,
              onChanged: onChanged,
            ),
          ),
      ],
    );
  }
}
