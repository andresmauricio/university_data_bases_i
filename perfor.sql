    CREATE DATABASE IF NOT EXISTS taller;

    USE taller;

    CREATE TABLE IF NOT EXISTS persona (
    id_persona INT AUTO_INCREMENT PRIMARY KEY,
    nombres VARCHAR(45) NOT NULL,
    documento VARCHAR(12) NOT NULL,
    direccion VARCHAR(45) NOT NULL,
    telefono VARCHAR(45) NOT NULL,
    correo VARCHAR(45) NOT NULL,
    fecha_de_creacion DATE,
    fecha_de_actualizacion DATE
    );

    CREATE TABLE IF NOT EXISTS vehiculo (
    id_vehiculo INT AUTO_INCREMENT PRIMARY KEY,
    marca VARCHAR(45) NOT NULL,
    color VARCHAR(45) NOT NULL,
    tipo VARCHAR(45) NOT NULL
    );

    CREATE TABLE IF NOT EXISTS cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    persona_id_persona INT NOT NULL,
    vehiculo_id_vehiculo INT NOT NULL,
    FOREIGN KEY (persona_id_persona) REFERENCES persona(id_persona),
    FOREIGN KEY (vehiculo_id_vehiculo) REFERENCES vehiculo(id_vehiculo)
    );

    CREATE TABLE IF NOT EXISTS formacion (
    id_formacion INT AUTO_INCREMENT PRIMARY KEY,
    experiencia SMALLINT(50) NOT NULL,
    profesion VARCHAR(45) NOT NULL
    );

    CREATE TABLE IF NOT EXISTS mecanico (
        id_mecanico INT AUTO_INCREMENT PRIMARY KEY,
        formacion_id_formacion INT NOT NULL,
        persona_id_persona INT NOT NULL,
        FOREIGN KEY (formacion_id_formacion) REFERENCES formacion (id_formacion),
        FOREIGN KEY (persona_id_persona) REFERENCES persona (id_persona)
    );

    CREATE TABLE IF NOT EXISTS especialidad (
        id_especialidad INT AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(45) NOT NULL
    );

    CREATE TABLE IF NOT EXISTS mecanico_has_especialidad (
        mecanico_id_mecanico INT NOT NULL,
        especialidad_id_especialidad INT NOT NULL,
        FOREIGN KEY (mecanico_id_mecanico) REFERENCES mecanico (id_mecanico),
        FOREIGN KEY (especialidad_id_especialidad) REFERENCES especialidad (id_especialidad)
    );

    CREATE TABLE IF NOT EXISTS factura (
        id_factura INT AUTO_INCREMENT PRIMARY KEY,
        total INT NULL,
        iva DECIMAL NULL,
        vehiculo_id_vehiculo INT NOT NULL,
        cliente_id_cliente INT NOT NULL,
        fecha_de_ingreso DATE,
        fecha_de_salida DATE,
        FOREIGN KEY (vehiculo_id_vehiculo) REFERENCES vehiculo (id_vehiculo),
        FOREIGN KEY (cliente_id_cliente) REFERENCES cliente (id_cliente)
    );

    CREATE TABLE IF NOT EXISTS repuesto (
        id_repuesto INT AUTO_INCREMENT PRIMARY KEY,
        nombre_del_respuesto VARCHAR(45) NOT NULL,
        valor DECIMAL NOT NULL
    );

    CREATE TABLE IF NOT EXISTS libreta (
        id_libreta INT AUTO_INCREMENT PRIMARY KEY,
        valor_mano_de_obra DECIMAL ,
        mecanico_id_mecanico INT NOT NULL ,
        factura_id_factura INT NOT NULL,
        FOREIGN KEY (mecanico_id_mecanico) REFERENCES mecanico (id_mecanico),
        FOREIGN KEY (factura_id_factura) REFERENCES factura (id_factura)
    );

    CREATE TABLE IF NOT EXISTS repuestos_has_libreta (
        id_respuestos_libreta INT AUTO_INCREMENT PRIMARY KEY,
        repuesto_id_repuesto INT NOT NULL,
        libreta_id_libreta INT NOT NULL,
        FOREIGN KEY (repuesto_id_repuesto) REFERENCES repuesto (id_repuesto),
        FOREIGN KEY (libreta_id_libreta) REFERENCES libreta (id_libreta)
    );



    -- INSERT DE DATOS PERSONA -- 
    INSERT INTO persona (id_persona, nombres, documento, direccion, telefono, correo, fecha_de_creacion, fecha_de_actualizacion) 
    VALUES  (NULL, 'Andres Acelas', 1052412238, 'Carrera 7b # 10 -12', 3157350570, 'andres@andres.com', NULL, NULL), 
            (NULL, 'Maria del Pilar', 1057979123, 'Calle 1 # 45 -89', 3202404004, 'maria@maria.com', NULL, NULL);

    -- INERT VEHICULOS --
    INSERT INTO vehiculo (id_vehiculo, marca, color, tipo)
     VALUES (NULL, 'Mazda', 'Rojo', 'Converible'), (NULL, 'Ferrari', 'Negro', 'Deportivo');

     -- INERT CLIENTE -- 
     INSERT INTO cliente (id_cliente, persona_id_persona, vehiculo_id_vehiculo) VALUES (NULL, '2', '2');

     -- INSERT FORMACIÓN -- 
     INSERT INTO formacion (id_formacion, experiencia, profesion) VALUES (NULL, '6', 'Tecnico');

     --INSERT MECANICO -- 
     INSERT INTO mecanico (id_mecanico, formacion_id_formacion, persona_id_persona) VALUES (NULL, '1', '1');

     -- INSERT ESPECIALIDAD --
     INSERT INTO especialidad (id_especialidad, nombre) VALUES (NULL, 'Frenos'), (NULL, 'Carroceria');

     --MANY TO MANY ESPECIALIDAD A MECANICO --
     INSERT INTO mecanico_has_especialidad (mecanico_id_mecanico, especialidad_id_especialidad) VALUES ('1', '2');

     -- INSERT REPUESTOS -- 
     INSERT INTO repuesto (id_repuesto, nombre_del_respuesto, valor) VALUES (NULL, 'Llantas', '240.000'), (NULL, 'Motor', '860.000');

     --INSERT FACTURAS --
    INSERT INTO factura (id_factura, total, iva, vehiculo_id_vehiculo, cliente_id_cliente, fecha_de_ingreso, fecha_de_salida) 
    VALUES (NULL, '500000', 11.5, '2', '1', NULL, NULL), (NULL, '230000', 11.5, '2', '1', NULL, NULL);

    -- INSERT LIBRETA --
    INSERT INTO libreta (id_libreta, valor_mano_de_obra, mecanico_id_mecanico, factura_id_factura) 
    VALUES (NULL, '60.000', '1', '1'), (NULL, '78.000', '1', '1');

    -- INSERT MANY TO MANY LIBRETA - REPUESTOS --
    INSERT INTO repuestos_has_libreta (id_respuestos_libreta, repuesto_id_repuesto, libreta_id_libreta) 
    VALUES (NULL, '1', '1'), (NULL, '2', '1'), (NULL, '2', '2');


    -- SELECT INFO -- 

    SELECT * FROM persona;
    SELECT * FROM persona WHERE id_persona=1;

    SELECT * FROM vehiculo;
    SELECT * FROM vehiculo WHERE id_vehiculo=2;

    SELECT * FROM cliente;
    SELECT * FROM cliente WHERE id_cliente=1;
    SELECT cliente.id_cliente, persona.nombres, persona.documento, persona.telefono, persona.direccion, 
    vehiculo.marca, vehiculo.tipo 
    FROM ((cliente 
    INNER JOIN persona ON cliente.id_cliente=persona.id_persona)
    INNER JOIN vehiculo ON cliente.id_cliente=vehiculo.id_vehiculo);

    SELECT * FROM formacion;
    SELECT * FROM formacion WHERE id_formacion=1;

    SELECT * FROM mecanico;
    SELECT * FROM mecanico WHERE id_mecanico=1;
    SELECT mecanico.id_mecanico, persona.nombres, persona.documento, persona.telefono, persona.direccion,
    formacion.profesion, formacion.experiencia
    FROM ((mecanico
    INNER JOIN persona ON mecanico.id_mecanico=persona.id_persona)
    INNER JOIN formacion ON mecanico.id_mecanico=formacion.id_formacion);

    SELECT * FROM especialidad;
    SELECT * FROM especialidad WHERE id_especialidad=1;

    SELECT * FROM mecanico_has_especialidad;
    SELECT * FROM mecanico_has_especialidad WHERE mecanico_id_mecanico=1;


    
    SELECT * FROM repuesto;
    SELECT * FROM repuesto WHERE id_repuesto=2;

    SELECT * FROM factura;
    SELECT * FROM factura WHERE id_factura=2;
    SELECT factura.id_factura, persona.nombres, persona.documento, persona.telefono, persona.direccion, 
    vehiculo.marca, vehiculo.tipo 
    FROM ((factura 
    INNER JOIN persona ON factura.cliente_id_cliente=persona.id_persona)
    INNER JOIN vehiculo ON factura.vehiculo_id_vehiculo=vehiculo.id_vehiculo);
    
    SELECT * FROM libreta;
    SELECT * FROM libreta WHERE id_libreta=2;
    SELECT libreta.id_libreta, persona.nombres,  
    factura.id_factura 
    FROM ((libreta 
    INNER JOIN persona ON libreta.mecanico_id_mecanico=persona.id_persona)
    INNER JOIN factura ON libreta.factura_id_factura=factura.id_factura);

    SELECT * FROM repuestos_has_libreta;
    SELECT * FROM repuestos_has_libreta WHERE id_respuestos_libreta=2;




    













