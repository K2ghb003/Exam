package scoremanager.main;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.School;
import bean.Student;
import bean.Teacher;
import dao.ClassNumDao;
import dao.StudentDao;
import tool.Action;

public class StudentUpdateExecuteAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("UTF-8");

        // セッションからログインユーザ取得
        Teacher teacher = (Teacher) request.getSession().getAttribute("user");
        if (teacher == null) {
            response.sendRedirect("Login.action");
            return;
        }

        School school = teacher.getSchool();

        // パラメータ取得
        String no = request.getParameter("no");
        String name = request.getParameter("name");
        String classNum = request.getParameter("classNum");
        String isAttendStr = request.getParameter("isAttend");

        // 入力チェック用エラーマップ
        Map<String, String> errors = new HashMap<>();

        // バリデーション
        if (name == null || name.trim().isEmpty()) {
            errors.put("name", "氏名を入力してください");
        }

        if (classNum == null || classNum.trim().isEmpty()) {
            errors.put("classNum", "クラスを選択してください");
        }

        // エラーがある場合、元の変更画面へ戻す
        if (!errors.isEmpty()) {
            StudentDao studentDao = new StudentDao();
            Student student = studentDao.get(no);
            student.setName(name);
            student.setClassNum(classNum);
            student.setAttend("true".equals(isAttendStr));
            student.setSchool(school);

            ClassNumDao classNumDao = new ClassNumDao();
            request.setAttribute("student", student);
            request.setAttribute("classNumList", classNumDao.filter(school));
            request.setAttribute("errors", errors);

            request.getRequestDispatcher("/scoremanager/main/student_update.jsp").forward(request, response);
            return;
        }

        // 学生情報の更新（saveを使用）
        Student student = new Student();
        student.setNo(no);
        student.setName(name);
        student.setClassNum(classNum);
        student.setAttend("true".equals(isAttendStr));
        student.setSchool(school);

        StudentDao studentDao = new StudentDao();
        boolean result = studentDao.save(student);

        if (result) {
            request.setAttribute("student", student);
            request.getRequestDispatcher("/scoremanager/main/student_update_done.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "学生情報の更新に失敗しました。");
            request.getRequestDispatcher("/scoremanager/main/error.jsp").forward(request, response);
        }
    }
}
