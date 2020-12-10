# Carlos Salas 
# Ada Pluguez
import sqlite3
import csv
from sqlite3 import Error


#Functions
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

def populateTablesFromFile(conn):
    cursor = conn.cursor()
    sql_file = open("db.sql")
    sql_as_string = sql_file. read()
    cursor.executescript(sql_as_string)

def emptyTables(conn):
    cursor = conn.cursor()
    sql_file = open("emptyTables.sql")
    sql_as_string = sql_file. read()
    cursor.executescript(sql_as_string)


def checkStock(_conn, barcode, storeID):
    try:   
        sql = """SELECT DISTINCT i_stock FROM Inventory WHERE i_barcode = {} AND i_storeID = '{}';""".format(barcode, storeID)
        cur = _conn.cursor()
        cur.execute(sql)
    
        rows = cur.fetchall()
        for row in rows: 
            l = "StoreID:"+storeID +"|Product Barcode:"+barcode+'|Stock:{:<10}'.format(row[0])
            print(l)

    except Error as e:
        print(e)

def checkAllStock(_conn):
    try:   
        sql = """SELECT DISTINCT p_barcode,p_type,p_price,i_storeID,i_stock FROM Product, Inventory WHERE p_barcode = i_barcode ORDER BY i_storeID;"""
        cur = _conn.cursor()
        cur.execute(sql)
    
        rows = cur.fetchall()
        print("Barcode, Type, Price, StoreID, Stock")
        for row in rows: 
            l = '{:<10} {:<10} {:>10} {:<10} {:>10} '.format(row[0], row[1], row[2],row[3], row[4])
            print(l)

    except Error as e:
        print(e)

