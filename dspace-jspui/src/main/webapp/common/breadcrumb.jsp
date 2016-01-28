<%@ include file="/common/taglib.jsp"%>
<div class="breadcrumb-line">
	<form name="breadcrumbsForm" id="breadcrumbsForm" method="post">
		<ul class="breadcrumb">
		<c:forEach items="${breadcrumbList}" var="breadcrumb">
			<li><c:if test="${breadcrumb.method=='POST'}">
					<c:set var="action">onclick="javascript:invia('<c:url
							value="${breadcrumb.url}?breadcrumbId=${breadcrumb.position}&${breadcrumb.queryString}" />')"</c:set>
				</c:if> <c:if test="${breadcrumb.method=='GET'}">
					<c:set var="action">href="<c:url
							value="${breadcrumb.url}?breadcrumbId=${breadcrumb.position}&${breadcrumb.queryString}" />"</c:set>
				</c:if> <a ${action}><fmt:message key="breadcrumbs.${breadcrumb.tag}" /></a>
			</li>
		</c:forEach>
		</ul>
	</form>
	<div class="visible-xs breadcrumb-toggle">
		<a class="btn btn-link btn-lg btn-icon" data-toggle="collapse"
			data-target=".breadcrumb-buttons"><i class="icon-menu2"></i></a>
	</div>
	<ul class="breadcrumb-buttons collapse">
		<li class="language dropdown">
			<c:set var="currentLocale"><%= org.springframework.web.servlet.support.RequestContextUtils.getLocale(request).getLanguage()%></c:set>
			<a class="dropdown-toggle" data-toggle="dropdown">
				<img src="/${SR_MODULE_NAME}/cineca/images/flag/flag_${currentLocale}.png" alt="<fmt:message key="flag.${currentLocale}"/>" title="<fmt:message key="flag.${currentLocale}"/>"/> <span><fmt:message key="flag.${currentLocale}"/></span> <b class="caret"></b>
			</a>
			<ul class="dropdown-menu dropdown-menu-right icons-right">
				<li><a href="javascript:changeLanguage('${I18N_BASE}');" ><img src="/${SR_MODULE_NAME}/cineca/images/flag/flag_${I18N_BASE}.png" alt="<fmt:message key="flag.${I18N_BASE}"/>" title="<fmt:message key="flag.${I18N_BASE}"/>"/><fmt:message key="flag.${I18N_BASE}"/></a></li>
				<c:forEach items="${fn:split(I18N_LIST,',')}" var="language">
					<li><a href="javascript:changeLanguage('${language}');" ><img src="/${SR_MODULE_NAME}/cineca/images/flag/flag_${language}.png" alt="<fmt:message key="flag.${language}"/>" title="<fmt:message key="flag.${language}"/>"/><fmt:message key="flag.${language}"/></a></li>
				</c:forEach>
			</ul>
		</li>
	</ul>
	<script type="text/javascript">
		var languageChangeArray = [ 'jspui'];
		var languageChangeMap=new Object();
		$.each(languageChangeArray, function(index, value) { 
			languageChangeMap[value]=false;
		});
		function changeLanguage(language) {
			$('body').append('<div class="overlay"><div class="opacity"></div><i class="icon-spinner2 spin"></i></div>');
			$('.overlay').fadeIn(150);
			$.each(languageChangeMap, function(module, value) { 
				$.ajax({
					url: ((module.substring(0, 1) == "/") ? "" : "/") +module+"/language/change.ajax",
					dataType: "text",		
					contentType: "application/x-www-form-urlencoded;charset=UTF-8",													
					data: {
						changeLocale: language,
						RAND: Math.random(9999)
					},
					success: function(data,extStatus, errorThrown) {
						languageChangeMap[module]=true;
					},
					error: function(data,extStatus, errorThrown) {
					}
				});
			});
			checkModuleCalls(languageChangeMap);
			window.setTimeout("location.reload();",2000);
		}
	</script>
</div>