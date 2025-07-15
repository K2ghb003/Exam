package scoremanager.main;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.School;
import bean.Student;
import bean.Teacher;
import dao.ClassNumDao;
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

        // 現在の年から過去5年分を生成
        List<Integer> entYearList = new ArrayList<>();
        int currentYear = Calendar.getInstance().get(Calendar.YEAR);
        for (int year = currentYear; year >= currentYear - 5; year--) {
            entYearList.add(year);
        }

        // 初期の空学生オブジェクト
        req.setAttribute("student", new Student());
        req.setAttribute("classNumList", classNumList);
        req.setAttribute("entYearList", entYearList);

        req.getRequestDispatcher("/scoremanager/main/student/student_create.jsp").forward(req, res);
    }
}
