package scoremanager.main;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.School;
import bean.Student;
import bean.Teacher;
import dao.ClassNumDao;
import dao.StudentDao;
import tool.Action;

public class StudentCreateAction extends Action {

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
        req.setCharacterEncoding("UTF-8");

        Teacher teacher = (Teacher) req.getSession().getAttribute("user");
        if (teacher == null) {
            req.setAttribute("error", "セッションが切れています。再ログインしてください。");
            req.getRequestDispatcher("/scoremanager/main/error.jsp").forward(req, res);
            return;
        }

        School school = teacher.getSchool();

        // クラス一覧の取得
        ClassNumDao classNumDao = new ClassNumDao();
        List<String> classNumList = classNumDao.filter(school);

        // 入学年度一覧の取得（なければダミー追加）
        StudentDao studentDao = new StudentDao();
        List<Integer> entYearList = studentDao.getEntYearList(school);
        if (entYearList == null || entYearList.isEmpty()) {
            entYearList = new ArrayList<>();
            for (int year = 2020; year <= 2025; year++) {
                entYearList.add(year);
            }
        }

        // 初期空の学生オブジェクト
        req.setAttribute("student", new Student());
        req.setAttribute("classNumList", classNumList);
        req.setAttribute("entYearList", entYearList);

        req.getRequestDispatcher("/scoremanager/main/student_create.jsp").forward(req, res);
    }
}
