import 'package:flutter/material.dart';

import '../../constants/app_sizes.dart';

enum TaskTileType {alert, normal}
class AppTaskListTile extends StatelessWidget {
  const AppTaskListTile({
    super.key,
    required this.title,
    this.count,
    required this.type,
  });

  final String title;
  final int? count;
  final TaskTileType type;

  @override
  Widget build(BuildContext context) {
    final x = _map(type);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: x.dotColor,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: SizedBoxSizes.sizedBoxSmallWidth),
        Text(
          count != null ? '$title ($count)' : title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: x.fontWeight,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  _TileConfig _map(TaskTileType type) {
    switch (type) {
      case TaskTileType.alert:
        return _TileConfig(
          dotColor: Colors.red,
          fontWeight: FontWeight.w800,
        );
      case TaskTileType.normal:
        return _TileConfig(
          dotColor: Colors.green,
          fontWeight: FontWeight.w500,
        );
    }
  }
}

class _TileConfig {
  final Color dotColor;
  final FontWeight fontWeight;

  _TileConfig({
    required this.dotColor,
    required this.fontWeight,
  });
}
