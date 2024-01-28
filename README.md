**Práctica para el módulo Patrones de diseño de Keepcoding.**

En esta práctica desarrollo una app con lenguaje swift bajo el patrón de diseño MVVM (Model - View - ViewModel). Para su elaboración se consumido la API de Dragon Ball para realizar llamadas de red. Solamente he añadido de imagen, las capturas que difieren del proyecto anterior. He rediseñado las table y las celdas buscando otro aspecto gráfico nuevo que tener.

**Resultado: APTO**

![Simulator Screenshot - iPhone 15 - 2024-01-28 at 14 43 1](https://github.com/agavgar/Practica_DisPatrones_AGGA/assets/98350985/fb23148d-d45c-4d00-90eb-bda7da1b7579)
![Simulator Screenshot - iPhone 15 - 2024-01-28 at 14 43 2](https://github.com/agavgar/Practica_DisPatrones_AGGA/assets/98350985/cc91c053-0cc0-4a5c-8222-35ad56a99561)
![Simulator Screenshot - iPhone 15 - 2024-01-28 at 14 43 3](https://github.com/agavgar/Practica_DisPatrones_AGGA/assets/98350985/124adb93-678e-431b-b550-16e500e4a1e4)


**Breve descripción**

Es una app focalizada en Dragon Ball. Ya que su historia tiene muchos personajes interesantes, esta app nos muestra una lista de muchos personajes y sus numerosas transformaciones. Todo ello haciendo una llamada a un useCaseGenerico que se ocupa de gestionar todas las llamadas a la API siendo genérico donde todas las llamadas las gestionamos desde le viewModel de cada pantalla. Al final se trata de la siguiente navegación: vieWModel tiene la funcion que recupera el objeto y luego se lo enviamos a la vista a travñes de estados y llamadas asíncronas.

**Guía de instalación**

Simplemente debemos descargarnos el prouyecto en ZIP o en HTTP y clonar el repositorio. Luego ejecutar el archivo del proyecto de xCode y con pulsar al play tendremos la aplicación funcionando. Solo usuarios con MAC y xCode instalado. TESTADO EN IPHONE XR.

**Experiencia**

El proyecto se ha reecho entero, empezandose de 0 y no cogiendo la base de la práctica anterior. Al principio me parecía un poco confuso lo de manejar la lógica a través de otras clases pero a medida que más pantallas haces, te das cuenta que es un proceso increiblemente agil para desarrollar todo y es muy sencillo encontrar los errores de primeras. Digamos que para una app así, quizás no sea la mejor opción pero entiendo el potencial del patrón MVVM y sin duda saerá con el que trabajaré en un futuro. He tenido la posibilidad de hacer el trabajo solo con UITableViewController pero como reto personal he querido realizarlo usando los dos tipos de tablas que tenemos en mópvil, usando Collections y Tablas. Lo demás es azucar sintáctico y mucho cariño!
