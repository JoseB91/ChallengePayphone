# ChallengePayphone

Applicación iOS construida como prueba técnica de Payphone. Obtiene una lista de usuarios de una API REST, guarda esa información localmente y permite eliminar usuarios. Usa una estrategia cache-first, si no existe conexión a Internet se puede visualizar la información de la base de datos local que actúa como fuente de verdad.

---

## Table of Contents

1. [Requerimientos](#requerimientos)
2. [Setup](#setup)
3. [Arquitectura](#arquitectura)
4. [Localizacion](#localizacion)
5. [Consideraciones](#consideraciones)

---

## Requerimientos

| Herramiente        | Version            |
| ------------------ | ------------------ |
| Versión mínima iOS | 15.0               |
| Alamofire (SPM)    | Llamadas de red    |
| RealmSwift (SPM)   | Persistencia Local |

---

## Setup

1. Clonar el repository.
2. Abrir `ChallengePayphone.xcodeproj` en Xcode.
3. Swift Package Manager incluye **Alamofire** y **RealmSwift** automáticamente. No hay necesidad de agregar manualmente alguna dependencia.
4. Correr la app `ChallengePayphone`.

---

## Arquitectura

El proyecto está construido con **Clean Architecture** basada en 3 capas:

```
┌─────────────────────────────────┐
│         Presentation            │  SwiftUI Views + ViewModels
├─────────────────────────────────┤
│            Domain               │  Modelo + protocolo Repository
├─────────────────────────────────┤
│             Data                │  Remote (Alamofire) + Local (Realm)
└─────────────────────────────────┘
```

Presentation y Data dependen del Domain. Ni Domain ni Presentation interactúan con Realm o Alamofire directamente.

La navegación usa el patrón **Coordinator** para mantener la lógica de enrutamiento fura de las vistas. La creación y gestión de dependencias está centralizada en **Composer** permitiendo cambiar de infraestructura con facilidad.

Se usan abstracciones a través de los protocolos para poder inyectar dependencias y facilitar las pruebas unitarias sobre los componentes.

---

## Localizacion

La app tiene soporte para idiomas inglés y español.

---

## Consideraciones

- **Realm thread safety**: Se debe considerar manejar de mejor manera la concurrencia entre objetos Realm y el resto de la app.

- **`Constants.usersURL`**: El valor de la url base debería venir de un archivo `xcconfig` para poder manejar diferentes ambientes (desarrollo, qa, producción).

- **Condición iOS 16 en `CoordinatorView`**: Se debe implementar otra estrategia usando `NavigationView` para versiones menores a iOS 16 ya que actualmente solo se considera `NavigationStack` que necesita mínimo iOS 16.
