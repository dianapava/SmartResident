---
description: Flujo automatizado para Git (Rama, Commit y Push)
---

Este es un flujo de trabajo para automatizar las tareas de Git en el proyecto SmartResident. Cuando la usuaria (Ale) pida ejecutar este flujo, sigue estos pasos estrictamente:

1. Pregunta a Ale el nombre de la nueva rama que quiere crear (por ejemplo: `feat/login`, `fix/boton-whatsapp`).
2. Pregunta a Ale el mensaje del commit que describa los cambios (siguiendo Conventional Commits, ej: `feat: agrega boton flotante`).
// turbo-all
3. Ejecuta en la terminal: `git checkout -b <nombre_rama_proporcionado>`
4. Ejecuta en la terminal: `git add .`
5. Ejecuta en la terminal: `git commit -m "<mensaje_proporcionado>"`
6. Ejecuta en la terminal: `git push -u origin <nombre_rama_proporcionado>`
