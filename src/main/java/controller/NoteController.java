package controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dto.Note;
import logic.BeachService;

@Controller
@RequestMapping("note")
public class NoteController {
	@Autowired
	private BeachService service;
	
	
	@RequestMapping(value = "/NoteCount", method = RequestMethod.GET)
	@ResponseBody
	public int AlarmCnt(@RequestParam("id") String n_recv_id) {
		return service.notecount(n_recv_id);
	}
	 
	@GetMapping("notelist")
	public ModelAndView notelist(String id, Integer pageNum){
		ModelAndView mav = new ModelAndView();
		if(pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		int limit = 10; //한 페이지에 보여질 게시물 수
		int notecount = service.notecount(id);
		int maxpage = (int)((double)notecount / limit + 0.95);
		int startpage = (int)((pageNum / 10.0 / + 0.9) - 1) * 10 + 1; //페이지 시작 번호
		int endpage = startpage + 9;
		if(endpage > maxpage) {
			endpage = maxpage;
		}
		int noteno = notecount - (pageNum - 1) * limit + 1; //화면에 표시될 게시물 번호
		List<Note> notelist = service.notelist(id);
		mav.addObject("pageNum",pageNum);
		mav.addObject("notelist",notelist);
		mav.addObject("notecount",notecount);
		mav.addObject("maxpage",maxpage);
		mav.addObject("startpage",startpage);
		mav.addObject("endpage",endpage);
		mav.addObject("noteno",noteno);
		return mav;
	}
	@GetMapping("notedetail")
	public ModelAndView notedetail(String n_id) {
		ModelAndView mav = new ModelAndView();
		Note notedetail = service.notedetail(n_id);
		mav.addObject("notedetail",notedetail);
		return mav;
	}
	//================================쪽지 보내기====================================
	@PostMapping("sendNote")
	public ModelAndView sendNote(Note note) {
		ModelAndView mav = new ModelAndView();
		int maxnum = service.notemaxnum();
		note.setN_no(++maxnum);
		service.sendNote(note);
		mav.setViewName("redirect:../note/notelist.do?id=" + note.getN_sent_id());
		return mav;
	}
	//==============================쪽지 삭제하기=====================================
	@RequestMapping(value = "/deleteNote", method = RequestMethod.POST)
	@ResponseBody
	public void DeleteNote(@RequestParam(value = "chbox[]") List<Integer> chArr) {
		for(Integer i : chArr) {
			service.deleteNote(i);
		}
	}
}
