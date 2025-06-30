package scoremanager.main;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.School;
import bean.Student;
import bean.Subject;
import bean.Teacher;
import bean.Test;
import dao.StudentDao;
import dao.SubjectDao;
import dao.TestDao;
import tool.Action;

public class TestRegistExecuteAction extends Action {

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {

        try {
            req.setCharacterEncoding("UTF-8");

            Teacher teacher = (Teacher) req.getSession().getAttribute("user");
            if (teacher == null) {
                req.setAttribute("error", "ログインセッションが切れています。再ログインしてください。");
                req.getRequestDispatcher("/error.jsp").forward(req, res);
                return;
            }

            School school = teacher.getSchool();

            String entYearStr = req.getParameter("entYear");
            String classNum = req.getParameter("classNum");
            String subjectCd = req.getParameter("subjectCd");
            String testNoStr = req.getParameter("no");

            String[] studentNos = req.getParameterValues("studentNo");
            String[] points = req.getParameterValues("point");

            if (entYearStr == null || classNum == null || subjectCd == null || testNoStr == null ||
                studentNos == null || points == null || studentNos.length != points.length) {
                req.setAttribute("error", "入力情報が不足しています。");
                req.getRequestDispatcher("/error.jsp").forward(req, res);
                return;
            }

            int entYear = Integer.parseInt(entYearStr);
            int testNo = Integer.parseInt(testNoStr);

            SubjectDao subjectDao = new SubjectDao();
            Subject subject = subjectDao.get(subjectCd, school);
            if (subject == null) {
                req.setAttribute("error", "指定された科目が見つかりません。");
                req.getRequestDispatcher("/error.jsp").forward(req, res);
                return;
            }

            StudentDao studentDao = new StudentDao();
            List<Student> students = studentDao.filter(school, entYear, classNum, true);

            TestDao testDao = new TestDao();

            for (int i = 0; i < studentNos.length; i++) {
                String studentNo = studentNos[i];
                String pointStr = points[i];

                if (studentNo == null || studentNo.isEmpty() || pointStr == null || pointStr.isEmpty()) continue;

                int point = Integer.parseInt(pointStr);

                Student targetStudent = students.stream()
                        .filter(s -> s.getNo().equals(studentNo))
                        .findFirst()
                        .orElse(null);

                if (targetStudent == null) continue;

                Test test = new Test();
                test.setSchool(school);
                test.setClassNum(classNum);
                test.setSubject(subject);
                test.setNo(testNo);
                test.setPoint(point);
                test.setStudent(targetStudent);

                testDao.saveOrUpdate(test); // 🔁 INSERT or UPDATE 処理
            }

            req.setAttribute("message", "登録が完了しました");
            req.getRequestDispatcher("/scoremanager/main/test_regist_done.jsp").forward(req, res);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "システムエラーが発生しました：" + e.getMessage());
            req.getRequestDispatcher("/error.jsp").forward(req, res);
        }
    }
}
