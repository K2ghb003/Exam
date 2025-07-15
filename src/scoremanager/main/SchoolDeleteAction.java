package scoremanager.main;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.School;
import bean.Teacher;
import dao.SchoolDao;
import tool.Action;

public class SchoolDeleteAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // ログインチェック
        Teacher teacher = (Teacher) request.getSession().getAttribute("user");
        if (teacher == null) {
            response.sendRedirect("Login.action");
            return;
        }

        String cd = request.getParameter("cd");
        SchoolDao dao = new SchoolDao();
        School school = dao.get(cd);

        if (school == null) {
            request.setAttribute("error", "指定された学校が見つかりません。");
            request.getRequestDispatcher("/scoremanager/main/school_list.jsp").forward(request, response);
            return;
        }

        request.setAttribute("school", school);
        request.getRequestDispatcher("/scoremanager/main/school_delete.jsp").forward(request, response);
    }
}
