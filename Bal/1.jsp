
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>

<head>

		<title>SNU Authentication</title>


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />


<style type="text/css">.mystyle1 { FONT-FAMILY:Arial;FONT-SIZE:10;}.text1 {  font-family: Arial; font-size: 11px}
</style>
<style type="text/css">
.otpclass{display:none;}.phoneclass{display:none;}.captchaclass{display:none;}
#logingetotpbtn:disabled{background: #ccc;}#registergetotp:disabled{background: #ccc;}
</style>
<style type="text/css">
   <!--
     body {
     height: 100%;
     margin: 0;
     padding: 0;
    }
   //-->
  </style>

	<link rel="stylesheet" href="/css/cyberoam.css" />
	<link rel="stylesheet" href="/css/fck_editorarea.css" />


<link rel="shortcut icon" type="image/x-icon" href="/images/favicon.ico" />
<script language="JavaScript" src="/javascript/cyberoam.js"></script>
<!--
 Google OAuth OTP Flow GVK Mumbai Airport
<script language="JavaScript" src="/javascript/googleOAuth.js"></script>
<script language="JavaScript" src="http://184.168.20.115/zeta/js/jquery.min.js"></script>
<script language="JavaScript" src="https://apis.google.com/js/client.js"></script>
 -->
<script type="text/javascript" src="/javascript/utilities.js"></script>
<!-- script language="JavaScript" src="/javascript/usagecounter.js"></script-->
<script type="text/javascript" src="/javascript/ajax.js"></script>

<script type="text/javascript">
	var MAC_DYNAMIC_USER = "786";
	var serverContextPath = "/24online";
	var VALIDATELOGINCAPTCHA = "1013";
	var VALIDATEOTPFORMACBASEDUSER = "1019";
	var MACADDRESS = "null";
	var isSingleBox = true;
	var AJAXPROXYURL = "/24online/webpages/ajaxproxy.jsp";
	var CHECKCAPTCHAFORMACBASEDUSER = "1021";
	var CHECKOTPCAPTCHAFORMACBASEDUSER = "1018";
	var CHECKFOROTP = "1014";
	var HTTPCLIENTAUTHENTICATE = "191";
	var isResetPasswordOn = false;
	var isMACBasedUser = false;
	var CHECKFORLOGINCAPTCHA = "1020";
	var GETLOGINCAPTCHA = "1017";
	var GETLOGINOTP = "1015";
	var VALIDATELOGINOTP = "1012";
	var VALIDATELOGINCAPTCHA = "1013";
	var SENDREGISTEROTP = "1016";
	var GETLOGINCAPTCHA = "1017";
	var VALIDATEUSERNAME = "624";
</script>
<script type="text/javascript" src="/javascript/otpcaptcha.js"></script>

