
# Ejercicio 10: Seguridad y Backups en MongoDB

## ✅ Creación de un usuario con permisos de lectura y escritura

Para crear un usuario con permisos de lectura y escritura sobre una base de datos (por ejemplo, `miBaseDeDatos`), se deben ejecutar los siguientes comandos desde el shell de MongoDB:

```javascript
use miBaseDeDatos

db.createUser({
  user: "miUsuario",
  pwd: "miContraseñaSegura",
  roles: [{ role: "readWrite", db: "miBaseDeDatos" }]
})
```

### Descripción:
- `use miBaseDeDatos`: cambia el contexto a la base de datos deseada.
- `createUser`: crea un nuevo usuario.
- `readWrite`: es el rol que permite lectura y escritura sobre la base de datos especificada.

---

## ✅ Backup (respaldo) de una base de datos

Para generar un backup de una base de datos usando la línea de comandos:

```bash
mongodump --db miBaseDeDatos --out /ruta/del/backup
```

### Descripción:
- `--db`: especifica el nombre de la base de datos.
- `--out`: indica la carpeta donde se almacenará el respaldo.

**Ejemplo:**

```bash
mongodump --db miBaseDeDatos --out /backups/miBaseDeDatos-backup
```

---

## ✅ Restauración de una base de datos

Para restaurar una base de datos desde un backup previamente generado:

```bash
mongorestore --db miBaseDeDatos --drop /ruta/del/backup/miBaseDeDatos
```

### Descripción:
- `--db`: nombre de la base de datos a restaurar.
- `--drop`: elimina los datos existentes antes de restaurar.
- La ruta debe contener los archivos `.bson` generados por `mongodump`.

**Ejemplo:**

```bash
mongorestore --db miBaseDeDatos --drop /backups/miBaseDeDatos-backup/miBaseDeDatos
```

---

**Nota:** Asegurate de tener los permisos necesarios y que el servicio de MongoDB esté activo al ejecutar estos comandos.
