package me.bex.paynon.core.database;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import javax.sql.DataSource;

@Configuration
public class DatabaseConfig {

    @Value("${POSTGRES_JDBC_URL:}")
    private String url;

    @Value("${POSTGRES_USERNAME:root}")
    private String userName;

    @Bean
    public DataSource getDataSource() {
        DataSourceBuilder<?> dataSourceBuilder = DataSourceBuilder.create();
        dataSourceBuilder.driverClassName("org.postgresql.Driver");
        dataSourceBuilder.username(userName);
        dataSourceBuilder.url(url);
        dataSourceBuilder.password("");

        return dataSourceBuilder.build();
    }
}