<script type="text/javascript">
	re = /\w{1,}/;
	rew=/\W{1,}/;
	usernamere=/^[a-zA-Z0-9_\.]{1,30}$/;

	var hotelUserWin = null;
	var dt = new Date();

	dt.setHours("16");
	dt.setMinutes("21");
	dt.setSeconds("1");
	dt.setDate("22");
	dt.setMonth("7");
	dt.setYear("2017");
	var d=new Date();

	function openMyAccountWindow(){
	
		var profileName = document.getElementById("profileName");
		var url="/24online/myaccount.jsp";
		if(profileName!=null && profileName !==  undefined &&  profileName != 'null'){
			url=url+"?profileName="+profileName.value;
		}
		window.open(url,'_person');
	}

	function changeBandwidth(){
		var scrw = window.screen.availWidth;
		var scrh = window.screen.availHeight;
		var w =scrw-120;
		var h =scrh-150;
		var left = (scrw-w)/2;
		var top = 5;
		window.open("/24online/webpages/redirectclientgui.jsp?key=ChangeBWOnDemandURL&username=null",'_blank','screenX=0,screenY=0,left='+left+',top='+top+',width=' + w + ',height=' + h +  ',titlebar=0,scrollbars=1');
	}

	function doNothing(){

	}


	/* call to ajax */
	function showAlert(){
		
	}

	/* this function get the message from XML document  */
	function popup(){

		var xmlDoc = req.responseXML.documentElement;
		var message = xmlDoc.getElementsByTagName("message");
		message = message[0].firstChild.data;
		var dtold = new Date();
		alert(message);
		var dtnew = new Date();
		var timeGap=dtnew.getTime()-dtold.getTime();
		timeGap=parseInt(timeGap/1000);
		document.forms[0].popupalert.value="0";
		document.forms[0].sessionTimeout.value=document.forms[0].sessionTimeout.value-timeGap;
	}

	/* this get the Data related to usage from XML */
	function getData(){

		//alert("get Data");
		var xmlDoc = req.responseXML.documentElement;

		var input = xmlDoc.getElementsByTagName("input");
		input = input[0].firstChild.data;

		var output = xmlDoc.getElementsByTagName("output");
		output = output[0].firstChild.data;

		var total = xmlDoc.getElementsByTagName("total");
		total = total[0].firstChild.data;

		var timeout = xmlDoc.getElementsByTagName("timeout");
		timeout = timeout[0].firstChild.data;

		var logout=xmlDoc.getElementsByTagName("logout");
		logout = logout[0].firstChild.data;

		var useddatatransfer = xmlDoc.getElementsByTagName("useddatatransfer");
		useddatatransfer = useddatatransfer[0].firstChild.data;
		document.getElementById('useddatatransfer').innerHTML =ByteConversion( useddatatransfer);

		var expiredate = xmlDoc.getElementsByTagName("expiredate");
		expiredate = expiredate[0].firstChild.data;
		document.getElementById('expiredate').innerHTML = expiredate;

		var packageamount = xmlDoc.getElementsByTagName("packageamount");
		packageamount = packageamount[0].firstChild.data;
		document.getElementById('packageamount').innerHTML = packageamount;

		if(logout==1){
			logoutUser();
			return;
		}


		/* unlimited usage for unlimited time */
		if(input==-1 && output==-1 && total==-1 && timeout==-1){

			document.getElementById("inOctets").innerHTML="Not Applicable";
			document.getElementById("outOctets").innerHTML="Not Applicable";
			document.getElementById("totalOctets").innerHTML="Not Applicable";
			document.getElementById("outOctets").innerHTML="Not Applicable";
		}

		/* only total is availabe*/
		if(total > 0){
			var str=ByteConversion(total);
			document.getElementById("totalOctets").innerHTML=str;
			document.getElementById("inOctets").innerHTML="Not Applicable";
			document.getElementById("outOctets").innerHTML="Not Applicable";

		}else{

			document.getElementById("totalOctets").innerHTML="Not Applicable";

			if(input > 0){
				var str=ByteConversion(input);
				document.getElementById("inOctets").innerHTML=str;
			}else{
				document.getElementById("inOctets").innerHTML="Unlimited";
			}

			if(output > 0){
				var str=ByteConversion(output);
				document.getElementById("outOctets").innerHTML=str;

			}else{
				document.getElementById("outOctets").innerHTML="Unlimited";
			}
		}

		if(timeout > 0 ){
			getTime(timeout);
		}else if(timeout==-1){

			document.getElementById("sessionTime").innerHTML="Not Applicable";
			document.forms[0].sessionTimeout.value="Not Applicable";

		}
	}

	numCheck = new RegExp('^[0-9]{1,}$');
	rePhone = /[^0-9]/;

	function validate(){
		phoneNum=document.getElementById('Phone').value;
		var securitycode=document.getElementById('textfield').value;
		if(trimAll(phoneNum)==''){
			alert('Mobile No. Required');
			return false;
		}
		phoneNum = trim(phoneNum);
		if(phoneNum != '' && (rePhone.test(trim(phoneNum)) || phoneNum.length != 10)){
			alert('Specify correct Phone number');
			return false;
		}
		if(trimAll(securitycode)==''){
			alert('Security Code Required');
			return false;
		}
		loadValidateSecurityCode();
		return false;
	}

	function loadValidateSecurityCode() {
		var phoneNum=document.getElementById('Phone').value;
		var securitycode=document.getElementById('textfield').value;
		if (trim(phoneNum) != '' && trim(securitycode) != ''){
			securitycode= trim(securitycode);
			var url =	'/24online/servlet/AjaxManager?mode=581&phone='+phoneNum+'&securitycode='+securitycode;
			var funToCall = parseValidateSecurityCode;
			AJAXRequestWithProxy(url,funToCall,errorfun_validatesecuritycode);
		}
	}
	function parseValidateSecurityCode(){
		var xmlDoc = req.responseXML.documentElement;
		var message = xmlDoc.getElementsByTagName('message');
		message = message[0].firstChild.data;
		if(message == 'valid'){
			var username = xmlDoc.getElementsByTagName('username');
			var password = xmlDoc.getElementsByTagName('password');
			document.getElementById('username').value = username[0].firstChild.data;
			document.getElementById('password').value = password[0].firstChild.data;
			document.regform.submit();
		}else{
			alert('Invalid security code entered');
		}
	}

	function loadValidateNumber() {
		var phoneNum=document.getElementById('Phone').value;
		if(trimAll(phoneNum)==''){
			alert('Mobile No. Required');
			return false;
		}
		if (trim(phoneNum) != '' ){
			phoneNum = trim(phoneNum);
			if(rePhone.test(trim(phoneNum)) || phoneNum.length != 10){
				alert('Specify correct Phone number');
				return false;
			}
			var url = '/24online/servlet/AjaxManager?mode=580&phone='+phoneNum;
			var funToCall = parseValidateNumber;
			AJAXRequestWithProxy(url,funToCall,errorfun_validatephone);
			return true;
		}
	}
	function parseValidateNumber(){
		var xmlDoc = req.responseXML.documentElement;
		var message = xmlDoc.getElementsByTagName('message');
		message = message[0].firstChild.data;
		if(message == 'invalid'){
		}else{
			var securitycode = xmlDoc.getElementsByTagName('securitycode');
			securitycode = securitycode[0].firstChild.data;
		}
	}
	function errorfun_validatephone(){
		alert('Error in validating phone number');
	}
	function errorfun_validatesecuritycode(){
		alert('Error in validating security code');
	}

	function assignPrimiumPackage(){
		var username=document.getElementById('username').value;
		var password=document.getElementById('password').value;
		var url = '/24online/servlet/AjaxManager?mode=2002&username='+username+'&password='+password;
		var funToCall = parseAssignPrimiumPackage;
		AJAXRequestWithProxy(url,funToCall,errorfun_assignPrimiumPackage);
	}
	function parseAssignPrimiumPackage(){
		var xmlDoc = req.responseXML.documentElement;
		var message = xmlDoc.getElementsByTagName('message');
		message = message[0].firstChild.data;
		if(message == 'valid'){
			document.loginform.submit();
		}else{
			alert('Error while performing Change Package');
		}
	}
	function errorfun_assignPrimiumPackage(){
		alert('Error while assign Package');
	}

	/* this function get the time from XML document  */
	function getTime(timeout){
		var newSessiontime=timeout;
		var orgSessiontime = parseInt(document.forms[0].orgSessionTimeout.value);
		var Sessiontime=parseInt(document.forms[0].sessionTimeout.value);
		var diffSessiontime = orgSessiontime - Sessiontime;
		newSessiontime=newSessiontime-diffSessiontime;
		document.forms[0].sessionTimeout.value = newSessiontime;
		document.forms[0].orgSessionTimeout.value = timeout;
	}

	function err(){

	}

	/* detect touch in iPad and other touch sensitive device */
	try{
	document.addEventListener('touchstart', function(event) {
	//ï¿½ ï¿½ alert(event.touches.length);

			if(document.forms[0].chrome.value==0 && false){
				byteReducer();
				document.forms[0].chrome.value=1;
			}
		}, false);
	}catch(err){

	}

	/* This function call when body has focus and set the value */
	function gotFocus(){
		if(document.forms[0].chrome.value==0 && false){
			byteReducer();
			document.forms[0].chrome.value=1;
		}
	}

	/* This function call when body has focus */
	function lostFocus(){

		/*if(isChrome()){
			document.forms[0].chrome.value=0;
		}*/
	}


	/* this function call the ajax for byte reducer */
	function startByteReducer(){
		document.forms[0].chrome.value=0;
		setTimeout("startByteReducer()",600000);
	}


	/* call to ajax */
	function  byteReducer(){
		//alert("byte reducer start");
		
	}

	function setCurrentTimeDate(){
		dt.setMinutes(dt.getMinutes()+1);
		var date= getDayOfWeek(dt.getDay())+" , "+dt.getDate()+" "+getMonth(dt.getMonth())+" , "+dt.getFullYear();
		var time=dt.getHours()+" : "+dt.getMinutes()+" hours";
		var lblTime=document.getElementById('time');
		var lblDate=document.getElementById('date');
		if(lblTime!=null){
			lblTime.innerHTML = time;
		}
		if(lblDate!=null){
			lblDate.innerHTML = date;
		}
		setTimeout("setCurrentTimeDate()",60000);
	}
	function liverequest_done() {
		var textContent = req.responseXML;
		if(textContent != null && textContent != "") {
			var xmlDoc = req.responseXML.documentElement;
			var logoutstatus = xmlDoc.getElementsByTagName("logoutstatus");
			if(logoutstatus.length > 0 && logoutstatus[0].firstChild !== undefined && logoutstatus[0].firstChild != null) {
				logoutstatus = logoutstatus[0].firstChild.data;
			}
			else {
				logoutstatus = false;
			}
			var message = xmlDoc.getElementsByTagName("message");
			if(message.length > 0 && message[0].firstChild !== undefined && message[0].firstChild != null) {
				message = message[0].firstChild.data;
			}
			else {
				message = "";
			}
			if(logoutstatus == "true") {
				if(message != null && message!= "") {
					alert(message);
				}
				location.href="/24online/webpages/client.jsp?logoutstatus=true&message="+message+"&livemessage="+message;
			}
			else {
				if(message != null && message!= "") {
					alert(message);
				}
			}
		}
	}
	function refreshLiveRequest(liveRequestTime,isfirsttime){
		setTimeout("refreshLiveRequest("+liveRequestTime+",false)",liveRequestTime);
		AJAXRequest_async('/24online/webpages/liverequest.jsp?username=null&isfirsttime='+isfirsttime,liverequest_done,liverequest_done);
	}
	// SEND LIVE UPDATE REQ TO A PORT WHERE NO PROCESSING OCCURS SO THAT LOAD ON APACHE IS REDUCED
	// AND THIS ALSO KEEPS THE USER LIVE TO AVOID IDLE-TIMEOUT.
	function sendLiveUpdate(isfirsttime){
		if(isfirsttime == '1'){
			isfirsttime = '0';
		}else{
			iframeliveupd.location.href='http://192.168.50.1:9090/';
		}
		setTimeout("sendLiveUpdate("+isfirsttime+")",180000);
	}

	function validateLogout(){
		document.forms[0].mode.value='193';
		document.forms[0].checkClose.value='1';
	}


	function validateLogin() {
		
			
				if (!(re.test(document.forms[0].username.value))){
					alert('Please enter the User Name');
					document.forms[0].username.focus();
					return false;
				}
				if(document.forms[0].username.value.length > 50){
					alert('Username can not be more than 50 character');
					document.forms[0].username.value='';
					document.forms[0].username.focus();
					return false;
				}
			
			
				if(document.forms[0].password.value==''){
					alert('please enter password');
					document.forms[0].password.focus();
					return false;
				}
			
			targ=document.getElementsByName('chkcond')[0];
			if(targ != null && !document.forms[0].chkcond.checked){
				alert('Please Read and Agree Terms and Conditions.');
				document.forms[0].chkcond.focus();
				return false;
			}
			if(document.clientloginform.loginotp !== undefined) {
				checkLoginOTPCaptcha();
				return false;
			}
		
	}

	function fetchUserFromPassword() {
		form = document.forms[0];
	    var url = "/24online/servlet/AjaxManager?mode=2000&nasip=127.0.0.1&password="+document.getElementsByName('password')[0].value;
		var funToCall = parseUserNameFromPasswd;
		
			AJAXRequest_async(url,funToCall,errorfunction);
		
	}


	function parseUserNameFromPasswd() {
        var xmlDoc = req.responseXML.documentElement;
        var username = "0";
        var password = "0";
        var returnValue = xmlDoc.getElementsByTagName('returnstatus');
        returnValue = returnValue[0].firstChild.data;
		if(returnValue == 0){
			if(document.getElementById('errormessage')){
				document.getElementById('errormessage').innerHTML = '';
			}
			username = xmlDoc.getElementsByTagName('username')[0].firstChild.data;
			password = xmlDoc.getElementsByTagName('password')[0].firstChild.data;
			if(username != "0" && password != "0" && username != "" ){
				document.forms[0].username.value = username;
				document.forms[0].password.value = password;
				if(document.clientloginform.loginotp !== undefined) {
					checkLoginOTPCaptcha();
					return false;
				}
			}
		} else {
			alert('Invalid Voucher Code Entered');
			return false;
		}
	}

	function validateLoginAndSubmit(){
		if (!(re.test(document.forms[0].username.value))){
			alert('Please enter the Coupon Id');
			document.forms[0].username.focus();
			return false;
		}
	
		if(document.forms[0].password.value==''){
			alert('please enter password');
			document.forms[0].password.focus();
			return false;
		}
	
		if(document.clientloginform.loginotp !== undefined) {
			checkLoginOTPCaptcha();
			return false;
		}
		document.forms[0].mode.value='191';
		document.forms[0].checkClose.value='1';
		document.forms[0].method='post';
		validateSubmit();
		return true;
	}
	function buycouponnow(){
		location.href="/24online/webpages/paymentgateway/onlinepinpurchase.jsp"
	}

	function logoutUser(){
		document.forms[0].mode.value='193';
		document.forms[0].checkClose.value='1';
		document.forms[0].method='post';
		document.forms[0].submit();
	}

	var message="ï¿½ Cyberoam-Client";
	function click(e){
		if (document.all) {
			if (event.button == 1 || event.button == 2) {
				alert(message);
				return false;
			}
		}
		if (document.layers) {
			if (e.which == 3) {
				alert(message);
				return false;
			}
		}
	}
	if (document.layers) {
		document.enableExternalCapture();
		document.captureEvents(Event.MOUSEDOWN);
	}
	//document.onmousedown=click;
	function blurobj(obj){
		obj.style.backgroundColor="lightgrey";
		obj.disabled = true ;
	}
	function callAdministrator(){
		window.open("/24online/webpages/calladmin.jsp","CallAdmin","dialogHeight=5;dialogWidth=35;center=1;status=0;resizable=0;help=0");

	}

	function openBuyNewPackage(){

		
			var scrw = window.screen.availWidth;
			var scrh = window.screen.availHeight;

			var w = scrw-120;
			var h = scrh-150;
			var left = (scrw-w)/2;
			var top = 5;

			window.open('/24online/buypkgusing_pgway.html','_blank','screenX=0,screenY=0,left='+left+',top='+top+',width=' + w + ',height=' + h +  ',resizable=1,status=1,titlebar=0,menubar=1,toolbar=1,location=1,scrollbars=1');
		

	}

	function openMyAccountLogin(){
		
			var scrw = window.screen.availWidth;
			var scrh = window.screen.availHeight;

			var w = scrw-120;
			var h = scrh-150;
			var left = (scrw-w)/2;
			var top = 5;
			var profileName = document.getElementById("profileName");
			var url="/24online/myaccount.jsp";
			if(profileName!=null && profileName !==  undefined &&  profileName != 'null'){
				url+="?profileName="+profileName.value;
			}
			window.open(url,'_blank','screenX=0,screenY=0,left='+left+',top='+top+',width=' + w + ',height=' + h +  ',resizable=1,status=1,titlebar=0,menubar=1,toolbar=1,location=1,scrollbars=1');
		
	}

	function openRenewPackageByPaymentGateway(){

		var scrw = window.screen.availWidth;
		var scrh = window.screen.availHeight;

		var w =scrw-120;
		var h =scrh-150;

		var left = (scrw-w)/2;
		var top = 5;

		window.open('/24online/renewusing_pgway.html','_blank','screenX=0,screenY=0,left='+left+',top='+top+',width=' + w + ',height=' + h +  ',resizable=1,status=1,titlebar=0,menubar=1,toolbar=1,location=1,scrollbars=1');
	}

	function openHotelUserRegistration(){

		var scrw = window.screen.availWidth;
		var scrh = window.screen.availHeight;

		var w =scrw-120;
		var h =scrh-150;

		var left = (scrw-w)/2;
		var top = 5;

		if(hotelUserWin == null || hotelUserWin.closed){
			hotelUserWin = window.open('/24online/webpages/hoteluserregistration.jsp','_blank','screenX=0,screenY=0,left='+left+',top='+top+',width=' + w + ',height=' + h +  ',resizable=1,status=1,titlebar=0,menubar=1,toolbar=1,location=1,scrollbars=1');
		}else{
			hotelUserWin.focus();
		}

	}

	function accessHotelUserWindowParam(){
		

	}
	function sendGuestMsgRequest(){
		alert("Your request for Guest Messages has been sent.\nMessage(s) will be displayed in a short while.");
		var scrw = window.screen.availWidth;
		var w =scrw-180;
		window.open("/24online/webpages/myaccount/guestmessages.jsp?username=null",'guestmsg','resizable=1,status=1,width='+w);
		/*document.clientloginform.mode.value="";
		document.clientloginform.guestmsgreq.value="true";
		document.clientloginform.method="post";
		document.clientloginform.submit();*/
	}
	function sendGuestBillReq(){
		var scrw = window.screen.availWidth;
		var scrh = window.screen.availHeight;
		var w =scrw-120;
		var h =scrh-150;
		var left = (scrw-w)/2;
		var top = 5;
		window.open('/24online/webpages/hoteluserregistration.jsp?pwdmode=514','_blank','screenX=0,screenY=0,left='+left+',top='+top+',width=' + w + ',height=' + h +  ',titlebar=yes,scrollbars=yes');
	}

	// functions for loading Package Details

	function loadPackageDetails() {
		// Sending AJAX Request with user name and respective mode
		
	} //Return from AJAX

	function parsePackageDetails(){
		var xmlDoc = req.responseXML.documentElement;

		var allottedtime = xmlDoc.getElementsByTagName("allottedtime");
		allottedtime = allottedtime[0].firstChild.data;
		document.getElementById('allottedtime').innerHTML = allottedtime;

		var packageamount = xmlDoc.getElementsByTagName("packageamount");
		packageamount = packageamount[0].firstChild.data;
		document.getElementById('packageamount').innerHTML = packageamount;

		var expiredays = xmlDoc.getElementsByTagName("expiredays");
		expiredays = expiredays[0].firstChild.data;
		document.getElementById('expiredays').innerHTML = expiredays;

		var expiredate = xmlDoc.getElementsByTagName("expiredate");
		expiredate = expiredate[0].firstChild.data;
		document.getElementById('expiredate').innerHTML = expiredate;

	}

	function getPackagesForDynamicUsers(){
		
	}

	function StringtoXML(text){
        if (window.ActiveXObject){
          var doc=new ActiveXObject('Microsoft.XMLDOM');
          doc.async='false';
          doc.loadXML(text);
        } else {
          var parser=new DOMParser();
          var doc=parser.parseFromString(text,'text/xml');
        }
        return doc;
    }

	function parsePackagesForDynamicUsers(){
		var xmlDoc = req.responseXML.documentElement;
		var groupIdBox = document.getElementById('groupid');

		if (groupIdBox == null ) {
			//alert("Group id Object not found...");
			var newdiv = document.createElement('select');
			newdiv.setAttribute("name", "groupid");
			newdiv.setAttribute("id", "groupid");
			document.clientloginform.appendChild(newdiv);

			document.getElementById('groupid').style.display = "none";
		}

		var targ = document.getElementsByName('groupid')[0];
		if(targ != null){
			
				targ.options.length=0;
		    	targ.options[0] = new Option( 'Select Here', '0' );
		    	fillComboWithIndex("groupid","poolbindedgrouplist",0,xmlDoc);
			

		}
	}

