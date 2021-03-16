import mysql.connector
from mysql.connector.constants import ClientFlag

config = {
    'user': 'Dawn',
    'password': 'Diesel123',
    'host': '10.200.21.42',
    'database': 'delsqlserver',
    'port': "1433",
#   'client_flags': [ClientFlag.SSL],
#   'ssl_ca': '/opt/mysql/ssl/ca.pem',
#   'ssl_cert': '/opt/mysql/ssl/client-cert.pem',
#   'ssl_key': '/opt/mysql/ssl/client-key.pem',
}

cnxn = mysql.connector.connect(**config)
cursor = cnxn.cursor()


cursor.execute("SELECT * from *;") 
row = cursor.fetchone() 
while row: 
    print(row[0])
    row = cursor.fetchone()

#cnxn.close()