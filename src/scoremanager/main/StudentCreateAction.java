package scoremanager.main;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.School;
import bean.Teacher;
import dao.ClassNumDao;
import tool.Action;

public class StudentCreateAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        // ログイン中の教師情報を取得
        HttpSession session = request.getSession();
        Teacher teacher = (Teacher) session.getAttribute("user");

        if (teacher == null) {
            // 未ログインの場合はログイン画面へリダイレクト
            response.sendRedirect("Login.action");
            return;
        }

        // 所属校を取得
        School school = teacher.getSchool();
        if (school == null) {
            request.setAttribute("error", "所属校情報が取得できません。");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
            return;
        }

        // クラス一覧を取得
        ClassNumDao classNumDao = new ClassNumDao();
        List<String> classNumList = classNumDao.filter(school);

        // JSPに渡す
        request.setAttribute("classNumList", classNumList);

        // 学生登録画面へフォワード
        request.getRequestDispatcher("/scoremanager/main/student_create.jsp").forward(request, response);
    }
}
