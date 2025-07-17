package scoremanager.main.classes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.ClassNum;
import bean.School;
import bean.Teacher;
import dao.ClassNumDao;
import tool.Action;

public class ClassEditExecuteAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        request.setCharacterEncoding("UTF-8");

        // ログインチェック
        Teacher teacher = (Teacher) request.getSession().getAttribute("user");
        if (teacher == null) {
            request.getRequestDispatcher("/error.jsp").forward(request, response);
            return;
        }

        School school = teacher.getSchool();
        String oldClassNum = request.getParameter("class_num");
        String newClassNum = request.getParameter("new_class_num");

        if (newClassNum == null || newClassNum.isEmpty()) {
            request.setAttribute("error", "新しいクラス番号を入力してください。");
            request.getRequestDispatcher("/scoremanager/main/classes/class_edit.jsp").forward(request, response);
            return;
        }

        ClassNumDao dao = new ClassNumDao();

        // すでに使用中のクラスは変更不可
        if (dao.isUsedClass(oldClassNum, school)) {
            request.setAttribute("error", "このクラスは使用中のため変更できません。");
            request.getRequestDispatcher("/scoremanager/main/classes/class_edit.jsp").forward(request, response);
            return;
        }

        ClassNum classNumObj = new ClassNum();
        classNumObj.setSchool(school);
        classNumObj.setClass_num(oldClassNum);

        boolean success = dao.save(classNumObj, newClassNum);

        if (!success) {
            request.setAttribute("error", "更新に失敗しました。");
            request.getRequestDispatcher("/scoremanager/main/classes/class_edit.jsp").forward(request, response);
            return;
        }

        request.getRequestDispatcher("/scoremanager/main/classes/class_edit_done.jsp").forward(request, response);
    }
}
