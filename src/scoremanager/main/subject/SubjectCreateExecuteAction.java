package scoremanager.main.subject;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.School;
import bean.Subject;
import bean.Teacher;
import dao.SubjectDao;
import tool.Action;

public class SubjectCreateExecuteAction extends Action {

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
        req.setCharacterEncoding("UTF-8");

        String cd = req.getParameter("cd");
        String name = req.getParameter("name");

        Subject subject = new Subject();
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

        // ▼ 入力チェック
        Map<String, String> errors = new HashMap<>();

        if (cd == null || cd.trim().isEmpty()) {
            errors.put("cd", "科目コードを入力してください");
        } else if (cd.length() != 3) {
            errors.put("cd", "科目コードは3文字で入力してください");
        } else {
            SubjectDao dao = new SubjectDao();
            Subject exist = dao.get(cd, school);
            if (exist != null) {
                errors.put("cd", "科目コードが重複しています");
            }
        }

        if (name == null || name.trim().isEmpty()) {
            errors.put("name", "科目名を入力してください");
        }

        // ▼ エラーがあれば戻す
        if (!errors.isEmpty()) {
            req.setAttribute("errors", errors);
            req.setAttribute("subject", subject);
            req.getRequestDispatcher("/scoremanager/main/subject/subject_create.jsp").forward(req, res);
            return;
        }

        // ▼ 登録処理
        SubjectDao dao = new SubjectDao();
        boolean result = dao.save(subject);

        if (result) {
            req.setAttribute("subject", subject);
            req.getRequestDispatcher("/scoremanager/main/subject/subject_create_done.jsp").forward(req, res);
        } else {
            req.setAttribute("error", "登録に失敗しました");
            req.getRequestDispatcher("/scoremanager/main/error.jsp").forward(req, res);
        }
    }
}
