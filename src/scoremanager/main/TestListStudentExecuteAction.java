package scoremanager.main;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.School;
import bean.Student;
import bean.Teacher;
import bean.TestListStudent;
import dao.StudentDao;
import dao.TestListStudentDao;
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
        String studentNumber = studentNumberParam.trim();


        // 学校情報のインスタンスを作成
        School school = new School();

        // 学生のテスト情報を取得するDAOのインスタンス作成
        TestListStudentDao testliststudentDao = new TestListStudentDao();

        // 学生情報を取得するDAOのインスタンスを作成
        StudentDao studentDao = new StudentDao();


        // 学籍番号をもとに学生情報を取得
        Student student = studentDao.get(studentNumber);

        // 学籍番号をもとにテスト情報を取得
        List<TestListStudent> testliststudent = testliststudentDao.filter(student);


        // Teacherから学校情報を取得して設定
        if (teacher.getSchool() != null) {
            school.setCd(teacher.getSchool().getCd());
            school.setName(teacher.getSchool().getName());
        }


        // 成績情報が存在しない場合
        if (testliststudent == null || testliststudent.isEmpty()) {
            request.setAttribute("notFound", true);
        } else {
            request.setAttribute("testliststudent", testliststudent);
        }


        // 取得した情報をリクエスト属性にセット
        request.setAttribute("school", school);
        request.setAttribute("testliststudent", testliststudent);
        request.setAttribute("student", student);

        request.getRequestDispatcher("/scoremanager/main/test_list_student.jsp").forward(request, response);
    }
}
