package controller;


import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import dto.Beach;
import dto.Board;
import logic.CipherUtil;
import dto.Review;
import dto.User;
import exception.ReviewException;
import logic.BeachService;


@Controller
@RequestMapping("review")
public class ReviewController {
	@Autowired
	private BeachService service;
	
	@RequestMapping("reviewwrite")
	public ModelAndView reviewwrite(@Valid Review review,Beach beach,BindingResult bresult, MultipartFile file1,
			HttpServletRequest request,User user,HttpSession session) {
		ModelAndView mav = new ModelAndView();
		 if(bresult.hasErrors()) { mav.getModel().putAll(bresult.getModel());
		 System.out.println(review);
		 mav.setViewName("redirect:../beach/detail.do?id="+review.getBeachno());
		 return mav; 
		 }
		try {
			service.reviewcreate(review, request);
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println(review);
			throw new ReviewException("오류","");
		}
		mav.setViewName("redirect:../beach/detail.do?beachno="+review.getBeachno());
		return mav;
	}
	
	@RequestMapping("delete")
	public ModelAndView delete(Review review) {
		ModelAndView mav = new ModelAndView();
		System.out.println(review.getR_seq());
		service.reviewdelete(review.getR_seq());
		mav.setViewName("redirect:../beach/list.do");
		return mav;
	}
	
	
}
