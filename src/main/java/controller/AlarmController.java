package controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dto.Alarm;
import dto.Note;
import logic.BeachService;

@Controller
@RequestMapping("/alarm")
public class AlarmController {
	@Autowired
	private BeachService service;
	
	//==========================================알림 보내기===========================================
	@RequestMapping("*")
	public ModelAndView alarm(String id) {
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	//=========================================알람 저장===========================================
	 @RequestMapping(value="/saveAlarm.do", method = RequestMethod.POST)
	 @ResponseBody
	 public String saveAlarm(@RequestBody Alarm alarm) {
		 int maxnum = service.alarmMaxnum(); //알람 maxnum 가져와서
		 alarm.setA_no(++maxnum); // +1 해준다.
		 service.saveAlarm(alarm);
		 return null;
	 }
	//======================================유저 알람 갯수 가져오기===========================================
	@RequestMapping(value = "/AlarmCnt", method = RequestMethod.GET)
	@ResponseBody
	public int AlarmCnt(@RequestParam("id") String a_recv_id) {
		int count = service.AlarmCnt(a_recv_id);
		return count;
	}
	//======================================알림 상세보기(레이아웃)============================================
	@RequestMapping(value = "/AlarmDetail", method = RequestMethod.POST)
	@ResponseBody
	public List<Alarm> AlarmDetail(@RequestParam("id") String a_recv_id) {
		List<Alarm> alarm = service.AlarmDetail(a_recv_id);
		return alarm;
	}
	//===================================== 알림 삭제하기 =================================================
	@RequestMapping(value = "/AlarmDelete", method = RequestMethod.POST)
	@ResponseBody
	public int AlarmDelete(@RequestParam("a_no") int a_no) {
		try {
			service.AlarmDelete(a_no);
			return 1;
		} catch(Exception e) {
			return 0;
		}
	}
}
