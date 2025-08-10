CREATE DATABASE klkMenol;
USE klkMenol;


--creando mis tablas


CREATE TABLE Profesor(
PROF_ID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
PROF_Nombre VARCHAR(70) NOT NULL,
PROF_Apellido VARCHAR(100) NOT NULL,
PROF_Cedula VARCHAR(15) NOT NULL,
PROF_Telefono NUMERIC(15) NOT NULL,
PROF_Asignatura VARCHAR(15) NOT NULL,
PROF_Estado VARCHAR(1) NOT NULL
);

CREATE TABLE Estudiante(
EST_Matricula VARCHAR(30) PRIMARY KEY NOT NULL,
EST_Nombre VARCHAR(70) NOT NULL,
EST_Apellido VARCHAR(100) NOT NULL,
EST_Telefono NUMERIC(15) NOT NULL,
EST_Estado VARCHAR(1) NOT NULL
);

CREATE TABLE Asignatura(
ASIG_Codigo VARCHAR(15) PRIMARY KEY NOT NULL,
ASIG_Nombre VARCHAR(50) NOT NULL,
ASIG_Estado VARCHAR(15) NOT NULL

);

CREATE TABLE Nota(
NOT_Codigo BIGINT IDENTITY(1,1) PRIMARY KEY NOT NULL,
NOT_Estudiante VARCHAR(30) NOT NULL,
NOT_Profesor INT NOT NULL,
NOT_Asignatura VARCHAR(15) NOT NULL,
NOT_PP1 NUMERIC(3) NOT NULL,
NOT_PP2 NUMERIC(3) NOT NULL,
NOT_EF NUMERIC(3) NOT NULL,
NOT_TP NUMERIC(3) NOT NULL,
NOT_Estado VARCHAR(15) NOT NULL
);
--DROP DATABASE klkMenol;
--ALTER TABLE Estudiante
--DROP COLUMN EST_Asignatura;



--RELACIONANDO MIS TABLAS

ALTER TABLE Nota ADD FOREIGN KEY (NOT_Asignatura) REFERENCES Asignatura (ASIG_Codigo);
ALTER TABLE Nota ADD FOREIGN KEY (NOT_Estudiante) REFERENCES Estudiante (EST_Matricula);
ALTER TABLE Nota ADD FOREIGN KEY (NOT_Profesor) REFERENCES Profesor (PROF_ID);


--INSERTANDO MIS DATOS

--ASIGNATURA
INSERT INTO Asignatura
VALUES('BIO-01','Biología 1','A');

INSERT INTO Asignatura
VALUES('INF-555','Ingeniería de Sistemas','A');

INSERT INTO Asignatura
VALUES('INF-455','Bases de Datos 1','A');

--PROFESOR

INSERT INTO Profesor
VALUES('José Guillermo','Urbáez', '018-000', 8092248387, 'INF-555', 'A');

INSERT INTO Profesor
VALUES('Karla','Urbáez', '018-010', 809254, 'BIO-01', 'A');

--ESTUDIANTES 

INSERT INTO Estudiante
VALUES('19-0253', 'Juanito', 'Alimaña', 85321, 'A');

INSERT INTO Estudiante
VALUES('19-0254', 'Alondra', 'Jiménez', 87521, 'A');

--NOTAS

INSERT INTO Nota
VALUES ('19-0254', 1, 'INF-555', 70, 90, 95, 90, 'AP');

INSERT INTO Nota
VALUES ('19-0253', 2, 'BIO-01', 60, 75, 80, 90, 'AP');



--DML

SELECT *FROM Estudiante;
SELECT *FROM Profesor;
SELECT *FROM Nota;

SELECT e.EST_Matricula AS 'Matrícula',
	   e.EST_Nombre + ' ' + e.Est_Apellido AS 'Estudiante',
	   p.PROF_Nombre + ' ' + p.PROF_Apellido AS 'Profesor',
	   n.NOT_Asignatura AS 'Código Asignatura', 
	   a.ASIG_Nombre AS 'Asignatura',
	   n.NOT_PP1 AS 'PP1',
	   n.NOT_PP2 AS 'PP2',
	   n.NOT_EF AS 'EF',
	   n.NOT_TP AS 'NP',
	   n.NOT_Estado AS 'Estado'
FROM Estudiante e, Profesor p, Asignatura a, Nota n
WHERE e.EST_Matricula = n.NOT_Estudiante
AND p.PROF_ID = n.NOT_Profesor
AND a.ASIG_Codigo = n.NOT_Asignatura;

