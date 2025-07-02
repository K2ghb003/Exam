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

            // ログインチェック
            Teacher teacher = (Teacher) req.getSession().getAttribute("user");
            if (teacher == null) {
                req.setAttribute("error", "セッションが切れています。ログインし直してください。");
                req.getRequestDispatcher("/error.jsp").forward(req, res);
                return;
            }

            School school = teacher.getSchool();

            // パラメータ取得
            String entYearStr = req.getParameter("entYear");
            String classNum = req.getParameter("classNum");
            String subjectCd = req.getParameter("subjectCd");
            String testNoStr = req.getParameter("no");

            String[] studentNos = req.getParameterValues("studentNo");
            String[] points = req.getParameterValues("point");

            // バリデーション
            if (entYearStr == null || classNum == null || subjectCd == null || testNoStr == null ||
                studentNos == null || points == null || studentNos.length != points.length) {
                req.setAttribute("error", "必要な情報が不足しています。");
                req.getRequestDispatcher("/error.jsp").forward(req, res);
                return;
            }

            int entYear = Integer.parseInt(entYearStr);
            int testNo = Integer.parseInt(testNoStr);

            // 対象科目と学生情報取得
            SubjectDao subjectDao = new SubjectDao();
            Subject subject = subjectDao.get(subjectCd, school);

            if (subject == null) {
                req.setAttribute("error", "科目情報が取得できませんでした。");
                req.getRequestDispatcher("/error.jsp").forward(req, res);
                return;
            }

            StudentDao studentDao = new StudentDao();
            List<Student> studentList = studentDao.filter(school, entYear, classNum, true);

            TestDao testDao = new TestDao();

            // 登録処理
            for (int i = 0; i < studentNos.length; i++) {
                String studentNo = studentNos[i];
                String pointStr = points[i];

                if (studentNo == null || pointStr == null || studentNo.isEmpty() || pointStr.isEmpty()) {
                    continue;
                }

                int point;
                try {
                    point = Integer.parseInt(pointStr);
                } catch (NumberFormatException e) {
                    continue; // 不正な数値はスキップ
                }

                Student target = studentList.stream()
                        .filter(s -> studentNo.equals(s.getNo()))
                        .findFirst()
                        .orElse(null);

                if (target == null) continue;

                Test test = new Test();
                test.setSchool(school);
                test.setStudent(target);
                test.setClassNum(classNum);
                test.setSubject(subject);
                test.setNo(testNo);
                test.setPoint(point);

                testDao.saveOrUpdate(test);
            }

            // 完了画面へ
            req.setAttribute("message", "成績の登録が完了しました。");
            req.getRequestDispatcher("/scoremanager/main/test_regist_done.jsp").forward(req, res);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "システムエラーが発生しました：" + e.getMessage());
            req.getRequestDispatcher("/error.jsp").forward(req, res);
        }
    }
}
