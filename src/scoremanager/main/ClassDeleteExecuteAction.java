package scoremanager.main;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.School;
import bean.Teacher;
import dao.ClassNumDao;
import tool.Action;

public class ClassDeleteExecuteAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // セッションからユーザー（教師）を取得
        Teacher teacher = (Teacher) request.getSession().getAttribute("user");

        // 未ログイン時はログイン画面へリダイレクト
        if (teacher == null) {
            response.sendRedirect("Login.action");
            return;
        }

        School school = teacher.getSchool();
        String classNum = request.getParameter("classNum");

        // 入力チェック
        if (classNum == null || classNum.isEmpty()) {
            request.setAttribute("error", "クラス番号が指定されていません。");
            request.getRequestDispatcher("/scoremanager/main/class_list.jsp").forward(request, response);
            return;
        }

        // DAOを使って削除処理を実行
        ClassNumDao dao = new ClassNumDao();
        boolean isUsed = dao.isUsedClass(classNum, school); // クラスが使用中かどうかを確認

        if (isUsed) {
            request.setAttribute("error", "このクラスは使用中のため削除できません。");
        } else {
            boolean success = dao.delete(classNum, school);
            if (success) {
                request.setAttribute("message", "クラスを削除しました。");
            } else {
                request.setAttribute("error", "クラスの削除に失敗しました。");
            }
        }

        // クラス一覧画面にフォワード
        request.getRequestDispatcher("/scoremanager/main/class_list.jsp").forward(request, response);
    }
}
