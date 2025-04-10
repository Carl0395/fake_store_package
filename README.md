# Fake Store Package

Este paquete de Flutter permite interactuar con la [Fake Store API](https://fakestoreapi.com/), una API falsa que proporciona datos de productos, carritos y usuarios para propósitos de prueba y desarrollo.

## Características

- Obtener una lista de productos.
- Crear un producto con valores por defecto.
- Obtener una lista de carritos.

## Instalación

Para utilizar este paquete, añade `fake_store_package` a las dependencias de tu proyecto en el archivo `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  fake_store_package:
    git:
      url: https://github.com/Carl0395/fake_store_package.git
```

## Ejemplo rápido

```dart
import 'package:fake_store_package/fake_store_package.dart';

void main() async {
  final products = await FakeStoreApi.getProducts();
  for (var product in products) {
    print('${product.id}: ${product.title} - \$${product.price}');
  }
}
```

👉 Para ver un ejemplo completo, consulta la carpeta example/ del repositorio.

## 📘 Documentación de funciones

- Obtener una lista de productos.

```dart
final result = await FakeStorePackage.getProducts();
```

- Obtener todos los carritos de compra.

```dart
final result = await FakeStorePackage.getCarts();
```

❗ Manejo de errores

El paquete utiliza el tipo Either (de package:dartz) para manejar errores de forma funcional:

```dart
result.fold(
  (error) => print('Ocurrió un error: ${error.message}'),
  (data) => print('Éxito'),
);
```

Tipos de errores posibles (Failure):

- ServerFailure
- ParsingFailure
- ConnectionFailure

🧱 Modelos disponibles

- ProductModel
- CartModel

🔧 Internamente el paquete usa:

- dartz para manejo de errores
- http para peticiones HTTP
- Un HttpHelper interno para centralizar llamadas a la API

