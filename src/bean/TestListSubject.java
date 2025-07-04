package bean;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

public class TestListSubject implements Serializable {

	/**
	 * 入学年度:int
	 */
	private int entYear;

	/**
	 * 学籍番号:String
	 */
	private String studentNo;

	/**
	 * 学生名:String
	 */
	private String studentName;

	/**
	 * クラス番号:String
	 */
	private String classNum;

	/**
	 * 学生の各種ポイントや得点を科目や評価項目ごとに管理
	 */
	private Map<Integer,Integer> points = new HashMap<>();

	/**
	 *  コンストラクタ
	 *  フィールドの初期化、NullPointerException防止
	 */
	public TestListSubject() {
		this.points = new HashMap<>();
	}

	/**
	 * ゲッター・セッター
	 */
	public int getEntYear() {
		return entYear;
	}

	public void setEntYear(int entYear) {
		this.entYear = entYear;
	}

	public String getStudentNo() {
		return studentNo;
	}

	public void setStudentNo(String studentNo) {
		this.studentNo = studentNo;
	}

	public String getStudentName() {
		return studentName;
	}

	public void setStudentName(String studentName) {
		this.studentName = studentName;
	}

	public String getClassNum() {
		return classNum;
	}

	public void setClassNum(String classNum) {
		this.classNum = classNum;
	}

	public Map<Integer, Integer> getPoints() {
		return points;
	}

	public void setPoints(Map<Integer, Integer> points) {
		this.points = points;
	}

	/**
	 * getPointKey ※数値を文字列に変換する、空の場合はnull
	 */
	public String getPoint(int key) {
		Integer value = points.get(key);
		return value != null ? value.toString() : "";
	}


	/**
	 * putPoint
	 */
	public void putPoint(int key, int value) {
        points.put(key, value);
    }
}
