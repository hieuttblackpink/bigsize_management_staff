// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'deals.dart';

class GraphsData extends Equatable {
  List<int> money;
  List<int> orders;

  List<int> get moneyGraph => money.isEmpty ? [0] : money;
  List<int> get ordersGraph => orders.isEmpty ? [0] : orders;

  GraphsData({required this.money, required this.orders});

  factory GraphsData.empty() => GraphsData(money: const [0], orders: const [0]);

  bool get isEmpty => money.isEmpty && orders.isEmpty;

  @override
  List<Object?> get props => [money.firstOrNull, orders.firstOrNull];
}

class DealsData extends Equatable {
  List<Deal> deals;
  int start;
  int end;
  int maxNumber;

  DealsData({
    required this.deals,
    required this.start,
    required this.end,
    required this.maxNumber,
  });

  factory DealsData.empty() =>
      DealsData(deals: const [], start: 0, end: 0, maxNumber: 0);

  bool get isEmpty => deals.isEmpty;
  bool get isEnd => end == maxNumber;

  void getNext() {
    start = end;
    end = end + 20;
    if (end > maxNumber) end = maxNumber;
  }

  @override
  List<Object?> get props => [start, end];
}

class ShowData<T> extends Equatable {
  List<T> data;
  int start = 0;
  int end = 20;
  int maxNumber;
  bool isLoading = false;

  ShowData({
    required this.data,
    required this.maxNumber,
  });

  factory ShowData.empty() => ShowData(data: const [], maxNumber: 0);

  bool get isEmpty => data.isEmpty;
  bool get isEnd => (start + data.length) == maxNumber;

  void getNext() {
    end = start + data.length;
    end = end + 20;
    if (end > maxNumber) end = maxNumber;
  }

  Widget get lastItem =>
      isEnd ? Container() : const Center(child: CircularProgressIndicator());

  @override
  List<Object?> get props => [start, end, isLoading];
}
