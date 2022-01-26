package controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import dto.Mapping;
import logic.BeachService;

@Controller
@RequestMapping("map")
public class MapController {
	
	 @Autowired
	 BeachService service;
	
	@RequestMapping("beachinfo")
	public ModelAndView beachinfo(int beachno) {
		ModelAndView mav = new ModelAndView();
		Mapping beachinfo = service.info(beachno);
		System.out.println(beachinfo);
		mav.addObject("beachinfo",beachinfo);
		return mav;
	}
}
