package scoremanager.main;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.School;
import bean.Subject;
import bean.Teacher;
import bean.TestListSubject;
import dao.ClassNumDao;
import dao.StudentDao;
import dao.SubjectDao;
import dao.TestListSubjectDao;
import tool.Action;

public class TestListSubjectExecuteAction extends Action {

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

//        // 検索条件の取得
        String entYearStr = request.getParameter("entYear");
        String classNum = request.getParameter("classNum");
        String subjectStr = request.getParameter("subject");
//
//        // 検索条件の変換
        Integer entYear = (entYearStr != null && !entYearStr.isEmpty()) ? Integer.parseInt(entYearStr) : null;
        classNum = (classNum != null && !classNum.isEmpty()) ? classNum : null;
        subjectStr = (subjectStr != null && !subjectStr.isEmpty()) ? subjectStr : null;

        Map<String, String> errors = new HashMap<>();
        if (subjectStr == null || subjectStr.trim().isEmpty()) {
            errors.put("subject", "科目番号を入力してください");
        }
        if (!errors.isEmpty()) {
        	ClassNumDao classNumDao = new ClassNumDao();
            List<String> classNumList = classNumDao.filter(school);
        	request.setAttribute("classList", classNumList);

        	SubjectDao subjectDao = new SubjectDao();
            List<Subject> subjectList = subjectDao.filter(school);
            request.setAttribute("subjectList", subjectList);

            StudentDao studentDao = new StudentDao();
            List<Integer> entYearList = studentDao.getEntYearList(school);
            request.setAttribute("entYearList", entYearList);

        	request.setAttribute("errors", errors);
        	request.getRequestDispatcher("test_list.jsp").forward(request, response);
            return;
        }

        // クラス一覧の取得
        SubjectDao subDao = new SubjectDao();
        Subject subject = subDao.get(subjectStr, school);

        TestListSubjectDao dao = new TestListSubjectDao();
        List<TestListSubject> subjectTestList = dao.filter(entYear.intValue(), classNum, subject, school);

        // 科目一覧の取得

        // 入学年度リストを作成

        // JSPへデータを渡す
        // 収集したデータをリクエストに設定
        request.setAttribute("subjectTestList", subjectTestList);
        request.setAttribute("subject", subject);
        request.setAttribute("mode", "sj");

        ClassNumDao classNumDao = new ClassNumDao();
        List<String> classNumList = classNumDao.filter(school);
        request.setAttribute("classList", classNumList);

        SubjectDao subjectDao = new SubjectDao();
        List<Subject> subjectList = subjectDao.filter(school);
        request.setAttribute("subjectList", subjectList);

        StudentDao studentDao = new StudentDao();
        List<Integer> entYearList = studentDao.getEntYearList(school);
        request.setAttribute("entYearList", entYearList);


        // 表示するJSPへフォワード
        request.getRequestDispatcher("test_list_student.jsp").forward(request, response);
    }
}
