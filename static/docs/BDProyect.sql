CREATE DATABASE bdproyect;
\c bdproyect

CREATE TABLE tmestado (
    idestado SERIAL PRIMARY KEY,
    destado VARCHAR(12) NOT NULL
);

CREATE TABLE tmtipouser (
    idtipouser SERIAL PRIMARY KEY,
    dtipouser VARCHAR(15) NOT NULL
);

CREATE TABLE tmusuarios (
    idusuario SERIAL PRIMARY KEY,
    correo VARCHAR(100) NOT NULL UNIQUE CHECK (correo ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'),
    contrasena TEXT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    tel VARCHAR(8) CHECK (tel ~ '^[0-9]{7,8}$'),
    cel VARCHAR(10) NOT NULL CHECK (cel ~ '^[0-9]{10}$'),
    idtipouser INTEGER NOT NULL,
    idestado INTEGER NOT NULL DEFAULT 1,
    FOREIGN KEY (idtipouser) REFERENCES tmtipouser (idtipouser) on update cascade on delete restrict,
    FOREIGN KEY (idestado) REFERENCES tmestado (idestado) on update cascade on delete restrict
);

CREATE TABLE tddirecciones (
    iddireccion SERIAL PRIMARY KEY,
    idusuario INTEGER NOT NULL,
    departamento VARCHAR(30) NOT NULL,
    municipio VARCHAR(30) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    codpostal VARCHAR(6) NOT NULL,
    idestado INTEGER NOT NULL DEFAULT 1,
    FOREIGN KEY (idusuario) REFERENCES tmusuarios (idusuario) on update cascade on delete restrict,
    FOREIGN KEY (idestado) REFERENCES tmestado (idestado) on update cascade on delete restrict
);

CREATE TABLE tmcategorias (
    idcategoria SERIAL PRIMARY KEY,
    dcategoria VARCHAR(30) NOT NULL,
    idestado INTEGER NOT NULL DEFAULT 1,
    FOREIGN KEY (idestado) REFERENCES tmestado (idestado) on update cascade on delete restrict
);

CREATE TABLE tmsubcategorias (
    idsubcategoria SERIAL PRIMARY KEY,
    idcategoria INTEGER NOT NULL,
    dsubcategoria VARCHAR(30) NOT NULL,
    idestado INTEGER NOT NULL DEFAULT 1,
    FOREIGN KEY (idcategoria) REFERENCES tmcategorias (idcategoria) on update cascade on delete restrict,
    FOREIGN KEY (idestado) REFERENCES tmestado (idestado) on update cascade on delete restrict
);

CREATE TABLE tmproductos (
    idproducto SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion TEXT NOT NULL,
    precio DECIMAL(10,2) NOT NULL CHECK (precio >= 0),
    idcategoria INTEGER NOT NULL,
    idsubcategoria INTEGER NOT NULL,
    idestado INTEGER NOT NULL DEFAULT 1,
    FOREIGN KEY (idcategoria) REFERENCES tmcategorias (idcategoria) on update cascade on delete restrict,
    FOREIGN KEY (idsubcategoria) REFERENCES tmsubcategorias (idsubcategoria) on update cascade on delete restrict,
    FOREIGN KEY (idestado) REFERENCES tmestado (idestado) on update cascade on delete restrict
);

CREATE TABLE tmtallas (
    idtalla SERIAL PRIMARY KEY,
    dtalla VARCHAR(3) NOT NULL,
    idestado INTEGER NOT NULL DEFAULT 1,
    FOREIGN KEY (idestado) REFERENCES tmestado (idestado) on update cascade on delete restrict
);

CREATE TABLE tmcolores (
    idcolor SERIAL PRIMARY KEY,
    dcolor VARCHAR(7) NOT NULL,
    idestado INTEGER NOT NULL DEFAULT 1,
    FOREIGN KEY (idestado) REFERENCES tmestado (idestado) on update cascade on delete restrict
);

CREATE TABLE tdinventario (
    idinventario SERIAL PRIMARY KEY,
    idproducto INTEGER NOT NULL,
    idtalla INTEGER NOT NULL,
    idcolor INTEGER NOT NULL,
    cantidad INTEGER NOT NULL CHECK (cantidad >= 0),
    img_1 VARCHAR(255) NOT NULL,
    img_2 VARCHAR(255),
    img_3 VARCHAR(255),
    idestado INTEGER NOT NULL DEFAULT 1,
    FOREIGN KEY (idproducto) REFERENCES tmproductos (idproducto) on update cascade on delete restrict,
    FOREIGN KEY (idtalla) REFERENCES tmtallas (idtalla) on update cascade on delete restrict,
    FOREIGN KEY (idcolor) REFERENCES tmcolores (idcolor) on update cascade on delete restrict,
    FOREIGN KEY (idestado) REFERENCES tmestado (idestado) on update cascade on delete restrict
);

CREATE TABLE tdbolsa (
    idbolsa SERIAL PRIMARY KEY,
    idusuario INTEGER NOT NULL,
    idinventario INTEGER NOT NULL,
    cantidad INTEGER NOT NULL,
    idestado INTEGER NOT NULL DEFAULT 1,
    FOREIGN KEY (idusuario) REFERENCES tmusuarios (idusuario) on update cascade on delete restrict,
    FOREIGN KEY (idinventario) REFERENCES tdinventario (idinventario) on update cascade on delete restrict,
    FOREIGN KEY (idestado) REFERENCES tmestado (idestado) on update cascade on delete restrict
);

CREATE TABLE tdfavoritos (
    idfavorito SERIAL PRIMARY KEY,
    idusuario INTEGER NOT NULL,
    idinventario INTEGER NOT NULL,
    idestado INTEGER NOT NULL DEFAULT 1,
    FOREIGN KEY (idusuario) REFERENCES tmusuarios (idusuario) on update cascade on delete restrict,
    FOREIGN KEY (idinventario) REFERENCES tdinventario (idinventario) on update cascade on delete restrict,
    FOREIGN KEY (idestado) REFERENCES tmestado (idestado) on update cascade on delete restrict
);

CREATE TABLE tdventas (
    idventa SERIAL PRIMARY KEY,
    idusuario INTEGER NOT NULL,
    idbolsa INTEGER NOT NULL,
    fecha_venta DATE NOT NULL,
    hora_venta TIME NOT NULL,
    idestado INTEGER NOT NULL,
    FOREIGN KEY (idusuario) REFERENCES tmusuarios (idusuario) on update cascade on delete restrict,
    FOREIGN KEY (idbolsa) REFERENCES tdbolsa (idbolsa) on update cascade on delete restrict,
    FOREIGN KEY (idestado) REFERENCES tmestado (idestado) on update cascade on delete restrict
);