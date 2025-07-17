package scoremanager.main.school;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.School;
import dao.SchoolDao;
import tool.Action;

public class SchoolListAction extends Action {
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        SchoolDao dao = new SchoolDao();
        List<School> schools = dao.getAll(); // 全学校取得

        request.setAttribute("schools", schools);

        request.getRequestDispatcher("/scoremanager/main/school/school_list.jsp").forward(request, response);
    }
}
