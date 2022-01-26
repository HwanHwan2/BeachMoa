package controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Random;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dto.AdminMail;
import dto.Board;
import dto.Comment;
import dto.Review;
import dto.User;
import exception.CommonException;
import exception.LoginException;
import logic.BeachService;
import logic.CipherUtil;

@Controller
@RequestMapping("user")
public class UserController {

   @Autowired
   private BeachService service;

   @Autowired
   private CipherUtil cipher;

   @Autowired
   private AdminMail adminMail;

   // 네트워크 접속을 위한 인증 객체 (계정 아이디와 패스워드)
   private final class MyAuthenticator extends Authenticator {
      private String id;
      private String pw;

      public MyAuthenticator(String id, String pw) {
         this.id = id;
         this.pw = pw;
      }

      @Override
      protected PasswordAuthentication getPasswordAuthentication() {
         return new PasswordAuthentication(id, pw);
      }
   }

   /*
    * 모든페이지 매핑
    */
   @GetMapping("*")
   public String user(Model model) {
      model.addAttribute(new User());
      return null;
   }

    //메인 게시판      
    @RequestMapping("main")
    public ModelAndView list() {
       ModelAndView mav = new ModelAndView();
        int limit = 6;
        int listcount = service.boardcount();
        int listcount2 = service.boardcount2();
        List<Board> boardlist2 = service.boardlist(limit);
        List<Board> boardlist3 = service.boardlist2(limit);
        for(Board b : boardlist2) {
           int cnt = service.commentcount(b.getSeq());
            b.setCommcnt(cnt);
        } 
        mav.addObject("listcount",listcount);
        mav.addObject("boardlist2",boardlist2);
        mav.addObject("boardlist3",boardlist3);
        mav.addObject("today", new SimpleDateFormat("yyyyMMdd").format(new Date()));
         return mav;
        }   

   /* 마이 페이지 */
   @RequestMapping("mypage")
   public ModelAndView loginCheckmypage(Integer pageNum,String type,String tab, String subtab, HttpSession session) {
      ModelAndView mav = new ModelAndView();
      
      User user = (User) session.getAttribute("login"); //로그인 정보
      User dbuser = service.selectOne(user.getId());
      if (pageNum == null || pageNum.toString().equals("")) {
         pageNum = 1;
      }
      int limit = 10; // 한 페이지에 보여질 게시물의 건수
      /* 내가 작성한 게시글 */
      int listcount = service.getMyBoardCount(user.getId()); //등록 게시물
      List<Board> myboardlist = service.getMyBoardList(pageNum, limit, user.getId());
      int maxpage = (int) ((double) listcount / limit + 0.95);
      // 화면에 표시 할 페이지의 시작 번호
      int startpage = (int) ((pageNum / 10.0 + 0.9) - 1) * 10 + 1;
      int endpage = startpage + 9;
      if (endpage > maxpage)
         endpage = maxpage;
      /* 내가 작성한 댓글*/
      int commentcount = service.getMyCommentCount(user.getId()); // 댓글 개수
      List<Comment> mycommentlist = service.getMyCommentList(pageNum,limit,user.getId()); //- 댓글 리스트
      /* 내가 작성한 리뷰 */
      int reviewcount = service.getMyReviewCount(user.getId());
      List<Review> myreviewlist = service.getMyReviewList(pageNum,limit,user.getId()); //리뷰리스트
      mav.addObject("startpage",startpage);
       mav.addObject("maxpage",maxpage);
       mav.addObject("endpage",endpage);
       mav.addObject("user",dbuser);
       mav.addObject("reviewcount",reviewcount);
       mav.addObject("myreviewlist",myreviewlist);
       mav.addObject("commentcount",commentcount);
       mav.addObject("mycommentlist",mycommentlist);
       mav.addObject("listcount",listcount);
       mav.addObject("myboardlist", myboardlist);
      return mav;
   }

