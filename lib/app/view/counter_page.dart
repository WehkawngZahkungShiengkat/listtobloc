// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:listtobloc/app/cubit/counter_cubit.dart';

class CounterPage extends StatelessWidget {
  static const routeName = '/counterlist';
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CountersListView();
  }
}

class CountersListView extends StatefulWidget {
  @override
  State<CountersListView> createState() => _CountersListViewState();
}

class _CountersListViewState extends State<CountersListView> {
  // CountersListView({super.key});
  final List<CounterCubit> _counterCubit = [
    CounterCubit(),
    CounterCubit(),
    CounterCubit()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Counters"),
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Column(
            children: List.generate(
                3,
                (index) => BlocProvider.value(
                      value: _counterCubit[index],
                      child: CounterView(
                        viewId: (index + 1).toString(),
                      ),
                    )),
          )),
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (int i = 0; i < _counterCubit.length; i++) {
      _counterCubit[i].close();
    }

    super.dispose();
  }
}

class CounterView extends StatelessWidget {
  final String viewId;
  const CounterView({
    Key? key,
    required this.viewId,
  }) : super(key: key);

  @override
  Widget build(BuildContext counterBuildercontext) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          border: Border.all(
              color:
                  Colors.primaries[Random().nextInt(Colors.primaries.length)]),
        ),
        // color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "counter $viewId",
                style: const TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Builder(
                    builder: (counterCubitcontext) {
                      return FloatingActionButton(
                        heroTag: "counter$viewId decrease btn",
                        onPressed: () {
                          counterCubitcontext.read<CounterCubit>().decrement();
                        },
                        child: const Icon(Icons.remove),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BlocBuilder<CounterCubit, CounterState>(
                      builder: (counterCubitcontext, state) {
                        return Text(
                          state.count.toString(),
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                  ),
                  Builder(
                    builder: (counterCubitcontext) {
                      return FloatingActionButton(
                        heroTag: "counter$viewId increase btn",
                        onPressed: () {
                          BlocProvider.of<CounterCubit>(counterCubitcontext)
                              .increment();
                          // context.read<CounterCubit>().increment();
                        },
                        child: const Icon(Icons.add),
                      );
                    },
                  ),
                ],
              ),
              Builder(builder: (counterCubitcontext) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        counterCubitcontext,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: BlocProvider.of<CounterCubit>(
                                counterCubitcontext),
                            child: CounterDetailView(
                              viewId: viewId,
                            ),
                          ),
                        ),
                      );
                    },
                    child: Text("Go To Counter $viewId"),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class CountersListView1 extends StatelessWidget {
  const CountersListView1({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Counters"),
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Column(
            children: List.generate(
                3,
                (index) => CounterView1(
                      viewId: (index + 1).toString(),
                    )),
          )),
        ),
      ),
    );
  }
}

class CounterView1 extends StatelessWidget {
  final String viewId;
  const CounterView1({
    Key? key,
    required this.viewId,
  }) : super(key: key);

  @override
  Widget build(BuildContext counterBuildercontext) {
    return BlocProvider(
      create: (counterCubitcontext) => CounterCubit(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            border: Border.all(
                color: Colors
                    .primaries[Random().nextInt(Colors.primaries.length)]),
          ),
          // color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "counter $viewId",
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Builder(builder: (counterCubitcontext) {
                      return FloatingActionButton(
                        heroTag: "counter$viewId increase btn",
                        onPressed: () {
                          BlocProvider.of<CounterCubit>(counterCubitcontext)
                              .increment();
                          // context.read<CounterCubit>().increment();
                        },
                        child: const Icon(Icons.add),
                      );
                    }),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BlocBuilder<CounterCubit, CounterState>(
                        builder: (counterCubitcontext, state) {
                          return Text(
                            state.count.toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                    ),
                    Builder(builder: (counterCubitcontext) {
                      return FloatingActionButton(
                        heroTag: "counter$viewId decrease btn",
                        onPressed: () {
                          counterCubitcontext.read<CounterCubit>().decrement();
                        },
                        child: const Icon(Icons.remove),
                      );
                    })
                  ],
                ),
                Builder(builder: (counterCubitcontext) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          counterCubitcontext,
                          MaterialPageRoute(
                            builder: (_) => BlocProvider.value(
                              value: BlocProvider.of<CounterCubit>(
                                  counterCubitcontext),
                              child: CounterDetailView(
                                viewId: viewId,
                              ),
                            ),
                          ),
                        );
                      },
                      child: Text("Go To Counter $viewId"),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CounterDetailView extends StatelessWidget {
  final String viewId;
  const CounterDetailView({
    Key? key,
    required this.viewId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Counters"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color:
                    Colors.primaries[Random().nextInt(Colors.primaries.length)],
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                border: Border.all(
                    color: Colors
                        .primaries[Random().nextInt(Colors.primaries.length)]),
              ),
              // color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "counter $viewId",
                      style: const TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Builder(
                          builder: (counterCubitcontext) {
                            return FloatingActionButton(
                              heroTag: "counter$viewId decrease btn",
                              onPressed: () {
                                counterCubitcontext
                                    .read<CounterCubit>()
                                    .decrement();
                              },
                              child: const Icon(Icons.remove),
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: BlocBuilder<CounterCubit, CounterState>(
                            builder: (counterCubitcontext, state) {
                              return Text(
                                state.count.toString(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              );
                            },
                          ),
                        ),
                        Builder(
                          builder: (counterCubitcontext) {
                            return FloatingActionButton(
                              heroTag: "counter$viewId increase btn",
                              onPressed: () {
                                BlocProvider.of<CounterCubit>(
                                        counterCubitcontext)
                                    .increment();
                                // context.read<CounterCubit>().increment();
                              },
                              child: const Icon(Icons.add),
                            );
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // context.read<CounterCubit>().decrement();
                          Navigator.popUntil(
                            context,
                            ModalRoute.withName("/counterlist"),
                          );
                        },
                        child: const Text("Go Back"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
