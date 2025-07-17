package scoremanager.main.classes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.School;
import bean.Teacher;
import tool.Action;

public class ClassDeleteAction extends Action {
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        try {
            request.setCharacterEncoding("UTF-8");

            Teacher teacher = (Teacher) request.getSession().getAttribute("user");
            if (teacher == null) {
                request.setAttribute("error", "ログイン情報がありません。");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
                return;
            }

            School school = teacher.getSchool();
            String classNum = request.getParameter("class_num");

            request.setAttribute("class_num", classNum);
            request.getRequestDispatcher("/scoremanager/main/classes/class_delete.jsp").forward(request, response);

        } catch (Exception e) {
            request.setAttribute("error", "削除確認の表示中にエラーが発生しました。");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
