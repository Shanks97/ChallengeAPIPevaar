use master;

drop table if exists Products;
drop table if exists ProductTypes;

CREATE TABLE ProductTypes
(
	[ID] INT PRIMARY KEY,
	[Name] VARCHAR (MAX) NOT NULL
);

INSERT INTO ProductTypes([ID], [Name])
VALUES
(1, 'Bien'),
(2, 'Vehiculo'),
(3, 'Terreno'),
(4, 'Apartamento');


CREATE TABLE Products
(
	[ID] UNIQUEIDENTIFIER PRIMARY KEY default NEWID(),
	[Description] VARCHAR (MAX) NOT NULL,
	[Type] INT NOT NULL,
	[Value] DOUBLE PRECISION NOT NULL,
	[PurchaseDate] DATETIME NOT NULL default GETDATE(),
	[IsActive] BIT NOT NULL default 0,

	CONSTRAINT FK_ProductType FOREIGN KEY (Type) REFERENCES ProductTypes(ID)
);
CREATE INDEX IDX_ProdName on Products(ID) 

--execute sp_helpindex 'Products'	

INSERT INTO Products(ID, [Description], [Type], [Value], PurchaseDate, IsActive)
VALUES
(NEWID(), 'Este paquete contiene el Echo Dot (4.a generaci�n) con Amazon Smart Plug.', 1, 49.99, default, 1),
(NEWID(), 'Conoce el nuevo Echo Dot - Nuestro parlante inteligente m�s popular con Alexa. Este dise�o elegante y compacto ofrece voces n�tidas y bajos equilibrados, para un sonido completo.', 1, 49.99, default, 1),
(NEWID(), 'Lista para ayudar - P�dele a Alexa que te cuente un chiste, reproduzca m�sica, conteste preguntas, ponga las noticias, revise el pron�stico del tiempo, configure alarmas y m�s.', 1, 49.99, default, 1),
(NEWID(), 'Controla por voz tu entretenimiento - Reproduce canciones en l�nea desde Amazon Music, Apple Music, Spotify, Sirius XM, y m�s. Reproduce m�sica, audiolibros y podcasts en tu casa, con m�sica multihabitaci�n.', 1, 49.99, default, 1);


SELECT * FROM dbo.ProductTypes;
SELECT * FROM dbo.Products