# Carlos Salas 
# Ada Pluguez
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

def addProduct(_conn, _p_barcode, supplier, typ, price):
    try:   
    
        sql = """INSERT INTO Product Values ({},{},{},{});""".format(_p_barcode, supplier, typ, price)

        cur = _conn.cursor()
        
        cur.execute(sql)
        
       
    except Error as e:
        print(e)    




def checkStock(_conn):
    try:   

        sql = """SELECT p_barcode,p_type,p_price,i_storeID,i_stock
FROM Product, Inventory
WHERE p_barcode = i_barcode
    AND i_stock <= 15
ORDER BY i_storeID;"""
        cur = _conn.cursor()
        cur.execute(sql)
    
        rows = cur.fetchall()
        for row in rows: 
            l = '{:<10} {:<10} {:>10} {:<10} {:>10} '.format(row[0], row[1], row[2],row[3], row[4])
            print(l)

    except Error as e:
        print(e)

def barCodeLookUp(_conn,_p_barcode):
    try:   

        sql = """Select * from Product where p_barcode = {}; """.format(_p_barcode)
        cur = _conn.cursor()
        cur.execute(sql)
    
        rows = cur.fetchall()
        for row in rows: 
            l = '{:<10} {:<10} {:>10} {:>10} '.format(row[0], row[1], row[2], row[3])
            print(l)

    except Error as e:
        print(e)

def checkPrice(_conn,_p_type):
    try:   

        sql = """ SELECT * 
FROM Product
WHERE p_type = '{}';""".format(_p_type)
        cur = _conn.cursor()
        cur.execute(sql)
    
        rows = cur.fetchall()
        for row in rows: 
            l = '{:<10} {:<10} {:>10} {:>10} '.format(row[0], row[1], row[2], row[3])
            print(l)

    except Error as e:
        print(e)

def printInventory(_conn):
    try:   

        sql = """SELECT i_storeID, i_stock, p_type, p_price
FROM Inventory,Product
WHERE i_barcode = p_barcode;"""
        cur = _conn.cursor()
        cur.execute(sql)
    
        rows = cur.fetchall()
        for row in rows: 
            l = '{:<10} {:<10} {:<10} {:<10} '.format(row[0], row[1], row[2], row[3])
            print(l)

    except Error as e:
        print(e)

def addInventory(_conn,_i_storeID,_i_barcode,_i_stock):
    try:   

        sql = """INSERT INTO Inventory VALUES('{}', {}, {});""".format(_i_storeID,_i_barcode,_i_stock)
        cur = _conn.cursor()
        cur.execute(sql)
    
        rows = cur.fetchall()
        for row in rows: 
            l = '{:<10} {:<10} {:<10} {:<10} '.format(row[0], row[1], row[2], row[3])
            print(l)

    except Error as e:
        print(e)


def main():
    database = r"Backup.sqlite"
    clerkMenu = {}
    clerkMenu['1']="- Check Stock" 
    clerkMenu['2']="- Check Price"
    clerkMenu['3']="- Lookup Barcode"
    clerkMenu['4']="- Add to Inventory"
    clerkMenu['5']="- Remove From Inventory"
    clerkMenu['6']="- View Store Inventory"
    clerkMenu['7']="- Exit"
    managerMenu = {}
    managerMenu['1']="- Add Product" 
    managerMenu['2']="- Remove Product"
    managerMenu['3']="- Change Product Price"
    managerMenu['4']="- Lookup Barcode"
    managerMenu['5']=" -Add to Inventory"
    managerMenu['6']="- Remove From Inventory"
    managerMenu['7']="- View Store Inventory"
    managerMenu['8']="- View Product List"
    managerMenu['9']="- Store Supplier List"
    managerMenu['10']="- Exit"
    menu = {}
    menu['1']="- Manager" 
    menu['2']="- Clerk"
    menu['3']="- Exit Application"
    # create a database connection
    conn = openConnection(database)
    with conn:
        print("Welcome to Inventory Manager v1.0")
        while True: 
            options=menu.keys()
            #options.sort()
            for entry in options: 
                print(entry, menu[entry])
            selection=input("Enter Selection:") 
            if selection =='2': 
                while True: 
                    print("Clerk Menu:")
                    options=clerkMenu.keys()
                    #options.sort()
                    for entry in options: 
                        print(entry, clerkMenu[entry])
                    selection=input("Enter Selection:") 
                    if selection =='1': 
                        print ("Check Stock") 
                        checkStock(conn)
                    elif selection == '2': 
                        print ("Check Price")
                        # typ = input("Product: ")
                        # checkPrice(conn,typ)
                        
                    elif selection == '3':
                        print ("Lookup Barcode")
                        barcode=input("Enter barcode:")
                        barCodeLookUp(conn,barcode)

                    elif selection == '4': 
                        print("Add to inventory")
                        # i_storeID=input("Enter storeID:")
                        # i_barcode=input("Enter barcode:")
                        # i_stock=input("Enter number in stock:")
                        
                        addInventory(conn, i_storeID, i_barcode, i_stock)
                        
                    elif selection == '5': 
                        print("Remove to inventory")
                        
                    elif selection == '6': 
                        print("View Store Inventory")
                        printInventory(conn)
                    elif selection == '7': 
                        break
                    
                    else: 
                        print("Unknown Option Selected!") 
            elif selection == '1': 
                while True: 
                    print("Manager Menu:")
                    options=managerMenu.keys()
                    #options.sort()
                    for entry in options: 
                        print(entry, managerMenu[entry])
                    selection=input("Enter Selection:") 
                    if selection =='1': 
                        print ("Add Product:\n")
                        barcode=input("Enter barcode:")
                        supplier=input("Enter supplierID:")
                        typ=input("Enter product type:")
                        price=input("Enter price:")
                        addProduct(conn, barcode, supplier, typ, price)
                    elif selection == '2': 
                        print ("Remove Product")
                    elif selection == '3':
                        print ("Change Product Price")
                    elif selection == '4':
                        print ("Add to inventory") 
                    elif selection == '5': 
                        print("Remove to inventory") 
                    elif selection == '6': 
                        print("Lookup Barcode")
                    elif selection == '7': 
                        print("Store Inventory")
                    elif selection == '8': 
                        print("Store Product List")
                    elif selection == '9': 
                        print("Store Supplier List")
                    elif selection == '10': 
                        break
                    else: 
                        print("Unknown Option Selected!")
            elif selection == '3': 
                print("Closing Application...")
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

