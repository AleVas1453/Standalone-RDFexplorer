Project: An autonomous web platform for browsing and exploring semantic (RDF) data.

This web application provides user-friendly access to semantic (RDF) data. 
It reads a configuration (config.properties file) and a folder with the data (RDF files) which it loads into memory, 
meaning the application deliberately does not require a connection to an RDF triplestore. Some of the key features it provides:
- Fully configurable through a configuration file in which you define the categories of entities you are interested in exploring by providing SPARQL queries.
- Displaying data of a category of entities in a table with ranking and filtering capabilities.
- Ability to visualize the data of a table in a bar chart by simply selecting a table column.
- Entity page with more information about a selected entity.

The application has been creating using Java JDK 17 (Version 17.0.8.1) and Java EE 6
