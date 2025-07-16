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

        // ログインユーザー（教師）確認
        Teacher teacher = (Teacher) request.getSession().getAttribute("user");
        if (teacher == null) {
            request.getRequestDispatcher("/scoremanager/main/error.jsp").forward(request, response);
            return;
        }

        String classNum = request.getParameter("class_num");

        School school = teacher.getSchool();

        ClassNumDao dao = new ClassNumDao();
        ClassNum classnum = dao.get(classNum, school);

        request.setAttribute("classnum", classnum);
        request.getRequestDispatcher("/scoremanager/main/class_edit.jsp").forward(request, response);
    }
}
