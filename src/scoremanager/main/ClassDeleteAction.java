package scoremanager.main;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.ClassNum;
import bean.School;
import bean.Teacher;
import dao.ClassNumDao;
import tool.Action;

public class ClassDeleteAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        // ログインユーザー取得
        Teacher teacher = (Teacher) request.getSession().getAttribute("user");
        if (teacher == null) {
            response.sendRedirect("Login.action");
            return;
        }

        School school = teacher.getSchool();

        // パラメータ取得
        String classNumStr = request.getParameter("class_num");

        if (classNumStr == null || classNumStr.isEmpty()) {
            request.setAttribute("error", "クラス番号が指定されていません。");
            request.getRequestDispatcher("/scoremanager/main/class_list.jsp").forward(request, response);
            return;
        }

        // クラス情報取得
        ClassNumDao dao = new ClassNumDao();
        ClassNum classNum = dao.get(classNumStr, school);

        if (classNum == null) {
            request.setAttribute("error", "指定されたクラスが見つかりません。");
            request.getRequestDispatcher("/scoremanager/main/class_list.jsp").forward(request, response);
            return;
        }

        request.setAttribute("classNum", classNum);
        request.getRequestDispatcher("/scoremanager/main/class_delete.jsp").forward(request, response);
    }
}
