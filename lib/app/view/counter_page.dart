// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:listtobloc/app/cubit/counter_cubit.dart';

class CounterPage extends StatelessWidget {
  static const routeName = '/';
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CountersListView();
  }
}

class CountersListView extends StatelessWidget {
  const CountersListView({super.key});

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
                (index) => CounterView(
                      viewId: (index + 1).toString(),
                    )),
          )),
        ),
      ),
    );
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
                        showDialog(
                            context: counterCubitcontext,
                            builder: (BuildContext counterCubitcontext) {
                              return AlertDialog(
                                content: Column(
                                  children: [
                                    Text(
                                      'counter $viewId',
                                      style: const TextStyle(
                                        fontSize: 30,
                                        color: Colors.white,
                                      ),
                                    ),
                                    BlocBuilder<CounterCubit, CounterState>(
                                      builder: (context, state) {
                                        return Text(
                                          state.count.toString(),
                                          style: const TextStyle(
                                            fontSize: 30,
                                            color: Colors.white,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              );
                            });
                        // Navigator.push(
                        //     counterCubitcontext,
                        //     MaterialPageRoute(
                        //         builder: (context) => CounterDetailView(
                        //               viewId: viewId,
                        //             )));
                      },
                      child: Text("Go To Counter $viewId"),
                    ),
                  );
                }),
                Builder(builder: (counterCubitcontext) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // showDialog(
                        //   context: counterCubitcontext,
                        //   builder: (BuildContext context) =>
                        //       detailViewPopupDialog(context, viewId),
                        // );
                        Navigator.push(
                          counterCubitcontext,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider.value(
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

Widget detailViewPopupDialog(BuildContext context, String vid) {
  return AlertDialog(
    title: Text("counter $vid"),
    content: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            children: [
              Text("data $vid"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Builder(builder: (context) {
                    return FloatingActionButton(
                      heroTag: "counter$vid increase btn",
                      onPressed: () {
                        BlocProvider.of<CounterCubit>(context).increment();
                        // context.read<CounterCubit>().increment();
                      },
                      child: const Icon(Icons.add),
                    );
                  }),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BlocBuilder<CounterCubit, CounterState>(
                      builder: (context, state) {
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
                  Builder(builder: (context) {
                    return FloatingActionButton(
                      heroTag: "counter$vid decrease btn",
                      onPressed: () {
                        context.read<CounterCubit>().decrement();
                      },
                      child: const Icon(Icons.remove),
                    );
                  })
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
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
          body: BlocProvider(
            create: (counterCubitcontext) => CounterCubit(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors
                      .primaries[Random().nextInt(Colors.primaries.length)],
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  border: Border.all(
                      color: Colors.primaries[
                          Random().nextInt(Colors.primaries.length)]),
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
                                BlocProvider.of<CounterCubit>(
                                        counterCubitcontext)
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
                                counterCubitcontext
                                    .read<CounterCubit>()
                                    .decrement();
                              },
                              child: const Icon(Icons.remove),
                            );
                          })
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            // context.read<CounterCubit>().decrement();
                          },
                          child: Text("Go To Counter $viewId"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
