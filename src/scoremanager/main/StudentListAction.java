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
        String isAttendStr = request.getParameter("isAttend");

        Integer entYear = null;
        if (entYearStr != null && !entYearStr.isEmpty()) {
            try {
                entYear = Integer.parseInt(entYearStr);
            } catch (NumberFormatException e) {
                entYear = null;
            }
        }

        Boolean isAttend = null;
        if (isAttendStr != null) {
            isAttend = Boolean.parseBoolean(isAttendStr);
        }

        // 学生一覧取得（条件に応じてfilterメソッドを呼び分け）
        StudentDao studentDao = new StudentDao();
        List<Student> students;

        if (entYear != null && classNum != null && !classNum.isEmpty() && isAttend != null) {
            students = studentDao.filter(school, entYear, classNum, isAttend);
        } else if (entYear != null && isAttend != null) {
            students = studentDao.filter(school, entYear, isAttend);
        } else if (isAttend != null) {
            students = studentDao.filter(school, isAttend);
        } else {
            students = studentDao.filter(school);
        }

        // 入学年度一覧の取得
        List<Integer> entYearList = studentDao.getEntYearList(school);

        // クラス一覧の取得
        ClassNumDao classNumDao = new ClassNumDao();
        List<String> classNumList = classNumDao.filter(school);

        // JSPへデータを渡す
        request.setAttribute("students", students);
        request.setAttribute("entYearList", entYearList);
        request.setAttribute("classNumList", classNumList);

        // フィルター保持用（JSPで選択状態を保持するため）
        request.setAttribute("entYear", entYear);
        request.setAttribute("classNum", classNum);
        request.setAttribute("isAttend", isAttend);

        // JSPへフォワード
        request.getRequestDispatcher("/scoremanager/main/student_list.jsp").forward(request, response);
    }
}
