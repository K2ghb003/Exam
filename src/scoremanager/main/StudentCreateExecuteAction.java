package scoremanager.main;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.School;
import bean.Student;
import bean.Teacher;
import dao.ClassNumDao;
import dao.StudentDao;
import tool.Action;

public class StudentCreateExecuteAction extends Action {

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
        req.setCharacterEncoding("UTF-8");

        // 入力取得
        String no = req.getParameter("no");
        String name = req.getParameter("name");
        String entYearStr = req.getParameter("entYear");
        String classCode = req.getParameter("classNum");
        String isAttendStr = req.getParameter("isAttend");

        // 学生生成
        Student student = new Student();
        student.setNo(no);
        student.setName(name);
        student.setClassNum(classCode);
        student.setAttend("true".equals(isAttendStr));

        // セッションから教師取得
        Teacher teacher = (Teacher) req.getSession().getAttribute("user");
        if (teacher == null) {
            req.setAttribute("error", "セッションが無効です");
            req.getRequestDispatcher("/scoremanager/main/error.jsp").forward(req, res);
            return;
        }

        School school = teacher.getSchool();
        student.setSchool(school);

        // 入学年度
        Integer entYear = null;
        try {
            entYear = Integer.parseInt(entYearStr);
            student.setEntYear(entYear);
        } catch (NumberFormatException e) {
            // エラー処理に続く
        }

        // バリデーション
        Map<String, String> errors = new HashMap<>();
        StudentDao studentDao = new StudentDao();
        if (no == null || no.trim().isEmpty()) {
            errors.put("no", "学生番号を入力してください");
        } else if (studentDao.get(no) != null) {
            errors.put("no", "学生番号が重複しています");
        }

        if (name == null || name.trim().isEmpty()) {
            errors.put("name", "氏名を入力してください");
        }

        if (entYear == null) {
            errors.put("entYear", "入学年度を選択してください");
        }

        if (classCode == null || classCode.trim().isEmpty()) {
            errors.put("classNum", "クラスを選択してください");
        }

        // リスト取得
        ClassNumDao classNumDao = new ClassNumDao();
        List<String> classNumList = classNumDao.filter(school);
        List<Integer> entYearList = studentDao.getEntYearList(school);  // ← 学校に紐づく年度一覧

        req.setAttribute("classNumList", classNumList);
        req.setAttribute("entYearList", entYearList);

        if (!errors.isEmpty()) {
            req.setAttribute("student", student);
            req.setAttribute("errors", errors);
            req.getRequestDispatcher("/scoremanager/main/student_create.jsp").forward(req, res);
            return;
        }

        // 登録処理
        boolean result = studentDao.save(student);
        if (result) {
            req.setAttribute("student", student);
            req.getRequestDispatcher("/scoremanager/main/student_create_done.jsp").forward(req, res);
        } else {
            req.setAttribute("error", "登録に失敗しました");
            req.getRequestDispatcher("/scoremanager/main/error.jsp").forward(req, res);
        }
    }
}
