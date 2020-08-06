# extractlinkedserverctemssql
> Microsoft SQL Server project which utilizes a stored procedure and cte to extract data from a linked server

## Table of Contents
* [Version](#version)
* [Important Note](#important-note)
* [Dependent MSSQL Function](#dependent-mssql-function)
* [Prerequisite Data Types](#prerequisite-data-types)
* [Prerequisite Functions](#prerequisite-functions)
* [Prerequisite Conditions](#prerequisite-conditions)
* [Usage](#usage)

### Version
* 0.0.1

### **Important Note**
* This project was written with SQL Server 2012 methods

### Dependent MSSQL Function
* [Omit Characters](https://github.com/Cuates/omitcharactersmssql)

### Prerequisite Data Types
* bigint
* nvarchar
* datetime2

### Prerequisite Functions
* nullif
* ltrim
* rtrim
* openquery
* cast

### Usage
* `dbo.extractLinkedServerCte @optionMode = 'extractLinkedServerEntries'`
