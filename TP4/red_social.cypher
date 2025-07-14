
// LIMPIAR BASE
MATCH (n) DETACH DELETE n;

// Crear Usuarios
CREATE (:Usuario {nombre: "Lucia"});
CREATE (:Usuario {nombre: "Mateo"});
CREATE (:Usuario {nombre: "Sofía"});
CREATE (:Usuario {nombre: "Juan"});

// Conexiones
MATCH (a:Usuario {nombre: "Lucia"}), (b:Usuario {nombre: "Mateo"})
CREATE (a)-[:CONOCE]->(b), (b)-[:CONOCE]->(a);

MATCH (a:Usuario {nombre: "Lucia"}), (b:Usuario {nombre: "Sofía"})
CREATE (a)-[:CONOCE]->(b), (b)-[:CONOCE]->(a);

MATCH (a:Usuario {nombre: "Sofía"}), (b:Usuario {nombre: "Juan"})
CREATE (a)-[:CONOCE]->(b), (b)-[:CONOCE]->(a);

MATCH (a:Usuario {nombre: "Mateo"}), (b:Usuario {nombre: "Juan"})
CREATE (a)-[:CONOCE]->(b), (b)-[:CONOCE]->(a);

// Posts
CREATE (:Post {titulo: "Hola Mundo", fecha: date("2025-07-01")});
CREATE (:Post {titulo: "Cypher es genial", fecha: date("2025-07-02")});
CREATE (:Post {titulo: "Graph DB FTW", fecha: date("2025-07-03")});

// Relaciona posts a usuarios
MATCH (u:Usuario {nombre: "Lucia"}), (p:Post {titulo: "Hola Mundo"}) CREATE (u)-[:PUBLICO]->(p);
MATCH (u:Usuario {nombre: "Mateo"}), (p:Post {titulo: "Cypher es genial"}) CREATE (u)-[:PUBLICO]->(p);
MATCH (u:Usuario {nombre: "Mateo"}), (p:Post {titulo: "Graph DB FTW"}) CREATE (u)-[:PUBLICO]->(p);

// Habilidades
CREATE (:Habilidad {nombre: "Neo4j"});
CREATE (:Habilidad {nombre: "Cypher"});
CREATE (:Habilidad {nombre: "JavaScript"});
CREATE (:Habilidad {nombre: "Python"});
CREATE (:Habilidad {nombre: "HTML"});
CREATE (:Habilidad {nombre: "CSS"});
CREATE (:Habilidad {nombre: "React"});
CREATE (:Habilidad {nombre: "Node.js"});

// Relacionar habilidades a usuarios
MATCH (u:Usuario {nombre: "Lucia"}), (h:Habilidad {nombre: "Neo4j"}) CREATE (u)-[:TIENE]->(h);
MATCH (u:Usuario {nombre: "Lucia"}), (h:Habilidad {nombre: "Cypher"}) CREATE (u)-[:TIENE]->(h);

MATCH (u:Usuario {nombre: "Mateo"}), (h:Habilidad {nombre: "JavaScript"}) CREATE (u)-[:TIENE]->(h);
MATCH (u:Usuario {nombre: "Mateo"}), (h:Habilidad {nombre: "React"}) CREATE (u)-[:TIENE]->(h);

MATCH (u:Usuario {nombre: "Sofía"}), (h:Habilidad {nombre: "Python"}) CREATE (u)-[:TIENE]->(h);
MATCH (u:Usuario {nombre: "Sofía"}), (h:Habilidad {nombre: "Node.js"}) CREATE (u)-[:TIENE]->(h);

MATCH (u:Usuario {nombre: "Juan"}), (h:Habilidad {nombre: "HTML"}) CREATE (u)-[:TIENE]->(h);
MATCH (u:Usuario {nombre: "Juan"}), (h:Habilidad {nombre: "CSS"}) CREATE (u)-[:TIENE]->(h);

// Endoso
MATCH (endorser:Usuario {nombre: "Mateo"}), (u:Usuario {nombre: "Lucia"}), (h:Habilidad {nombre: "Neo4j"})
CREATE (endorser)-[:ENDOSO {a: u}]->(h);

MATCH (endorser:Usuario {nombre: "Sofía"}), (u:Usuario {nombre: "Mateo"}), (h:Habilidad {nombre: "JavaScript"})
CREATE (endorser)-[:ENDOSO {a: u}]->(h);

MATCH (endorser:Usuario {nombre: "Lucia"}), (u:Usuario {nombre: "Sofía"}), (h:Habilidad {nombre: "Python"})
CREATE (endorser)-[:ENDOSO {a: u}]->(h);

MATCH (endorser:Usuario {nombre: "Juan"}), (u:Usuario {nombre: "Mateo"}), (h:Habilidad {nombre: "React"})
CREATE (endorser)-[:ENDOSO {a: u}]->(h);

MATCH (endorser:Usuario {nombre: "Lucia"}), (u:Usuario {nombre: "Juan"}), (h:Habilidad {nombre: "HTML"})
CREATE (endorser)-[:ENDOSO {a: u}]->(h);

// CONSULTAS

// 1. Usuarios con más conexiones
MATCH (u:Usuario)-[:CONOCE]-()
RETURN u.nombre AS Usuario, count(*) AS Conexiones
ORDER BY Conexiones DESC;

// 2. Top 2 usuarios con más publicaciones
MATCH (u:Usuario)-[:PUBLICO]->(:Post)
RETURN u.nombre AS Usuario, count(*) AS Publicaciones
ORDER BY Publicaciones DESC
LIMIT 2;

// 3. Habilidades más endosadas
MATCH (:Usuario)-[e:ENDOSO]->(h:Habilidad)
RETURN h.nombre AS Habilidad, count(e) AS Endosos
ORDER BY Endosos DESC;

// 4. Habilidades que un usuario NO ha endosado (ej. "Lucia")
MATCH (u:Usuario {nombre: "Lucia"}), (h:Habilidad)
WHERE NOT EXISTS {
  MATCH (u)-[:ENDOSO]->(h)
}
RETURN h.nombre AS Habilidades_No_Endosadas;
