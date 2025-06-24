package scoremanager.main;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.School;
import bean.Subject;
import bean.Teacher;
import dao.SchoolDao;
import dao.SubjectDao;
import tool.Action;

public class SubjectListAction extends Action {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {

		//ローカル変数の宣言 1
		req.setCharacterEncoding("UTF-8");
		HttpSession session = req.getSession();

		//リクエストパラメータ―の取得 2
		Teacher user = (Teacher)session.getAttribute("user");


		//DBからデータ取得 3
		SchoolDao schDao = new SchoolDao();
		School school = schDao.get(user.getSchool().getCd());

		SubjectDao subDao = new SubjectDao();
		List<Subject> subject = subDao.filter(school);


		//ビジネスロジック 4
		//なし

		//DBへデータ保存 5
		//なし

		//レスポンス値をセット 6
		req.setAttribute("subject_list", subject);
//		System.out.println("session get");

		//JSPへフォワード 7
		req.getRequestDispatcher("subject_list.jsp").forward(req, res);
//		System.out.println("forrward get");
	}
}
