import pyodbc
server = '10.200.21.42\delsqlserver'
username = 'Dawn'
password = 'diesel123'
cnxn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER='+server+';UID='+username+';PWD='+ password)

cursor = cnxn.cursor()
cursor.execute("SELECT * from *;") 
row = cursor.fetchone() 
while row: 
    print(row[0])
    row = cursor.fetchone()

cnxn.close()