package scoremanager.main.tests;

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

        // ログインチェック
        Teacher teacher = (Teacher) request.getSession().getAttribute("user");
        if (teacher == null) {
            response.sendRedirect("Login.action");
            return;
        }

        School school = teacher.getSchool();
        if (school == null) {
            request.setAttribute("error", "所属校の情報が取得できません。");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
            return;
        }

        // パラメータ取得
        String entYearStr = request.getParameter("f1");
        String classNum = request.getParameter("f2");
        String subjectCd = request.getParameter("f3");
        String testNoStr = request.getParameter("f4");

        Integer entYear = null;
        Integer testNo = null;

        try {
            if (entYearStr != null && !entYearStr.isEmpty()) {
                entYear = Integer.parseInt(entYearStr);
            }
            if (testNoStr != null && !testNoStr.isEmpty()) {
                testNo = Integer.parseInt(testNoStr);
            }
        } catch (NumberFormatException e) {
            // 無効な数値は無視して null のまま扱う
        }

        // 一覧データ取得
        ClassNumDao classNumDao = new ClassNumDao();
        SubjectDao subjectDao = new SubjectDao();
        StudentDao studentDao = new StudentDao();

        List<String> classNumList = classNumDao.filter(school);
        List<Subject> subjectList = subjectDao.filter(school);
        List<Integer> entYearList = studentDao.getEntYearList(school);

        // エラーフラグ
        boolean hasError = false;

        // 科目チェック
        if (subjectCd == null || subjectCd.isEmpty()) {
            request.setAttribute("subjectError", true);
            hasError = true;
        }

        // 回数チェック
        if (testNo == null) {
            request.setAttribute("noError", true);
            hasError = true;
        }

        // 条件がそろっていてエラーがない場合のみ検索
        if (!hasError && entYear != null && classNum != null && !classNum.isEmpty()) {
            List<Student> studentList = studentDao.filter(school, entYear, classNum, true);
            request.setAttribute("studentList", studentList);

            Subject subject = subjectDao.get(subjectCd, school);
            if (subject != null) {
                TestDao testDao = new TestDao();
                List<Test> testList = testDao.filter(school, subject, testNo);

                Map<String, Integer> pointMap = new HashMap<>();
                for (Test t : testList) {
                    if (t.getStudent() != null && t.getStudent().getNo() != null) {
                        pointMap.put(t.getStudent().getNo(), t.getPoint());
                    }
                }

                request.setAttribute("pointMap", pointMap);
            }
        }

        // 入力データと一覧の再表示用設定
        request.setAttribute("entYear", entYear);
        request.setAttribute("classNum", classNum);
        request.setAttribute("subjectCd", subjectCd);
        request.setAttribute("no", (testNo != null) ? testNo : "");

        request.setAttribute("entYearList", entYearList);
        request.setAttribute("classNumList", classNumList);
        request.setAttribute("subjectList", subjectList);

        // JSPへフォワード
        request.getRequestDispatcher("/scoremanager/main/tests/test_regist.jsp").forward(request, response);
    }
}
