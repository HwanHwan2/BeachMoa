package logic;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import dao.AlarmDao;
import dao.BeachDao;
import dao.BoardDao;
import dao.CommentDao;
import dao.MapDao;
import dao.NoteDao;
import dao.RecommendDao;
import dao.ReportDao;
import dao.ReviewDao;
import dao.UserDao;
import dto.Alarm;
import dto.Beach;
import dto.Board;
import dto.Comment;
import dto.Mapping;
import dto.Note;
import dto.Recommend;
import dto.Report;
import dto.Review;
import dto.User;

@Service
public class BeachService {
	@Autowired
	private BoardDao boardDao;
	@Autowired
	private CommentDao commentDao;
	@Autowired
	private UserDao userDao;
	@Autowired
	private ReportDao reportDao;
	@Autowired
	private BeachDao beachDao;
	@Autowired
	private NoteDao noteDao;
	@Autowired
	private MapDao mapDao;
	@Autowired
	private AlarmDao alarmDao;
	@Autowired
	private ReviewDao reviewDao;
	@Autowired
	private RecommendDao recommendDao;

// 	=============================== board ===================================
	public int boardcount(int btype, String searchtype, String searchcontent) {
		return boardDao.count(btype, searchtype, searchcontent);
	}

	public List<Board> boardlist(int btype, Integer pageNum, int limit, String searchtype, String searchcontent) {
		return boardDao.list(btype, pageNum, limit, searchtype, searchcontent);
	}

	public int maxnum() {
		return boardDao.maxnum();
	}

	public void boardwrite(Board board, HttpServletRequest request) {
		boardDao.write(board);

	}

	public Board detail(Integer seq) {
		return boardDao.boarddetail(seq);
	}

	public void readcntadd(int readcnt, Integer seq) {
		boardDao.readcntadd(readcnt, seq);

	}

	public List<Board> boardlist2(Integer btype, Integer seq) {
		return boardDao.list2(btype, seq);
	}

	public void boardupdate(Board board, HttpServletRequest request) {
		boardDao.update(board);
	}

	public void boarddelete(Board board) {
		boardDao.delete(board);

	}

	public List<Board> getMyBoardList(Integer pageNum, int limit, String id) {
		return boardDao.getUserBoardList(pageNum, limit, id);
	}

	public int getMyBoardCount(String id) {
		return boardDao.getUserBoardCount(id);
	}

	public void deleteMyBoard(String[] boardchk) {
		for (String seq : boardchk) {
			boardDao.deleteMyBoard(seq);
		}
	}

// 	=============================== comment ===================================
	public int c_maxnum() {
		return commentDao.maxnum();
	}

	public void commentwrite(Comment comment, HttpServletRequest request) {
		commentDao.write(comment);

	}

	public List<Comment> commentlist(int b_seq) {
		return commentDao.list(b_seq);
	}

	public int commentcount(int b_seq) {
		return commentDao.count(b_seq);
	}

	public void commentupdate(Comment comment, HttpServletRequest request) {
		commentDao.update(comment);
	}

	public void commentdelete(int c_seq) {
		commentDao.delete(c_seq);
	}

	public int getMyCommentCount(String id) {
		return commentDao.selectcount(id);
	}

	public List<Comment> getMyCommentList(Integer pageNum, int limit, String id) {
		return commentDao.selectlist(pageNum, limit, id);
	}

	public void deleteMyComment(String[] commentchk) {
		for (String c : commentchk) {
			int seq = Integer.parseInt(c);
			commentDao.delete(seq);
		}
	}

// 	=============================== user ===================================
	public void entry(@Valid User user) {
		// 일반 가입
		if (user.getLogintype().equals("normal"))
			userDao.addUser(user);
		else
			userDao.addSnsUser(user);
	}

	public User selectOne(String id) {
		return userDao.getUser(id);
	}
	// db에 계정 있는지 확인

	// col 칼럼 val 값
	public int checkOne(String col, String val) {
		return userDao.getUserCount(col, val);
	}

	// 칼럼명 두개로 조회
	public int checkEmail(String col, String val, String email) {
		return userDao.getUserSearch(col, val, email);
	}

	/* 비밀번호 찾기 변경 */
	public void pwChange(String id, String password) {
		userDao.setPassword(id, password);
	}

	/*
	 * 아이디 찾기 아이디 리스트
	 */
	public List<User> searchidlist(User user) {
		return userDao.getIdSearch(user);
	}

	/*
	 * 유저 정보 리스트
	 */
	public List<User> getUserList() {
		return userDao.getUserList();
	}

	/*
	 * 회원 가입자 수
	 */
	public int getUserCount() {
		return userDao.getUserCount(null, null);
	}

	/*
	 * 관리자 유저 정보 검색
	 */
	public List<User> getUserList(String col, String value) {
		return userDao.getUserSearch(col, value);
	}

	public int getUserCount(String col, String value) {
		return userDao.getUserCount(col, value);
	}

	public int checkPassword(String id, String hashpswd) {
		return userDao.getPassCheck(id, hashpswd);
	}

	/* 비밀번호 변경 */
	public void setPassword(String id, String hashPassword) {
		userDao.setPassword(id, hashPassword);
	}

	public void setUserNickname(String id, String nickname) {
		userDao.setUserNickname(id, nickname);
	}

	public void deleteUser(String id) {
		userDao.deleteUser(id);
	}

// 	=============================== report ===================================
	public int reportmaxnum() {
		return reportDao.reportmaxnum();
	}

	public void reportwrite(Report report, HttpServletRequest request) {
		reportDao.write(report);
	}

