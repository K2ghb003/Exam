package scoremanager.main.school;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Teacher;
import tool.Action;

public class SchoolCreateAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        // ログインチェック（教師）
        Teacher teacher = (Teacher) request.getSession().getAttribute("user");
        if (teacher == null) {
            response.sendRedirect("Login.action");
            return;
        }

        // 入力画面にフォワード
        request.getRequestDispatcher("/scoremanager/main/school/school_create.jsp").forward(request, response);
    }
}
