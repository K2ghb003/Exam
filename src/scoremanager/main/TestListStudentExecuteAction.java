package scoremanager.main;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.School;
import bean.Student;
import bean.Teacher;
import bean.TestListSubject;
import dao.StudentDao;
import dao.TestListSubjectDao;
import tool.Action;

public class TestListStudentExecuteAction extends Action {

	@Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("UTF-8");

        // セッションからログインユーザ取得
        HttpSession session = request.getSession();
        Teacher teacher = (Teacher) session.getAttribute("user");
        if (teacher == null) {
            response.sendRedirect("Login.action");
            return;
        }

        // パラメータから学生番号を取得
        String studentNumberParam = request.getParameter("no");
        if (studentNumberParam == null || studentNumberParam.trim().isEmpty()) {
            // 学生番号が未入力の場合はエラー処理
            request.setAttribute("error", "学生番号を入力してください。");
            request.getRequestDispatcher("test_list.jsp").forward(request, response);
            return;
        }

         String studentNumber = studentNumberParam.trim();

      // 学生情報を取得するDAOのインスタンスを作成
         StudentDao studentDao = new StudentDao();

         TestListSubjectDao TestListsubjectDao = new TestListSubjectDao();

         // 学籍番号をもとに学生情報を取得
         Student student = studentDao.get(studentNumber);

      // 学籍番号をもとに学生情報を取得
         List<TestListSubject> testlistsubject = TestListsubjectDao.filter(student);

      // 学生リストを取得
//         List<Student> students = studentDao.(studentNumber);
//         request.setAttribute("students", students);

         if (student == null) {
             // 該当する学生が見つからない場合
             request.setAttribute("error", "該当する学生が見つかりません。");
             request.getRequestDispatcher("test_list.jsp").forward(request, response);
             return;
         }

        // 学校情報のインスタンスを作成
        School school = new School();

        // Teacherから学校情報を取得して設定
        if (teacher.getSchool() != null) {
            school.setCd(teacher.getSchool().getCd());
            school.setName(teacher.getSchool().getName());
        }

        // 取得した情報をリクエスト属性にセット（必要に応じて）
        request.setAttribute("school", school);
        request.setAttribute("testlistsubject", testlistsubjectt);

        request.getRequestDispatcher("/scoremanager/main/test_list_student.jsp").forward(request, response);
    }
}
