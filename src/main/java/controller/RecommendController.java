package controller;


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
@RequestMapping("recommend")
public class RecommendController {
	@Autowired
	private BeachService service;
	
	@PostMapping("recommendreview")
	public ModelAndView recommendreview(Review review,BindingResult bresult,Beach beach,HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			service.recommendreview(review.getR_seq(),review.getId());
		}catch(Exception e) {
			e.printStackTrace();
			throw new ReviewException("오류","");
		}
		mav.setViewName("redirect:../beach/detail.do?beachno="+review.getBeachno());
		return mav;
	}
	
	
}
