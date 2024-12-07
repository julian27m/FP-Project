<h1 align="center">
<img src="https://github.com/user-attachments/assets/b4034cfc-4ad7-495e-bbef-f2a2842ec793" alt="Banner" style="width:100%;"/>
  Hummingbird - Functional Language
</h1>

<p align="center">
  <a href="#dart-descripción">Descripción</a>   |   
  <a href="#gear-requisitos-del-sistema">Requisitos del Sistema</a>   |  
  <a href="#rocket-instalación">Instalación</a>   |  
  <a href="#file_folder-estructura-del-proyecto">Estructura del Proyecto</a>   |  
  <a href="#handshake-créditos" target="_blank">Créditos</a>
</p>

<br>

## 🎯 Descripción

Hummingbird es un lenguaje de programación funcional reducido implementado en Mozart (Oz), diseñado como un proyecto educativo para explorar técnicas como reducción de grafos e instanciación de plantillas. Este lenguaje soporta definiciones de funciones, aplicaciones de funciones y primitivas aritméticas, siguiendo un enfoque modular que facilita su mantenimiento y escalabilidad.

El proyecto incluye herramientas para construir, reducir y evaluar programas funcionales simples a través de una representación basada en grafos.

## ⚙️ Requisitos del Sistema

1. Mozart Programming Interface (MPI) o su extensión para Visual Studio Code.
2. Un entorno compatible con la ejecución de proyectos en Mozart Oz.

Nota:
Para ejecutar proyectos en Mozart Oz desde Visual Studio Code:

1. Asegúrate de que la extensión de Mozart esté instalada.
2. Abre el archivo principal main.oz.
3. Usa el comando Ctrl + . seguido de Ctrl + B para ejecutar el programa.

## 🚀 Instalación

Sigue estos pasos para configurar y ejecutar el proyecto en tu máquina local:

1. Abre tu terminal o consola de comandos.
2. Clona este repositorio con el siguiente comando:
   ``git clone https://github.com/julian27m/FP-Project.git``
3. Navega al directorio del proyecto:
   ``cd FP-Project``
4. Asegúrate de que Mozart MPI o la extensión en Visual Studio Code está correctamente instalada.
5. Abre el archivo main.oz en tu editor.
6. Ejecuta el proyecto siguiendo las instrucciones mencionadas en la sección de Requisitos del Sistema.

  
## 📁 Estructura del Proyecto

El proyecto está organizado en los siguientes archivos para mantener un enfoque modular:

- ``main.oz``: Punto de entrada del programa. Coordina el flujo de datos entre los módulos.
- ``StringTool.oz``: Utilidades para manipular cadenas de texto, como dividir, unir y limpiar contenido.
- ``Core.oz``: Contiene la lógica principal del evaluador, incluyendo la creación y manipulación de árboles, reducción de expresiones y evaluación de funciones.

## 🔨 Ejecución

Para compilar y ejecutar Hummingbird, sigue estos pasos:

1. **Limpia** los archivos compilados anteriores con el siguiente comando:
   ```bash
   ./clean.bat
    ```
   Esto asegura que no haya archivos de compilación desactualizados que puedan interferir con el proceso.

2. Compila y ejecuta el programa con:
    ```bash
   ./start.bat
    ```
3. El archivo start.bat realiza las siguientes acciones:
    - Compila los módulos StringTools.oz, Core.oz y Main.oz.
    - Ejecuta el programa usando ozengine.
  
      
4. Observa los resultados en la consola.

   ## Cómo funciona Hummingbird

   El programa Hummingbird sigue un flujo estructurado para interpretar y evaluar programas funcionales escritos en su lenguaje específico. A continuación, se detalla cada etapa de ejecución, basada en el           ejemplo:
 
   ```bash
    fun square x = x * x
    square 5
   ```
   
   Este programa define una función twice que duplica el valor de su argumento (x) y luego la aplica al número 5.

   1. Lectura del programa
    El intérprete comienza leyendo el archivo de entrada (Example2_twice.hb) que contiene el programa funcional.
    Deberías ver una salida similar a esta:

   ```bash
    Reading program from: Example2_twice.hb
   
    Program contents:
      fun twice x = x + x
      twice 5
   ```
   
    2. Análisis del programa
       
       a. Definición de funciones:
        
       - El intérprete identifica y parsea las funciones definidas en el programa.
        -La función twice x = x + x se representa como un grafo que detalla su cuerpo (x + x) y sus argumentos (x).
         
        b. Construcción del grafo:
        
        Hummingbird convierte el cuerpo de la función en un grafo que describe las operaciones y sus relaciones.

       ```bash
        Function: fun twice x = x + x
        Parsing function body: x + x

        === Task1. Building the graph to represent the program ===

          Root(@) -> Left(*), Right(@)
        )   Right(@) -> Left(x), Right(x
       
       ```
       
       c. Detalles de la función:
          El nombre, los argumentos y el cuerpo de la función se almacenan para su posterior evaluación.

       ```bash
       === Function Details ===

        Name: twice
        Args: x
        Body: x + x
       ```

       3. Aplicación de funciones
          El intérprete detecta la aplicación de la función twice con el argumento 5 y genera un grafo inicial para esta expresión.

          ```bash
          Function: twice 5

          Current Expression Tree:
          @
            |__twice
            |__5
          ```

          4. Reducción del grafo
             
              Sustitución de argumentos:
              - La función twice sustituye su argumento x con el valor 5.
              - El grafo de la expresión se actualiza para reflejar el cuerpo de la función con el valor proporcionado.
            
          ```bash
          Current Expression Tree:
          @
            |__+
            |__@
              |__5
              |__5
          ```

          Evaluación de operaciones:
            La operación 5 + 5 se evalúa, y el resultado se inserta en el grafo.
          
          ```bash
          === Task 4. Updating the expression for the evaluation ===       

          Evaluated: 5 + 5 = 10
          
          Current Expression Tree:
          10
          ```

          *El intérprete finaliza el proceso mostrando el resultado final de la evaluación (10) y el árbol final reducido.*

           ```bash
           Final Tree:
          10
          
          Final Result: 10
          ```

## 🤝 Créditos

Este repositorio se realizó bajo la supervisión de:

- <a href="https://www.linkedin.com/in/julián-27-mora/" target="_blank">Julián Camilo Mora Valbuena</a>
- <a href="https://www.linkedin.com/in/juan-esteban-rodriguez-ospino/" target="_blank">Juan Esteban Rodríguez Ospino</a>

<div align="center">
  <img src="https://github.com/user-attachments/assets/7f165cc2-e6a5-4665-ad01-025a3f5875a6" alt="Hummingbird" style="width:20%;"/>

</div>

&#xa0;
