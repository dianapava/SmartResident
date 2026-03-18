---
description: Flujo automatizado para Git (Rama, Commit, Push y PR)
---

Este es un flujo de trabajo para automatizar las tareas de Git en el proyecto SmartResident. Cuando la usuaria (Ale) pida ejecutar este flujo, sigue estos pasos estrictamente:

1. Pregunta a Ale el nombre de la nueva rama que quiere crear (por ejemplo: `feat/login`, `fix/boton-whatsapp`).
2. Pregunta a Ale el mensaje del commit que describa los cambios (siguiendo Conventional Commits, ej: `feat: agrega boton flotante`).
// turbo-all
3. Ejecuta en la terminal: `git checkout -b <nombre_rama_proporcionado>`
4. Ejecuta en la terminal: `git add .`
5. Ejecuta en la terminal: `git commit -m "<mensaje_proporcionado>"`
6. Ejecuta en la terminal: `git push -u origin <nombre_rama_proporcionado>`
7. Explícale a Ale que el Pull Request se debe terminar de crear en la página de GitHub. Recuérdale que puede darle clic directo al enlace (URL) que arroja la terminal después del "push" para ir directo a abrir su PR.
