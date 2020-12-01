// STEP: Import required packages
import java.sql.*;
import java.io.FileWriter;
import java.io.FileReader;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.io.File;
import java.util.ArrayList;

public class BarcodeDatabase {
    private Connection c = null;
    private String dbName;
    private boolean isConnected = false;
    private Statement stmt = null;
    private Statement stmt2 = null;
    private Statement stmt3 = null;

    public static void userInterface(){
        //user type selection
        //manager menu
            //add product
            //change price
            //lookup item


        //clerk menu
            //Check inventory
            //Check price
            //add to inventory
            //remove from inventory
            
    }
    public static void createNewDatabase(String location, String fileName) {

        String url = "jdbc:sqlite:"+ location + fileName;

        try (Connection conn = DriverManager.getConnection(url)) {
            if (conn != null) {
                DatabaseMetaData meta = conn.getMetaData();
                System.out.println("The driver name is " + meta.getDriverName());
                System.out.println("A new database has been created.");
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    private void openConnection(String _dbName) {
        dbName = _dbName;

        if (false == isConnected) {
            System.out.println("++++++++++++++++++++++++++++++++++");
            System.out.println("Open database: " + _dbName);

            try {
                String connStr = new String("jdbc:sqlite:");
                connStr = connStr + _dbName;

                // STEP: Register JDBC driver
                Class.forName("org.sqlite.JDBC");

                // STEP: Open a connection
                c = DriverManager.getConnection(connStr);

                // STEP: Diable auto transactions
                c.setAutoCommit(false);

                isConnected = true;
                System.out.println("success");
            } catch (Exception e) {
                System.err.println(e.getClass().getName() + ": " + e.getMessage());
                System.exit(0);
            }

            System.out.println("++++++++++++++++++++++++++++++++++");
        }
    }

    private void closeConnection() {
        if (true == isConnected) {
            System.out.println("++++++++++++++++++++++++++++++++++");
            System.out.println("Close database: " + dbName);

            try {
                // STEP: Close connection
                c.close();

                isConnected = false;
                dbName = "";
                System.out.println("success");
            } catch (Exception e) {
                System.err.println(e.getClass().getName() + ": " + e.getMessage());
                System.exit(0);
            }

            System.out.println("++++++++++++++++++++++++++++++++++");
        }
    }

    private void createTables() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Create table");
        try {
            /*
 CREATE TABLE IF NOT EXISTS Inventory(i_storeID    VARCHAR(30) not NULL,i_barcode  INT(15,0) not NULL,i_stock  INT(15,0) not NULL);

CREATE TABLE IF NOT EXISTS Producer(
 pr_name VARCHAR(25) not NULL,
 pr_type VARCHAR(25) not NULL,
 pr_cityKey  INT(15,0) not NULL,   
 pr_shippingRateKey  INT(15,0) not NULL
);


CREATE TABLE IF NOT EXISTS Supplier(
 s_supplierID  VARCHAR(25) not NULL,
 s_cityKey      INT(15,0) not NULL,
 s_shippingRateKey  INT(15,0) not NULL
);

CREATE TABLE IF NOT EXISTS Product(
 p_barcode  INT(15,0) not NULL,
 p_supplierID  VARCHAR(25) not NULL,
 p_type   VARCHAR(25) not NULL,
 p_price    DECIMAL(15,0) not NULL
);

CREATE TABLE IF NOT EXISTS Customer(
 cu_customerID  VARCHAR(30) not NULL,
 cu_storeID  VARCHAR(30) not NULL,
 cu_barcode  INT(15,0) not NULL
);

CREATE TABLE IF NOT EXISTS Store(
 st_storeID  VARCHAR(25) not NULL,
 st_cityKey  INT(15,0) not NULL,
 st_type   VARCHAR(25) not NULL
);


CREATE TABLE IF NOT EXISTS Country(
 c_countryKey  INT(15,0) not NULL,
 c_name    VARCHAR(25) not NULL
 c_shippingRate  DECIMAL(10,0) not NULL
);

CREATE TABLE IF NOT EXISTS City(
 ci_cityKey   INT(15,0) not NULL,
 ci_countryKey   INT(15,0) not NULL,
 ci_name   VARCHAR(25) not NULL
);

CREATE TABLE IF NOT EXISTS StoreSupp(
 stu_storeID VARCHAR(25) not NULL,
 stu_suppID  VARCHAR(25) not NULL
);

CREATE TABLE IF NOT EXISTS ProductCustomer(
 pc_custID      VARCHAR(30) not NULL,
 pc_barcode     INT(15,0) not NULL
);
            */
           stmt = c.createStatement();
           String sql = " CREATE TABLE IF NOT EXISTS Inventory(i_storeID VARCHAR(30) not NULL,i_barcode  INT(15,0) not NULL,i_stock  INT(15,0) not NULL);"; 
           stmt.executeUpdate(sql);
           stmt.close();
        } catch ( Exception e ) {
           System.err.println( e.getClass().getName() + ": " + e.getMessage() );
           System.exit(0);
        }
        System.out.println("Table created successfully");
        System.out.println("++++++++++++++++++++++++++++++++++");
    }


   
    private void populateTables() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Populate table");
        int id = 1;
        int s_suppkey = 0;
        String s_name = " ";
        String n_name = " ";
        int n_nationkey = 0;
        int capacity = 0;
        String sql = "";
        try {
            ArrayList<String> temp = new ArrayList<String>();
            stmt = c.createStatement();
            stmt2 = c.createStatement();
            stmt3 = c.createStatement();
            /*
            The nations where these warehouses are located are
            those that have the largest number of lineitems supplied by the supplier that are ordered by customers
            from that nation. In case of equality, the nations are sorted in alphabetical order and the rst two
            are selected.
            */
            ResultSet rs = stmt.executeQuery( "SELECT s_suppkey, s_name, n_name, n_nationkey, max FROM  (SELECT MAX(count) AS max, n_name as name2, s_suppkey as skey, n_nationkey as nkey FROM nation,(SELECT DISTINCT SUM(l_quantity) AS count, s_nationkey, s_suppkey FROM orders, supplier, lineitem, customer WHERE  o_custkey = c_custkey AND l_suppkey = s_suppkey AND o_orderkey = l_orderkey AND c_nationkey = s_nationkey  GROUP BY s_suppkey) WHERE n_nationkey = s_nationkey),supplier, nation  WHERE  n_name = name2 AND s_suppkey = skey AND s_nationkey = n_nationkey GROUP BY n_nationkey;");
            ResultSet ps = stmt2.executeQuery( "SELECT MAX(sum) AS s FROM (SELECT SUM(p_size) AS sum FROM supplier, customer, nation, lineitem, part, orders WHERE c_custkey = o_custkey AND l_suppkey = s_suppkey AND l_partkey = p_partkey AND o_orderkey = l_orderkey AND c_nationkey = n_nationkey GROUP BY n_nationkey);");
            ResultSet max = stmt3.executeQuery("SELECT MAX(count) AS max, n_name, s_suppkey n_nationkey FROM nation,(SELECT DISTINCT SUM(l_quantity) AS count, s_nationkey, s_suppkey FROM orders, supplier, lineitem, customer WHERE o_custkey = c_custkey AND l_suppkey = s_suppkey AND o_orderkey = l_orderkey AND c_nationkey = s_nationkey  GROUP BY s_suppkey) WHERE n_nationkey = s_nationkey;");
           
           
            
            while (rs.next() ) {
                s_suppkey = rs.getInt("s_suppkey");
                s_name = rs.getString("s_name");
                n_name = rs.getString("n_name");
               n_nationkey = rs.getInt("n_nationkey");
               /*
               while(max.next()){
                    capacity = max.getInt("max");
                    n_name = max.getString("n_name");
                    n_nationkey = max.getInt("n_nationkey");
                    System.out.println(n_name + " " + n_nationkey + " " + capacity); 
                
                }
                */
                s_name = "'" + s_name + "___" + n_name +"'";
                /*

                In order to determine the capacity of a
                warehouse, you have to compute the total size of the parts (p size) supplied by the supplier to the
                customers in a nation. Then, the warehouse capacity is taken as the double of the maximum total part
                size across all the nations. The two warehouses owned by a supplier have the same capacity.
                */
                //Compute total size of parts supplied by the supplier to the customers in a nation
                
                while (ps.next()){
                    capacity = ps.getInt("s");
                    System.out.println(capacity); 
                }
                sql = "INSERT INTO warehouse (w_warehousekey,w_name,w_capacity,w_suppkey,w_nationkey) " +
                "VALUES ( "+ id++ +", "+s_name+", "+capacity+", "+s_suppkey+", "+n_nationkey+" );";
                temp.add(sql);
                sql = "INSERT INTO warehouse (w_warehousekey,w_name,w_capacity,w_suppkey,w_nationkey) " +
                "VALUES ( "+ id++ +", "+s_name+", "+capacity+", "+s_suppkey+", "+n_nationkey+" );";
                temp.add(sql);
                //System.out.println("s_name: " + s_name +"  "+ s_suppkey);                
            }

            for(int i = 0; i < temp.size(); i++){
                stmt.executeUpdate(temp.get(i));
            }
            rs.close();
            stmt.close();
            c.commit();
        } catch (SQLException  e ) {
            System.err.println( e.getClass().getName() + ": " + e.getMessage() );
            System.exit(0);
        }
        System.out.println("Records created successfully");
        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void dropTables() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Drop table");
      
      try {


         stmt = c.createStatement();
         String sql = "DELETE from warehouse;";
         stmt.executeUpdate(sql);
         c.commit();
         stmt.close();
      } catch ( Exception e ) {
         System.err.println( e.getClass().getName() + ": " + e.getMessage() );
         System.exit(0);
      }
      System.out.println("Operation done successfully");
   
        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void Q1() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Q1");

        try {
            FileWriter writer = new FileWriter("output/1.out", false);
            PrintWriter printer = new PrintWriter(writer);
            int w_warehousekey = 0;
            int w_capacity = 0;
            String w_name = " ";
            int w_suppkey = 0;
            int w_nationkey = 0;
            printer.printf("%10s %-40s %10s %10s %10s\n", "wId", "wName", "wCap", "sId", "nId");
            stmt = c.createStatement();
            ResultSet rs = stmt.executeQuery( "SELECT w_warehousekey, w_name, w_capacity, w_suppkey, w_nationkey FROM warehouse;");
            while(rs.next()){
                w_warehousekey = rs.getInt("w_warehousekey");
                w_name = rs.getString("w_name");
                w_capacity = rs.getInt("w_capacity");
                w_suppkey = rs.getInt("w_suppkey");
                w_nationkey = rs.getInt("w_nationkey");
                printer.printf("%10s %-40s %10s %10s %10s\n", w_warehousekey, w_name, w_capacity, w_suppkey, w_nationkey);
                //System.out.println(w_warehousekey + w_name + w_capacity + w_suppkey + w_nationkey);
            }
            printer.close();
            writer.close();
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void Q2() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Q2");

        try {
            FileWriter writer = new FileWriter("output/2.out", false);
            PrintWriter printer = new PrintWriter(writer);

            printer.printf("%-40s %10s %10s\n", "nation", "numW", "totCap");

            printer.close();
            writer.close();
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void Q3() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Q3");

        try {
            File fn = new File("input/3.in");
            FileReader reader = new FileReader(fn);
            BufferedReader in = new BufferedReader(reader);
            String nation = in.readLine();
            in.close();

            FileWriter writer = new FileWriter("output/3.out", false);
            PrintWriter printer = new PrintWriter(writer);

            printer.printf("%-20s %-20s %-40s\n", "supplier", "nation", "warehouse");

            printer.close();
            writer.close();
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void Q4() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Q4");

        try {
            File fn = new File("input/4.in");
            FileReader reader = new FileReader(fn);
            BufferedReader in = new BufferedReader(reader);
            String region = in.readLine();
            int cap = Integer.parseInt(in.readLine());
            in.close();

            FileWriter writer = new FileWriter("output/4.out", false);
            PrintWriter printer = new PrintWriter(writer);

            printer.printf("%-40s %10s\n", "warehouse", "capacity");

            printer.close();
            writer.close();
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void Q5() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Q5");

        try {
            File fn = new File("input/5.in");
            FileReader reader = new FileReader(fn);
            BufferedReader in = new BufferedReader(reader);
            String nation = in.readLine();
            in.close();

            FileWriter writer = new FileWriter("output/5.out", false);
            PrintWriter printer = new PrintWriter(writer);

            printer.printf("%-20s %20s\n", "region", "capacity");

            printer.close();
            writer.close();
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }


    public static void main(String args[]) {
        BarcodeDatabase db = new BarcodeDatabase();
        //createNewDatabase("C:/Users/plugu/Documents/Main/CSE111/Project/","inventory.db");
        
        db.openConnection("data/inventory.sqlite");
        db.dropTables();
        db.createTables();
        db.populateTables();

        userInterface();

        db.closeConnection();
    }


	public @interface java {
	}
}
