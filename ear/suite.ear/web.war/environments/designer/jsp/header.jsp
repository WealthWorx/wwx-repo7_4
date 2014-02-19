<%@ include file="/portal/include/include_java.jsp" %>
<%@ page import="com.appiancorp.ap2.environment.EnvironmentUtils.Environment"%>
<c:import url="/portal/navcontrol.do" charEncoding="UTF-8"/>

<fmt:setBundle basename="text.jsp.framework.header" />
<c:set var="aeDisplayAlt">
  <b:message key="DesignerEnvironmentDisplayName" bundle="ap-app-i18n"/>
</c:set>
<%pageContext.setAttribute("logopath", ConfigurationFactory.getConfiguration(SuiteConfiguration.class).getLogoPath());%>

<c:set var="userLocale"
  value="${sessionScope['javax.servlet.jsp.jstl.fmt.locale.session']}" />
<c:set var="currentLocaleString"><%-- Has to be a one liner otherwise the line breaks get encoded too --%>
  <c:out value='${userLocale.language}'/><c:if test="${!empty userLocale.country}">_<c:out value='${userLocale.country}'/></c:if><c:if test="${!empty userLocale.variant}">_<c:out value='${userLocale.variant}'/></c:if>
</c:set>

<div id="environmentHeader">
  <div id="applicationLogo">
    <a hidefocus="true" href="#" onclick="backgroundPage('/portal/getGlobalHomePage.do'); return false;">
      <p:img page="${logopath}" alt="${PORTAL_APP_CONFIG.appname}" height="26px" />
    </a>
  </div>

  <div class="topNavigationControls">
    <a hidefocus="true" href="<%=request.getContextPath()%>/tempo" class="headerTempoIcon" title='<fmt:message key="LaunchTempo"/>' target="tempoWindow">Tempo</a>
    <a hidefocus="true" href="#" class="sprite alerts" onclick="backgroundPage('/portal/newnotifications.do'); return false;"><fmt:message key="Alerts"/>&nbsp;<span class="notificationCount"></span></a> 
    <a hidefocus="true" href="#" class="sprite preferences" onclick="backgroundAction('/portal/updateUserPreferences.do','asiDialog'); return false;" title='<fmt:message key="ClickToModifyPref"/>'><asi:out encoding="html" value="${upfs.username}"/></a> 
    <%pageContext.setAttribute("customdesignerlinks", ConfigurationFactory.getConfiguration(SuiteConfiguration.class).getCustomDesignerLinksPath());%>
     <c:if test="${!empty customdesignerlinks}">
       <c:import url="${customdesignerlinks}" charEncoding="UTF-8"/>
    </c:if>
    <a hidefocus="true" href="#" class="sprite logout" onclick="logout(); return false;"><fmt:message key="SignOut"/></a>
    <c:set var="appsUrl"><%= Environment.APPS_PORTAL.getEntryPoint() %></c:set>
      	<c:set var="userLocale" value="${sessionScope['javax.servlet.jsp.jstl.fmt.locale.session']}"/>
  <%pageContext.setAttribute("showappsportal", ConfigurationFactory.getConfiguration(NavigationConfiguration.class).showAppsPortal());%>
  <c:if test="${!empty showappsportal}">
    <c:if test="${showappsportal}">
      <c:choose>
        <c:when test="${sessionScope['javax.servlet.jsp.jstl.fmt.locale.session'] == 'ar'}">
          <a hidefocus="true" href="#" class="launchlink" title="<fmt:message key="OpenEndUserPortal" />" onclick="popup('<asi:url value="${appsUrl}" environment="apps" />', 'userportalWindow', 'width=900,height=720,directories=yes,location=yes,menubar=yes,resizable=yes,scrollbars=yes,status=yes,titlebar=yes,toolbar=yes', false, false); return false;"class="launch" target="_blank"><p:img page="/framework/img/launch_portal_1-ar.gif" ignoreLowBandwidth="true" alt="" /><span class="launchtext"><fmt:message key="LaunchPortal"/></span><p:img page="/framework/img/launch_portal_3-ar.gif" ignoreLowBandwidth="true" alt="" /></a>
        </c:when>
        <c:otherwise>
          <a hidefocus="true" href="#" class="launchlink" title="<fmt:message key="OpenEndUserPortal" />" onclick="popup('<asi:url value="${appsUrl}" environment="apps" />', 'userportalWindow', 'width=900,height=720,directories=yes,location=yes,menubar=yes,resizable=yes,scrollbars=yes,status=yes,titlebar=yes,toolbar=yes', false, false); return false;"class="launch" target="_blank"><p:img page="/framework/img/launch_portal_1.gif" ignoreLowBandwidth="true" alt="" /><span class="launchtext"><fmt:message key="LaunchPortal"/></span><p:img page="/framework/img/launch_portal_3.gif" ignoreLowBandwidth="true" alt="" /></a>
        </c:otherwise>
      </c:choose>
    </c:if>
  </c:if>
  </div>
  <div class="clearboth"></div>
</div>