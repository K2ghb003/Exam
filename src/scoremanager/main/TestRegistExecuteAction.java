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

public class TestRegistExecuteAction extends Action {

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
        try {
            req.setCharacterEncoding("UTF-8");

            // ログインユーザー確認
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
            String subjectCd = req.getParameter("subject");
            String testNoStr = req.getParameter("count");

            String[] studentNos = req.getParameterValues("regist");
            String[] points = req.getParameterValues("point");

            if (entYearStr == null || classNum == null || subjectCd == null || testNoStr == null ||
                studentNos == null || points == null || studentNos.length != points.length) {
                req.setAttribute("error", "必要な情報が不足しています。");
                req.getRequestDispatcher("/error.jsp").forward(req, res);
                return;
            }

            int entYear = Integer.parseInt(entYearStr);
            int testNo = Integer.parseInt(testNoStr);

            // 科目情報の取得
            SubjectDao subjectDao = new SubjectDao();
            Subject subject = subjectDao.get(subjectCd, school);
            if (subject == null) {
                req.setAttribute("error", "科目情報が取得できませんでした。");
                req.getRequestDispatcher("/error.jsp").forward(req, res);
                return;
            }

            // 学生リストの取得
            StudentDao studentDao = new StudentDao();
            List<Student> studentList = studentDao.filter(school, entYear, classNum, true);

            // 点数とエラー格納用マップ
            Map<String, String> pointMap = new HashMap<>();
            Map<String, String> pointErrors = new HashMap<>();

            // バリデーション
            for (int i = 0; i < studentNos.length; i++) {
                String studentNo = studentNos[i];
                String pointStr = points[i];

                if (studentNo == null || studentNo.trim().isEmpty()) {
                    continue;
                }

                if (pointStr == null || pointStr.trim().isEmpty()) {
                    pointMap.put(studentNo, "");  // 空欄も保持
                    pointErrors.put(studentNo, "点数を入力してください。");
                    continue;
                }

                try {
                    int point = Integer.parseInt(pointStr.trim());
                    pointMap.put(studentNo, pointStr); // 文字列として保持
                    if (point < 0 || point > 100) {
                        pointErrors.put(studentNo, "0～100の範囲で入力してください。");
                    }
                } catch (NumberFormatException e) {
                    pointMap.put(studentNo, pointStr); // 文字列として保持
                    pointErrors.put(studentNo, "数値で入力してください。");
                }
            }

            // エラーがある場合、再表示
            if (!pointErrors.isEmpty()) {
                ClassNumDao classNumDao = new ClassNumDao();
                List<String> classNumList = classNumDao.filter(school);
                List<Subject> subjectList = subjectDao.filter(school);
                List<Integer> entYearList = studentDao.getEntYearList(school);

                // 検索用データ
                req.setAttribute("entYearList", entYearList);
                req.setAttribute("classNumList", classNumList);
                req.setAttribute("subjectList", subjectList);
                req.setAttribute("studentList", studentList);

                // 検索条件保持
                req.setAttribute("entYear", entYear);
                req.setAttribute("classNum", classNum);
                req.setAttribute("subjectCd", subjectCd);
                req.setAttribute("no", testNo);

                // 入力内容とエラーを返却
                req.setAttribute("pointMap", pointMap);
                req.setAttribute("pointErrors", pointErrors);

                req.getRequestDispatcher("/scoremanager/main/test_regist.jsp").forward(req, res);
                return;
            }

            // 成績の登録
            TestDao testDao = new TestDao();
            for (Student student : studentList) {
                String studentNo = student.getNo();
                if (!pointMap.containsKey(studentNo)) continue;

                int point = Integer.parseInt(pointMap.get(studentNo)); // 安全な値のみ通過

                Test test = new Test();
                test.setSchool(school);
                test.setStudent(student);
                test.setClassNum(classNum);
                test.setSubject(subject);
                test.setNo(testNo);
                test.setPoint(point);

                testDao.saveOrUpdate(test);
            }

            // 完了メッセージ
            req.setAttribute("message", "成績の登録が完了しました。");
            req.getRequestDispatcher("/scoremanager/main/test_regist_done.jsp").forward(req, res);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "システムエラーが発生しました：" + e.getMessage());
            req.getRequestDispatcher("/error.jsp").forward(req, res);
        }
    }
}
