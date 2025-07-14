<%-- 共通テンプレート --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
        rel="stylesheet"
        integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
        crossorigin="anonymous">

  <title>${param.title}</title>
  <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
  ${param.scripts}

  <style>
    .menu-toggle {
      display: none;
      position: fixed;
      top: 10px;
      left: 10px;
      background-color: #007bff;
      color: white;
      padding: 0.5rem 1rem;
      border-radius: 5px;
      z-index: 1001;
      font-size: 1.2rem;
      cursor: pointer;
    }

    #sidebar-wrapper {
      background-color: #f8f9fa;
    }

    @media screen and (max-width: 768px) {
      .menu-toggle {
        display: block;
      }

      #sidebar-wrapper {
        position: fixed;
        top: 0;
        left: 0;
        width: 250px;
        height: 100%;
        background-color: #f8f9fa;
        overflow-y: auto;
        transform: translateX(-100%);
        transition: transform 0.3s ease;
        z-index: 1000;
      }

      #sidebar-wrapper.open {
        transform: translateX(0);
      }

      main {
        margin-left: 0 !important;
      }
    }
  </style>

  <script>
    function toggleSidebar() {
      document.getElementById('sidebar-wrapper').classList.toggle('open');
    }
  </script>
</head>
<body>
  <div id="wrapper" class="container-fluid">
    <!-- ヘッダー -->
    <header class="d-flex flex-wrap justify-content-center py-3 px-5 mb-4 border-bottom border-2 bg-primary bg-opacity-10 bg-gradient">
      <c:import url="/common/header.jsp" />
    </header>

    <!-- ハンバーガーメニュー（スマホ用） -->
    <div class="menu-toggle d-md-none" onclick="toggleSidebar()">☰ メニュー</div>

    <!-- スマホ用スライドサイドバー -->
    <div id="sidebar-wrapper" class="d-md-none">
      <c:import url="/common/navigation.jsp" />
    </div>

    <!-- コンテンツ本体 -->
    <div class="row">
      <c:choose>
        <%-- ログイン済みの場合 --%>
        <c:when test="${user.isAuthenticated()}">
          <c:choose>
            <%-- showNavigation パラメータが false でない場合にナビゲーションを表示 --%>
            <c:when test="${param.showNavigation != 'false'}">
              <!-- PC用サイドバー -->
              <nav class="col-md-3 d-none d-md-block">
                <c:import url="/common/navigation.jsp" />
              </nav>

              <!-- メインコンテンツ -->
              <main class="col-md-9 col-12 border-start">
                ${param.content}
              </main>
            </c:when>
            <c:otherwise>
              <main class="col-12">
                ${param.content}
              </main>
            </c:otherwise>
          </c:choose>
        </c:when>

        <%-- 未ログインの場合 --%>
        <c:otherwise>
          <main class="col-12">
            ${param.content}
          </main>
        </c:otherwise>
      </c:choose>
    </div>

    <!-- フッター -->
    <footer class="py-2 my-4 bg-dark bg-opacity-10 border-top border-3">
      <c:import url="/common/footer.jsp" />
    </footer>
  </div>
</body>
</html>
