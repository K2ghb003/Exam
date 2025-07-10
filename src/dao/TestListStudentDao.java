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
        	TestListStudent t = new TestListStudent();
            t.setSubjectName(rSet.getString("name"));
//            System.out.println("Loaded subject: " + rSet.getString("name"));
            t.setSubjectCd(rSet.getString("cd"));
            t.setNum(rSet.getInt("no"));
            t.setPoint(rSet.getInt("point"));

//            TestListStudent item = new TestListStudent();
//            item.putPoint(rSet.getInt("no"), rSet.getInt("point"));
            list.add(t);
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

            String sql = baseSql + " right join subject on test.school_cd = subject.school_cd and test.subject_cd = subject.cd WHERE test.student_no LIKE ?";

            st = con.prepareStatement(sql);
            st.setString(1, student.getNo());
            rs = st.executeQuery();

//            if (rs.next()) {

                list.addAll(postFilter(rs));
//            }

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
