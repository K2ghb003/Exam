package scoremanager.main.classes;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.School;
import bean.Teacher;
import dao.ClassNumDao;
import tool.Action;

public class ClassListAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // ログインユーザーの取得
        Teacher teacher = (Teacher) request.getSession().getAttribute("user");

        if (teacher == null) {
            response.sendRedirect("Login.action");
            return;
        }

        // 学校情報の取得
        School school = teacher.getSchool();
        if (school == null) {
            request.setAttribute("error", "学校情報が取得できません。");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
            return;
        }

        // クラス情報一覧の取得
        ClassNumDao dao = new ClassNumDao();
        List<String> classList = dao.filter(school);

        // リクエストにリストをセット
        request.setAttribute("classList", classList);

        // 指定されたJSPにフォワード（修正ポイント）
        request.getRequestDispatcher("/scoremanager/main/classes/class_list.jsp").forward(request, response);
    }
}
