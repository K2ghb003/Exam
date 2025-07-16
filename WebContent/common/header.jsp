<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
  /* 控えめなウェーブアニメーション */
  .wave-text span {
    display: inline-block;
    animation: wave 3s ease-in-out infinite;
  }

  /* 各文字に少しずつ遅延をつけて波を作る */
  .wave-text span:nth-child(1) { animation-delay: 0s; }
  .wave-text span:nth-child(2) { animation-delay: 0.2s; }
  .wave-text span:nth-child(3) { animation-delay: 0.4s; }
  .wave-text span:nth-child(4) { animation-delay: 0.6s; }
  .wave-text span:nth-child(5) { animation-delay: 0.8s; }
  .wave-text span:nth-child(6) { animation-delay: 1s; }
  .wave-text span:nth-child(7) { animation-delay: 1.2s; }
  .wave-text span:nth-child(8) { animation-delay: 1.4s; }

  @keyframes wave {
    0%, 100% {
      transform: translateY(0);
    }
    50% {
      transform: translateY(-4px); /* 小さめの動きに調整 */
    }
  }
</style>

<div class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-dark text-decoration-none">
  <h1 class="fs-1 wave-text">
    <span>得</span><span>点</span><span>管</span><span>理</span><span>シ</span><span>ス</span><span>テ</span><span>ム</span>
  </h1>
</div>

<c:if test="${user.isAuthenticated()}">
  <div class="nav align-self-end">
    <span class="nav-item px-2">${user.getName()}様</span>
    <a class="nav-item px-2" href="/exam/scoremanager/main/Logout.action">ログアウト</a>
  </div>
</c:if>
