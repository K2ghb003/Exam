package scoremanager.main;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.School;
import bean.Student;
import bean.Teacher;
import dao.StudentDao;
import tool.Action;

public class StudentCreateExecuteAction extends Action {

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
        req.setCharacterEncoding("UTF-8");

        // 入力値の取得
        String no = req.getParameter("no");
        String name = req.getParameter("name");
        String entYearStr = req.getParameter("entYear");
        String classCode = req.getParameter("classNum");
        String isAttendStr = req.getParameter("isAttend");

        // 学生インスタンス作成
        Student student = new Student();
        student.setNo(no);
        student.setName(name);
        student.setClassNum(classCode);

        // 教師情報（セッションから取得）
        Teacher teacher = (Teacher) req.getSession().getAttribute("user");
        if (teacher == null) {
            req.setAttribute("error", "セッションが無効です");
            req.getRequestDispatcher("/scoremanager/main/error.jsp").forward(req, res);
            return;
        }

        // 所属校を設定
        School school = teacher.getSchool();
        student.setSchool(school);

        // 入学年度の変換と設定
        Integer entYear = null;
        try {
            entYear = Integer.parseInt(entYearStr);
            student.setEntYear(entYear);
        } catch (NumberFormatException e) {
            // エラー処理で後から対応
        }

        // 在学情報の設定（チェックボックスがONなら true）
        student.setAttend(isAttendStr != null && isAttendStr.equals("true"));

        // 入力チェック
        Map<String, String> errors = new HashMap<>();

        if (no == null || no.trim().isEmpty()) {
            errors.put("no", "学生番号を入力してください");
        } else {
            StudentDao studentDao = new StudentDao();
            Student exist = studentDao.get(no);
            if (exist != null) {
                errors.put("no", "学生番号が重複しています");
            }
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

        // エラーがある場合は登録画面に戻す
        if (!errors.isEmpty()) {
            req.setAttribute("errors", errors);
            req.setAttribute("student", student);
            req.getRequestDispatcher("/scoremanager/main/student_create.jsp").forward(req, res);
            return;
        }

        // 学生情報の登録
        StudentDao studentDao = new StudentDao();
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
