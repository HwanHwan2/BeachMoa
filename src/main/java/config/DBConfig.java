package config;

import java.beans.PropertyVetoException;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;

import com.mchange.v2.c3p0.ComboPooledDataSource;

@Configuration
public class DBConfig {
	@Bean(destroyMethod = "close")
	public DataSource dataSource() {
		ComboPooledDataSource ds = new ComboPooledDataSource();	//커넥션 풀 객체
		try {
			ds.setDriverClass("org.mariadb.jdbc.Driver");
			ds.setJdbcUrl("jdbc:mariadb://localhost:3306/beachdb");
			ds.setUser("root");
			ds.setPassword("c852323a");
			ds.setMaxPoolSize(20);	//최대 커넥션 객체의 갯수
			ds.setMinPoolSize(3);	//최소 커넥션 객체의 갯수
			ds.setInitialPoolSize(5);	//초기 생성되는 커넥션 객체의 갯수 지정
		} catch (PropertyVetoException e) {
			e.printStackTrace();
		}
		return ds;
	}
	//마이바티스 설정
	@Bean
	public SqlSessionFactory sqlSessionFactory() throws Exception {
		SqlSessionFactoryBean bean = new SqlSessionFactoryBean();
		bean.setDataSource(dataSource());
		bean.setConfigLocation(new ClassPathResource("mybatis-config.xml"));
		return bean.getObject();
	}
	@Bean
	public SqlSessionTemplate sqlSessionTemplate() throws Exception{
		return new SqlSessionTemplate(sqlSessionFactory());
	}
}
