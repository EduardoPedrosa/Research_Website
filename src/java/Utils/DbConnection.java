package Utils;

import java.beans.PropertyVetoException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import org.apache.commons.dbcp2.BasicDataSource;


public class DbConnection {

    private static DbConnection datasource;
    private BasicDataSource ds;

    private DbConnection() throws IOException, SQLException, PropertyVetoException {
        ds = new BasicDataSource();
        ds.setDriverClassName("com.mysql.jdbc.Driver");
        ds.setUsername("root");
        ds.setPassword("eduardoigorjoao");
        ds.setUrl("jdbc:mysql://localhost:3306/progweb?useSSL=false");
        ds.setMinIdle(5);
        ds.setMaxIdle(20);
        ds.setMaxOpenPreparedStatements(180);
    }

    public static DbConnection getInstance() throws IOException, SQLException, PropertyVetoException {
        if (datasource == null) {
            datasource = new DbConnection();
            return datasource;
        } else {
            return datasource;
        }
    }

    public Connection getConnection() throws SQLException {
        return this.ds.getConnection();
    }
}