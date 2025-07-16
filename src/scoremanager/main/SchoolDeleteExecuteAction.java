package scoremanager.main;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Teacher;
import dao.SchoolDao;
import tool.Action;

public class SchoolDeleteExecuteAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("UTF-8");

        // ログインチェック
        Teacher teacher = (Teacher) request.getSession().getAttribute("user");
        if (teacher == null) {
            response.sendRedirect("Login.action");
            return;
        }

        String cd = request.getParameter("cd");

        SchoolDao dao = new SchoolDao();

        // 削除前の使用チェック
        boolean isUsed = dao.isUsedSchool(cd);
        if (isUsed) {
            request.setAttribute("error", "この学校は使用中のため削除できません");
            request.getRequestDispatcher("/scoremanager/main/school_list.jsp").forward(request, response);
            return;
        }

        // 削除処理
        boolean success = dao.delete(cd);

        if (!success) {
            request.setAttribute("error", "削除に失敗しました");
        }

        request.getRequestDispatcher("/scoremanager/main/school_delete_done.jsp").forward(request, response);
    }
}
