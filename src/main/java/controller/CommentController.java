package controller;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import dto.Board;
import dto.Comment;
import exception.BoardException;
import logic.BeachService;

@Controller
@RequestMapping("board")
public class CommentController {
   @Autowired
   BeachService service;
   
//    =============================== 댓글 작성 ===================================
   @PostMapping("c_write")
   public ModelAndView c_write(@Valid Comment comment, Board board, int btype, BindingResult bresult, HttpServletRequest request) throws Exception{
      ModelAndView mav = new ModelAndView();
      if(bresult.hasErrors()) {
         mav.getModel().putAll(bresult.getModel());
         return mav;
      }
      int seq = service.c_maxnum();
      comment.setC_seq(++seq);
      int num = Integer.parseInt(request.getParameter("b_seq"));
      try {
         service.commentwrite(comment,request);
      }catch(Exception e) {
         e.printStackTrace();
         throw new BoardException("등록에 실패했습니다", "info.do?seq="+num+"&btype="+btype);
      }
      mav.setViewName("redirect:info.do?seq="+num+"&btype="+btype);
      return mav;
      
   }
//    =============================== 댓글 수정 ===================================
   @PostMapping("c_update")
   public ModelAndView c_update(@Valid Comment comment, int btype, BindingResult bresult, HttpServletRequest request) throws Exception{
      ModelAndView mav = new ModelAndView();
      if(bresult.hasErrors()) {
         mav.getModel().putAll(bresult.getModel());
         return mav;
      }
      int num = Integer.parseInt(request.getParameter("b_seq"));
      try {
         service.commentupdate(comment, request);
      }catch(Exception e) {
         e.printStackTrace();
         throw new BoardException("수정에 실패했습니다", "info.do?seq="+num+"&btype="+btype);
      }
      mav.setViewName("redirect:info.do?seq="+num+"&btype="+btype);
      return mav;
   }
//    =============================== 댓글 삭제 ===================================
   @PostMapping("c_delete")
   public ModelAndView c_delete(HttpServletRequest request,int c_seq, int btype) throws Exception{
      ModelAndView mav = new ModelAndView();
      int num = Integer.parseInt(request.getParameter("b_seq"));
      try {
         service.commentdelete(c_seq);
      }catch(Exception e) {
         e.printStackTrace();
         throw new BoardException("삭제에 실패했습니다", "info.do?seq="+num+"&btype="+btype);
      }
      mav.setViewName("redirect:info.do?seq="+num+"&btype="+btype);
      return mav;
   }
//    =============================== 답글 작성 ===================================
   @PostMapping("c_reply")
   public ModelAndView c_reply(@Valid Comment comment, int c_seq, int btype,Board board, BindingResult bresult, HttpServletRequest request) throws Exception{
      ModelAndView mav = new ModelAndView();
      if(bresult.hasErrors()) {
         mav.getModel().putAll(bresult.getModel());
         return mav;
      }
      int seq = service.c_maxnum();
      comment.setC_seq(++seq);
      comment.setC_grp(c_seq);
      int num = Integer.parseInt(request.getParameter("b_seq"));
      try {
         service.commentwrite(comment,request);
      }catch(Exception e) {
         e.printStackTrace();
         throw new BoardException("등록에 실패했습니다", "info.do?seq="+num+"&btype="+btype);
      }
      mav.setViewName("redirect:info.do?seq="+num+"&btype="+btype);
      return mav;
      
   }
}