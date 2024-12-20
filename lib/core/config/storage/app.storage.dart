import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../entity/_entity.dart';

class AppStorage {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  // READ ALL
  Future<Map<String, String>> readAll() async {
    final SharedPreferences prefs = await _prefs;
    Map<String, String> data = {};
    try {
      prefs.getKeys().forEach((key) {
        final value = prefs.getString(key);
        if (value != null) data[key] = value;
      });
      return data;
    } catch (e) {
      rethrow;
    }
  }

  // DELETE ALL
  Future<void> deleteAll() async {
    final SharedPreferences prefs = await _prefs;
    try {
      await prefs.clear();
      debugPrint('🟢 Todos os dados foram deletados.');
    } catch (e) {
      debugPrint('🔴 Erro ao deletar tudo: ${e.toString()}');
      rethrow;
    }
  }

  // READ DATA
  Future<String> readSecureData(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(key) ?? '';
  }

  // WRITE DATA
  Future<void> writeSecureData(String key, String value) async {
    final SharedPreferences prefs = await _prefs;
    try {
      await prefs.setString(key, value);
      debugPrint('🟢 Dados salvos: $key = $value');
    } catch (e) {
      debugPrint('🔴 Erro ao salvar dados: ${e.toString()}');
      rethrow;
    }
  }

  // DELETE DATA
  Future<void> deleteSecureData(String key) async {
    final SharedPreferences prefs = await _prefs;
    try {
      await prefs.remove(key);
      debugPrint('🟢 Dados deletados: $key');
    } catch (e) {
      debugPrint('🔴 Erro ao deletar dados: ${e.toString()}');
      rethrow;
    }
  }

  // PRODUCT RELATED
  Future<void> saveProduct(ProductEntity product) async {
    try {
      String productJson = jsonEncode(product.toMap());
      await writeSecureData('product', productJson);
    } catch (e) {
      debugPrint('🔴 Erro ao salvar o produto: ${e.toString()}');
    }
  }

  Future<ProductEntity?> getProduct() async {
    try {
      final productJson = await readSecureData('product');
      if (productJson.isNotEmpty) {
        return ProductEntity.fromMap(jsonDecode(productJson));
      }
      return null;
    } catch (e) {
      debugPrint('🔴 Erro ao ler o produto: ${e.toString()}');
      return null;
    }
  }

  Future<void> deleteProduct() async {
    await deleteSecureData('product');
  }

  // LIST PRODUCTS
  Future<void> saveProducts(List<ProductEntity> products) async {
    try {
      String productsJson = jsonEncode(products.map((e) => e.toMap()).toList());
      await writeSecureData('products', productsJson);
    } catch (e) {
      debugPrint('🔴 Erro ao salvar os produtos: ${e.toString()}');
    }
  }

  Future<List<ProductEntity>> getProducts() async {
    try {
      final productsJson = await readSecureData('products');
      if (productsJson.isNotEmpty) {
        final List<dynamic> productsMap = jsonDecode(productsJson);
        return productsMap.map<ProductEntity>((item) => ProductEntity.fromMap(item)).toList();
      }
      return [];
    } catch (e) {
      debugPrint('🔴 Erro ao ler os produtos: ${e.toString()}');
      return [];
    }
  }

  Future<void> deleteProducts() async {
    await deleteSecureData('products');
  }

  // LIST FAVORITE PRODUCTS
  Future<void> saveFavoriteProducts(List<ProductEntity> products) async {
    try {
      String productsJson = jsonEncode(products.map((e) => e.toMap()).toList());
      await writeSecureData('favoriteProducts', productsJson);
    } catch (e) {
      debugPrint('🔴 Erro ao salvar os produtos favoritos: ${e.toString()}');
    }
  }

  Future<List<ProductEntity>> getFavoriteProducts() async {
    try {
      final productsJson = await readSecureData('favoriteProducts');
      if (productsJson.isNotEmpty) {
        final List<dynamic> productsMap = jsonDecode(productsJson);
        return productsMap.map<ProductEntity>((item) => ProductEntity.fromMap(item)).toList();
      }
      return [];
    } catch (e) {
      debugPrint('🔴 Erro ao ler os produtos favoritos: ${e.toString()}');
      return [];
    }
  }

  Future<void> deleteFavoriteProducts() async {
    await deleteSecureData('favoriteProducts');
  }
}
