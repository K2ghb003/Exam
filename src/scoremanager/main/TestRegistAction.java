package scoremanager.main;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.School;
import bean.Student;
import bean.Subject;
import bean.Teacher;
import bean.Test;
import dao.ClassNumDao;
import dao.StudentDao;
import dao.SubjectDao;
import dao.TestDao;
import tool.Action;

public class TestRegistAction extends Action {

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

        // パラメータ取得
        String entYearStr = request.getParameter("entYear");
        String classNum = request.getParameter("classNum");
        String subjectCd = request.getParameter("subjectCd");
        String testNoStr = request.getParameter("no");

        Integer entYear = null;
        if (entYearStr != null && !entYearStr.isEmpty()) {
            try {
                entYear = Integer.parseInt(entYearStr);
            } catch (NumberFormatException e) {
                entYear = null;
            }
        }

        Integer testNo = null;
        if (testNoStr != null && !testNoStr.isEmpty()) {
            try {
                testNo = Integer.parseInt(testNoStr);
            } catch (NumberFormatException e) {
                testNo = null;
            }
        }

        // クラス一覧の取得
        ClassNumDao classNumDao = new ClassNumDao();
        List<String> classNumList = classNumDao.filter(school);

        // 科目一覧の取得
        SubjectDao subjectDao = new SubjectDao();
        List<Subject> subjectList = subjectDao.filter(school);

        // 入学年度一覧の取得
        StudentDao studentDao = new StudentDao();
        List<Integer> entYearList = studentDao.getEntYearList(school);

        // 学生一覧の取得（検索条件がそろっていれば）
        if (entYear != null && classNum != null && !classNum.isEmpty()) {
            List<Student> studentList = studentDao.filter(school, entYear, classNum, true);
            request.setAttribute("studentList", studentList);

            // 成績取得処理（得点表示のため）
            if (subjectCd != null && !subjectCd.isEmpty() && testNo != null) {
                Subject subject = subjectDao.get(subjectCd, school);
                if (subject != null) {
                    TestDao testDao = new TestDao();
                    List<Test> testList = testDao.filter(school, subject, testNo);

                    Map<String, Integer> pointMap = new HashMap<>();
                    for (Test test : testList) {
                        pointMap.put(test.getStudent().getNo(), test.getPoint());
                    }

                    request.setAttribute("pointMap", pointMap);
                }
            }
        }

        // JSP用属性を設定
        request.setAttribute("classNumList", classNumList);
        request.setAttribute("subjectList", subjectList);
        request.setAttribute("entYearList", entYearList);
        request.setAttribute("entYear", entYear);
        request.setAttribute("classNum", classNum);
        request.setAttribute("subjectCd", subjectCd);
        request.setAttribute("no", (testNo != null) ? testNo : "");

        // JSPへフォワード
        request.getRequestDispatcher("/scoremanager/main/test_regist.jsp").forward(request, response);
    }
}
