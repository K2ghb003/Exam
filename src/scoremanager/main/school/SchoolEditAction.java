package scoremanager.main.school;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.School;
import dao.SchoolDao;
import tool.Action;

public class SchoolEditAction extends Action {
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String cd = request.getParameter("cd");

        SchoolDao dao = new SchoolDao();
        School school = dao.get(cd);

        request.setAttribute("school", school);

        request.getRequestDispatcher("/scoremanager/main/school/school_edit.jsp").forward(request, response);
    }
}
