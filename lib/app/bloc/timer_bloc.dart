// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:listtobloc/app/ticker.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final Ticker _ticker;
  static const int _duration = 100;

  StreamSubscription<int>? _tickerSubscription;

  TimerBloc(
    this._ticker,
    this._tickerSubscription,
  ) : super(const TimerInitial(_duration)) {
    on<TimerStarted>((event, emit) {
      // TODO: implement event handler
    });
    on<TimerPaused>((event, emit) {
      // TODO: implement event handler
    });
    on<TimerResumed>((event, emit) {
      // TODO: implement event handler
    });
    on<TimerReset>((event, emit) {
      // TODO: implement event handler
    });
    on<TimerTicked>((event, emit) {
      // TODO: implement event handler
    });

    @override
    Future<void> close() {
      _tickerSubscription?.cancel();
      return super.close();
    }

    void onStarted(TimerStarted event, Emitter<TimerState> emit) {
      emit(TimerRunInProgress(event.duration));
      _tickerSubscription?.cancel();
      _tickerSubscription = _ticker.tick(ticks: event.duration).listen(
        (duration) {
          add(TimerTicked(duration: duration));
        },
      );
    }

    void _onPaused(TimerPaused event, Emitter<TimerState> emit) {
      if (state is TimerRunInProgress) {
        _tickerSubscription?.pause();
        emit(TimerRunPause(state.duration));
      }
    }

    void _onResumed(TimerResumed resume, Emitter<TimerState> emit) {
      if (state is TimerRunPause) {
        _tickerSubscription?.resume();
        emit(TimerRunInProgress(state.duration));
      }
    }

    void _onReset(TimerReset event, Emitter<TimerState> emit) {
      _tickerSubscription?.cancel();
      emit(const TimerInitial(_duration));
    }

    void _onTicked(TimerTicked event, Emitter<TimerState> emit) {
      emit(
        event.duration > 0
            ? TimerRunInProgress(event.duration)
            : const TimerRunComplete(),
      );
    }
  }
}
