import pyodbc
server = '127.0.0.1'
database = 'testDB'
username = 'username'
password = 'password'
cnxn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER='+server+';DATABASE='+database+';UID='+username+';PWD='+ password)
cursor = cnxn.cursor()

cursor.execute("SELECT * from *;") 
row = cursor.fetchone() 
while row: 
    print(row[0])
    row = cursor.fetchone()