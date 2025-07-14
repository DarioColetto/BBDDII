
// ELIMINAR TODO
MATCH (n) DETACH DELETE n;

// Crea Departamentos
CREATE (:Departamento {nombre: "IT"});
CREATE (:Departamento {nombre: "Marketing"});
CREATE (:Departamento {nombre: "RRHH"});

// Crea Empleados
CREATE (:Empleado {nombre: "Ana", legajo: 101});
CREATE (:Empleado {nombre: "Bruno", legajo: 102});
CREATE (:Empleado {nombre: "Carla", legajo: 103});

// Relacion empleados con departamentos
MATCH (e:Empleado {nombre: "Ana"}), (d:Departamento {nombre: "IT"})
CREATE (e)-[:PERTENECE_A]->(d);

MATCH (e:Empleado {nombre: "Bruno"}), (d:Departamento {nombre: "Marketing"})
CREATE (e)-[:PERTENECE_A]->(d);

MATCH (e:Empleado {nombre: "Carla"}), (d:Departamento {nombre: "RRHH"})
CREATE (e)-[:PERTENECE_A]->(d);

// Crea Proyectos
CREATE (:Proyecto {nombre: "SistemaWeb"});
CREATE (:Proyecto {nombre: "Campaña2025"});

// Asignar empleados a proyectos con horas
MATCH (e:Empleado {nombre: "Ana"}), (p:Proyecto {nombre: "SistemaWeb"})
CREATE (e)-[:ASIGNADO_A {horas: 20}]->(p);

MATCH (e:Empleado {nombre: "Ana"}), (p:Proyecto {nombre: "Campaña2025"})
CREATE (e)-[:ASIGNADO_A {horas: 10}]->(p);

MATCH (e:Empleado {nombre: "Bruno"}), (p:Proyecto {nombre: "Campaña2025"})
CREATE (e)-[:ASIGNADO_A {horas: 30}]->(p);

MATCH (e:Empleado {nombre: "Carla"}), (p:Proyecto {nombre: "SistemaWeb"})
CREATE (e)-[:ASIGNADO_A {horas: 15}]->(p);

// Asigna líderes de proyectos
MATCH (e:Empleado {nombre: "Ana"}), (p:Proyecto {nombre: "SistemaWeb"})
CREATE (e)-[:LIDERA]->(p);

MATCH (e:Empleado {nombre: "Bruno"}), (p:Proyecto {nombre: "Campaña2025"})
CREATE (e)-[:LIDERA]->(p);

// CONSULTAS

// 1. Obtener el nombre del proyecto, su líder y los empleados asignados
MATCH (lider:Empleado)-[:LIDERA]->(p:Proyecto)
OPTIONAL MATCH (emp:Empleado)-[a:ASIGNADO_A]->(p)
RETURN 
  p.nombre AS Proyecto,
  lider.nombre AS Lider,
  collect(emp.nombre) AS Empleados_Asignados;

// 2. Calcular el total de horas semanales por proyecto
MATCH (:Empleado)-[a:ASIGNADO_A]->(p:Proyecto)
RETURN 
  p.nombre AS Proyecto, 
  sum(a.horas) AS Total_Horas_Semanales;

// 3. Listar empleados que trabajan en más de un proyecto
MATCH (e:Empleado)-[:ASIGNADO_A]->(p:Proyecto)
WITH e, count(DISTINCT p) AS cantidadProyectos
WHERE cantidadProyectos > 1
RETURN e.nombre AS Empleado, cantidadProyectos;
