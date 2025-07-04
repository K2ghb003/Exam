<%-- ログインJSP --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:import url="/common/base.jsp">
	<c:param name="title">
		得点管理システム
	</c:param>

	<c:param name="scripts">
		<script type="text/javascript">
			$(function() {
				$('#password-display').change(function() {
					if ($(this).prop('checked')) {
						$('#password-input').attr('type', 'text');
					} else {
						$('#password-input').attr('type', 'password');
					}
				});
			});
		</script>

		<style>
		.btn a {
		  position: relative;
		  display: block;
		  width: 280px;
		  padding: 15px 0;
		  background-color: #007bff; /* 青色 */
		  font-size: 14px;
		  font-weight: 700;
		  color: #fff;
		  line-height: 1.6;
		  text-decoration: none;
		  text-align: center;
		  transition: .2s;
		  box-sizing: border-box;
		  border-radius: 5px;
		}
		.btn a::after {
		  content: '';
		  position: absolute;
		  top: 0;
		  bottom: 0;
		  right: 25px;
		  width: 9px;
		  height: 9px;
		  margin: auto;
		  border-top: 2px solid #fff;
		  border-right: 2px solid #fff;
		  transform: rotate(45deg);
		  transition: .2s;
		  box-sizing: border-box;
		}
		.btn-3d a {
		  bottom: 7px;
		  box-shadow: 0 7px #0056b3; /* 濃い青の影 */
		}
		.btn-3d a:hover {
		  bottom: 0;
		  box-shadow: 0 0 #0056b3;
		}
		</style>
	</c:param>

	<c:param name="content">
		<section class="w-75 text-center m-auto border pb-3">
			<form action="LoginExecute.action" method="post">
				<div id="wrap_box">
					<h2 class="h3 mb-3 fw-norma bg-secondary bg-opacity-10 py-2">ログイン</h2>

					<c:if test="${errors.size()>0}">
						<div>
							<ul>
								<c:forEach var="error" items="${errors}">
									<li>${error}</li>
								</c:forEach>
							</ul>
						</div>
					</c:if>

					<!-- ＩＤ -->
					<div class="form-floating mx-5">
						<input class="form-control px-5 fs-5" autocomplete="off"
							id="id-input" maxlength="20" name="id" placeholder="半角でご入力下さい"
							style="ime-mode: disabled" type="text" value="${id}" required />
						<label>ＩＤ</label>
					</div>

					<!-- パスワード -->
					<div class="form-floating mx-5 mt-3">
						<input class="form-control px-5 fs-5" autocomplete="off"
							id="password-input" maxlength="20" name="pass"
							placeholder="パスワードを入力してください" style="ime-mode: disabled"
							type="password" required />
						<label>パスワード</label>
					</div>

					<!-- パスワード表示 -->
					<div class="form-check text-start mx-5 mt-2">
						<input type="checkbox" id="password-display"
							class="form-check-input" />
						<label class="form-check-label">パスワードを表示</label>
					</div>

					<!-- カスタム3Dログインボタン（青） -->
					<div class="btn btn-3d mt-4 mx-auto">
						<a href="main/Menu.action" onclick="this.closest('form').submit()">ログイン</a>
					</div>
				</div>
			</form>
		</section>
	</c:param>
</c:import>
