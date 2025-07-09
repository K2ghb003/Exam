<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- Google Fonts 読み込み -->
<link href="https://fonts.googleapis.com/css2?family=Patrick+Hand&display=swap" rel="stylesheet">

<!-- Google Fonts 読み込み -->
<link href="https://fonts.googleapis.com/css2?family=Patrick+Hand&display=swap" rel="stylesheet">

<style>
  body {
    background-color: white;
  }

  .sidebar {
    padding: 20px;
    background-color: white;
  }

  .cp_link {
    display: block;
    font-size: 18px; /* remからpxへ変更 */
    color: #333;
    text-decoration: underline;
    margin-bottom: 12px;
    transition: all 0.5s ease-in-out;
  }

  .cp_link:hover {
    transform: rotateX(360deg);
    color: #7CB342;
  }

  .nav-label {
    font-size: 17px;
    font-weight: bold;
    color: #00bcd4;
    margin: 20px 0 10px;
  }

  .submenu {
    margin-left: 16px;
  }
</style>


<!-- サイドバーナビゲーション -->
<div class="sidebar">
  <a href="Menu.action" class="cp_link">メニュー</a>
  <a href="StudentList.action" class="cp_link">学生管理</a>

  <div class="nav-label">成績管理</div>
  <div class="submenu">
    <a href="TestRegist.action" class="cp_link">成績登録</a>
    <a href="TestList.action" class="cp_link">成績参照</a>
  </div>

  <a href="SubjectList.action" class="cp_link">科目管理</a>
  <%-- <a href="ClassList.action" class="cp_link">クラス管理</a> --%>
</div>
