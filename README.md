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


{Show"Welcome to Hummingbird - Functional Programming Language"}

    {Show {GetSaludo}}

    {Show"The Graph module is working correctly."}

    {Show"The Reducer module is working correctly."}

    % Simulación básica de una operación funcional

    {Show"Introduce a function:"}

    Programa ="fun square(X) = X * X square(5)"

    for Value in  {Infix2Prefix {Str2Lst Programa}} do

    {Show Value}

    end

## 📁 Estructura del Proyecto

El proyecto está organizado en los siguientes archivos para mantener un enfoque modular:

- ``main.oz``: Punto de entrada del programa. Coordina el flujo de datos entre los módulos.
- ``graph.oz``: Define estructuras de datos para los grafos y funciones para construirlos.
- ``parser.oz``: Contiene la lógica para convertir el texto del programa funcional en una estructura interna comprensible.
- ``reducer.oz``: Implementa las reglas para reducir grafos y evaluar expresiones.
- ``util.oz``: Proporciona funciones auxiliares reutilizables como operaciones aritméticas y utilidades de depuración.

## 🤝 Créditos

Este repositorio se realizó bajo la supervisión de:

- <a href="https://www.linkedin.com/in/julián-27-mora/" target="_blank">Julián Camilo Mora Valbuena</a>
- <a href="https://www.linkedin.com/in/juan-esteban-rodriguez-ospino/" target="_blank">Juan Esteban Rodríguez Ospino</a>

<div align="center">
  <img src="https://github.com/user-attachments/assets/7f165cc2-e6a5-4665-ad01-025a3f5875a6" alt="Hummingbird" style="width:20%;"/>

</div>

&#xa0;
