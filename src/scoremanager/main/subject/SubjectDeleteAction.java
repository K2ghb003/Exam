package scoremanager.main.subject;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.School;
import bean.Subject;
import dao.SubjectDao;
import tool.Action;

public class SubjectDeleteAction extends Action {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {

		//ローカル変数の宣言 1
		req.setCharacterEncoding("UTF-8");
		School school = new School();

		//リクエストパラメータ―の取得 2
		String cd = req.getParameter("cd");


		//DBからデータ取得 3
		SubjectDao dao=new SubjectDao();
		Subject subject=dao.get(cd, school);
//		System.out.println("DAO get");


		//ビジネスロジック 4
		//なし

		//DBへデータ保存 5
		//なし

		//レスポンス値をセット 6
		req.setAttribute("subject", subject);
//		System.out.println("session get");

		//JSPへフォワード 7
		req.getRequestDispatcher("/scoremanager/main/subject/subject_delete.jsp").forward(req, res);
//		System.out.println("forrward get");
	}
}
