import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterState(count: 0));

  void increment() {
    log("incresement....");
    emit(CounterState(count: state.count + 1));
  }

  void decrement() {
    log("decreasement");
    emit(CounterState(count: state.count - 1));
  }
}

class CounterCubit2 extends Cubit<int> {
  CounterCubit2() : super(0);

  void increment() => emit(state + 1);

  void decrement() => emit(state - 1);
}
