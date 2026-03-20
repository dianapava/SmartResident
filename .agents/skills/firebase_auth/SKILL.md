---
name: Firebase Auth Integration (VIPER)
description: Guía estándar para implementar Firebase Authentication en proyectos iOS usando arquitectura VIPER.
---

# Skill: Firebase Authentication con VIPER

Esta skill define las reglas estrictas y los pasos que la IA debe seguir cada vez que se requiera implementar un flujo de inicio de sesión o registro usando Firebase en un proyecto iOS.

## 1. Instalación (Siempre consultar primero)
- **Herramienta:** Swift Package Manager (SPM).
- **URL del paquete:** `https://github.com/firebase/firebase-ios-sdk`
- **Regla:** Solo instalar los módulos estrictamente necesarios (ej. `FirebaseAuth`).

## 2. Configuración Inicial
- Se debe modificar el punto de entrada de la aplicación (`SmartResidentApp.swift`) para importar Firebase y llamar a `FirebaseApp.configure()`.
- Se debe hacer dentro de un `AppDelegate` usando `@UIApplicationDelegateAdaptor` o directamente en el `init()` de la App si la arquitectura lo permite.

## 3. Arquitectura (VIPER + Clean)
Para no acoplar Firebase directamente a la UI o al Interactor, se debe seguir este patrón:
1. **Crear un Servicio (AuthService):** Un protocolo (ej. `AuthServiceProtocol`) que defina métodos como `login(email, password)` y `register(email, password)`.
2. **Implementación de Firebase:** Una clase `FirebaseAuthManager` que implemente dicho protocolo usando código real de Firebase.
3. **Inyección en el Interactor:** El `AuthInteractor` no debe saber que Firebase existe; solo usa el `AuthServiceProtocol`. Si el día de mañana cambiamos Firebase por otra cosa, el Interactor no cambia ni una coma.

## 4. Manejo de Errores
- Firebase devuelve errores genéricos (ej. `auth/wrong-password`). El `AuthService` debe capturarlos y traducirlos a errores amigables para el usuario en español antes de enviarlos al Presenter.

## 5. UI (Vista)
- Nunca importar `FirebaseAuth` dentro de una vista de SwiftUI. Toda la comunicación pasa a través del Presenter -> Interactor -> Service.