   @PostMapping("entry")
   public ModelAndView userEntry(@Valid User user, String auth_num, BindingResult bresult, HttpSession session) {
      ModelAndView mav = new ModelAndView();
      String generation = (String) session.getAttribute("AuthNum");
      if (bresult.hasErrors()) {
         mav.getModel().putAll(bresult.getModel());
         bresult.reject("error.input.user"); // 글로벌 오류
         return mav;
      }

      if (!auth_num.equals(generation)) {
         throw new LoginException("인증번호가 일치하지 않습니다.", "entry.do");
      }

      /*
       * .getYear() 메소드는 중요도가 떨어져서 앞으로 없어지게 될 가능성이 큼.
       * 
       * 권고메세지 없앰
       */
      @SuppressWarnings("deprecation")
      int year = new Date().getYear() + 1900; // 2021
      int agerange = (year - Integer.parseInt(user.getBirthyear()) + 1) / 10 * 10; // 연령대 구하기
      user.setAge_range(agerange);
      user.setLogintype("normal");
      System.out.println(user.toString()); // 회원 가입시 유저 정보 확인

      // 암호화 부분.
      try {
         // 비밀번호 해쉬값 20자리로 등록
         user.setPassword(cipher.makehash(user.getPassword()).substring(0, 20));
         service.entry(user);
      } catch (Exception e) {
         e.printStackTrace(); // 회원가입 실패
         throw new LoginException("회원가입 실패", "entry.do");
      }
      mav.setViewName("alert");
      mav.addObject("url", "login.do");
      mav.addObject("message", "회원가입되었습니다.");
      return mav;
   }

   // 아이디 찾기, 비밀번호 찾기

