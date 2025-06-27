package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.Student;
import bean.TestListStudent;

public class TestListStudentDao extends Dao {

    private final String baseSql = "SELECT * FROM test";

    // postfilter
    public List<TestListStudent> postFilter(ResultSet rSet) throws Exception {
        List<TestListStudent> list = new ArrayList<>();

        while (rSet.next()) {
            TestListStudent item = new TestListStudent();
            item.putPoint(rSet.getInt("no"), rSet.getInt("point"));
            list.add(item);
        }

        return list;
    }


    // 学生filter
    public List<TestListStudent> filter(Student student) throws Exception {
        List<TestListStudent> list = new ArrayList<>();

        Connection con = null;
        PreparedStatement st = null;
        ResultSet rs = null;

        try {
            con = getConnection();

            String sql = baseSql + " WHERE student_no LIKE ?";

            st = con.prepareStatement(sql);
            st.setString(1, "%" + student.getNo() + "%");
            rs = st.executeQuery();

            while (rs.next()) {
                TestListStudent t = new TestListStudent();
                t.setEntYear(student.getEntYear());
                t.setStudentNo(student.getNo());
                t.setStudentName(student.getName());
                t.setClassNum(student.getClassNum());
                list.add(t);
            }

        } finally {

	        // リソースの解放
	        if (rs != null) {
                rs.close();
	        }
	        if (st != null) {
                st.close();
	        }
	        if (con != null) {
                con.close();
	        }
        }
        return list;
    }
}
