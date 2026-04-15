import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/dosen_model.dart';

/// Abstract data source interface for local Dosen operations
abstract class DosenLocalDataSource {
  /// Get all dosen from local storage
  Future<List<DosenModel>> getAllDosen();

  /// Add a new dosen to local storage
  Future<void> addDosen(DosenModel dosen);

  /// Update an existing dosen in local storage
  Future<void> updateDosen(DosenModel dosen);

  /// Delete a dosen from local storage by NIDN
  Future<void> deleteDosen(String nidn);
}

/// Implementation of DosenLocalDataSource using shared preferences
/// Persists dosen data locally
class DosenLocalDataSourceImpl implements DosenLocalDataSource {
  static const String _dosenKey = 'dosen_list';

  /// Get shared preferences instance
  Future<SharedPreferences> get _prefs => SharedPreferences.getInstance();

  /// Load dosen list from shared preferences
  Future<List<DosenModel>> _loadDosenList() async {
    final prefs = await _prefs;
    final jsonString = prefs.getString(_dosenKey);
    if (jsonString == null) {
      // Return default sample data
      return [
        const DosenModel(
          nidn: '1234567890',
          nama: 'Dr. Ahmad Santoso',
          alamat: 'Jl. Sudirman No. 1, Jakarta',
        ),
        const DosenModel(
          nidn: '0987654321',
          nama: 'Prof. Siti Aminah',
          alamat: 'Jl. Malioboro No. 15, Yogyakarta',
        ),
      ];
    }
    final jsonList = json.decode(jsonString) as List;
    return jsonList.map((json) => DosenModel.fromJson(json)).toList();
  }

  /// Save dosen list to shared preferences
  Future<void> _saveDosenList(List<DosenModel> dosenList) async {
    final prefs = await _prefs;
    final jsonList = dosenList.map((dosen) => dosen.toJson()).toList();
    final jsonString = json.encode(jsonList);
    await prefs.setString(_dosenKey, jsonString);
  }

  @override
  Future<List<DosenModel>> getAllDosen() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return await _loadDosenList();
  }

  @override
  Future<void> addDosen(DosenModel dosen) async {
    print('DataSource: Adding dosen ${dosen.nama}');
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    final dosenList = await _loadDosenList();
    // Check if NIDN already exists
    if (dosenList.any((d) => d.nidn == dosen.nidn)) {
      throw Exception('Dosen dengan NIDN ${dosen.nidn} sudah ada');
    }
    dosenList.add(dosen);
    await _saveDosenList(dosenList);
    print('DataSource: Added, list now has ${dosenList.length}');
  }

  @override
  Future<void> updateDosen(DosenModel dosen) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    final dosenList = await _loadDosenList();
    final index = dosenList.indexWhere((d) => d.nidn == dosen.nidn);
    if (index == -1) {
      throw Exception('Dosen dengan NIDN ${dosen.nidn} tidak ditemukan');
    }
    dosenList[index] = dosen;
    await _saveDosenList(dosenList);
  }

  @override
  Future<void> deleteDosen(String nidn) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    final dosenList = await _loadDosenList();
    final index = dosenList.indexWhere((d) => d.nidn == nidn);
    if (index == -1) {
      throw Exception('Dosen dengan NIDN $nidn tidak ditemukan');
    }
    dosenList.removeAt(index);
    await _saveDosenList(dosenList);
  }
}