   @RequestMapping("{url}search")
   public ModelAndView search(@PathVariable String url, User user, String auth_num, HttpSession session) {
      String generation = (String) session.getAttribute("AuthNum");
      ModelAndView mav = new ModelAndView();

      System.out.println(
            "url=" + url + ", id=" + user.getId() + ", email=" + user.getEmail() + "name=" + user.getName());
      // 비밀번호 찾기.
      if (url.equals("pw")) {
         mav.addObject("message", "이메일로 전송된 임시비밀번호로 로그인해주시기 바랍니다.");
         mav.addObject("url", "login.do");
         mav.setViewName("alert");
         // 임시 비밀번호 생성.
         try {
            String temNum = AuthNum();
            String temPw = cipher.makehash(temNum).substring(0, 20);
            session.setAttribute("temPw", temNum);
            mailSend(user.getEmail(), "pwsearch", session);
            service.pwChange(user.getId(), temPw);
         } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
         }
      }
      if (url.equals("id")) {
         if (!auth_num.equals(generation)) {
            throw new LoginException("인증번호가 일치하지 않습니다.", "login.do");
         }
         List<User> searchIdList = service.searchidlist(user);
         mav.addObject("list", searchIdList);
         mav.setViewName("user/idInquiry");
      }
      return mav;
   }

   // 비밀번호 변경
   @PostMapping("changepass")
   public ModelAndView changepass(@RequestParam Map<String, String> param, HttpSession session) {
      ModelAndView mav = new ModelAndView();
      User login = (User) session.getAttribute("login");
      try {
         String hashPassword = cipher.makehash(param.get("new_pw")).substring(0, 20);
         service.setPassword(login.getId(), hashPassword);
         mav.addObject("message", login.getNickname() + "님 비밀번호가 변경되었습니다.");
         mav.addObject("url", "mypage.do");
         mav.setViewName("alert");
      } catch (Exception e) {
         e.printStackTrace();
      }
      return mav;
   }
   
   /* 회원정보 수정(별명) */
   @PostMapping("update")
   public ModelAndView changenick(String nickname, HttpSession session) {
      ModelAndView mav = new ModelAndView();
      User login = (User) session.getAttribute("login");
      try {
         service.setUserNickname(login.getId(),nickname);
      }catch(Exception e) {
         e.printStackTrace();
         throw new CommonException("닉네임이 변경 실패.","mypage.do");
      }
      mav.setViewName("alert");
      mav.addObject("url", "mypage.do");
      mav.addObject("message", "닉네임이 변경되었습니다.");
      return mav;
   }
   
   /* 내 게시물 삭제*/
   @PostMapping("boarddelete")
   public ModelAndView boarddelete(String [] boardchk,HttpSession session) {
      ModelAndView mav = new ModelAndView();
      try {
         service.deleteMyBoard(boardchk);
      }catch(Exception e) {
         e.printStackTrace();
         throw new CommonException("게시물 삭제 오류","mypage.do");
      }
      
      mav.setViewName("alert");
      mav.addObject("url", "mypage.do");
      mav.addObject("message", "게시물이 삭제되었습니다.");
      return mav;
   }
   
   /* 내 댓글 삭제*/
   @PostMapping("commentdelete")
   public ModelAndView commentdelete(String [] commentchk,HttpSession session) {
      ModelAndView mav = new ModelAndView();
      try {
         service.deleteMyComment(commentchk);
      }catch(Exception e) {
         e.printStackTrace();
         throw new CommonException("댓글 삭제 오류","mypage.do");
      }
      mav.setViewName("alert");
      mav.addObject("url", "mypage.do");
      mav.addObject("message", "댓글이 삭제되었습니다.");
      return mav;
   }
   /* 내 리뷰 삭제*/
   @PostMapping("reviewdelete")
   public ModelAndView reviewdelete(String [] reviewchk,HttpSession session) {
      ModelAndView mav = new ModelAndView();
      try {
         service.deleteMyReview(reviewchk);
      }catch(Exception e) {
         e.printStackTrace();
         throw new CommonException("리뷰 삭제 오류","mypage.do");
      }
      mav.setViewName("alert");
      mav.addObject("url", "mypage.do");
      mav.addObject("message", "리뷰가 삭제되었습니다.");
      return mav;
   }
   
   // 회원가입 이메일 인증 전송
   @GetMapping("/mailAuth")
   @ResponseBody
   public String joinEmailAuth(@RequestParam("email") String email, HttpSession session) {
      System.out.println("========UserController입니다.=======");
      System.out.println("전송할 이메일 주소:" + email);
      mailSend(email, "emailAuth", session);
      return "";
   }

   // 아이디 찾기 이메일 인증 전송
   @GetMapping("/idemailAuth")
   @ResponseBody
   public String idEmailAuth(@RequestParam("email") String email, HttpSession session) {
      System.out.println("========UserController입니다.=======");
      System.out.println("전송할 이메일 주소:" + email);
      mailSend(email, "idsearch", session);
      return "";
   }

   // 메일 전송
   private void mailSend(String email, String type, HttpSession session) {
      System.out.println("=====MailSend실행=====");
      // Properties 클래스 : Map 구현 클래스. 키와 value의 자료형 String형
      Properties prop = new Properties();
      try {
         // mail.properties 파일의 절대 경로로 파일을 읽기 위한 입력스트림
         FileInputStream fis = new FileInputStream(adminMail.getPath() + "/src/main/resources/mail.properties"); // 본인
                                                                                       // properties위치설정
         prop.load(fis);// mail.properties의 내용을 prop객체로 저장
      } catch (IOException e) {
         e.printStackTrace();
      }

      String AuthNum = AuthNum();
      System.out.println("인증번호:" + AuthNum);
      session.setAttribute("AuthNum", AuthNum);
      MyAuthenticator auth = new MyAuthenticator(adminMail.getId(), adminMail.getPw()); // 인증 객체

      Session mSession = Session.getInstance(prop, auth); // session : 메일서버 연결

      MimeMessage message = new MimeMessage(mSession); // mimeMsg : 메일 전송 객체
      try {
         message.setFrom(new InternetAddress(auth.id)); // 보내는 주소 설정
         // 받는 사람 정보
         InternetAddress recipient = new InternetAddress((new String(email.getBytes("utf-8"), "8859_1")));

         // 전송일자 설정
         message.setSentDate(new Date());
         // 수신메일 설정
         message.setRecipient(Message.RecipientType.TO, recipient);
         // 제목 설정, 내용부분
         if (type.equals("emailAuth")) {
            message.setSubject("BeachMoa입니다. 이메일 인증 부탁드립니다.");
            message.setContent("BeachMoa 회원 가입을 위한 인증번호를 입력해주세요 <br> 인증번호:" + AuthNum, "text/html; charset=utf-8");
         } else if (type.equals("pwsearch")) {
            String temPw = (String) session.getAttribute("temPw");
            System.out.println("인증 임시번호" + temPw);
            message.setSubject("BeachMoa 임시 비밀번호 입니다.");
            message.setContent("임시비밀번호로 로그인하시고 비밀번호 변경을 해주시기 바랍니다. <br> 임시비밀번호:" + temPw,
                  "text/html; charset=utf-8");
         } else if (type.equals("idsearch")) {
            message.setSubject("BeachMoa입니다. 이메일 인증 부탁드립니다.");
            message.setContent("아이디 찾기를 위한 인증번호를 입력해주세요 <br> 인증번호:" + AuthNum, "text/html; charset=utf-8");
         }

         Transport.send(message); // 메일전송
      } catch (MessagingException me) {
         System.out.println("메일 전송 실패");
         me.printStackTrace();
      } catch (UnsupportedEncodingException e) {
         e.printStackTrace();
      }
   }

   // 인증번호 생성
   private String AuthNum() {
      Random ran = new Random();

      StringBuffer sb = new StringBuffer();
      for (int i = 0; i < 8; i++) {
         // 랜덤 논리
         boolean ranbol = ran.nextBoolean();
         if (ranbol) {
            sb.append((int) (ran.nextInt(9)) + 1);
         } else {
            sb.append((char) ((int) (ran.nextInt(26)) + 65));
         }
      }
      System.out.println("인증번호 8자리:" + sb.toString());
      return sb.toString();
   }

   /* 회원 비밀번호 변경 */

   // ajax 아이디 중복체크
   @RequestMapping(value = "/idCheck", method = RequestMethod.GET)
   @ResponseBody
   public int idCheck(@RequestParam("id") String id) {
      String col = "id";
      // System.out.println(id); //아이디 확인
      return service.checkOne(col, id);
   }

   // ajax 닉네임 중복체크
   @RequestMapping(value = "/nickCheck", method = RequestMethod.GET)
   @ResponseBody
   public int nickCheck(@RequestParam("nickname") String nickname) {
      String col = "nickname";
      // System.out.println(nickname); 닉네임 확인
      return service.checkOne(col, nickname);
   }

   // ajax id와 email에 해당 하는 계정 있는지 확인
   @RequestMapping(value = "/emailCheck", method = RequestMethod.GET)
   @ResponseBody
   public int emailCheck(@RequestParam("id") String id, @RequestParam("email") String email) {
      // System.out.println("id="+id+", email="+email);
      return service.checkEmail("id", id, email); // 칼럼명, 칼럼값, 이메일값
   }

   // ajax nameㄱ과 email에 해당 하는 계정 있는지 확인
   @RequestMapping(value = "/emailCheck2", method = RequestMethod.GET)
   @ResponseBody
   public int emailCheck2(@RequestParam("name") String name, @RequestParam("email") String email) {
      // System.out.println("name="+name+", email="+email);
      return service.checkEmail("name", name, email); // 칼럼명, 칼럼값, 이메일값
   }

   // ajax 비밀번호 유효성 확인
   @RequestMapping(value = "/passCheck", method = RequestMethod.GET)
   @ResponseBody
   public int passCheck(@RequestParam("id") String id, @RequestParam("nowpswd") String password) {
      String hashpswd;
      int result = 0;
      try {
         hashpswd = cipher.makehash(password).substring(0, 20);
         result = service.checkPassword(id, hashpswd);
      } catch (NoSuchAlgorithmException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      }
      return result;
   }

}