package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.ClassNum;
import bean.School;

public class ClassNumDao extends Dao {

    public List<String> filter(School school) throws Exception {
        List<String> list = new ArrayList<>();

        Connection con = getConnection();

        String sql = "SELECT class_num FROM class_num WHERE school_cd = ? ORDER BY class_num";

        PreparedStatement st = con.prepareStatement(sql);
        st.setString(1, school.getCd());

        ResultSet rs = st.executeQuery();

        while (rs.next()) {
            list.add(rs.getString("class_num"));
        }

        st.close();
        con.close();

        return list;
    }


    public ClassNum get(String classNum, School school) throws Exception {
    	ClassNum class_num = new ClassNum();

        Connection con = getConnection();

        String sql = "SELECT class_num, school_cd FROM class_num WHERE school_cd = ? and class_num=?";


        PreparedStatement st = con.prepareStatement(sql);
        st.setString(1, school.getCd());
        st.setString(1, classNum);

        ResultSet rs = st.executeQuery();

        if (rs.next()) {

        	class_num.setSchool(school);
        	class_num.setClass_num(rs.getString("class_num"));
        }

        st.close();
        con.close();

        return class_num;
    }


    public boolean save(ClassNum classNum) throws Exception {
        Connection con = getConnection();

        String sql = "INSERT INTO CLASS_NUM (SCHOOL_CD, CLASS_NUM) VALUES (?, ?)";


        PreparedStatement st = con.prepareStatement(sql);
        st.setString(1, classNum.getSchool().getCd());
        st.setString(2, classNum.getClass_num());

        int line = st.executeUpdate();

        st.close();
        con.close();

        return line == 1;
    }


    public boolean save(ClassNum classNum, String newClassNum) throws Exception {
        Connection con = getConnection();

        String sql = "UPDATE CLASS_NUM SET CLASS_NAME = ? WHERE SCHOOL_CD = ? AND CLASS_NUM = ?";


        PreparedStatement st = con.prepareStatement(sql);
        st.setString(1, newClassNum);
        st.setString(2, classNum.getSchool().getCd());
        st.setString(2, classNum.getClass_num());

        int line = st.executeUpdate();

        st.close();
        con.close();

        return line == 1;
    }
}
