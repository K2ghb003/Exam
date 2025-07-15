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

        String cd = request.getParameter("cd");
        String name = request.getParameter("name");

        School school = new School();
        school.setCd(cd);
        school.setName(name);

        SchoolDao dao = new SchoolDao();
        boolean success = dao.save(school);  // UPDATE を想定して使用

        if (success) {
            response.sendRedirect("SchoolList.action");
        } else {
            request.setAttribute("error", "更新に失敗しました");
            request.getRequestDispatcher("/view/error.jsp").forward(request, response);
        }
    }
}