/*
	function fillComboWithIndex(comboname,tagname,index,xmlDoc){
		//alert(xmlDoc);
		var targ=document.getElementsByName(comboname)[index];
		var options = xmlDoc.getElementsByTagName(tagname);

		var key;
		var val;

		for( var i=0; i < options.length; i++ ) {
			key = options[i].getElementsByTagName("key");
			val = options[i].getElementsByTagName("value");

			targ.options[ i ] = new Option( val[0].firstChild.data, key[0].firstChild.data );
		}
	}
*/
	function getGroupInfoByAjax(){
		
	}
	function loadCPProfileGroupDetails(){

		form = document.forms[0];

		var profileGroupId = document.getElementById("profilegroupid");
  var script   = document.createElement("script");
                                script.type  = "text/javascript";
                                script.src   = "/24online/javascript/profilecheck1.js?random="+Math.random()+"&profileGroupId"+profileGroupId;
                                document.body.appendChild(script);

		if(profileGroupId!=null && profileGroupId !=  'undefined' &&  profileGroupId != 'null' ){

			var profileName = document.getElementById("profileName").value;

			if(profileName!=null && profileName !=  'undefined' &&  profileName != 'null'){
				var script   = document.createElement("script");
				script.type  = "text/javascript";
				script.src   = "/24online/javascript/profilecheck3.js?random="+Math.random();
				document.body.appendChild(script);
				document.getElementById('cpprofiletable').style.display='none';
				var url="/24online/servlet/AjaxManager?mode=958&profileName="+profileName;
				var funToCall = loadProfileAttributeList;
				AJAXRequest_async(url,funToCall,errorfunction);
			}
			else {
				var script   = document.createElement("script");
                                script.type  = "text/javascript";
                                script.src   = "/24online/javascript/profilecheck2.js?random="+Math.random();
                                document.body.appendChild(script);
			}

		}


	}
	function loadProfileAttributeList(){

		var targ=document.getElementsByName('profilegroupid')[0];
		var xmlDoc = req.responseXML.documentElement;
	/* 	var message =  xmlDoc.getElementsByTagName('Message');
		alert("message : "+message[0]);
		if(message[0]!=null && message[0] !=  'undefined' &&  message[0] != 'null'){
			alert("test message;");
			message = message.getElementsByTagName("value");
			document.getElementById('errormessage').innerHTML = "<font class='errorfont'>"+message+"</font>";
		}
		alert("test message 2;"); */
		if(targ!= null) {
			targ.options.length=0;
			//targ.options[0] = new Option( 'Select Here', '0' );
			fillCombo("profilegroupid","profileAttributeList");
			document.forms[0].profilegroupid.focus();

			var profileAttribute = xmlDoc.getElementsByTagName('profileAttributeList');

			if(profileAttribute!=null && profileAttribute.length==1){

				document.getElementById('cpprofiletable').style.display='none';
			}else{

				document.getElementById('cpprofiletable').style.display='table';
			}
		}
	}
	function errorLoadCPProfile(){
		alert("Error while loading captive portal profile attributes. ")
	}
	function showSelectedPlanDetails(){
		var xmlDoc = req.responseXML.documentElement;
		var groupname;
		var groupid;
		var	allottedtime;
		var duration;
		var uplimit;
		var dnlimit;
		var price;

		groupname = xmlDoc.getElementsByTagName('groupname')[0].firstChild.data;
		groupid = xmlDoc.getElementsByTagName('groupid')[0].firstChild.data;
		allottedtime = xmlDoc.getElementsByTagName('allottedtime')[0].firstChild.data;
		duration = xmlDoc.getElementsByTagName('duration')[0].firstChild.data;
		uplimit = xmlDoc.getElementsByTagName('uplimit')[0].firstChild.data;
		dnlimit = xmlDoc.getElementsByTagName('dnlimit')[0].firstChild.data;
		price = xmlDoc.getElementsByTagName('price')[0].firstChild.data;

		targ=document.getElementById('packagename');
		if(targ != null){
			document.getElementById('packagename').innerHTML = groupname;
		}
		targ=document.getElementById('allottedtime');
		if(targ != null){
			document.getElementById('allottedtime').innerHTML = allottedtime;
		}
		targ=document.getElementById('packageamount');
		if(targ != null){
			document.getElementById('packageamount').innerHTML = price;
		}
		targ=document.getElementById('uploaddatatransfer');
		if(targ != null){
			document.getElementById('uploaddatatransfer').innerHTML = uplimit;
		}
		targ=document.getElementById('downloaddatatransfer');
		if(targ != null){
			document.getElementById('downloaddatatransfer').innerHTML = dnlimit;
		}

	}

	function validateLoginForMACBasedUsers(){
		form = document.forms[0];
		var url = "/24online/servlet/AjaxManager?mode=647&macaddress=null&nasip=127.0.0.1&groupid="+form.groupid.value;
		var funToCall = parseLoginForMACBasedUsers;
		
			AJAXRequest_async(url,funToCall,errorfunction);
		
	}

	function parseLoginForMACBasedUsers(){
		var xmlDoc = req.responseXML.documentElement;
		var username = "0";
		var password = "0";
		var returnValue = xmlDoc.getElementsByTagName('returnstatus');
		returnValue = returnValue[0].firstChild.data;
		if(returnValue == "1"){
			if(document.getElementById('errormessage')){
				document.getElementById('errormessage').innerHTML = '';
			}
			username = xmlDoc.getElementsByTagName('username')[0].firstChild.data;
			password = xmlDoc.getElementsByTagName('password')[0].firstChild.data;
			if(username != "0" && password != "0"){
				document.forms[0].username.value = username;
				document.forms[0].password.value = password;
				document.forms[0].mode.value='191';
				document.forms[0].checkClose.value='1';
				document.forms[0].submit();
			}
		}else{
			if(document.getElementById('errormessage')){
				document.getElementById('errormessage').innerHTML = "<font class='errorfont'>Problem in renewing MAC Based Dynamic User</font>";
			}
		}
	}
	function errorfunction(){
		//alert("errorfunction() called");
	}
	function oldCheckForResetPassword() {
		form = document.forms[0];
		var url = "/24online/servlet/AjaxManager?mode=655&username="+form.username.value+"&password="+form.password.value;
		var funToCall = parseCheckForResetPassword;
		var errorfun = errorfunction;
		
			AJAXRequest_async(url,funToCall,errorfun);
		
	}
	function checkForResetPassword(){
		form = document.forms[0];
		var url = "/24online/servlet/CPAjaxManager?mode=655&username="+form.username.value+"&password="+form.password.value;
		var profileGroupId = document.getElementById("profilegroupid");
		if(profileGroupId!=null && profileGroupId !==  undefined &&  profileGroupId != 'null' ){
			url += "&profilegroupid="+profilegroupid.value;
		}
		var profileName = document.getElementById("profileName");
		if(profileName!=null && profileName !==  undefined &&  profileName != 'null'){
			url += "&profileName="+profileName.value;
		}
		var funToCall = parseCheckForResetPassword;
		var errorfun = oldCheckForResetPassword;
		
			AJAXRequest_async(url,funToCall,errorfun);
		
	}
	function parseCheckForResetPassword(){
		var xmlDoc = req.responseXML.documentElement;
		if(xmlDoc != null){
			var userid = "0";
			var returnValue = xmlDoc.getElementsByTagName('returnstatus');
			returnValue = returnValue[0].firstChild.data;
			if(returnValue == "1"){
				userid = xmlDoc.getElementsByTagName('userid')[0].firstChild.data;
				if(userid != "0"){
					var redirecturl = "/24onlinehttps://netidportal.snu.edu.in/pwdReset.php?username="+document.forms[0].username.value;
					document.forms[0].username.value = "";
					document.forms[0].password.value = "";
					window.location = redirecturl;
					return;
				}
			}else{
				document.forms[0].mode.value='191';
				document.forms[0].checkClose.value='1';
				document.forms[0].submit();
			}
		}else{
			document.forms[0].mode.value='191';
			document.forms[0].checkClose.value='1';
			document.forms[0].submit();
		}
	}
	function focusUsername(){
		try{
	// if prelogin page and if it is not a MAC Based Dynamic User, then focus on username
	
				document.clientloginform.username.focus();
	
		}catch(err){
			try{
				console.debug("Can not get focus on username field becuase that field does not exist");
			}catch(err){/*This exception will be thrown by IE, because it does not have functionality of loggin in the console*/}
		}
		
}
	function autologin(){
		//alert('autologin called');
		
		document.forms[0].username.value="null";
		
		document.forms[0].password.value='null';
		document.forms[0].mode.value='191';
		document.forms[0].checkClose.value='1';
		document.forms[0].submit();
	}
	function validateSubmit(){
		
					document.getElementsByName('login')[0].disabled = true;

		
		return true;
	}


	 
