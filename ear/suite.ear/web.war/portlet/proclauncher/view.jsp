<%@ include file="/portal/include/include_java.jsp" %>

<c:choose>
  <%-- 
    #39107: If we just launched a process and the portlet configuration is set to refresh the page afterwads, then do not 
    render right now the contents of this portlet right now. Invoke the backgroundAction to re-render the whole page, then
    the contents of this portlet will be rendered. 
   --%>
  <c:when test="${requestScope.hasProcessBeenLaunched == 'true' && ap_portlet_proclauncher_form.refreshPage == 'true'}">
    <script type="text/javascript">if (window.name!='fProcess') {
      var url = '<asi:url value="/portal.do" keepDashboardContext="true"><asi:param name="$p" value="${$p}"/></asi:url>';
      url = "/"+url.substring(CONTEXT_PREFIX.length);
      backgroundAction(url,null,function() {
        STATUS.message('<asi:out encoding="js" value="${requestScope.ap_success_message}"/>')
      });
    }</script>
  </c:when>
  <c:otherwise>
    <script>
      var successMessage = '<asi:out encoding="js" value="${requestScope.ap_success_message}"/>';
      if (!StringUtils.isBlank(successMessage)) {
        // The message will be blank the first time we visit the page. Once we start a process and return to this portlet,
        // the status message will be populated. 
        STATUS.message(successMessage); 
      }
      importStyleSheetWithSkin('/portlet/proclauncher/css/proclauncher.css');
    </script>

    <fmt:setBundle basename="text.jsp.portlet.proclauncher.view"/>
    <% String newline = "\r\n"; pageContext.setAttribute("newline", newline); %>

    <sp:portalState var="ps" />
    <c:set var="chid" value="${ps.currentPortletId}"/>
    <c:if test="${!empty ap_portlet_proclauncher_form.processModel.name}">
      <c:set var="modelName"><asi:localeString value="${ap_portlet_proclauncher_form.processModel.name}"/></c:set>
    </c:if>
    <c:set var="portletTarget" scope="request" value="true"/>
    <c:set var="usingStartForm" value="${ap_portlet_proclauncher_form.hasStartForm && !ap_portlet_proclauncher_form.skipStartForm}"/>
    
    <c:choose>
      <c:when test="${usingStartForm && !ap_portlet_proclauncher_form.popStartForm}">
        <c:set var="ap_processModelId" scope="request" value="${ap_portlet_proclauncher_form.processModel.id}"/>
        <c:set var="portletId" scope="request" value="${chid}"/>
        <c:set var="inProcLauncher" scope="request" value="${ap_portlet_proclauncher_form.hasStartForm}"/>
        <c:import url="/process/proclauncher/configureprocess.do?processModelId=${ap_portlet_proclauncher_form.processModel.id}&$p=${ps.currentPageId}&$i=${chid}" charEncoding="UTF-8"/>
      </c:when>
      <c:otherwise>
        <c:set var="tmpPortletTarget" value="${portletTarget}"/>
        <c:if test="${usingStartForm}">
          <c:set var="tmpPortletTarget" value="true"/>
        </c:if>

        <c:set var="linkButtonLabel">
          <c:choose>
            <c:when test="${!empty ap_portlet_proclauncher_form.startLabel}" ><c:out value="${ap_portlet_proclauncher_form.startLabel}" escapeXml="false"/></c:when>
            <c:otherwise><fmt:message key="Launch"><fmt:param value="${modelName}" /></fmt:message></c:otherwise>
          </c:choose>
        </c:set>

        <span class="procLauncherNoForm">
        <asi:form action="/process/startprocess.do" update="true" name="ap_portlet_proclauncher_form"
          bundle="p-errors" portletTarget="${tmpPortletTarget}" useTextBundle="false" id="noStartForm_form_${chid}">

          <input type="hidden" name="redirect" value="<c:out value='${redirect}'/>"/>
          <input type="hidden" name="hasStartForm" value="<c:out value='${ap_portlet_proclauncher_form.hasStartForm}'/>"/>
          <input type="hidden" name="skipStartForm" value="<c:out value='${ap_portlet_proclauncher_form.skipStartForm}'/>"/>
          <input type="hidden" name="popStartForm" value="<c:out value='${ap_portlet_proclauncher_form.popStartForm}'/>"/>
          <input type="hidden" name="processModelId" value="<c:out value="${ap_portlet_proclauncher_form.processModel.id}"/>"/>
          <c:choose>
          <c:when test="${ap_portlet_proclauncher_form.useButton}">
            <asi:buttonset>
              <asi:button type="button" value="${linkButtonLabel}" onclick="startProcessModel_${chid}(this.form);" useTextBundle="false"/>
             </asi:buttonset>
          </c:when><c:otherwise>
            <asi:link href="#" onclick="startProcessModel_${chid}($$('noStartForm_form_${chid}'));" useTextBundle="false"><c:out value="${linkButtonLabel}" /></asi:link>
          </c:otherwise>
          </c:choose>

          <c:forTokens items="${ap_portlet_proclauncher_form.instructions}" delims="${newline}" var="line">
            <asi:formText text="${line}" useTextBundle="false"/>
          </c:forTokens>
        </asi:form>
        </span>

        <p:portalRequest var="pq" />
        <c:set var="configureprocessUrl"><asi:url value="/process/proclauncher/configureprocess.do" decorator="simplepopup" keepDashboardContext="true">
          <asi:param name="processModelId" value="${ap_portlet_proclauncher_form.processModel.id}"/>
          <asi:param name="inpopupwindow" value="${ap_portlet_proclauncher_form.popStartForm}"/>
          <asi:param name="portalPageId" value="${ap_portlet_proclauncher_form.portalPageId}"/>
          <asi:param name="portletId" value="${chid}"/>
          <asi:param name="com.appian.page.data.ctx.type.id" value="${pq.currentPortalPage.dataContextTypeId}"/>
          <asi:param name="$p" value="${ps.currentPageId}"/>
          <asi:param name="redirect" value="${redirect}"/>
        </asi:url></c:set>
    
        <script type="text/javascript">
        var chid = "<asi:out encoding="js" value="${chid}"/>";
        window["startProcessModel_{0}".supplant(chid)] =  function(form) {
          if(form.hasStartForm == null || form.skipStartForm == null) { return false; }
          if(form.hasStartForm.value == "false" || form.skipStartForm.value == "true") {
            // No start form display, the button/link should just kick off the process.
            <c:choose>
              <c:when test="${redirect == 'inchannel'}">
                form.$t.value = "/process/proclauncherstartprocess.do?isPopup=false";
              </c:when>
              <c:when test="${redirect == 'portalpage'}">
                var portalPageId = encodeURIComponent("<asi:out encoding="js" value='${ap_portlet_proclauncher_form.portalPageId}' />");
                form.$t.value = "/process/proclauncherstartprocess.do?isPopup=false&portalPageId="+portalPageId;
              </c:when>
              <c:otherwise>
                form.$t.value = "/process/proclauncherstartprocess.do?isPopup=false";
              </c:otherwise>
            </c:choose>
            form.submit();
          } else {
            // The button/link should pop up the start form.
            // In case that you need to send the portletId (${i}) as parameter in the URL, see T36831 first.
            url = '<asi:out value="${configureprocessUrl}" encoding="js"/>';
            // popup(url, "startFormWin", 'width=800,height=500,scrollbars=yes,resizable=yes,toolbar=no');
    	    popup(url, "startFormWin", 'width='+(2*screen.width/3)+',height='+screen.height+',left='+(screen.width/6)+',scrollbars=yes,resizable=yes,toolbar=no');
          }
        };
        </script>
      </c:otherwise>
    </c:choose>
  </c:otherwise>
</c:choose>
