import 'package:flutter/material.dart';

class Spinner extends Center {
  Spinner()
      : super(
          child: SizedBox(
            height: 25.0,
            width: 25.0,
            child: CircularProgressIndicator(),
          ),
        );
}
