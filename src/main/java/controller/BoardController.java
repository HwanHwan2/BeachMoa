package controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.ibatis.binding.BindingException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import dto.Board;
import dto.Comment;
import dto.Report;
import exception.BoardException;
import logic.BeachService;

@Controller
@RequestMapping({"board"})
public class BoardController {
   @Autowired
   BeachService service;
   
//    =============================== 게시글 리스트 ===================================
   @RequestMapping("list")
   public ModelAndView list(Integer pageNum, String searchtype, String searchcontent, int btype) {
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
//    =============================== GET 방식 조회 ===================================
   @GetMapping("*")
   public ModelAndView get(Integer seq) {
      ModelAndView mav = new ModelAndView();
      Board board = null;
      if(seq == null)
         board = new Board();
      else
         board = service.detail(seq);
      mav.addObject("board", board);
      return mav;
   }
//    =============================== 게시글 작성 ===================================   
   @PostMapping("write")
   public ModelAndView write(@Valid Board board, int btype, BindingResult bresult, HttpServletRequest request) throws Exception {
      ModelAndView mav = new ModelAndView();
      if(bresult.hasErrors()) {
         mav.getModel().putAll(bresult.getModel());
         return mav;
      }
      //db에 board 객체 저장.
      //최대 num 값 + 1을 등록되는 게시물의 num으로 설정
      //등록 성공 : list.do
      //등록 실패 : BoardException 예외 발생. write.do 등록 화면
      
      int seq = service.maxnum();
      board.setSeq(++seq);
      
      try {
         service.boardwrite(board, request);
      }catch(Exception e) {
         e.printStackTrace();
         throw new BoardException("등록에 실패했습니다", "write.do");
      }
      mav.setViewName("redirect:list.do?btype="+btype);
      return mav;
      
   }
//   =============================== 게시글, 댓글 상세보기 ===================================
   @RequestMapping("info")
   public ModelAndView detail(int seq,int btype) {
      ModelAndView mav = new ModelAndView();
      Board board = service.detail(seq);
      service.readcntadd(board.getReadcnt(),seq);
      List<Board> boardlist2 = service.boardlist2(btype,seq);
      List<Comment> commentlist = service.commentlist(seq);   //해당 게시글의 댓글 목록
      int maxseq = service.maxnum();
      int commentcount = service.commentcount(seq);   //해당 게시글의 댓글 갯수
      mav.addObject("commentcount",commentcount);   //해당 게시글의 댓글 갯수
      mav.addObject("commentlist",commentlist);   //해당 게시글의 댓글 목록
      mav.addObject("today", new SimpleDateFormat("yyyyMMdd").format(new Date()));
      mav.addObject("boardlist2",boardlist2);
      mav.addObject("board",board);
      mav.addObject("maxseq",maxseq);
      return mav;
   }
//   =============================== 비밀글 ===================================
   @PostMapping("proposed")
   public ModelAndView proposed(Board board, int seq, String inputpassword) {
      ModelAndView mav = new ModelAndView();
      Board dbboard = service.detail(seq);
      if(!inputpassword.equals(dbboard.getPassword())) {
            throw new BoardException("비밀번호가 틀립니다.","proposed.do?seq="+seq);
         }
      else {
         mav.setViewName("redirect:info.do?seq="+seq);
      }
      mav.setViewName("redirect:info.do?seq="+seq+"&btype="+board.getBtype());
      return mav;
   }
//   =============================== 게시글 수정 ===================================
   @PostMapping("update")
   public ModelAndView update(@Valid Board board, BindingResult bresult,HttpServletRequest request) {
      ModelAndView mav = new ModelAndView();
      if(bresult.hasErrors()) {
         mav.getModel().putAll(bresult.getModel());
         return mav;
      }
      //Board dbboard = service.detail(board.getSeq());

      //if(!board.getPassword().equals(dbboard.getPassword())) {
      //   throw new BoardException("비밀번호가 틀립니다.","update.do?seq="+board.getSeq());
      //}
      try {
            service.boardupdate(board,request);
            mav.setViewName("redirect:info.do?seq="+board.getSeq());
      }catch(Exception e) {
         e.printStackTrace();
         throw new BoardException("등록에 실패했습니다.","update.do?seq="+board.getSeq());
      }
      return mav;
   }
//   =============================== 게시글 삭제 ===================================
   @PostMapping("delete")
   public ModelAndView delete(Board board,BindingResult bresult) {
      ModelAndView mav = new ModelAndView();
      if(bresult.hasErrors()) {
         mav.getModel().putAll(bresult.getModel());
      }
      Board dbboard = service.detail(board.getSeq());
      try {
         service.boarddelete(board);
         }catch(Exception e) {
            throw new BoardException("삭제에 실패했습니다.","list.do?btype="+dbboard.getBtype());
         }
      mav.setViewName("redirect:list.do?btype="+dbboard.getBtype());
      return mav;
   }
//   =============================== 이미지 업로드 ===================================
   /*
    * upload : ckeditor에서 전달해 주는 파일의 이름.
    *          <input type="file" name="upload" ..>
    * CKEditorFuncNum : ckeditor에서 전달한 파라미터 이름
    */
   @RequestMapping("imgupload")
   public String imgupload(MultipartFile upload, String CKEditorFuncNum, HttpServletRequest request, Model model) {
      String path = request.getServletContext().getRealPath("/") + "board/imgfile/";
      File f = new File(path);
      if(!f.exists()) f.mkdirs();
      if(!upload.isEmpty()) {
         File file = new File(path, upload.getOriginalFilename());
         try {
            upload.transferTo(file);   //업로드된 내용을 파일에 저장
         }catch(Exception e) {
            e.printStackTrace();
         }
      }
      String fileName = request.getContextPath() + "/board/imgfile/" + upload.getOriginalFilename();
      model.addAttribute("fileName",fileName);
      model.addAttribute("CKEditorFuncNum", CKEditorFuncNum);
      return "ckedit";   //view 이름
   }
//   =============================== 게시물 신고 ===================================
   @PostMapping("report")
   public ModelAndView report(@Valid Report report, Board board, int btype,int b_seq, BindingResult bresult, HttpServletRequest request){
      ModelAndView mav = new ModelAndView();
      if(bresult.hasErrors()) {
         mav.getModel().putAll(bresult.getModel());
         return mav;
      }
      int seq = service.reportmaxnum();
      report.setR_seq(++seq);
      
      try {         
         service.reportwrite(report, request);
         service.reportadd(b_seq);
      }catch(Exception e) {
         e.printStackTrace();
         throw new BoardException("신고에 실패했습니다", "info.do?seq="+b_seq+"&btype="+btype);
      }
      throw new BoardException("게시물 신고가 접수 되었습니다", "info.do?seq="+b_seq+"&btype="+btype);
   }
//   =============================== 댓글 신고 ===================================
   @PostMapping("report2")
   public ModelAndView report2(@Valid Report report, Board board, int btype,int b_seq, int c_seq, BindingResult bresult, HttpServletRequest request){
      ModelAndView mav = new ModelAndView();
      if(bresult.hasErrors()) {
         mav.getModel().putAll(bresult.getModel());
         return mav;
      }
      int seq = service.reportmaxnum();
      report.setR_seq(++seq);
      
      //int reportcount = service.reportcount(b_seq);
      //System.out.println(reportcount);
      
      try {         
         service.reportwrite2(report, request);
         service.reportadd(b_seq);
         //service.creportadd(b_seq,c_seq);
      }catch(Exception e) {
         e.printStackTrace();
         throw new BoardException("신고에 실패했습니다", "info.do?seq="+b_seq+"&btype="+btype);
      }
      throw new BoardException("댓글 신고가 접수 되었습니다", "info.do?seq="+b_seq+"&btype="+btype);
   }
}   