def saveAllStock(_conn):
    try:   

        sql = """SELECT DISTINCT p_barcode,p_type,p_price,i_storeID,i_stock FROM Product, Inventory WHERE p_barcode = i_barcode ORDER BY i_storeID;"""
        cur = _conn.cursor()
        cur.execute(sql)
    
        rows = cur.fetchall()
        with open('output/StockAtAllStores.csv', mode='w') as inventory_file:
            inventory_writer = csv.writer(inventory_file, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
            header = ["Barcode, Type, Price, StoreID, Stock"]
            inventory_writer.writerow(header)
            for row in rows:
                inventory_writer.writerow(row)
                
       
        print("Saving data to output/StockAtAllStores.csv...")
    except Error as e:
        print(e)

def barCodeLookUp(_conn,_p_barcode):
    try:   

        sql = """Select DISTINCT * from Product where p_barcode = {}; """.format(_p_barcode)
        cur = _conn.cursor()
        cur.execute(sql)
    
        rows = cur.fetchall()
        for row in rows: 
            l = '{:<10} {:<10} {:>10} {:>10} '.format(row[0], row[1], row[2], row[3])
            print(l)

    except Error as e:
        print(e)

def checkPrice(_conn, barcode):
    try:   

        sql = """ SELECT DISTINCT p_price FROM Product WHERE p_barcode = '{}';""".format(barcode)
        cur = _conn.cursor()
        cur.execute(sql)
    
        rows = cur.fetchall()
        for row in rows: 
            l = 'Price:{:<10}'.format(row[0])
            print(l)

    except Error as e:
        print(e)

def printAllProduct(_conn):
    try:   

        sql = """SELECT DISTINCT * FROM Product ;"""
        cur = _conn.cursor()
        cur.execute(sql)
    
        rows = cur.fetchall()
        print("Barcode, SupplierID, Type, Price")
        for row in rows: 
            l = '{:<10} {:<10} {:<10} {:<10} '.format(row[0], row[1], row[2], row[3])
            print(l)

    except Error as e:
        print(e)

def printInventory(_conn, storeID):
    try:   

        sql = """SELECT DISTINCT i_storeID, i_barcode, i_stock, p_type, p_price FROM Inventory,Product WHERE i_storeID = '{}' AND i_barcode = p_barcode;""".format(storeID)
        cur = _conn.cursor()
        cur.execute(sql)
    
        rows = cur.fetchall()
        print("StoreID, Barcode, Stock, Type, Price")
        for row in rows: 
            l = '{:<10} {:<10} {:<10} {:<10} '.format(row[0], row[1], row[2], row[3])
            print(l)

    except Error as e:
        print(e)



def saveInventory(_conn, storeID):
    try:   

        sql = """SELECT DISTINCT i_storeID, i_barcode, i_stock, p_type, p_price FROM Inventory,Product WHERE i_storeID = '{}' AND i_barcode = p_barcode;""".format(storeID)
        cur = _conn.cursor()
        cur.execute(sql)
    
        rows = cur.fetchall()
        with open('output/Inventory_'+ storeID +'.csv', mode='w') as inventory_file:
            inventory_writer = csv.writer(inventory_file, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
            header = ["StoreID, Barcode, Stock, Type, Price"]
            inventory_writer.writerow(header)
            for row in rows:
                inventory_writer.writerow(row)
                
       
        print("Saving data to output/Inventory_" + storeID +".csv...")
    except Error as e:
        print(e)

def printSupplier(_conn, storeID):
    try:   

        sql = """SELECT DISTINCT s_supplierID, ci_name, c_name, c_shippingRate FROM Supplier, StoreSupp, City, Country, Product WHERE stu_storeID = '{}' AND stu_suppID = s_supplierID AND s_cityKey = ci_cityKey AND ci_countryKey = c_countryKey;""".format(storeID)
        cur = _conn.cursor()
        cur.execute(sql)
    
        rows = cur.fetchall()
        print("SupplierID, City, Country, ShippingRate")
        for row in rows: 
            l = '{:<10} {:<10} {:<10} {:<10} '.format(row[0], row[1], row[2], row[3])
            print(l)

    except Error as e:
        print(e)



def saveSupplier(_conn, storeID):
    try:   

        sql = """SELECT DISTINCT i_storeID, i_barcode, i_stock, p_type, p_price FROM Inventory,Product WHERE i_storeID = '{}' AND i_barcode = p_barcode;""".format(storeID)
        cur = _conn.cursor()
        cur.execute(sql)
    
        rows = cur.fetchall()
        with open('output/Suppliers_'+ storeID +'.csv', mode='w') as inventory_file:
            inventory_writer = csv.writer(inventory_file, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
            header = ["SupplierID, City, Country, ShippingRate"]
            inventory_writer.writerow(header)
            for row in rows:
                inventory_writer.writerow(row)
                
       
        print("Saving data to output/Supplier_" + storeID +".csv...")
    except Error as e:
        print(e)
def printProduct(_conn, storeID):
    try:   

        sql = """SELECT DISTINCT * FROM Product, Inventory WHERE i_storeID = '{}' AND p_barcode = i_barcode;""".format(storeID)
        cur = _conn.cursor()
        cur.execute(sql)
    
        rows = cur.fetchall()
        print("Barcode, SupplierID, Type, Price")
        for row in rows: 
            l = '{:<10} {:<10} {:<10} {:<10} '.format(row[0], row[1], row[2], row[3])
            print(l)

    except Error as e:
        print(e)



def saveProduct(_conn, storeID):
    try:   

        sql = """SELECT DISTINCT * FROM Product, Inventory WHERE i_storeID = '{}' AND p_barcode = i_barcode;""".format(storeID)
        cur = _conn.cursor()
        cur.execute(sql)
    
        rows = cur.fetchall()
        with open('output/Products_'+ storeID +'.csv', mode='w') as inventory_file:
            inventory_writer = csv.writer(inventory_file, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
            header = ["Barcode, SupplierID, Type, Price"]
            inventory_writer.writerow(header)
            for row in rows:
                inventory_writer.writerow(row)
                
       
        print("output/Saving data to Products_" + storeID +".csv...")
    except Error as e:
        print(e)

def printCustomer(_conn, storeID):
    try:   

        sql = """SELECT DISTINCT cu_customerID, cu_storeID, pc_barcode FROM Customer, ProductCustomer WHERE cu_storeID = '{}' AND pc_custID = cu_customerID;""".format(storeID)
        cur = _conn.cursor()
        cur.execute(sql)
        print("CustomerID, StoreID, Barcode")
        rows = cur.fetchall()
        for row in rows: 
            l = '{:<10} {:<10} {:<10} '.format(row[0], row[1], row[2])
            print(l)

    except Error as e:
        print(e)



def saveCustomer(_conn, storeID):
    try:   

        sql = """SELECT DISTINCT cu_customerID, cu_storeID, pc_barcode FROM Customer, ProductCustomer WHERE cu_storeID = '{}' AND pc_custID = cu_customerID;""".format(storeID)
        cur = _conn.cursor()
        cur.execute(sql)
    
        rows = cur.fetchall()
        with open('output/Customer_'+ storeID +'.csv', mode='w') as inventory_file:
            inventory_writer = csv.writer(inventory_file, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
            header = ["CustomerID, StoreID, Barcode"]
            inventory_writer.writerow(header)
            for row in rows:
                inventory_writer.writerow(row)
                
       
        print("output/Saving data to Customers_" + storeID +".csv...")
    except Error as e:
        print(e)

def deleteProduct(_conn, _p_barcode):
    try:   

        sql = """DELETE FROM Product
                WHERE p_barcode = {};""".format(_p_barcode)
      
       
        cur = _conn.cursor()
        print ("Removing {}".format(_p_barcode))
        cur.execute(sql)
        
       
    except Error as e:
        print(e)       
def addCustomer(_conn, customer, store):
    
    #addSupplier(_conn, supplier, s_cityKey, s_countryKey)
    try:   
    
        sql = """INSERT INTO Customer Values ('{}','{}');""".format(customer, store)

        cur = _conn.cursor()
        
        cur.execute(sql)
        
       
    except Error as e:
        print(e) 

def addProductCustomer(_conn, customer, barcode):
    
    #addSupplier(_conn, supplier, s_cityKey, s_countryKey)
    try:   
    
        sql = """INSERT INTO ProductCustomer Values ('{}',{});""".format(customer, barcode)

        cur = _conn.cursor()
        
        cur.execute(sql)
        
       
    except Error as e:
        print(e) 

def addProduct(_conn, _p_barcode, supplier, typ, price):
    
    #addSupplier(_conn, supplier, s_cityKey, s_countryKey)
    try:   
    
        sql = """INSERT INTO Product Values ({},{},{},{});""".format(_p_barcode, supplier, typ, price)

        cur = _conn.cursor()
        
        cur.execute(sql)
        
       
    except Error as e:
        print(e)    

def addSupplier(_conn, s_supplierID, s_cityKey):
    try:   
    
        sql = """INSERT INTO Supplier Values ({},{});""".format(s_supplierID, s_cityKey)

        cur = _conn.cursor()
        
        cur.execute(sql)
        
       
    except Error as e:
        print(e)    

def updatePrice(_conn, barcode, price):
    try:   
    
        sql = """UPDATE Product SET p_price ={} WHERE p_barcode = {};""".format(price, barcode)

        cur = _conn.cursor()
        
        cur.execute(sql)
        
       
    except Error as e:
        print(e)

def addToInventory(_conn,storeID, barcode, stock):
    try:   
        sql = """INSERT INTO Inventory Values ('{}','{}','{}');""".format(storeID, barcode, stock)
        cur = _conn.cursor()  
        cur.execute(sql)
        
    except Error as e:
        print(e)

def setInventoryStock(_conn, storeID, barcode, stock):
    try:   
        sql = """UPDATE Inventory SET i_stock = {} WHERE i_barcode = {} AND i_storeID = '{}';""".format(stock, barcode, storeID)
        cur = _conn.cursor()
        cur.execute(sql)
       
    except Error as e:
        print(e)

def removeFromInventory(_conn, storeID, barcode):
    try:   
        sql = """DELETE FROM Inventory WHERE i_barcode = {} AND i_storeID = '{}';""".format(barcode, storeID)
        cur = _conn.cursor()
        cur.execute(sql)
       
    except Error as e:
        print(e)


def main():

    #DB File name
    database = r"inventory.sqlite"

    #Populate Tables From File
    conn = openConnection(database)
    with conn:
        
        #Empty Tables if needed
        emptyTables(conn)
        populateTablesFromFile(conn)
    closeConnection(conn, database)
    
    #Menus    
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
    managerMenu['5']="- Add to Inventory"
    managerMenu['6']="- Remove From Inventory"
    managerMenu['7']="- Add Customer Data"
    managerMenu['8']="- View Store Inventory"
    managerMenu['9']="- View Product List"
    managerMenu['10']="- View Customer List"
    managerMenu['11']="- View Supplier List"
    managerMenu['12']="- Display Inventory for All Stores"
    managerMenu['13']="- Exit"

    menu = {}
    menu['1']="- Clerk Menu"
    menu['2']="- Manager Menu" 
    menu['3']="- Exit Application"
    
    #Main Menu Loop
    print("Welcome to Inventory Manager v1.0")
    while True:
        options=menu.keys()
        for entry in options: 
            print(entry, menu[entry])
        selection=input("Enter User Type:") 
        if selection =='1':
             #Clerk Menu Loop 
            while True: 
                print("Clerk Menu:")
                options=clerkMenu.keys()
                for entry in options: 
                    print(entry, clerkMenu[entry])
                selection=input("Enter Selection:") 
                if selection =='1': 
                    print ("Check Stock:")
                    storeID=input("Enter store ID:") 
                    barcode=input("Enter barcode:")
                    conn = openConnection(database)
                    with conn:
                        checkStock(conn,barcode, storeID)
                    closeConnection(conn, database)
                elif selection == '2': 
                    print ("Check Price:")
                    barcode=input("Enter barcode:")
                    conn = openConnection(database)
                    with conn:
                        checkPrice(conn,barcode)
                    closeConnection(conn, database)
                elif selection == '3':
                    print ("Lookup Barcode:")
                    barcode=input("Enter barcode:")
                    conn = openConnection(database)
                    with conn:
                        barCodeLookUp(conn,barcode)
                    closeConnection(conn, database) 
                elif selection == '4':
                    print ("Add to inventory:") 
                    conn = openConnection(database)
                    with conn:
                        storeID=input("Enter storeID of Inventory:")
                        printAllProduct(conn)
                        barcode=input("Enter barcode of Product to Add:")
                        recieved=input("Enter amount recieved:")
                        sql = """Select i_stock from Inventory WHERE i_storeID = '{}' AND i_barcode = '{}'; """.format(storeID, barcode)
                        cur = conn.cursor()
                        cur.execute(sql)
                        rows = cur.fetchall()
                        if  cur.rowcount == -1:
                            addToInventory(conn,storeID, barcode, recieved)
                        else:
                            
                            stock = rows[0][0] + int(recieved)
                            setInventoryStock(conn,storeID, barcode, stock)

                    closeConnection(conn, database)
                elif selection == '5': 
                    print("Remove from inventory:") 
                    conn = openConnection(database)
                    with conn:
                        storeID=input("Enter storeID of Inventory:")
                        printInventory(conn, storeID)
                        barcode=input("Enter barcode of Product to Remove:")
                        sold=input("Enter amount sold:")
                        sql = """Select i_stock from Inventory WHERE i_storeID = '{}' AND i_barcode = {}; """.format(storeID, barcode)
                        cur = conn.cursor()
                        cur.execute(sql)
    
                        rows = cur.fetchall()
                        stock = rows[0][0] - int(sold)
                        if stock == 0:
                            removeFromInventory(conn,storeID, barcode)
                        else:
                            setInventoryStock(conn,storeID, barcode, stock)

                    closeConnection(conn, database)
                elif selection == '6': 
                    print("View Store Inventory:")
                    storeID=input("Enter storeID to display inventory: ")
                    conn = openConnection(database)
                    with conn:
                        printInventory(conn, storeID)
                        print("Save to file? y/n\n")
                        selection=input("Enter Selection:") 

                        if selection == 'y':
                            saveInventory(conn, storeID)

                    closeConnection(conn, database)
                elif selection == '7': 
                    print("Returning to Main Menu...")
                    break
                else: 
                    print("Unknown Option Selected!") 
        elif selection == '2': 
            #Manager Menu Loop
            while True: 
                print("Manager Menu:")
                options=managerMenu.keys()
                for entry in options: 
                    print(entry, managerMenu[entry])
                selection=input("Enter Selection:") 
                if selection =='1': 
                    print ("Add Product:\n")
                    conn = openConnection(database)
                    with conn: 
                        barcode=input("Enter barcode:")
                        supplier=input("Enter supplierID:")
                        typ=input("Enter product type:")
                        price=input("Enter price:")
                        addProduct(conn, barcode, supplier, typ, price)
                    closeConnection(conn, database)
                elif selection == '2': 
                    print ("Remove Product:")
                    conn = openConnection(database)
                    with conn:
                        printAllProduct(conn)
                        barcode=input("Enter barcode of Product to Remove:")
                        deleteProduct(conn, barcode)
                    closeConnection(conn, database)
                elif selection == '3':
                    print ("Change Product Price:")
                    conn = openConnection(database)
                    with conn:
                        barcode=input("Enter barcode of Product:")
                        price = input("Enter new price of Product:")
                        updatePrice(conn, barcode, price)
                    closeConnection(conn, database)
                elif selection == '4': 
                    print("Lookup Barcode:")
                    barcode=input("Enter barcode:")
                    conn = openConnection(database)
                    with conn:
                        barCodeLookUp(conn,barcode)

                    closeConnection(conn, database)
                elif selection == '5':
                    print ("Add to inventory:") 
                    conn = openConnection(database)
                    with conn:
                        storeID=input("Enter storeID of Inventory:")
                        printAllProduct(conn)
                        barcode=input("Enter barcode of Product to Add:")
                        recieved=input("Enter amount recieved:")
                        sql = """Select i_stock from Inventory WHERE i_storeID = '{}' AND i_barcode = '{}'; """.format(storeID, barcode)
                        cur = conn.cursor()
                        cur.execute(sql)
                        rows = cur.fetchall()
                        if  cur.rowcount == -1:
                            addToInventory(conn,storeID, barcode, recieved)
                        else:
                            
                            stock = rows[0][0] + int(recieved)
                            setInventoryStock(conn,storeID, barcode, stock)

                    closeConnection(conn, database)
                elif selection == '6': 
                    print("Remove from inventory:") 
                    conn = openConnection(database)
                    with conn:
                        storeID=input("Enter storeID of Inventory:")
                        printInventory(conn, storeID)
                        barcode=input("Enter barcode of Product to Remove:")
                        sold=input("Enter amount sold:")
                        sql = """Select i_stock from Inventory WHERE i_storeID = {} AND i_barcode = {}; """.format(storeID, barcode)
                        cur = conn.cursor()
                        cur.execute(sql)
    
                        rows = cur.fetchall()
                        stock = rows[0][0] - int(sold)
                        if stock == 0:
                            removeFromInventory(conn,storeID, barcode)
                        else:
                            setInventoryStock(conn,storeID, barcode, stock)

                    closeConnection(conn, database)
                elif selection == '7': 
                    print("Add Customer:")
                    store=input("Enter storeID: ")
                    customer=input("Enter customer ID: ")
                    conn = openConnection(database)
                    with conn:
                       addCustomer(conn, customer, store)

                      

                    closeConnection(conn, database)
                    
                    print("Enter ProductCustomer Data: y/n")         
                    selection=input("Enter Selection:") 
                    if selection == 'y':
                        barcode=input("Enter barcode of product: ")
                        conn = openConnection(database)
                        with conn:
                            addProductCustomer(conn, customer, barcode)

                        

                        closeConnection(conn, database)
                
                elif selection == '8': 
                    print("Store Inventory:")
                    storeID=input("Enter storeID to display inventory: ")
                    conn = openConnection(database)
                    with conn:
                        printInventory(conn, storeID)
                        print("Save to file? y/n\n")
                        selection=input("Enter Selection:") 

                        if selection == 'y':
                            saveInventory(conn, storeID)

                    closeConnection(conn, database)
                elif selection == '9': 
                    print("Store Product List:")
                    storeID=input("Enter storeID to display product list: ")
                    conn = openConnection(database)
                    with conn:
                        printProduct(conn, storeID)
                        print("Save to file? y/n\n")
                        selection=input("Enter Selection:") 

                        if selection == 'y':
                            saveProduct(conn, storeID)

                    closeConnection(conn, database)
                elif selection == '10': 
                    print("Store Customer List:")
                    storeID=input("Enter storeID to display customer list: ")
                    conn = openConnection(database)
                    with conn:
                        printCustomer(conn, storeID)
                        print("Save to file? y/n\n")
                        selection=input("Enter Selection:") 

                        if selection == 'y':
                            saveCustomer(conn, storeID)

                    closeConnection(conn, database)
                elif selection == '11': 
                    print("Store Suppliers:")
                    conn = openConnection(database)
                    with conn:
                        storeID = input("Enter storeID to display supplier list: ")
                        printSupplier(conn, storeID)
                        print("Save to file? y/n\n")
                        selection=input("Enter Selection:") 

                        if selection == 'y':
                            saveSupplier(conn, storeID)

                    closeConnection(conn, database)
                elif selection == '12': 
                    print("Stock At All Stores:")
                    conn = openConnection(database)
                    with conn:
                        checkAllStock(conn)
                        print("Save to file? y/n\n")
                        selection=input("Enter Selection:") 

                        if selection == 'y':
                            saveAllStock(conn)

                    closeConnection(conn, database)
                elif selection == '13': 
                    print("Returning to Main Menu...")
                    break
                else: 
                    print("Unknown Option Selected!")
        elif selection == '3': 
            print("Closing Application...")
            break
        else: 
            print("Unknown Option Selected!")



if __name__ == '__main__':
    main()




