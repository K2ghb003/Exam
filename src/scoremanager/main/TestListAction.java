package scoremanager.main;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.School;
import bean.Student;
import bean.Subject;
import bean.Teacher;
import dao.ClassNumDao;
import dao.StudentDao;
import dao.SubjectDao;
import tool.Action;

public class TestListAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        // ログイン中の教師情報を取得
        Teacher teacher = (Teacher) request.getSession().getAttribute("user");
        if (teacher == null) {
            // ログインしていない場合はログインページへリダイレクト
            response.sendRedirect("Login.action");
            return;
        }

        // 所属校情報の取得
        School school = teacher.getSchool();
        if (school == null) {
            request.setAttribute("error", "所属校の情報が取得できません。");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
            return;
        }

        // 検索条件の取得
        String studentNo = request.getParameter("no");
        List<Student> students = null;

        if (studentNo != null && !studentNo.trim().isEmpty()) {
            // 学生番号で検索
            StudentDao studentDao = new StudentDao();
            Student student = studentDao.get(studentNo.trim());

            if (student != null) {
                students = new ArrayList<>();
                students.add(student);
            } else {
                students = new ArrayList<>(); // 空リスト
            }

        } else {
//            // 条件なしの場合は全件取得または適切な処理
//            StudentDao studentDao = new StudentDao();
//            students = studentDao.getAll(); // 例：全学生取得メソッド
        }
        request.setAttribute("students", students);


        // クラス一覧の取得
        ClassNumDao classNumDao = new ClassNumDao();
        List<String> classNumList = classNumDao.filter(school);

        // 科目一覧の取得
        SubjectDao subjectDao = new SubjectDao();
        List<Subject> subjectList = subjectDao.filter(school);

        // 入学年度リストを作成
        List<Integer> entYearList = new java.util.ArrayList<>();
        int currentYear = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);


        // JSPへデータを渡す
        // 収集したデータをリクエストに設定
        request.setAttribute("classList", classNumList);
        request.setAttribute("subjectList", subjectList);
        request.setAttribute("entYearList", entYearList);

        // 表示するJSPへフォワード
        request.getRequestDispatcher("test_list.jsp").forward(request, response);
    }
}
