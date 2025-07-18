package scoremanager.main.classes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.ClassNum;
import bean.School;
import bean.Teacher;
import dao.ClassNumDao;
import tool.Action;

public class ClassCreateAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        // ログインユーザー確認
        Teacher teacher = (Teacher) request.getSession().getAttribute("user");
        if (teacher == null) {
            response.sendRedirect("Login.action");
            return;
        }

        School school = teacher.getSchool();

        String classNum = request.getParameter("class_num");

        // 入力チェック
        if (classNum == null || classNum.trim().isEmpty()) {
//            request.setAttribute("error", "クラス番号を入力してください。");
            request.getRequestDispatcher("/scoremanager/main/classes/class_create.jsp").forward(request, response);

            return;
        }

        ClassNumDao dao = new ClassNumDao();

        // 重複チェック
        if (dao.get(classNum, school) != null && dao.get(classNum, school).getClass_num() != null) {
            request.setAttribute("error", "このクラスは既に登録されています。");
            request.getRequestDispatcher("/scoremanager/main/classes/class_create.jsp").forward(request, response);
            return;
        }

        // 登録処理
        ClassNum newClass = new ClassNum();
        newClass.setClass_num(classNum);
        newClass.setSchool(school);

        boolean success = dao.save(newClass);

        if (success) {
        	request.getRequestDispatcher("/scoremanager/main/classes/class_create_done.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "クラスの登録に失敗しました。");
            request.getRequestDispatcher("/scoremanager/main/classes/class_create.jsp").forward(request, response);
        }
    }
}
