package dao.mapper;


import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import dto.User;

public interface UserMapper {
   @Insert("insert into member (id,logintype,name,nickname,password,gender,age_range,birthyear,email,join_date)"
         + " values (#{id},#{logintype},#{name},#{nickname},#{password}, #{gender}, #{age_range},#{birthyear}, #{email},date_format(now(),'%Y-%m-%d'))")
   void insert(User user);
   
   @Select({"<script>",
         "select * from member",
         "<if test='id != null'> where id=#{id}</if>",
         "<if test='col != null and value != null'> where ${col} like '%${value}%'</if>",
         "</script>"})
   List<User> select(Map<String, Object> param);
   
   @Insert("insert into member (id,logintype,name,nickname,password,gender,age_range,birthyear,email,join_date)"
         + " values (#{id},#{logintype},#{name},#{nickname},#{password}, #{gender}, #{age_range},#{birthyear},#{id},date_format(now(),'%Y-%m-%d'))")
   void insertkn(User user);
   
   //해당 id,nickname 있는지 유무 확인 없음 : 0 있음 : 1
   @Select({"<script>",
         "select count(*) from member",
         "<if test='col != null and val != null'>where ${col} = #{val}</if>",
         "</script>"})
   int selectcount(Map<String, Object> param);
   
   @Select("select count(*) from member where ${col}=#{val} and email=#{email}")
   int selectcount2(Map<String, Object> param);
   
   @Update("update member set password = #{password} where id=#{id}")
   void updatepass(Map<String, Object> param);
   
   @Select({"<script>",
         "select * from member where name=#{name} and email=#{email}"
         +"</script>"})
   List<User> selectIdList(User user);
   
   @Select({"<script>",
      "select count(*) from member",
      "<if test='col != null and val != null'>where ${col} like '%${val}%' </if>",
      "</script>"})
   int selectsearch(Map<String, Object> param);
   
   @Select("select count(*) from member where id=#{id} and password=#{password}")
   int selectCheck(Map<String, Object> param);
   
   @Delete("delete from member where id=#{value}")
   void deleteOne(String id);
   
   @Update("update member set nickname=#{nickname} where id=#{id} ")
   void updatenickname(Map<String, Object> param);

   

}