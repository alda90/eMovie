# eMovie
Technical Test for Gonet/Rappi iOS Dev position

1. ¿En qué consiste el principio de responsabilidad única? ¿Cuál es su propósito?

Dice que cada módulo del proyecto debe de tener una sola responsabilidad. Esto es que si tenemos un módulo para hacer un proceso de pago,
el módulo solo tiene que tener las propiedades y la lógica para realizar el proceso. 
De este modo no se le deben agregar al módulo otras tareas de procesos externos, como una llamada al servidor para actualizar historial de pago
o guardar datos internamente en base de datos local
Esto nos ayuda a tener un código más limpio y una estructura óptima para trabajar.




2. ¿Qué características tiene, según su opinión, un “buen” código o código limpio?

Fácil de leer, la arquitectura debe ser clara, debe de ser escalable, manejable aceptando los principios SOLID para poder tabajar en mejoras,
actualizaciones y resolución de bugs.



3. Detalla cómo harías todo aquello que no hayas llegado a completar.

* Falto una mejor estructura o patrón de diseño para la navegación. Para que sean un poco mejor adaptables a todas las transiciones entre viewControllers
y que se puedan adaptar fácilmente a las animaciones.
* Una estructura de animaciones con ayuda de generics.
* Una real implementación offline ya sea con Realm o Core Data, siguiendo patrones de diseño que ayuden en el performance de la app y que se
complementen con la cache.
* Mejor implementación de la reproducción del video. Hondar más en las clases de AVPlayer para tener una implementación mejor controlada.
