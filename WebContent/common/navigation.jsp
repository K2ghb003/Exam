<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- Google Fonts 読み込み -->
<link href="https://fonts.googleapis.com/css2?family=Patrick+Hand&display=swap" rel="stylesheet">

<style>
  body {
    background-color: white;
  }

  /* スライドアニメーション（ラッパーに適用） */
  .slide-skew {
    opacity: 0;
    transform: translateX(180px) translateY(30px);
    animation: slide-skew 0.4s cubic-bezier(0.25, 1, 0.5, 1) forwards;
  }

  .delay-0 { animation-delay: 0s; }
  .delay-1 { animation-delay: 0.1s; }
  .delay-2 { animation-delay: 0.2s; }
  .delay-3 { animation-delay: 0.3s; }
  .delay-4 { animation-delay: 0.4s; }
  .delay-5 { animation-delay: 0.5s; }
  .delay-6 { animation-delay: 0.6s; }

  @keyframes slide-skew {
    0% {
      transform: translateX(180px) translateY(30px);
      opacity: 0;
    }
    100% {
      transform: translateX(0) translateY(0);
      opacity: 1;
    }
  }

  .sidebar {
    padding: 20px;
    background-color: white;
  }

  .cp_link {
    display: block;
    font-size: 18px;
    color: #333;
    text-decoration: underline;
    margin-bottom: 12px;
    transition: all 0.5s ease-in-out;
    transform: perspective(600px); /* 回転に立体感を出す */
  }

  .cp_link:hover {
    transform: perspective(600px) rotateX(360deg); /* 回転を hover 時に適用 */
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
  <div class="slide-skew delay-0"><a href="Menu.action" class="cp_link">メニュー</a></div>
  <div class="slide-skew delay-1"><a href="StudentList.action" class="cp_link">学生管理</a></div>

  <div class="slide-skew delay-2 nav-label">成績管理</div>
  <div class="submenu">
    <div class="slide-skew delay-3"><a href="TestRegist.action" class="cp_link">成績登録</a></div>
    <div class="slide-skew delay-4"><a href="TestList.action" class="cp_link">成績参照</a></div>
  </div>

  <div class="slide-skew delay-5"><a href="SubjectList.action" class="cp_link">科目管理</a></div>
  <%-- <div class="slide-skew delay-6"><a href="ClassList.action" class="cp_link">クラス管理</a></div> --%>
</div>
