# Flutter UI Test

Este es un proyecto de aplicación móvil desarrollado en **Flutter**, que implementa una interfaz de usuario con pantallas de **inicio de sesión** y **noticias**.

## Características principales

- **Autenticación simulada** con validación de usuario.
  - Para acceder, usa el siguiente correo y contraseña predeterminados:
    - **Email:** `email@email.com`
    - **Contraseña:** `email`
  - Si los datos ingresados son incorrectos, se mostrará un mensaje de error mediante `ScaffoldMessenger`. 
  - El proceso de autenticación incluye una simulación de carga con `Future.delayed` antes de redirigir al usuario a la pantalla de noticias.
- **Cambio de tema** (claro/oscuro) mediante un `ValueNotifier`.
- **Interfaz responsiva** adaptable a móviles y pantallas anchas.
- **Noticias dinámicas** con opción para compartir contenido.
- **Uso de imágenes** en `/assets/images/` para fondos y logotipos.

---

## Estructura del proyecto

```bash
flutter_ui_test/
├── android/                    # Configuración específica de Android
├── ios/                        # Configuración específica de iOS
├── lib/                        # Código fuente principal de la aplicación
│   ├── screens/                # Pantallas de la aplicación
│   │   ├── login_screen.dart   # Pantalla de inicio de sesión
│   │   ├── news_screen.dart    # Pantalla de noticias
│   ├── widgets/                # Componentes reutilizables
│   ├── theme_notifier.dart     # Gestión de tema claro/oscuro
│   ├── main.dart               # Punto de entrada de la aplicación
├── assets/                     # Recursos de la app (imágenes, fuentes, etc.)
│   ├── images/                 # Imágenes del logo y fondos
└── pubspec.yaml                # Configuración del proyecto y dependencias
```

---

## Instalación y ejecución

### Clonar el repositorio:

```bash
git clone https://github.com/tu_usuario/flutter_ui_test.git
cd flutter_ui_test
```

### Instalar dependencias:

```bash
flutter pub get
```

### Ejecutar la aplicación:

Con un dispositivo/emulador en ejecución:

```bash
flutter run
```

Para especificar la plataforma:

```bash
flutter run -d android  # Ejecutar en Android
flutter run -d ios      # Ejecutar en iOS
```

---

## Explicación de archivos principales

### `lib/main.dart`
- Configura la aplicación con rutas (`/` para **login**, `/news` para **noticias**).
- Implementa **cambio de tema dinámico** con `themeNotifier`.

### `lib/screens/login_screen.dart`
- Pantalla de inicio de sesión con:
  - Campos para **email** y **contraseña**.
  - Validación de entrada con `ScaffoldMessenger`.
  - Simulación de **autenticación** con un pequeño delay.
  - Botones para iniciar sesión con **Google y Facebook**.
  - Soporte para **recordar usuario** y **recuperar contraseña**.

### `lib/screens/news_screen.dart`
- Pantalla de noticias con:
  - Listado de artículos **dinámicos** en un `ListView`.
  - Posibilidad de **compartir artículos** con `share_plus`.
  - Diseño adaptable a **pantallas anchas** con `SideMenu`.

### `lib/theme_notifier.dart`
- **Gestión del tema** con `ValueNotifier<ThemeMode>`, permitiendo alternar entre **modo claro y oscuro**.