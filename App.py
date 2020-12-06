# Carlos Salas 
import sqlite3
from sqlite3 import Error


def openConnection(_dbFile):
    conn = None
    try:
        conn = sqlite3.connect(_dbFile)  
    except Error as e:
        print(e)
    return conn

def closeConnection(_conn, _dbFile):
    try:
        _conn.close()
    except Error as e:
        print(e)




def deleteProduct(_conn, _p_barcode):
    try:   

        sql = """DELETE FROM Product
                WHERE p_barcode = {};""".format(_p_barcode)
      
       
        cur = _conn.cursor()
        
        cur.execute(sql)
        
       
    except Error as e:
        print(e)       





def printTable(_conn,_table):
    try:   

        sql = """Select * from {}; """.format(_table)
        cur = _conn.cursor()
        cur.execute(sql)
    
        rows = cur.fetchall()
        for row in rows: 
            l = '{:<10} {:<10} {:>10}  '.format(row[0], row[1], row[2])
            print(l)

    except Error as e:
        print(e)

def printTable2(_conn,_table):
    try:   

        sql = """Select * from {}; """.format(_table)
        cur = _conn.cursor()
        cur.execute(sql)
    
        rows = cur.fetchall()
        for row in rows: 
            l = '{:<10} {:<10} {:>10} {:>10} '.format(row[0], row[1], row[2], row[3])
            print(l)

    except Error as e:
        print(e)

def printTable3(_conn,_table):
    try:   

        sql = """Select * from {}; """.format(_table)
        cur = _conn.cursor()
        cur.execute(sql)
    
        rows = cur.fetchall()
        for row in rows: 
            l = '{:<10} {:<10} '.format(row[0], row[1])
            print(l)

    except Error as e:
        print(e)

def main():
    database = r"inventory.sqlite"
    clerkMenu = {}
    clerkMenu['1']="-Check Inventory" 
    clerkMenu['2']="-Check Price"
    clerkMenu['3']="-Add to Inventory"
    clerkMenu['4']="-Remove From Inventory"
    clerkMenu['5']="-Exit"
    managerMenu = {}
    managerMenu['1']="-Add Product" 
    managerMenu['2']="-Remove Product"
    managerMenu['3']="-Change Price"
    managerMenu['4']="-Lookup Barcode"
    managerMenu['5']="-Exit"
    menu = {}
    menu['1']="-Manager." 
    menu['2']="-Clerk"
    menu['3']="-Exit Application"
    # create a database connection
    conn = openConnection(database)
    with conn:
        print("Welcome to Inventory Manager v1.0")
        while True: 
            options=menu.keys()
            #options.sort()
            for entry in options: 
                print(entry, menu[entry])
            selection=input("Select:") 
            if selection =='1': 
                while True: 
                    options=managerMenu.keys()
                    #options.sort()
                    for entry in options: 
                        print(entry, managerMenu[entry])
                    selection=input("Select:") 
                    if selection =='1': 
                        print ("Add") 
                    elif selection == '2': 
                        print ("Remove")
                    elif selection == '3':
                        print ("Change") 
                    elif selection == '4': 
                        print("Lookup")
                    elif selection == '5': 
                        break
                    else: 
                        print("Unknown Option Selected!") 
            elif selection == '2': 
                while True: 
                    options=clerkMenu.keys()
                    #options.sort()
                    for entry in options: 
                        print(entry, clerkMenu[entry])
                    selection=input("Select:") 
                    if selection =='1': 
                        print ("Add") 
                    elif selection == '2': 
                        print ("Remove")
                    elif selection == '3':
                        print ("Change") 
                    elif selection == '4': 
                        print("Lookup")
                    elif selection == '5': 
                        break
                    else: 
                        print("Unknown Option Selected!")
            elif selection == '3': 
                break
            else: 
                print("Unknown Option Selected!")

    closeConnection(conn, database)


if __name__ == '__main__':
    main()

#Lookup Item
#Display a stores Inventory
#Display Price
#Lookup City of Store
#Add Product
#Delete Product
#Update Product Price
#Add Stock to Inventory
#Remove Stock From Inventory
#Remove scanned item from inventory
#To display scaned barcodes we can read from a file which contains the barcodes to look up
#Display product type and price base on barcode '10100801' entered
#Displays the supplier with the least expensive product and the supplier with the most expensive product
#Display product type that needs to be restock. A product needs to be restock if there are less than 15 in stock. 
#Display the avg price by product type
#Display the country and the number of suppliers that it has
#Display city name and the number of suppliers it has
#Display countries with the max and min shipping rate
#Display the different product type from Producer
#Display supplier and the number of product type that it supplies



