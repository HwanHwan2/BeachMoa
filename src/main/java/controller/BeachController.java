package controller;


import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;


import dto.Beach;
import dto.Review;
import dto.User;
import dto.Mapping;
import dto.Recommend;
import logic.BeachService;

@Controller
@RequestMapping("beach")
public class BeachController {
	@Autowired
	private BeachService service;
	
	@RequestMapping("list")
	public ModelAndView list(Integer pageNum,String searchtype) {
		ModelAndView mav = new ModelAndView();
		if(pageNum == null || pageNum.toString().equals("")) {
			   pageNum = 1;
			}
		if(searchtype == null || searchtype.trim().equals("")) {
					searchtype = null;
				}
		int limit = 10;
		int listcount = service.beachcount(searchtype);
		List<Beach> beachList = service.getBeachList(pageNum,limit,searchtype);
		List<Review> beachimglist = service.getbeachimgList();
		//최대 필요한 페이지 수
		int maxpage = (int)((double)listcount/limit + 0.95);
		//화면에 표시할 페이지의 시작 번호
		int startpage = (int)((pageNum/10.0 + 0.9) - 1) * 10 + 1;
		//화면에 표시할 페이지의 끝 번호
		int endpage = startpage + 9;
		if(endpage > maxpage) endpage = maxpage;
		mav.addObject("pageNum", pageNum);
		mav.addObject("maxpage", maxpage);
		mav.addObject("startpage", startpage);
		mav.addObject("endpage", endpage);
		mav.addObject("beachList",beachList);
		mav.addObject("listcount", listcount);
		mav.addObject("beachimglist", beachimglist);
		return mav;		
	}
	@RequestMapping("detail")
	public ModelAndView detail(@Valid Review review,Integer beachno,Integer pageNum, Mapping mapping,User user, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
//		String str = "img/beachimg/" + beachno + "/";
//	 	ServletContext context = request.getServletContext();
//		String path = context.getRealPath("/") + str;
		Beach beach = service.getBeach(beachno,true);
		Mapping beachinfo = service.info(beachno);
		List<Review> beachimglist = service.getbeachimgList();
		mav.addObject("beachimglist", beachimglist);
		mav.addObject("beachinfo",beachinfo);
		mav.addObject("beach",beach);
		if(pageNum == null || pageNum.toString().equals("")) {
			   pageNum = 1;
			}
		int limit = 3;
		int listcount = service.reviewcount(beach.getBeachno());
		
		//최대 필요한 페이지 수
		int maxpage = (int)((double)listcount/limit + 0.95);
				//화면에 표시할 페이지의 시작 번호
		int startpage = (int)((pageNum/10.0 + 0.9) - 1) * 10 + 1;
				//화면에 표시할 페이지의 끝 번호
		int endpage = startpage + 9;
		int reviewno = listcount - (pageNum - 1) * limit; //화면 표시될 게시물 번호. 의미없음
		if(endpage > maxpage) endpage = maxpage;
//		mav.addObject("imgpath", path);
		mav.addObject("pageNum", pageNum);
		mav.addObject("maxpage", maxpage);
		List<Review> reviewList = service.getReviewList(beachno,pageNum,limit);
		mav.addObject("startpage", startpage);
		mav.addObject("endpage", endpage);
		mav.addObject("listcount", listcount);
		mav.addObject("reviewList",reviewList);
		mav.addObject("reviewno", reviewno);
		mav.addObject("today", //오늘날짜 
				  new SimpleDateFormat("yyyyMMdd").format(new Date()));
		mav.addObject("review", review);
		return mav;
	}
	
	@GetMapping("*")
	public ModelAndView get(@Valid Review review,Integer beachno) {
		ModelAndView mav = new ModelAndView();
		Beach beach = null;
		if(beachno == null)
			beach = new Beach();
		else
			beach = service.beachdetail(beachno);
		mav.addObject("beach", beach);
		mav.addObject("review", review);
		return mav;
	}
	@RequestMapping("recomendlist")
	public ModelAndView recomendlist() {
		ModelAndView mav = new ModelAndView();
		List<Beach> recomendbeachList = service.getRecomendBeachList();
		List<Review> beachimglist = service.getbeachimgList();
		mav.addObject("beachimglist", beachimglist);
		mav.addObject("recomendbeachList",recomendbeachList);
		return mav;		
	}
	
}
