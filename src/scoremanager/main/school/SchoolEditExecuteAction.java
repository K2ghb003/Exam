package scoremanager.main.school;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.School;
import dao.SchoolDao;
import dao.TeacherDao;
import tool.Action;

public class SchoolEditExecuteAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        request.setCharacterEncoding("UTF-8");

        // フォームから取得したパラメータを取得
        String cd = request.getParameter("cd");
        String old_cd = request.getParameter("old_cd");
        String name = request.getParameter("name");
        String mode = request.getParameter("mode");

        // Schoolオブジェクトを作成してデータをセット
        School school = new School();
        school.setCd(cd);
        school.setName(name);


        SchoolDao dao = new SchoolDao();
        TeacherDao teacherDao = new TeacherDao();
//        System.out.println(dao.get(cd));
//        System.out.println(teacherDao.findSchool(old_cd).size());

        if(teacherDao.findSchool(old_cd).size() > 0 && !cd.equals(old_cd)){

            School school_send = dao.get(old_cd);

            request.setAttribute("school", school_send);

        	request.setAttribute("error", "この学校番号は使用中のため変更できません。");
        	request.setAttribute("disabled", "disabled");
            request.getRequestDispatcher("/scoremanager/main/school/school_edit.jsp").forward(request, response);
            return;
        }

        // DAOを使って保存（更新または登録）
        boolean success = dao.save(school, mode, old_cd);

        if (success) {
            // 保存に成功したら一覧にリダイレクト
        	request.getRequestDispatcher("/scoremanager/main/school/school_edit_done.jsp").forward(request, response);
        	return;
        } else {
            // 保存に失敗した場合はエラーページへ
            request.setAttribute("error", "学校情報の更新に失敗しました。");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
            return;
        }
    }
}
