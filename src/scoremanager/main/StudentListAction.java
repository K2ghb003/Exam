package scoremanager.main;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.School;
import bean.Student;
import bean.Teacher;
import dao.ClassNumDao;
import dao.StudentDao;
import tool.Action;

public class StudentListAction extends Action {

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
        String entYearStr = request.getParameter("entYear");
        String classNum = request.getParameter("classNum");
        String isAuthenticatedStr = request.getParameter("isAttend");

        // 検索条件の変換
        Integer entYear = (entYearStr != null && !entYearStr.isEmpty()) ? Integer.parseInt(entYearStr) : null;
        Boolean isAuthenticated = (isAuthenticatedStr != null) ? true : null;

        // 学生一覧の取得
        StudentDao studentDao = new StudentDao();
        List<Student> students = studentDao.filter(school, entYear, classNum, isAuthenticated);

        // 入学年度一覧の取得
        List<Integer> entYearList = studentDao.getEntYearList(school);

        // クラス一覧の取得
        ClassNumDao classNumDao = new ClassNumDao();
        List<String> classNumList = classNumDao.filter(school);

        // JSPへデータを渡す
        request.setAttribute("students", students);
        request.setAttribute("entYearList", entYearList);
        request.setAttribute("classNumList", classNumList);

        // 表示するJSPへフォワード
        request.getRequestDispatcher("/scoremanager/main/student_list.jsp").forward(request, response);
    }
}
