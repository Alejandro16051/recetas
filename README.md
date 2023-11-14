# README 

## recetas
Aplicación móvil iOS con Swift utilizando la arquitectura MVVM y principios de clean code.

## Design Pattern: MVVM

En este proyecto, se implementa el patrón de diseño MVVM para garantizar la modularidad y la mantenibilidad del código.

## Librerías Externas

- **Google Maps SDK:**
  - Se utiliza el POD de Google Maps para la vista de mapa de origen de recetas, proporcionando una integración sencilla.

- **Toaster:**
  - Se integra el POD Toaster para mostrar avisos al usuario de manera efectiva y amigable.

## Diseño de interfaces

Se decidió crear también distintos storyboards para cada vista, puesto que cuando en los proyectos aumentan sus funcionalidades estos archivos xib suelen volverse realmente pesados y hacen del mantenimiento de estos elementos una tarea más extensa de lo que debería ser.

## Implementación de funcionalidades

Se trabaja cada funcionalidad de manera separada a la vista principal, de modo que, cada delegado tiene su propia extensión. Esto también va de acuerdo con la implementación de la arquitectura MVVM que permite tener tener una aplicación modularizada y efectivamente mantenible.
