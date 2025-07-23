package scoremanager.main;

import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.ClassNum;
import bean.School;
import bean.Student;
import bean.Teacher;
import dao.ClassNumDao;
import dao.SchoolDao;
import dao.StudentDao;
import tool.Action;

public class PromoteAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        // ログインチェック
        Teacher teacher = (Teacher) request.getSession().getAttribute("user");
        if (teacher == null) {
            request.setAttribute("error", "セッションが切れています。ログインし直してください。");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
            return;
        }

        SchoolDao schoolDao = new SchoolDao();
        StudentDao studentDao = new StudentDao();
        ClassNumDao classNumDao = new ClassNumDao();

        // 学校の決定（パラメータ or ログインユーザー）
        School school = teacher.getSchool();
        String schoolCd = request.getParameter("schoolCd");
        if (schoolCd != null && !schoolCd.isEmpty()) {
            School selected = schoolDao.get(schoolCd);
            if (selected != null) {
                school = selected;
            }
        }

        // 学校と年リストの取得
        List<School> schoolList = schoolDao.getAll();
        List<Integer> yearList = studentDao.getEntYearList(school);

        // 対象年度の決定
        String yearStr = request.getParameter("year");
        Integer selectedYear = null;
        if (yearStr != null && !yearStr.isEmpty()) {
            try {
                selectedYear = Integer.parseInt(yearStr);
            } catch (NumberFormatException e) {
                // 無視
            }
        } else if (!yearList.isEmpty()) {
            selectedYear = yearList.get(yearList.size() - 1);
        }

        // 学生リスト取得
        List<Student> studentList = null;
        if (selectedYear != null) {
            studentList = studentDao.filter(school, selectedYear, null, true);
        }

        // クラス一覧取得
        List<String> classStrList = classNumDao.filter(school);
        List<ClassNum> classList = new java.util.ArrayList<>();
        for (String classNumStr : classStrList) {
            ClassNum c = new ClassNum();
            c.setClass_num(classNumStr);
            c.setSchool(school);
            classList.add(c);
        }

        int currentYear = Calendar.getInstance().get(Calendar.YEAR);

        // JSPへ渡す
        request.setAttribute("schoolList", schoolList);
        request.setAttribute("yearList", yearList);
        request.setAttribute("studentList", studentList);
        request.setAttribute("selectedSchoolCd", school.getCd());
        request.setAttribute("selectedYear", selectedYear);
        request.setAttribute("currentYear", currentYear);
        request.setAttribute("classList", classList); // ClassNum型のリスト

        request.getRequestDispatcher("/scoremanager/main/promote.jsp").forward(request, response);
    }
}
