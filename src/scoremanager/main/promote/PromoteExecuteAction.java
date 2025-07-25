package scoremanager.main.promote;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.School;
import bean.Student;
import bean.Teacher;
import dao.StudentDao;
import tool.Action;

public class PromoteExecuteAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        Teacher teacher = (Teacher) request.getSession().getAttribute("user");
        if (teacher == null) {
            request.setAttribute("error", "セッションが切れています。ログインし直してください。");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
            return;
        }

        String schoolCd = request.getParameter("schoolCd");
        int entYear = Integer.parseInt(request.getParameter("year"));
        String[] promoteIds = request.getParameterValues("promoteIds");

        if (promoteIds == null || promoteIds.length == 0) {
            request.setAttribute("message", "進級対象の学生が選択されていません。");
            request.getRequestDispatcher("/scoremanager/main/promote/promote.jsp").forward(request, response);
            return;
        }

        StudentDao studentDao = new StudentDao();
//        int newEntYear = entYear + 1;

        List<String> promoted = new ArrayList<>();
        List<String> failed = new ArrayList<>();

        for (String studentNo : promoteIds) {
            Student oldStudent = studentDao.get(studentNo);

            if (oldStudent != null &&
                oldStudent.isAttend() &&
                oldStudent.getEntYear() == entYear &&
                oldStudent.getSchool().getCd().equals(schoolCd)) {

//                String newClassNum = request.getParameter("class_" + studentNo);
//                if (newClassNum == null || newClassNum.isEmpty()) {
//                    failed.add(studentNo + "（進級先クラス未指定）");
//                    continue;
//                }

                Student newStudent =oldStudent;

                School school = new School();
                school.setCd(schoolCd);
                newStudent.setSchool(school);

                try {
                    boolean success = studentDao.promote(newStudent);
                    if (success) {
                        promoted.add(studentNo);
                    } else {
                        failed.add(studentNo + "（重複）");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    failed.add(studentNo + "（エラー）");
                }
            }
        }

        StringBuilder msg = new StringBuilder();
        msg.append(promoted.size()).append("名の学生を進級させました。");
        if (!failed.isEmpty()) {
            msg.append("<br>以下の学生は進級できませんでした：").append(String.join("、", failed));
        }

        request.setAttribute("message", msg.toString());
        request.getRequestDispatcher("/scoremanager/main/promote/promote_done.jsp").forward(request, response);
    }
}
