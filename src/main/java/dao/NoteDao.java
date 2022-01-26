package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.NoteMapper;
import dto.Note;

@Repository("Note")
public class NoteDao {
	@Autowired
	private SqlSessionTemplate template;
	private Map<String,Object> param=  new HashMap<>();

	public List<Note> notelist(String id) {
		param.clear();
		param.put("id",id);
		return template.getMapper(NoteMapper.class).list(param);
	}

	public Note notedetail(String n_id) {
		param.clear();
		param.put("n_id",n_id);
		return template.getMapper(NoteMapper.class).detail(param);
	}
	//===============================쪽지 maxnum================================
	public int notemaxnum() {
		return template.getMapper(NoteMapper.class).notemaxnum();
	}

	public void sendNote(Note note) {
		param.clear();
		template.getMapper(NoteMapper.class).sendNote(note);
	}

	public int notecount(String id) {
		return template.getMapper(NoteMapper.class).notecount(id);
	}

	public void deleteNote(Integer i) {
		template.getMapper(NoteMapper.class).deleteNote(i);
	}
}
