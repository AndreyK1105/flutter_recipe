import 'package:flutter/material.dart';

abstract class HeaderWidgetState {}

class HeaderWidgetStateEmpty extends HeaderWidgetState {}

class HeaderWidgetStateLike extends HeaderWidgetState {
  int aggregateLikes;
  HeaderWidgetStateLike({required this.aggregateLikes});
}

class HeaderWidgetStateUnLike extends HeaderWidgetState {
  int aggregateLikes;
  HeaderWidgetStateUnLike({required this.aggregateLikes});
}
