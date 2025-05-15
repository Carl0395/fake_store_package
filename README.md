# Fake Store Package

Este paquete de Flutter permite interactuar con la [Fake Store API](https://fakestoreapi.com/), una API falsa que proporciona datos de productos, carritos y usuarios para propósitos de prueba y desarrollo.

## Características

- Obtener una lista de productos.
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

- BadRequestFailure
- ServerFailure
- ParsingFailure
- ConnectionFailure
- UnauthorizedFailure
- UnknownFailure

🧱 Modelos disponibles

- ProductModel
- CartModel
- ProductQuantityModel
- RatingModel

🔧 Internamente el paquete usa:

- dartz para manejo de errores
- http para peticiones HTTP
- Un HttpHelper interno para centralizar llamadas a la API

#
# 🧪 Pruebas Unitarias en `fake_store_package`

Este paquete incluye una suite de pruebas unitarias para garantizar la fiabilidad y robustez de las funcionalidades principales. A continuación, se detallan las pruebas implementadas y cómo ejecutarlas.

## 📁 Estructura de Pruebas

Las pruebas se encuentran en el directorio `test/` y cubren los siguientes módulos:

- **`carts_api_test.dart`**: Pruebas para la clase `CartsApi`, incluyendo:
  - `getCarts()`: Verifica la obtención de la lista de carritos.
  - `getCart(String id)`: Verifica la obtención de un carrito específico por ID.

- **`products_api_test.dart`**: Pruebas para la clase `ProductsApi`, incluyendo:
  - `getProducts()`: Verifica la obtención de la lista de productos.
  - `getCategories()`: Verifica las obtención de la lista de categorías.
  - `getProductsByCategory(String category)`: Verifica la obtención de productos por categoría.

- **`users_api_test.dart`**: Pruebas para la clase `UsersApi`, incluyendo:
  - `getUser(String id)`: Verifica la obtención de un usuario por id.
  - `createUser(UserModel user)`: Verifica la creación de un usuario.

- **`models_test.dart`**: Pruebas para los modelos de datos, incluyendo:
  - `CartModel`: Verifica la serialización y deserialización.
  - `ProductModel`: Verifica la serialización y deserialización.
  - `ProductQuantityModel`: Verifica la serialización y deserialización.
  - `RatingModel`: Verifica la serialización y deserialización.
  - `UserModel`: Verifica la serialización y deserialización.

- **`failures_test.dart`**: Pruebas para la clase `Failures`, incluyendo:
  - `BadRequestFailure`: Verifica la instancia de la clase y sus metodos.
  - `UnauthorizedFailure`: Verifica la instancia de la clase y sus metodos.
  - `ServerFailure`: Verifica la instancia de la clase y sus metodos.
  - `ParsingFailure`: Verifica la instancia de la clase y sus metodos.
  - `ConnectionFailure`: Verifica la instancia de la clase y sus metodos.
  - `UnknownFailure`: Verifica la instancia de la clase y sus metodos.

## 🧰 Herramientas Utilizadas

- **Framework de Pruebas**: [flutter_test](https://pub.dev/packages/flutter_test)
- **Mocking**: [mocktail](https://pub.dev/packages/mocktail)
- **Programación Funcional**: [dartz](https://pub.dev/packages/dartz)

## 🚀 Ejecución de Pruebas

Para ejecutar todas las pruebas unitarias, utiliza el siguiente comando en la raíz del proyecto:

```bash
flutter test
