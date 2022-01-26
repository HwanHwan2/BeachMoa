package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.UserMapper;
import dto.User;

@Repository
public class UserDao {
   @Autowired
   private SqlSessionTemplate template;
   private Map<String, Object> param = new HashMap<String, Object>();
   

   public void addUser(User user) {
      param.clear();
      template.getMapper(UserMapper.class).insert(user);
   }

   public User getUser(String id) {
      param.clear();
      param.put("id", id);
      return template.getMapper(UserMapper.class).select(param).get(0);
   }

   public void addSnsUser(User user) {
      param.clear();
      template.getMapper(UserMapper.class).insertkn(user);
   }

   /*
    *  id email 검색기능   
    *    
    */
   public int getUserCount(String col, String val) {
      int result;
      param.clear();
      if(col==null || col.equals("")) {
         result = template.getMapper(UserMapper.class).selectcount(param);
      }else if(col.equals("name") || col.equals("id")){
         param.put("col", col);
         param.put("val", val);
         result = template.getMapper(UserMapper.class).selectcount(param);
      }else {
         param.put("col",col);
         param.put("val",val);
         result = template.getMapper(UserMapper.class).selectsearch(param);
      }
      return result;
   }
   
   public int getUserSearch(String col,String val, String email) {
      param.clear();
      param.put("col", col);
      param.put("val", val);
      param.put("email", email);
      return template.getMapper(UserMapper.class).selectcount2(param);
   }

   public void setPassword(String id, String temPw) {
      param.clear();
      param.put("id", id);
      param.put("password", temPw);
      template.getMapper(UserMapper.class).updatepass(param);
   }

   public List<User> getIdSearch(User user) {   
      return template.getMapper(UserMapper.class).selectIdList(user);
   }

   public List<User> getUserList() {
      return template.getMapper(UserMapper.class).select(param);
   }

   public List<User> getUserSearch(String col, String value) {
      param.clear();
      List<User> userlist;
      if(col==null || col.equals("")) {
         userlist = template.getMapper(UserMapper.class).select(param);
      }else {
         param.put("col", col);
         param.put("value", value);
         userlist = template.getMapper(UserMapper.class).select(param);
      }
      return userlist;
   }

   public int getPassCheck(String id, String hashpswd) {
      param.clear();
      param.put("id", id);
      param.put("password", hashpswd);
      return template.getMapper(UserMapper.class).selectCheck(param);
   }

   public void deleteUser(String id) {
      template.getMapper(UserMapper.class).deleteOne(id);
   }

   public void setUserNickname(String id, String nickname) {
      param.clear();
      param.put("id", id);
      param.put("nickname", nickname);      
      template.getMapper(UserMapper.class).updatenickname(param);
   }
}