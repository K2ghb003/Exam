package bean;

import java.io.Serializable;

public class Student implements Serializable {

	/**
	 * 学籍番号:String
	 */
	private String no;

	/**
	 * 学生名:String
	 */
	private String name;

	/**
	 * 入学年度:int
	 */
	private int entYear;

	/**
	 * クラス番号:String
	 */
	private String classNum;

	/**
	 * 在籍の有無:boolean true=在籍, false=退籍
	 */
	private boolean isAttend;

	/**
	 * 所属校:School
	 */
	private School school;

	/**
	 * 学年
	 */
	private int year;

	/**
	 * ゲッター・セッター
	 */
	public String getNo() {
		return no;
	}

	public void setNo(String no) {
		this.no = no;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getEntYear() {
		return entYear;
	}

	public void setEntYear(int entYear) {
		this.entYear = entYear;
	}

	public String getClassNum() {
		return classNum;
	}

	public void setClassNum(String classNum) {
		this.classNum = classNum;
	}

	public boolean isAttend() {
		return isAttend;
	}

	public void setAttend(boolean isAttend) {
		this.isAttend = isAttend;
	}

	public School getSchool() {
		return school;
	}

	public void setSchool(School school) {
		this.school = school;
	}

	public int getYear() {
		return year;
	}

	public void setYear(int year) {
		this.year = year;
	}

}
