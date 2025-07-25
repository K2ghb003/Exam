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
        padding: 4rem 10rem 6rem;
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

      /* 個別色 */
      .btn-student {
        background-image: linear-gradient(45deg, #4facfe 0%, #00f2fe 100%);
      }

      .btn-score {
        background-image: linear-gradient(45deg, #43e97b 0%, #38f9d7 100%);
      }

      .btn-subject {
        background-image: linear-gradient(45deg, #fa709a 0%, #fee140 100%);
      }

      .btn-class {
        background-image: linear-gradient(45deg, #fbc2eb 0%, #a6c1ee 100%);
      }

      .btn-school {
        background-image: linear-gradient(45deg, #84fab0 0%, #8fd3f4 100%);
      }

      .btn-promote {
        background-image: linear-gradient(45deg, #ffecd2 0%, #fcb69f 100%);
      }

      .btn-easter {
        background-image: linear-gradient(45deg, #c471f5 0%, #fa71cd 100%);
      }

      /* 成績管理 (サブメニュー付き) */
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
      <!-- メニューオプション（初期は非表示） -->
      <div id="menu-options" class="menu-options" style="display: none;">
        <a href="/exam/scoremanager/main/student/StudentList.action" class="btn-circle menu-item btn-student">学生管理</a>

        <div class="score-wrapper menu-item">
          <div class="btn-circle score-main btn-score menu-item">成績管理</div>
          <div class="submenu">
            <a href="/exam/scoremanager/main/tests/TestRegist.action">成績登録</a>
            <a href="/exam/scoremanager/main/tests/TestList.action">成績参照</a>
          </div>
        </div>

        <a href="/exam/scoremanager/main/subject/SubjectList.action" class="btn-circle menu-item btn-subject">科目管理</a>
        <a href="/exam/scoremanager/main/classes/ClassList.action" class="btn-circle menu-item btn-class">クラス管理</a>
        <a href="/exam/scoremanager/main/school/SchoolList.action" class="btn-circle menu-item btn-school">学校管理</a>
        <a href="/exam/scoremanager/main/promote/Promote.action" class="btn-circle menu-item btn-promote">進級処理</a>
        <a id="easterMessage" style="display: none;" href="/exam/scoremanager/main/easter-egg.jsp" class="btn-circle menu-item btn-easter">easter-egg</a>
      </div>
    </div>

    <script>
      document.addEventListener('DOMContentLoaded', function () {
        setTimeout(() => {
          const menuOptions = document.getElementById("menu-options");
          const items = document.querySelectorAll(".menu-item");
          let speed = 1;

          menuOptions.style.display = "flex";

          items.forEach((item, index) => {
            speed -= 0.06;
            setTimeout(() => {
              item.classList.add("show");
            }, speed * (index + 1) * 400);
          });
        }, 800); // 0.8秒後にメニュー表示
      });

      // Easter Egg: Konamiコード検出
      let typedKeys = '';
      const secretCode = 'arrowuparrowuparrowdownarrowdownarrowleftarrowrightarrowleftarrowrightba';

      document.addEventListener('keydown', function (e) {
        typedKeys += e.key.toLowerCase();
        if (typedKeys.length > secretCode.length) {
          typedKeys = typedKeys.slice(-secretCode.length);
        }
        if (typedKeys === secretCode) {
          triggerEasterEgg();
          typedKeys = '';
        }
      });

      function triggerEasterEgg() {
        const message = document.getElementById('easterMessage');
        if (message) {
          message.style.display = 'block';
        }
        console.log('✨ EASTER EGG TRIGGERED ✨');
      }
    </script>

  </c:param>
</c:import>
