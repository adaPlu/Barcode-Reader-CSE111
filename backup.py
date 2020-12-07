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
    database = r"Backup.sqlite"

    # create a database connection
    conn = openConnection(database)
    with conn:
      
        print('Tables Available: \n City\n Country\n Customer\n Inventory\n Store\n Supplier\n Producer\n Product\n ProductCustomer\n StoreSupp\n' )
        input = raw_input("Enter table to display: ")

        # printTable2(conn,input)
        #printTable3(conn,input)
        # print "you entered ", input
        if input == 'City':
            printTable(conn,input)
        elif input == 'Country':
            printTable(conn,input)
        elif input == 'Customer':
            printTable(conn,input)    
        elif input == 'Inventory':
            printTable(conn,input) 
        elif input == 'Store':
            printTable(conn,input) 
        elif input == 'Supplier':
            printTable(conn,input) 
        
        elif input == 'Producer':
            printTable2(conn,input)
        elif input == 'Product':
            printTable2(conn,input)   

        elif input == 'ProductCustomer':
            printTable3(conn,input)
        elif input == 'StoreSupp':
            printTable3(conn,input)     

        # print('Should we delete to continue')
        input2 = raw_input("Enter the barcode of the product to delete: ")
        # print "you entered ", var
        # if input2 == '10000002':
        deleteProduct(conn,input2)   
      
    closeConnection(conn, database)


if __name__ == '__main__':
    main()