CREATE DATABASE Sample

ALTER DATABASE Sample MODIFY NAME = SAMPLE1
EXECUTE sp_renamedb'SAMPLE1', 'SAMPLE2'

DROP DATABASE SAMPLE2

