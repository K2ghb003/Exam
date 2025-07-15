package scoremanager.main.student;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.School;
import bean.Student;
import bean.Teacher;
import dao.ClassNumDao;
import dao.StudentDao;
import tool.Action;

public class StudentUpdateAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            request.setCharacterEncoding("UTF-8");

            // パラメータから学生番号を取得
            String no = request.getParameter("no");

            if (no == null || no.isEmpty()) {
                request.setAttribute("error", "学生番号が指定されていません");
                request.getRequestDispatcher("/scoremanager/main/error.jsp").forward(request, response);
                return;
            }

            // セッションから教員情報を取得
            Teacher teacher = (Teacher) request.getSession().getAttribute("user");
            if (teacher == null) {
                request.setAttribute("error", "ログイン情報がありません");
                request.getRequestDispatcher("/scoremanager/main/error.jsp").forward(request, response);
                return;
            }

            School school = teacher.getSchool();

            // 学生情報を取得
            StudentDao studentDao = new StudentDao();
            Student student = studentDao.get(no);

            // 学生が存在しない場合
            if (student == null) {
                request.setAttribute("error", "指定された学生が存在しません");
                request.getRequestDispatcher("/scoremanager/main/error.jsp").forward(request, response);
                return;
            }

            // クラス一覧の取得
            ClassNumDao classNumDao = new ClassNumDao();
            List<String> classNumList = classNumDao.filter(school);

            // データをリクエストにセット
            request.setAttribute("student", student);
            request.setAttribute("classNumList", classNumList);

            // 画面へフォワード
            request.getRequestDispatcher("/scoremanager/main/student/student_update.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "データ取得中にエラーが発生しました");
            request.getRequestDispatcher("/scoremanager/main/error.jsp").forward(request, response);
        }
    }
}
