# Oracle Role Grant Automation

Automatización PL/SQL para asignar privilegios y crear sinónimos cuando aparecen nuevos objetos en schemas Oracle seleccionados. El objetivo es mantener el acceso de roles consumidores sin depender de tareas manuales después de cada cambio de estructura.

## Cómo funciona

1. Un trigger DDL detecta la creación de objetos configurados.
2. La operación requerida se registra en una tabla de cola.
3. Un procedimiento procesa los elementos pendientes y genera los `GRANT` o sinónimos correspondientes.
4. Un job de `DBMS_SCHEDULER` ejecuta el procesamiento de forma periódica.
5. Un control de sesión evita recursión durante la creación de los objetos auxiliares.

## Contenido

`TRG_GRANT_OBJ_PRIV_TO_ROLE.sql` incluye:

- tabla de cola;
- trigger de base de datos;
- contexto de control de sesión;
- procedimiento ejecutor;
- job programado con `DBMS_SCHEDULER`.

## Configuración

Antes de instalar, adaptar en el script:

- schema técnico;
- patrones de schemas observados;
- roles y schemas consumidores;
- tablespace de la cola;
- frecuencia del job;
- mecanismo de logging y manejo de errores.

## Requisitos

- Oracle Database con `DBMS_SCHEDULER` habilitado.
- Privilegios para crear triggers, procedimientos, tablas y jobs.
- Permisos suficientes para otorgar privilegios sobre los objetos administrados.

El script utiliza DDL dinámico. Se recomienda validarlo primero en un ambiente controlado y asignar únicamente los privilegios necesarios.