</script>
</head>

<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="loadPackageDetails();focusUsername();loadCPProfileGroupDetails();showRegisterUserCaptcha();" onbeforeunload="accessHotelUserWindowParam();" onfocus="gotFocus();" onblur="lostFocus();">

<form action="/24online/servlet/E24onlineHTTPClient" method="post" target="_parent" name="clientloginform">
<input type="hidden" name="mode" value="191" />
<input type="hidden" name="isAccessDenied" value="null" />
<input type="hidden" name="url" value="http://go.microsoft.com:80/fwlink/?LinkID=219472" />
<input type="hidden" name="message" value="" />
<input type="hidden" name="checkClose" value="0" />
<input type="hidden" name="sessionTimeout" value="0" />
<input type="hidden" name="guestmsgreq" value="false" />
<input type="hidden" name="logintype" value="2" />
<input type="hidden" name="orgSessionTimeout" value="0" />
<input type="hidden" name="chrome" value="-1" />
<input type="hidden" name="alerttime" value="null" />
<input type="hidden" name="timeout" value="0" />
<input type="hidden" name="popupalert" value="0" />
<input type="hidden" name="dtold" value="0" />
<input type="hidden" name="mac" value='null' />
<input type="hidden" name="servername" id="servername" value='192.168.50.1' />


