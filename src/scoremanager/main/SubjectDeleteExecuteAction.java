package scoremanager.main;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Subject;
import dao.SubjectDao;
import tool.Action;

public class SubjectDeleteExecuteAction extends Action {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {

		//ローカル変数の宣言 1
		req.setCharacterEncoding("UTF-8");
		Subject subject = new Subject();

		//リクエストパラメータ―の取得 2
		String cd = req.getParameter("cd");
//		String id = "oom";
//		System.out.println("id get");

		subject.setCd(cd);


		//DBからデータ取得 3
		SubjectDao dao=new SubjectDao();
		boolean bool=dao.delete(subject);
//		System.out.println("DAO get");


		//ビジネスロジック 4
		//なし
//		System.out.println(bool);

		//DBへデータ保存 5
		//なし

		//レスポンス値をセット 6
		if(bool=true){
			req.setAttribute("subject", subject);
//		System.out.println("session get");

		//JSPへフォワード 7
			req.getRequestDispatcher("subject_delete_done.jsp").forward(req, res);
		} else{
			req.getRequestDispatcher("error.jsp").forward(req, res);
		}
//		System.out.println("forrward get");
	}
}
