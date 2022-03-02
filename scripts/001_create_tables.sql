/*
Projeto:		Sistema Hora Atividade Afranio
Autor:			Gerson Prado
Data inicio:	31/01/2022
Versão:			1.0
Script:			Criação das tabelas de cadastros.
*/

-- Tabela de cadastro de professor
Begin Transaction
	--Tabela de cadastro de cargo
	If Not Exists(Select name From sys.tables tables Where name = 'tb_cargo') --Ok
	Begin
		Create Table tb_cargo (
			id Int Identity(1,1) Primary Key,
			descricao Varchar(200) not null,			
			data_insercao Datetime not null,
			ativo Bit not null
		)
	End
	
	--Tabela de cadastro de especialidade	
	If Not Exists(Select name From sys.tables tables Where name = 'tb_especialidade') --Ok
	Begin
		Create Table tb_especialidade (
			id Int Identity(1,1) Primary Key,
			descricao Varchar(150) not null,			
			data_insercao Datetime not null,
			ativo Bit not null
		)
	End
	
	--Tabela de cadastro de categoria
	If Not Exists(Select name From sys.tables tables Where name = 'tb_categoria') --Ok
	Begin
		Create Table tb_categoria (
			id Int Identity(1,1) Primary Key,
			descricao Varchar(150),		
			data_insercao Datetime not null,
			ativo Bit not null
		)
	End
	
	--Tabela de cadastro de padrao
	If Not Exists(Select name From sys.tables tables Where name = 'tb_padrao') --Ok
	Begin
		Create Table tb_padrao (
			id Int Identity(1,1) Primary Key,
			codigo Varchar(50) not null,
			descricao Varchar(150),		
			data_insercao Datetime not null,
			ativo Bit not null
		)
	End
	
	--Tabela de cadastro de jornada
	If Not Exists(Select name From sys.tables tables Where name = 'tb_jornada') --Ok
	Begin
		Create Table tb_jornada (
			id Int Identity(1,1) Primary Key,
			codigo Varchar(50) not null,
			descricao Varchar(150),
			data_insercao Datetime not null,
			ativo Bit not null
		)
	End

	--Tabela de cadastro de classe	
	If Not Exists(Select name From sys.tables tables Where name = 'tb_classe') --Ok
	Begin
		Create Table tb_classe (
			id Int Identity(1,1) Primary Key,
			classe Varchar(25) not null,
			turma Varchar(25) not null,
			data_insercao Datetime not null,
			ativo Bit not null
		)
	End

	--Tabela de cadastro de turno
	If Not Exists(Select name From sys.tables tables Where name = 'tb_turno') --Ok
	Begin
		Create Table tb_turno (
			id Int Identity(1,1) Primary Key,
			descricao Varchar(50) not null,			
			data_insercao Datetime not null,
			ativo Bit not null
		)
	End
	
	--Tabela de cadastro de horario de turno
	If Not Exists(Select name From sys.tables tables Where name = 'tb_turno_horario') --
	Begin
		Create Table tb_turno_horario (
			id Int Identity(1,1) Primary Key,
			horario Varchar(100) not null,
			turno Varchar(10) not null,
			sigla Varchar(15) not null,
			data_insercao Datetime not null,
			ativo Bit not null
		)
	End	
	
	If Not Exists(Select name From sys.tables tables Where name = 'tb_docente') --Ok
	Begin
		Create Table tb_docente (
			id Int Identity(1,1) Primary Key,
			numero Int Not Null,
			rf Int Not Null,
			sindicato Varchar(50),
			nome Varchar(200) not null,
			id_categoria Int Foreign Key References tb_categoria(id),
			id_padrao Int Foreign Key References tb_padrao(id),
			id_jornada Int Foreign Key References tb_jornada(id),
			data_insercao Datetime not null,
			ativo Bit not null
		)
	End	
	
	If Not Exists(Select name From sys.tables tables Where name = 'tb_docente_cargos') --Ok
	Begin
		Create Table tb_docente_cargos (
			id Int Identity(1,1) Not Null,
			id_docente Int Not Null Foreign Key References dbo.tb_docente(id),
			id_cargo  Int Not Null Foreign Key References dbo.tb_cargo(id),			
			data_insercao Datetime not null,
			ativo Bit not null,
			Primary Key(id, id_docente, id_cargo)
		)		
	End

	If Not Exists(Select name From sys.tables tables Where name = 'tb_docente_especialidades') --Ok
	Begin
		Create Table tb_docente_especialidades (
			id Int Identity(1,1) Not Null,
			id_docente Int Not Null Foreign Key References dbo.tb_docente(id),
			id_especialidade  Int Not Null Foreign Key References dbo.tb_especialidade(id),			
			id_jornada  Int Not Null Foreign Key References dbo.tb_jornada(id),
			data_insercao Datetime not null,
			ativo Bit not null,
			Primary Key(id, id_docente, id_especialidade)
		)		
	End

	If Not Exists(Select name From sys.tables tables Where name = 'tb_docente_classes') --Ok
	Begin
		Create Table tb_docente_classes (
			id Int Identity(1,1) Not Null,
			id_docente Int Not Null Foreign Key References dbo.tb_docente(id),
			id_classe  Int Not Null Foreign Key References dbo.tb_classe(id),			
			data_insercao Datetime not null,
			ativo Bit not null,
			Primary Key(id, id_docente, id_classe)
		)		
	End
	
	If Not Exists(Select name From sys.tables tables Where name = 'tb_docente_hora_atividade') --
	Begin
		Create Table tb_docente_hora_atividade (
			id Int Identity(1,1) Primary Key,
			id_turno_horario Int Foreign Key References tb_turno_horario(id),
			id_docente_especialidade Int Foreign Key References dbo.tb_docente_especialidades(id),
			id_dia_semana Varchar(2),
			data_insercao Datetime not null,
			ativo Bit not null
		)
	End

If @@ERROR > 1 
Begin
	Rollback
End
Else
Begin
	Commit
End