<script type="text/javascript">

var donothing_logout = new function () {};

	function reloadthis() {
		if(document.clientloginform.guestmsgreq.value == "false"){

		}
	}
	window.onbeforeunload=reloadthis;
</script>
<script type="text/javascript">

</script>

<!--
<div id="jsdis" style="display:''">
	<br /><br />
	<center><b>You do not have Javascript enabled browser.</b></center>
</div>
-->

  <div id="jsena" style="display:'none'">
<table width="100%" border="0" cellpadding="0" cellspacing="0">


		<tr>
		<td width="100%">
			<link rel="stylesheet" type="text/css" href="/css/customizecss/style.css" /><div class="wrapper"><div class="header"><img width="262" height="46" class="m10" alt="Shiv Nadar University" src="/images/customizeimages/logo.png" longdesc="http://snu.edu.in" /> </div><div class="titlebar">INFORMATION TECHNOLOGY</div><div class="main"><h1 class="centralized">NETWORK AUTHENTICATION</h1><p class="centralized">Please login to access Internet.</p><p class="centralized"><span style="color: rgb(53, 63, 69); font-family: Arial, Verdana, sans-serif; font-size: medium; background-color: rgb(255, 255, 255);"><table border=0 cellpadding="0" cellspacing="0" id="cpprofiletable" style="display:none"><TR align="center"><td height="20">&nbsp;&nbsp;&nbsp;</td><td align="left" height="20"><font class="textfont"><b>SNU&nbsp;&nbsp;</b></font></td><td align="left" height="20"><select name="profilegroupid" id="profilegroupid" style="width:150px"><option value="-1">Select Here</option></select> </td> </tr><TR></tr><tr></td><td><input type="hidden" name="profileName" id="profileName" value="SNU"/></td></tr> </table></span></p><br /><div id="stylized" class="myform"><form id="form" method="post" action="adminlanding.html" name="form">    <h1>Login</h1>    <p align="left">Please fill all the information requested below. <br /><strong><font color="#008080">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font><font color="#ff0000"> </font></strong></p>    <label>SNU Net ID <span class="small">Enter your SNU Net Id</span> </label>    <div id="usernameDiv" name="usernameDiv"><input type='text' name='username'></div>    <div style="DISPLAY: none" id="usernameTypedDiv" name="usernameTypedDiv"><input name="usernameTyped" /></div>    <label>Password<span class="small">Enter your Password</span> </label><input type='password' name='password'><button onclick="return appendUserName()" type="submit" value="Login">Login</button>    <div class="spacer">&nbsp;</div></form></div><br /><p class="centralized"><a href="http://start.snu.edu.in/PWDResetPRTL.aspx">Forgot Password</a> </p></div><div style="WIDTH: 876px; HEIGHT: 77px" class="footer"><span class="footercaption clr">&copy; Copyright Shiv Nadar University 2012. All Rights Reserved. Disclaimer</span> <span class="footersubcaption">The Shiv Nadar University has been established under U.P. Act No 12 of 2011. Shiv Nadar University is UGC Approved</span> </div></div><input type=hidden name=saveinfo><input type='hidden' name='loginotp' id='loginotp' value='false' /><input type='hidden' name='logincaptcha' id='logincaptcha' value='false' /><input type='hidden' name='registeruserotp' id='registeruserotp' value='false' /><input type='hidden' name='registercaptcha' id='registerusercaptcha' value='false' /><div style=display:none><font class="note" ><b><label  id="sessionTime">Not Applicable</label></b></font></div><div style=display:none><font class="note" ><b><label id="inOctets">Not Applicable</label></b></font></div><div style=display:none><font class="note" ><b><label id="outOctets" >Not Applicable</label></b></font></div><div style=display:none><font class="note" ><b><label id="totalOctets">Not Application</label></b></font></div><div style=display:none><font class="note" ><b><label id="packageamount"></label></b></font></div><div style=display:none><font class="note" ><b><label id="expiredate"></label></b></font></div><div style=display:none><font class="note" ><b><label id="date"></label></b></font></div><div style=display:none><font class="note" ><b><label id="time"></label></b></font></div><div style=display:none><font class="note" ><b><label id="useddatatransfer"></label></b></font></div><div style=display:none><font class="note" ><b><label id="status"></label></b></font></div>
		</td>
	</tr>

</table>

  </div>
</form>
<script type="text/javascript">

	jsena.style.display='' ;
</script>



<script type="text/javascript">



</script>

</body>
</html>

