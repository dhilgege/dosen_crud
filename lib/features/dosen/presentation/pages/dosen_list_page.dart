import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/injection/injection_container.dart';
import '../../domain/entities/dosen.dart';
import '../bloc/dosen_bloc.dart';
import '../bloc/dosen_event.dart';
import '../bloc/dosen_state.dart';
import '../widgets/dosen_card.dart';
import '../widgets/dosen_form_dialog.dart';
import '../widgets/loading_widget.dart';

class DosenListPage extends StatelessWidget {
  const DosenListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<DosenBloc>()..add(LoadDosen()),
      child: Builder( // ✅ FIX CONTEXT UTAMA
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Data Dosen'),
              centerTitle: true,
              elevation: 2,
            ),
            body: BlocBuilder<DosenBloc, DosenState>(
              builder: (context, state) {
                if (state is DosenInitial) {
                  return const LoadingWidget();
                } else if (state is DosenLoading) {
                  return const LoadingWidget();
                } else if (state is DosenLoaded) {
                  return _buildLoadedState(context, state.dosenList);
                } else if (state is DosenError) {
                  return _buildErrorState(context, state.message);
                }
                return const SizedBox.shrink();
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => _showAddDosenDialog(context),
              tooltip: 'Tambah Dosen',
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLoadedState(BuildContext context, List<Dosen> dosenList) {
    if (dosenList.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.school, size: 80, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              'Belum ada data dosen',
              style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 8),
            Text(
              'Tekan tombol + untuk menambah data',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<DosenBloc>().add(LoadDosen());
      },
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 80),
        itemCount: dosenList.length,
        itemBuilder: (context, index) {
          final dosen = dosenList[index];
          return DosenCard(
            dosen: dosen,
            onEdit: () => _showEditDosenDialog(context, dosen),
            onDelete: () => _deleteDosen(context, dosen.nidn), // ✅ konsisten
          );
        },
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 80, color: Colors.red.shade400),
          const SizedBox(height: 16),
          Text(
            'Terjadi Kesalahan',
            style: TextStyle(
              fontSize: 18,
              color: Colors.red.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<DosenBloc>().add(LoadDosen());
            },
            child: const Text('Coba Lagi'),
          ),
        ],
      ),
    );
  }

  // ✅ FIX DIALOG ADD
  void _showAddDosenDialog(BuildContext context) async {
    final bloc = context.read<DosenBloc>();
    print('Showing add dialog');
    final dosen = await showDialog<Dosen>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: bloc,
        child: DosenFormDialog(),
      ),
    );
    print('Dialog returned: $dosen');
    if (dosen != null) {
      print('Dispatching AddDosenEvent');
      bloc.add(AddDosenEvent(dosen));
    } else {
      print('No dosen returned from dialog');
    }
  }

  // ✅ FIX DIALOG EDIT
  void _showEditDosenDialog(BuildContext context, Dosen dosen) async {
    final bloc = context.read<DosenBloc>();
    final updatedDosen = await showDialog<Dosen>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: bloc,
        child: DosenFormDialog(dosen: dosen),
      ),
    );
    if (updatedDosen != null) {
      bloc.add(UpdateDosenEvent(updatedDosen));
    }
  }

  void _deleteDosen(BuildContext context, String nisn) {
    context.read<DosenBloc>().add(DeleteDosenEvent(nisn));
  }
}