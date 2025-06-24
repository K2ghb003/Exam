package scoremanager.main;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.School;
import bean.Subject;
import bean.Teacher;
import dao.SubjectDao;
import tool.Action;

public class SubjectUpdateExecuteAction extends Action {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {

		//ローカル変数の宣言 1
		req.setCharacterEncoding("UTF-8");
		Subject subject = new Subject();

		//リクエストパラメータ―の取得 2
		String cd = req.getParameter("cd");
		String name = req.getParameter("name");

		subject.setCd(cd);
		subject.setName(name);

		Teacher teacher = (Teacher) req.getSession().getAttribute("user");
        if (teacher == null) {
            req.setAttribute("error", "セッションが無効です");
            req.getRequestDispatcher("/scoremanager/main/error.jsp").forward(req, res);
            return;
        }

        School school = teacher.getSchool();
        subject.setSchool(school);


		//DBからデータ取得 3
        Map<String, String> errors = new HashMap<>();

        SubjectDao daoConf = new SubjectDao();
        Subject conf = new Subject();

        	System.out.println("try0");
        	conf = daoConf.get(cd, school);
        	System.out.println("try1");
        	if (conf == null) {
        		System.out.println("try2");
        		errors.put("cd", "科目コードが存在していません");
        	}

        	// ▼ エラーがあれば戻す
        	System.out.println("try3");
        	if (!errors.isEmpty()) {
        		System.out.println("try4");
        		req.setAttribute("errors", errors);
        		req.setAttribute("subject", subject);
        		req.getRequestDispatcher("subject_update.jsp").forward(req, res);
        		System.out.println("try5");
        		return;
        	} else{
        		SubjectDao dao=new SubjectDao();
        		boolean bool=dao.save(subject);

        		//レスポンス値をセット 6
        		if(bool=true){
        			req.setAttribute("subject", subject);

        			//JSPへフォワード 7
        			req.getRequestDispatcher("subject_update_done.jsp").forward(req, res);
        		} else{
        			req.getRequestDispatcher("error.jsp").forward(req, res);
        		}
        	}





		//ビジネスロジック 4
		//なし


		//DBへデータ保存 5
//		System.out.println("forrward get");
	}
}
