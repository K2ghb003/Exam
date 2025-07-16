package scoremanager.main;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.School;
import dao.SchoolDao;
import tool.Action;

public class SchoolEditExecuteAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        request.setCharacterEncoding("UTF-8");

        // フォームから取得したパラメータを取得
        String cd = request.getParameter("cd");
        String name = request.getParameter("name");

        // Schoolオブジェクトを作成してデータをセット
        School school = new School();
        school.setCd(cd);
        school.setName(name);

        // DAOを使って保存（更新または登録）
        SchoolDao dao = new SchoolDao();
        boolean success = dao.save(school);

        if (success) {
            // 保存に成功したら一覧にリダイレクト
        	request.getRequestDispatcher("/scoremanager/main/school_edit_done.jsp").forward(request, response);
        } else {
            // 保存に失敗した場合はエラーページへ
            request.setAttribute("error", "学校情報の更新に失敗しました。");
            request.getRequestDispatcher("/view/error.jsp").forward(request, response);
        }
    }
}
