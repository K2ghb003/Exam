package scoremanager.main;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.ClassNum;
import bean.School;
import bean.Teacher;
import dao.ClassNumDao;
import tool.Action;

public class ClassEditAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // セッションから教師情報を取得
        Teacher teacher = (Teacher) request.getSession().getAttribute("user");

        if (teacher == null) {
            request.setAttribute("error", "セッションが切れています。ログインし直してください。");
            request.getRequestDispatcher("/view/error.jsp").forward(request, response);
            return;
        }

        String classNumStr = request.getParameter("classNum");
        if (classNumStr == null || classNumStr.isEmpty()) {
            request.setAttribute("error", "クラス番号が指定されていません。");
            request.getRequestDispatcher("/view/error.jsp").forward(request, response);
            return;
        }

        School school = teacher.getSchool();
        ClassNumDao dao = new ClassNumDao();
        ClassNum classNum = dao.get(classNumStr, school);

        if (classNum == null) {
            request.setAttribute("error", "指定されたクラスが見つかりません。");
            request.getRequestDispatcher("/view/error.jsp").forward(request, response);
            return;
        }

        request.setAttribute("classNum", classNum);
        request.getRequestDispatcher("/scoremanager/main/class_edit.jsp").forward(request, response);
    }
}
