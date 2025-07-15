<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="/common/base.jsp">
  <c:param name="title">得点管理システム</c:param>
  <c:param name="showNavigation" value="false" />
  <c:param name="scripts"></c:param>
  <c:param name="content">
    <style>
      .center {
        display: flex;
        align-items: center;
        flex-direction: column;
        padding: 4rem 0 6rem;
      }

      .menu-button-wrapper {
        display: flex;
        justify-content: center;
        width: 100%;
      }

      #menu-button {
        margin-top: 2rem; /* ← 少し下にずらす調整 */
      }

      .menu-options {
        display: flex;
        justify-content: center;
        gap: 5rem;
        margin-top: 2rem;
        flex-wrap: wrap;
      }

      .btn-circle {
        display: inline-block;
        text-decoration: none;
        color: #FFF;
        width: 13rem;
        height: 13rem;
        line-height: 13rem;
        border-radius: 50%;
        text-align: center;
        background-image: linear-gradient(45deg, #709dff 0%, #91fdb7 100%);
        box-shadow: 0 6px 14px rgba(0, 0, 0, 0.2);
        font-weight: bold;
        font-size: 1.3rem;
        opacity: 0;
        transform: scale(0);
        transition: all 0.5s ease;
        cursor: pointer;
      }

      .btn-circle.show {
        opacity: 1;
        transform: scale(1);
      }

      .btn-circle:hover {
        transform: scale(1.05);
      }

      .score-wrapper {
        position: relative;
        width: 13rem;
        height: 13rem;
      }

      .score-main {
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        margin: auto;
        z-index: 1;
        transition: opacity 0.4s ease, visibility 0.4s ease;
      }

      .submenu {
        position: absolute;
        top: -4rem;
        left: 10%;
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 1.2rem;
        opacity: 0;
        visibility: hidden;
        transition: opacity 0.4s ease, visibility 0.4s ease;
        z-index: 2;
        margin-left: 0;
      }

      .submenu a {
        width: 10rem;
        height: 10rem;
        line-height: 10rem;
        border-radius: 50%;
        background-image: linear-gradient(45deg, #7dd3fc 0%, #86efac 100%);
        color: white;
        font-weight: bold;
        text-align: center;
        text-decoration: none;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        font-size: 1.2rem;
        transition: transform 0.3s ease;
      }

      .submenu a:hover {
        transform: scale(1.05);
        color: var(--bs-link-color);
      }

      .score-wrapper:hover .score-main {
        opacity: 0;
        visibility: hidden;
      }

      .score-wrapper:hover .submenu {
        opacity: 1;
        visibility: visible;
      }
    </style>

    <div class="center">
      <!-- 最初のメニュー ボタン（中央・下に微調整） -->
      <div class="menu-button-wrapper">
        <div id="menu-button" class="btn-circle show">メニュー</div>
      </div>

      <!-- 下のメニュー項目（スライドイン表示） -->
      <div id="menu-options" class="menu-options" style="display: none;">
        <a href="StudentList.action" class="btn-circle menu-item">学生管理</a>

        <div class="score-wrapper menu-item">
          <div class="btn-circle score-main menu-item">成績管理</div>
          <div class="submenu">
            <a href="TestRegist.action">成績登録</a>
            <a href="TestList.action">成績参照</a>
          </div>
        </div>

        <a href="SubjectList.action" class="btn-circle menu-item">科目管理</a>
<%--         <a href="ClassList.action" class="btn-circle menu-item">クラス管理</a> --%>
      </div>
    </div>

    <script>
      document.addEventListener('DOMContentLoaded', function () {
        setTimeout(() => {
          const menuBtn = document.getElementById("menu-button");
          const menuOptions = document.getElementById("menu-options");
          const items = document.querySelectorAll(".menu-item");

          menuBtn.style.display = "none";
          menuOptions.style.display = "flex";

          items.forEach((item, index) => {
            setTimeout(() => {
              item.classList.add("show");
            }, (index + 1) * 400);
          });
        }, 703);
      });
    </script>
  </c:param>
</c:import>
