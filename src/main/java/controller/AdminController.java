package controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import dto.Board;
import dto.User;
import exception.LoginException;
import logic.BeachService;

@Controller
@RequestMapping("admin")
public class AdminController {

   @Autowired
   private BeachService service;

   @GetMapping("*")
   public String all() {
      return null;
   }

   @GetMapping("main")
   public ModelAndView main(HttpSession session) {
      ModelAndView mav = new ModelAndView();
      return mav;
   }

   /* 유저 정보 조회 */
   @RequestMapping("userlist")
   public ModelAndView userlist(String col, String value, HttpSession session) {
      ModelAndView mav = new ModelAndView();
      List<User> userlist = service.getUserList(col,value);
      int usercount = service.getUserCount(null,null);
      int searchcount = service.getUserCount(col,value);
      mav.addObject("userlist", userlist);
      mav.addObject("searchcount", searchcount);
      mav.addObject("usercount", usercount);
      
      return mav;
   }
   /* 유저 회원 탈퇴 */
   @GetMapping("userdelete")
   public String userdelete(@RequestParam("id") String id) {
      try {
      service.deleteUser(id);
      }catch(Exception e) {
         e.printStackTrace();
         throw new LoginException("회원탈퇴 실패","userlist.do");
      }
      return "redirect:userlist.do";
   }
   /* 게시판 관리 */
   @RequestMapping("board")
   public ModelAndView boardMangement(Integer pageNum, String searchtype, String searchcontent, int btype) {
      ModelAndView mav = new ModelAndView(); 
      if(pageNum == null || pageNum.toString().equals("")) {
            pageNum=1;
         }
         if(searchtype == null || searchcontent == null || searchtype.trim().equals("") || searchcontent.trim().equals("")) {
            searchtype = null;
            searchcontent = null;
         }
         int limit = 10;   //한 페이지에 보여질 게시물의 건수
         //검색 조건에 맞도록 등록된 게시물 건수
         int listcount = service.boardcount(btype,searchtype,searchcontent); //등록 게시물
         //boardlist : 화면에 출력할 게시물 목록 (최대 10건)
         List<Board> boardlist = service.boardlist(btype,pageNum,limit,searchtype,searchcontent);
         for(Board b : boardlist) {
            int cnt = service.commentcount(b.getSeq());
            b.setCommcnt(cnt);
         }
         //최대 필요한페이지 수
         int maxpage = (int)((double)listcount/limit + 0.95);
         //화면에 표시 할 페이지의 시작 번호
         int startpage = (int)((pageNum/10.0 + 0.9) - 1) * 10 + 1;
         int endpage = startpage + 9;
         if(endpage > maxpage)
            endpage = maxpage;
         int boardno = listcount - (pageNum - 1) * limit +1;   //화면에 표시될 게시물 번호. 의미 없음x   
         mav.addObject("btype",btype);
         mav.addObject("pageNum",pageNum);
         mav.addObject("boardno",boardno);
         mav.addObject("maxpage",maxpage);
         mav.addObject("startpage",startpage);
         mav.addObject("endpage",endpage);
         mav.addObject("listcount",listcount);
         mav.addObject("boardlist",boardlist);
         mav.addObject("today", new SimpleDateFormat("yyyyMMdd").format(new Date()));
         return mav;
   }
   
}
