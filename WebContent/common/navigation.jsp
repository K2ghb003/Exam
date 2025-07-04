<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
  *,
  *:before,
  *:after {
    box-sizing: inherit;
  }

  html {
    box-sizing: border-box;
    font-size: 62.5%;
  }

  .btn,
  a.btn,
  button.btn {
    font-size: 1.4rem;
    font-weight: 600;
    line-height: 1.4;
    display: inline-block;
    padding: 0.6rem 1.6rem;
    cursor: pointer;
    user-select: none;
    transition: all 0.3s;
    text-align: center;
    text-decoration: none;
    letter-spacing: 0.05em;
    color: #212529;
    border-radius: 0.4rem;
  }

  a.btn-malformation {
    font-size: 1.4rem;
    padding: 0.8rem 1.6rem;
    color: #fff;
    text-decoration: none;
    border-radius: 100% 40px / 40px 100%;
    background: linear-gradient(135deg, #fca1a1 40%, #fcfc5d 100%);
    display: inline-block;
    text-align: center;
    margin: 0.5rem 0;
    min-width: 13rem; /* ← 一つ前の幅に戻した */
    transition: border-radius 0.3s ease;
  }

  a.btn-malformation:hover {
    color: #fff;
    border-radius: 60% 80% / 100% 80%;
    text-decoration: none;
  }

  .nav-label {
    font-size: 1.3rem;
    font-weight: bold;
    margin: 1.2rem 0 0.8rem;
    color: #00bcd4; /* 成績管理の色を水色に */
  }

  .submenu {
    margin-left: 1.6rem;
  }

  .sidebar {
    padding: 1rem 2rem;
  }
</style>

<!-- サイドバーナビゲーション -->
<div class="sidebar">
  <a href="Menu.action" class="btn-malformation">メニュー</a>
  <a href="StudentList.action" class="btn-malformation">学生管理</a>

  <div class="nav-label">成績管理</div>
  <div class="submenu">
    <a href="TestRegist.action" class="btn-malformation">成績登録</a>
    <a href="TestList.action" class="btn-malformation">成績参照</a>
  </div>

  <a href="SubjectList.action" class="btn-malformation">科目管理</a>
  <a href="ClassList.action" class="btn-malformation">クラス管理</a>
</div>
