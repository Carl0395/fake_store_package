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
