package scoremanager.main;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.School;
import bean.Teacher;
import dao.SchoolDao;
import tool.Action;

public class SchoolCreateExecuteAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        request.setCharacterEncoding("UTF-8");

        // ログインチェック
        Teacher teacher = (Teacher) request.getSession().getAttribute("user");
        if (teacher == null) {
            response.sendRedirect("Login.action");
            return;
        }

        // 入力値の取得
        String cd = request.getParameter("cd");
        String name = request.getParameter("name");

        // 入力チェック
        if (cd == null || cd.isEmpty() || name == null || name.isEmpty()) {
            request.setAttribute("error", "学校コードと名前を入力してください");
            request.getRequestDispatcher("/scoremanager/main/school_create.jsp").forward(request, response);
            return;
        }

        SchoolDao dao = new SchoolDao();

        // 登録済みチェック
        if (dao.get(cd) != null) {
            request.setAttribute("error", "この学校コードはすでに使用されています");
            request.getRequestDispatcher("/scoremanager/main/school_create.jsp").forward(request, response);
            return;
        }

        // 登録処理
        School school = new School();
        school.setCd(cd);
        school.setName(name);

        dao.save(school);

        // 完了後は一覧画面へ
        response.sendRedirect("SchoolList.action");
    }
}
