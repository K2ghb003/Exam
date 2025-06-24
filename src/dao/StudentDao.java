package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.ClassNum;
import bean.School;
import bean.Student;

public class StudentDao extends Dao {

    private final String baseSql = "SELECT * FROM student WHERE school_cd = ?";

    public List<Student> filter(School school, Integer entYear, String classNum, Boolean isAttend) throws Exception {
        List<Student> list = new ArrayList<>();

        Connection con = getConnection();
        StringBuilder sql = new StringBuilder(baseSql);

        // 条件追加
        if (entYear != null) {
            sql.append(" AND ent_year = ?");
        }
        if (classNum != null && !classNum.isEmpty()) {
            sql.append(" AND class_num = ?");
        }
        if (isAttend != null) {
            sql.append(" AND is_attend = ?");
        }

        sql.append(" ORDER BY ent_year, no");

        PreparedStatement st = con.prepareStatement(sql.toString());
        int idx = 1;
        st.setString(idx++, school.getCd());
        if (entYear != null) {
            st.setInt(idx++, entYear);
        }
        if (classNum != null && !classNum.isEmpty()) {
            st.setString(idx++, classNum);
        }
        if (isAttend != null) {
            st.setBoolean(idx++, isAttend);
        }

        ResultSet rs = st.executeQuery();

        while (rs.next()) {
            Student s = new Student();
            s.setNo(rs.getString("no"));
            s.setName(rs.getString("name"));
            s.setEntYear(rs.getInt("ent_year"));

            ClassNum cn = new ClassNum();
//            cn.setClass_num(rs.getString("class_num"));
            s.setClassNum(rs.getString("class_num"));

            // 修正点：Boolean として安全に取得
            s.setAttend((Boolean)rs.getObject("is_attend"));

            s.setSchool(school);
            list.add(s);
        }

        st.close();
        con.close();

        return list;
    }

    public List<Integer> getEntYearList(School school) throws Exception {
        List<Integer> list = new ArrayList<>();

        Connection con = getConnection();
        String sql = "SELECT DISTINCT ent_year FROM student WHERE school_cd = ? ORDER BY ent_year";
        PreparedStatement st = con.prepareStatement(sql);
        st.setString(1, school.getCd());
        ResultSet rs = st.executeQuery();

        while (rs.next()) {
            list.add(rs.getInt("ent_year"));
        }

        st.close();
        con.close();

        return list;
    }
}
