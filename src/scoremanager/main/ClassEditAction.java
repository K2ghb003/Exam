package scoremanager.main;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.ClassNum;
import bean.School;
import bean.Teacher;
import dao.ClassNumDao;
import tool.Action;

public class ClassEditAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        // ログインチェック
        Teacher teacher = (Teacher) request.getSession().getAttribute("user");
        if (teacher == null) {
            response.sendRedirect("Login.action");
            return;
        }

        School school = teacher.getSchool();

        String oldClassNum = request.getParameter("old_class_num");
        String newClassNum = request.getParameter("new_class_num");

        // バリデーション
        if (oldClassNum == null || newClassNum == null || newClassNum.trim().isEmpty()) {
            request.setAttribute("error", "新しいクラス番号を入力してください。");
            request.getRequestDispatcher("/scoremanager/main/class_edit.jsp").forward(request, response);
            return;
        }

        ClassNumDao dao = new ClassNumDao();
        ClassNum classNumObj = dao.get(oldClassNum, school);

        if (classNumObj == null) {
            request.setAttribute("error", "指定されたクラスが存在しません。");
            request.getRequestDispatcher("/scoremanager/main/class_edit.jsp").forward(request, response);
            return;
        }

        // 変更処理（使用中のデータかのチェックは省略。必要ならロジック追加可）
        boolean success = dao.save(classNumObj, newClassNum);

        if (success) {
            response.sendRedirect("ClassList.action");
        } else {
            request.setAttribute("error", "クラス情報の更新に失敗しました。");
            request.getRequestDispatcher("/scoremanager/main/class_edit.jsp").forward(request, response);
        }
    }
}
