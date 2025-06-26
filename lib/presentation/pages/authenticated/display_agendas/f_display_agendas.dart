import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:judge/domain/entities/export.dart';
import 'package:judge/presentation/providers/export.dart';
import 'package:judge/presentation/routes/export.dart';
import 'package:judge/shared/export.dart';
import 'w_fetch_more_button.dart';

class DisplayAgendasFragment extends StatelessWidget {
  const DisplayAgendasFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DisplayAgendasBloc, AbsDisplayState<Agenda>>(
      builder: (context, state) {
        if (!state.isMounted) {
          return Center(child: CircularProgressIndicator());
        } else if (state.data.isEmpty) {
          return Center(
            child: Text(
              'Nothing Fetched',
              style: context.textTheme.displaySmall,
            ),
          );
        }
        return RefreshIndicator(
          displacement: 40,
          edgeOffset: 0,
          strokeWidth: 3,
          onRefresh: () async {
            if (state.status == Status.loading) {
              return;
            }
            context.read<DisplayAgendasBloc>().add(
              DisplayMountedEvent(),
            );
          },
          child: ListView.builder(
            itemCount: state.data.length,
            itemBuilder: (context, index) {
              final e = state.data[index];
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    onTap: () async {
                      await context.pushRoute(AgendaDetailRoute(agenda: e));
                    },
                    title: Text(
                      e.title,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.titleMedium,
                    ),
                    subtitle: e.createdBy == null
                        ? null
                        : Text(
                            e.createdBy!.username,
                            style: context.textTheme.labelMedium,
                          ),
                  ),

                  /// 더 가져오기 버튼
                  if (!state.isEnd && index == state.data.length - 1)
                    FetchMoreButtonWidget(),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
