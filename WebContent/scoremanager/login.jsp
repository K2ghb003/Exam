<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:import url="/common/base.jsp">
  <c:param name="title">得点管理システム</c:param>

  <c:param name="scripts">
    <script type="text/javascript">
      $(function () {
        $('#password-display').change(function () {
          $('#password-input').attr('type', $(this).prop('checked') ? 'text' : 'password');
        });
      });
    </script>
  </c:param>

  <c:param name="content">
    <style>
      @media screen and (max-width: 600px) {
        .form-floating {
          margin-left: 1rem !important;
          margin-right: 1rem !important;
        }

        .form-control {
          font-size: 1rem !important;
          padding: 0.75rem !important;
        }

        .btn-login {
          width: 90% !important;
          font-size: 1.1rem;
          padding: 1rem 0 !important;
        }

        .anim-box.kiran {
          padding: 1rem 1rem;
          max-width: 90%;
        }

        #wrap_box {
          width: 100%;
        }
      }

      .kurukuru-poyoyon {
        display: inline-block;
        opacity: 0;
        animation: kurukuru 1.4s ease-out forwards, poyoyon2 1s ease-in-out 1.5s forwards;
      }

      @keyframes kurukuru {
        0% {
          transform: rotateY(0deg) translateY(40px);
          opacity: 0;
        }
        100% {
          transform: rotateY(360deg) translateY(0);
          opacity: 1;
        }
      }

      @keyframes poyoyon2 {
        0% {
          transform: scale(1.0, 1.0) translate(0, 0);
          opacity: 1;
        }
        15% {
          transform: scale(0.98, 0.9) translate(0, 5px);
        }
        30% {
          transform: scale(1.02, 1.0) translate(0, 8px);
        }
        50% {
          transform: scale(0.98, 1.05) translate(0, -8px);
        }
        70% {
          transform: scale(1.0, 0.9) translate(0, 5px);
        }
        100% {
          transform: scale(1.0, 1.0) translate(0, 0);
        }
      }

      .anim-box.kiran {
        position: relative;
        overflow: hidden;
        display: inline-block;
        background-color: #f1f2f3;
        padding: 1rem 4rem;
        width: 100%;
        max-width: 600px;
        text-align: center;
      }

      .anim-box.kiran::before {
        content: "";
        position: absolute;
        top: -100px;
        left: 0;
        width: 30px;
        height: 100%;
        background-color: #fff;
        opacity: 0;
        animation: kiran 3.3s linear infinite;
        pointer-events: none;
      }

      @keyframes kiran {
        0% {
          transform: scale(2) rotate(45deg);
          opacity: 0;
        }
        10% {
          transform: scale(20) rotate(45deg);
          opacity: 0.8;
        }
        20% {
          transform: scale(30) rotate(45deg);
          opacity: 0.4;
        }
        30% {
          transform: scale(45) rotate(45deg);
          opacity: 0.2;
        }
        40% {
          transform: scale(60) rotate(45deg);
          opacity: 0;
        }
        100% {
          transform: scale(60) rotate(45deg);
          opacity: 0;
        }
      }

      .btn-login {
        width: 250px;
        background-color: skyblue;
        border-radius: 4px;
        color: #fff;
        display: block;
        font-size: 20px;
        font-weight: bold;
        text-align: center;
        text-decoration: none;
        margin: 10px auto;
        padding: 30px 0;
        box-shadow: 0 5px 0 rgba(0,0,0,0.2);
        text-shadow: 1px 1px 1px #333;
        border: none;
        cursor: pointer;
        transition: all 0.3s ease;
      }

      .btn-login:hover {
        box-shadow: none;
        transform: translate3d(0, 5px, 0);
        transition-duration: 0.6s;
        opacity: 0.8;
        text-shadow: none;
      }
    </style>

    <section class="text-center m-auto border pb-3" style="max-width: 500px; width: 90%;">
      <form action="LoginExecute.action" method="post">
        <div id="wrap_box">
          <h2 class="h3 mb-3 fw-normal anim-box kiran mx-auto">
            <span class="kurukuru-poyoyon">ログイン</span>
          </h2>

          <c:if test="${errors.size()>0}">
            <div>
              <ul>
                <c:forEach var="error" items="${errors}">
                  <li>${error}</li>
                </c:forEach>
              </ul>
            </div>
          </c:if>

          <div>
            <div class="form-floating mx-5">
              <input class="form-control px-5 fs-5" autocomplete="off"
                id="id-input" maxlength="20" name="id" placeholder="半角でご入力下さい"
                style="ime-mode: disabled" type="text" value="${id}" required />
              <label>ＩＤ</label>
            </div>

            <div class="form-floating mx-5 mt-3">
              <input class="form-control px-5 fs-5" autocomplete="off"
                id="password-input" maxlength="20" name="password"
                placeholder="20文字以内の半角英数字でご入力下さい" style="ime-mode: disabled"
                type="password" required />
              <label>パスワード</label>
            </div>

            <div class="form-check mt-3">
              <label class="form-check-label" for="password-display">
                <input class="form-check-input" id="password-display" name="chk_d_ps" type="checkbox" />
                パスワードを表示
              </label>
            </div>
          </div>

          <div class="mt-4">
            <input class="btn-login" type="submit" name="login" value="ログイン"/>
          </div>
        </div>
      </form>
    </section>
  </c:param>
</c:import>