	public void reportwrite2(Report report, HttpServletRequest request) {
		reportDao.write2(report);
	}

	public int reportcount(int b_seq) {
		return reportDao.count(b_seq);
	}

	public void reportadd(int reportcount) {
		reportDao.add(reportcount);

	}

//  =========================================beach=================================
	public Beach getBeach(Integer beachno) {
		return beachDao.selectOne(beachno);
	}

	public int beachcount(String searchtype) {
		return beachDao.count(searchtype);
	}

	public List<Beach> getBeachList(Integer pageNum, int limit, String searchtype) {
		return beachDao.list(pageNum, limit, searchtype);
	}


	public Beach beachdetail(Integer beachno) {
		return beachDao.selectOne(beachno);
	}

	public Beach getBeach(Integer beachno, boolean b) {
		return beachDao.selectOne(beachno);
	}
//	=========================================review=================================
//	public void reviewwrite(@Valid Review review, HttpServletRequest request) {
//		if(review.getFile1() != null && !review.getFile1().isEmpty()) {
//			uploadFileCreate(review.getFile1(), request, "board/file/");
//			review.setFileurl(review.getFile1().getOriginalFilename());
//		}
//		reviewDao.write(review);
//	}
	public void reviewcreate(@Valid Review review, HttpServletRequest request) {
	
		if(review.getFile1() != null && !review.getFile1().isEmpty()) {
			uploadFileCreate(review.getFile1(), request, ("/img/beachimg/" + review.getBeachno() + "/"));
			System.out.println();
			review.setFileurl(review.getFile1().getOriginalFilename());
		}
		reviewDao.insert(review);
	}
	public void reviewdelete(int i) {
		reviewDao.delete(i);

	}

	private void uploadFileCreate(MultipartFile file1, HttpServletRequest request, String path) {
		String orgFile = file1.getOriginalFilename(); //업로드된 파일의 이름
		String uploadPath = request.getServletContext().getRealPath("/") +path;
		File fpath = new File(uploadPath);
		if(!fpath.exists()) fpath.mkdirs(); //업로드 폴더가 없는 경우 폴더 생성
		try {
			//picture : 업로드된 파일의 내용 저장
			// transferTo : 업로드된 파일의 내용을 File로 저장
			file1.transferTo(new File(uploadPath+orgFile));
		} catch(Exception e) {
			e.printStackTrace();
		}		
	}

	public int reviewcount(int beachno) {
		return reviewDao.count(beachno);
	}

	public List<Review> getReviewList(int beachno, Integer pageNum, int limit) {
		return reviewDao.list(beachno, pageNum, limit);
	}

	public int reviewmaxnum() {
		return reviewDao.reviewmaxnum();
	}

	public int getMyReviewCount(String id) {
		return reviewDao.reviewCount(id);
	}

	public List<Review> getMyReviewList(Integer pageNum, int limit, String id) {
		return reviewDao.myReviewList(pageNum, limit, id);
	}

	public void deleteMyReview(String[] reviewchk) {
		for (String r : reviewchk) {
			int seq = Integer.parseInt(r);
			reviewDao.delete(seq);
		}
	}
	public List<Review> getbeachimgList() {
		return reviewDao.beachimgList();
	}

//	=========================================recommend=================================
	public List<Beach> getRecomendBeachList() {
		return beachDao.recomendlist();
	}

	public Recommend reccnt(int r_seq) {
		return recommendDao.recommendcnt(r_seq);
	}

	public int recommendcount(int r_seq) {
		return recommendDao.count(r_seq);
	}

	public void recommendreview(int r_seq, String id) {
		reviewDao.plusreccnt(r_seq);

	}

//	========================================map=========================================
	public Mapping info(int beachno) {
		return mapDao.info(beachno);
	}

// ==================================쪽지 리스트============================================
	public List<Note> notelist(String id) {
		return noteDao.notelist(id);
	}

// ==================================쪽지 상세정보==========================================
	public Note notedetail(String n_id) {
		// TODO Auto-generated method stub
		return noteDao.notedetail(n_id);
	}

// =================================쪽지 보내기===========================================
	public void sendNote(Note note) {
		noteDao.sendNote(note);
	}

// ================================쪽지 maxnum==========================================
	public int notemaxnum() {
		return noteDao.notemaxnum();
	}

// ==================================쪽지 총 갯수========================================
	public int notecount(String id) {
		return noteDao.notecount(id);
	}

// ==================================알림 maxnum========================================
	public int alarmMaxnum() {
		return alarmDao.alarmMaxnum();
	}

// ==================================알림을 DB에 저장=====================================
	public void saveAlarm(Alarm alarm) {
		alarmDao.saveAlarm(alarm);
	}

// ===================================유저 알람 갯수 가져오기================================
	public int AlarmCnt(String a_recv_id) {
		return alarmDao.AlarmCnt(a_recv_id);
	}

//===================================알림 상세정보(레이아웃========================================
	public List<Alarm> AlarmDetail(String a_recv_id) {
		return alarmDao.AlarmDetail(a_recv_id);
	}

//==================================쪽지 삭제하기==============================================
	public void deleteNote(Integer i) {
		noteDao.deleteNote(i);
	}

	public int boardcount() {
		return boardDao.count();
	}

	public List<Board> boardlist(int limit) {
		return boardDao.list(limit);
	}

	public int boardcount2() {
		return boardDao.count2();
	}

	public List<Board> boardlist2(int limit) {
		return boardDao.list2(limit);
	}

	//==========================알람 삭제 ===================
	public void AlarmDelete(int a_no) {
		alarmDao.AlarmDelete(a_no);
	}

	

}
