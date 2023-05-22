import 'package:flutter/material.dart';

class Spinner extends Center {
  const Spinner({super.key})
      : super(
          child: const SizedBox(
            height: 25.0,
            width: 25.0,
            child: CircularProgressIndicator(),
          ),
        );
}
