// STEP: Import required packages
import java.sql.*;
import java.io.FileWriter;
import java.io.FileReader;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.io.File;
import java.util.ArrayList;
import java.util.Scanner;

public class BarcodeDatabase {
    private Connection c = null;
    private String dbName;
    private boolean isConnected = false;
    private Statement stmt = null;

    public static void userInterface(){
        //user type selection
        int inter = 0;
        int uid = 0;
        int input = 0;
        while(inter == 0){
            //user type selection
            Scanner myObj = new Scanner(System.in);  // Create a Scanner object
            System.out.println("Barcode Inventory System v1.0");
            System.out.println("Enter user type:");
            System.out.println("1 - Manager");
            System.out.println("2 - Clerk");
            uid = myObj.nextInt(); 
            //get user input
            //cehck manager or clerk
            if(uid == 1){
                //manager menu
                //add product
                //change price
                //lookup item
            }
            else if(uid == 2){
                //clerk menu
                //Check inventory
                //Check price
                //add to inventory
                //remove from inventory    
                if (input == 0){
                    inter = 1;
                    System.out.println("Closing Application...");
                }
            }
        }
        
            
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
           stmt = c.createStatement();
           String sql = "CREATE TABLE IF NOT EXISTS Inventory " +
                          "(i_storeID VARCHAR(30) not NULL," +
                          " i_barcode  INT(15,0) not NULL," + 
                          "i_stock  INT(15,0) not NULL) "; 
           stmt.executeUpdate(sql);
           sql =  "CREATE TABLE IF NOT EXISTS Producer(" +
                          "pr_name VARCHAR(25) not NULL," +
                          "pr_type VARCHAR(25) not NULL," + 
                          "pr_cityKey  INT(15,0) not NULL,"+
                          "pr_shippingRateKey  INT(15,0) not NULL)"; 


           stmt.executeUpdate(sql);
           sql =  "CREATE TABLE IF NOT EXISTS Supplier(" +
                          "s_supplierID  VARCHAR(25) not NULL," +
                          " s_cityKey      INT(15,0) not NULL," + 
                          "s_shippingRateKey  INT(15,0) not NULL)"; 
                         

           stmt.executeUpdate(sql);
           sql =  " CREATE TABLE IF NOT EXISTS Product(" +
                          "p_barcode  INT(15,0) not NULL," +
                          "p_supplierID  VARCHAR(25) not NULL," + 
                          "p_type   VARCHAR(25) not NULL,"+
                          "p_price    DECIMAL(15,0) not NULL)"; 
                        
           stmt.executeUpdate(sql);
           sql =  "CREATE TABLE IF NOT EXISTS Customer(" +
                        "cu_customerID  VARCHAR(30) not NULL," +
                        "cu_storeID  VARCHAR(30) not NULL," + 
                        "cu_barcode  INT(15,0) not NULL)"; 
                         

           stmt.executeUpdate(sql);

           sql =  "CREATE TABLE IF NOT EXISTS City(" +
                        "ci_cityKey   INT(15,0) not NULL," +
                        "ci_countryKey   INT(15,0) not NULL," + 
                        "ci_name   VARCHAR(25) not NULL)"; 
                         

           stmt.executeUpdate(sql);
           sql =  "CREATE TABLE IF NOT EXISTS Country(" +
                        "c_countryKey  INT(15,0) not NULL," +
                        "c_name    VARCHAR(25) not NULL," + 
                        "c_shippingRate  DECIMAL(10,0) not NULL)"; 
                         

           stmt.executeUpdate(sql);
           sql =  "CREATE TABLE IF NOT EXISTS City(" +
           "ci_cityKey   INT(15,0) not NULL," +
           "ci_countryKey   INT(15,0) not NULL," + 
           "ci_name   VARCHAR(25) not NULL)"; 
            

            stmt.executeUpdate(sql);
            sql =  "CREATE TABLE IF NOT EXISTS ProductCustomer(" +
                    "pc_custID      VARCHAR(30) not NULL," +
                    "pc_barcode     INT(15,0) not NULL)"; 
                        

            stmt.executeUpdate(sql);
            sql =  "CREATE TABLE IF NOT EXISTS StoreSupp(" +
                    "stu_storeID      VARCHAR(25) not NULL," +
                    "stu_suppID    VARCHAR(25) not NULL)"; 
                        

            stmt.executeUpdate(sql);
                
           stmt.close();
           c.commit();
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


        
        try {
           
            stmt = c.createStatement();
        





            String sql_ = "INSERT INTO Inventory Values ('Store#001',10000002,3);";
            stmt.executeUpdate(sql_);
            
            sql_ = "INSERT INTO Inventory Values ('Store#001',10100001,7);";
            stmt.executeUpdate(sql_);
            sql_ = "INSERT INTO Inventory Values ('Store#001',11140001,65);";
            stmt.executeUpdate(sql_);
            sql_ = "INSERT INTO Inventory Values ('Store#001',10060001,11);";
            stmt.executeUpdate(sql_);
            sql_ = "INSERT INTO Inventory Values ('Store#001',10100801,12);";
            stmt.executeUpdate(sql_);
            sql_ = "INSERT INTO Inventory Values ('Store#001',10000901,18);";
            stmt.executeUpdate(sql_);
            sql_ = "INSERT INTO Inventory Values ('Store#001',11140201,1);";
            stmt.executeUpdate(sql_);
            sql_ = "INSERT INTO Inventory Values ('Store#002',10000001,5);";
            stmt.executeUpdate(sql_);
            sql_ = "INSERT INTO Inventory Values ('Store#002',10000002,1);";
            stmt.executeUpdate(sql_);
            sql_ = "INSERT INTO Inventory Values ('Store#003',10100001,7);";
            stmt.executeUpdate(sql_);
            sql_ = "INSERT INTO Inventory Values ('Store#003',10000001,23);";
            stmt.executeUpdate(sql_);
            sql_ = "INSERT INTO Inventory Values ('Store#003',11140001,65);";
            stmt.executeUpdate(sql_);
            sql_ = "INSERT INTO Inventory Values ('Store#004',10060001,11);";
            stmt.executeUpdate(sql_);
            sql_ = "INSERT INTO Inventory Values ('Store#004',10007002,1);";
            stmt.executeUpdate(sql_);
            sql_ = "INSERT INTO Inventory Values ('Store#004',10100801,12);";
            stmt.executeUpdate(sql_);
            sql_ = "INSERT INTO Inventory Values ('Store#005',10000901,18);";
            stmt.executeUpdate(sql_);
            sql_ = "INSERT INTO Inventory Values ('Store#005',11140201,1);";
            stmt.executeUpdate(sql_);
            sql_ = "INSERT INTO Inventory Values ('Store#005',10000001,35);";
            stmt.executeUpdate(sql_);
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
        //db.dropTables();
        db.createTables();
        //db.populateTables();

        userInterface();

        db.closeConnection();
    }


	public @interface java {
	}
}
