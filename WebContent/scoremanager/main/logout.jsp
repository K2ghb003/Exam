<%-- ログアウトJSP（テトリス風アニメーション） --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="/common/base.jsp">
  <c:param name="title">得点管理システム</c:param>

  <c:param name="content">
    <style>
      /* テトリス風アニメーション */
      .tetris-block {
        opacity: 0;
        transform: translateY(100px);
        animation: tetrisFall 0.5s ease-out forwards;
      }

      .tetris-block.delay-1 { animation-delay: 0.2s; }
      .tetris-block.delay-2 { animation-delay: 0.4s; }
      .tetris-block.delay-3 { animation-delay: 0.6s; }
      .tetris-block.delay-4 { animation-delay: 0.8s; }

      @keyframes tetrisFall {
        0% {
          opacity: 0;
          transform: translateY(100px);
        }
        100% {
          opacity: 1;
          transform: translateY(0);
        }
      }

      .logout-message {
        background-color: #a0d6b4;
        padding: 1rem;
        border-radius: 8px;
        font-size: 1.2rem;
      }

      .login-link {
        display: inline-block;
        margin-top: 1rem;
        padding: 0.6rem 1.2rem;
        background-color: #007bff;
        color: white;
        text-decoration: none;
        border-radius: 5px;
        transition: background-color 0.3s;
      }

      .login-link:hover {
        background-color: #0056b3;
      }

      #wrap_box {
        max-width: 500px;
        margin: 50px auto;
        text-align: center;
      }
    </style>

    <div id="wrap_box">
      <h2 class="h3 mb-3 fw-normal bg-secondary bg-opacity-10 py-2 tetris-block delay-1">ログアウト</h2>
      <div class="tetris-block delay-2 logout-message">ログアウトしました</div>
      <div class="tetris-block delay-3">
        <a href="../Login.action" class="login-link">ログイン</a>
      </div>
    </div>
  </c:param>
</c:import>
