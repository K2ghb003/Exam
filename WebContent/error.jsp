<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="/common/base.jsp">
  <c:param name="title">エラーページ</c:param>

  <c:param name="scripts">
    <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
  </c:param>

  <c:param name="content">
    <section>
      <div class="row justify-content-center">
        <c:choose>
          <%-- ログイン済みの場合 --%>
          <c:when test="${user.isAuthenticated()}">
            <main class="col-12 text-center">
              <h2 class="text-danger mt-4">エラーが発生しました</h2>
              ${error}

              <c:if test="${param.error == 'h2'}">
                <p class="mb-4 text-danger">H2 データベースに接続できません。H2 Console が起動しているか接続が切断されていないか確認してください。</p>
              </c:if>

              <c:if test="${param.error != 'h2'}">
                <p class="mb-4">お手数ですが、もう一度お試しください。</p>
              </c:if>

              <a href="/exam/scoremanager/main/Menu.action" class="btn btn-secondary">メニューに戻る</a>
            </main>
          </c:when>

          <%-- 未ログインの場合 --%>
          <c:otherwise>
            <main class="col-12 text-center">
              <h2 class="text-danger mt-4">エラーが発生しました</h2>
              ${error}

              <c:if test="${param.error == 'h2'}">
                <p class="mb-4 text-danger">H2 データベースに接続できません。H2 Console を起動してください。</p>
              </c:if>

              <c:if test="${param.error != 'h2'}">
                <p class="mb-4">ログインしてから操作をお試しください。</p>
              </c:if>

              <a href="/exam/scoremanager/Login.action" class="btn btn-primary">ログインページへ戻る</a>
            </main>
          </c:otherwise>
        </c:choose>
      </div>
    </section>
  </c:param>
</c:import>
