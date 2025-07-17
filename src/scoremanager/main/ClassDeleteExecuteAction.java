package scoremanager.main.classes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.School;
import bean.Teacher;
import dao.ClassNumDao;
import tool.Action;

public class ClassDeleteExecuteAction extends Action {
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        try {
            request.setCharacterEncoding("UTF-8");

            Teacher teacher = (Teacher) request.getSession().getAttribute("user");
            if (teacher == null) {
                request.setAttribute("error", "ログイン情報がありません。");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
                return;
            }

            School school = teacher.getSchool();
            String classNum = request.getParameter("class_num");

            ClassNumDao dao = new ClassNumDao();

            // 使用中なら削除できない
            if (dao.isUsedClass(classNum, school)) {
                request.setAttribute("error", "このクラスは使用中のため削除できません。");
                request.setAttribute("class_num", classNum);
                request.getRequestDispatcher("/scoremanager/main/class_delete.jsp").forward(request, response);
                return;
            }

            boolean success = dao.delete(classNum, school);

            if (!success) {
                request.setAttribute("error", "クラスの削除に失敗しました。");
                request.setAttribute("class_num", classNum);
                request.getRequestDispatcher("/scoremanager/main/class_delete.jsp").forward(request, response);
                return;
            }

            // 削除成功後にクラス一覧へリダイレクト
            request.getRequestDispatcher("/scoremanager/main/class_delete_done.jsp").forward(request, response);

        } catch (Exception e) {
            request.setAttribute("error", "削除中に予期せぬエラーが発生しました。");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
