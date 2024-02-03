from O365 import Account

# secretID='9dddc22d-2549-42c0-93ca-3360ba363f34'
clientID='dfe48188-4c79-41af-90ee-593238ca5adf'
secretValue='Iof8Q~k6-yup36_xIe4Q3Nx7vaZsu_h1unMURaYq'
tenantID='096e042b-10e9-4832-b6b7-455fdb008a37'

credentials = (clientID, secretValue)

account = Account(credentials, auth_flow_type='credentials', tenant_id=tenantID)
if account.authenticate():
    directory = account.directory()
    for user in directory.get_users():
        print(user)