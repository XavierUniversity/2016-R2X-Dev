<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<link rel="shortcut icon" href="favicon.ico" />

<title>Road to Xavier</title>

<link rel="stylesheet" href="css/style.default.css" />
<link rel="stylesheet" href="css/responsive-tables.css">
    
  <style>
	  
	 .img-centered{display: block;
    margin-left: auto; margin-right: auto; padding-top: 10px;}
    
    
     @media (min-width : 320px) {  .img-centered { padding-left: 50px; }  
    
     
     }
   </style>   
    
<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
<script src="js/html5shiv.js"></script>
<script src="js/respond.min.js"></script>
<![endif]-->

<script src="js/jquery-1.10.2.min.js"></script>
<script src="js/jquery-migrate-1.2.1.min.js"></script>
<script src="js/jquery-ui-1.10.3.min.js"></script>

<script src="js/bootstrap.min.js"></script>
<script src="js/modernizr.min.js"></script>
<script src="js/jquery.cookies.js"></script>
<script src="js/tinymce/jquery.tinymce.js"></script>
<script src="js/custom.js"></script>
<script src="js/wysiwyg.js"></script>


<!--[if lte IE 8]>
<script src="js/excanvas.min.js"></script>
<![endif]-->

</head>

<body>


<div class="topbar">
		<div class="show-nav">
			<a id="nav-icon" href="#">
				<span></span>
				<span></span>
				<span></span>
				<span></span>
			</a>
		</div>
		
		<img src="images/logo.svg" class="img-centered">
</div>		    



<div id="mainwrapper" class="mainwrapper">

    <div class="header">
	    
        <!--<div class="logo">
            <a href="dashboard.html"><img src="images/logo.svg" alt="The Road to Xavier" /></a>
        </div>-->
        <div class="headerinner">
            <ul class="headmenu">
                <li class="odd">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        <span class="count">4</span>
                        <span class="head-icon head-message"></span>
                        <span class="headmenu-label">Messages</span>
                    </a>
                    <ul class="dropdown-menu">
                        <li class="nav-header">Messages</li>
                        <li><a href=""><span class="glyphicon glyphicon-envelope"></span> New message from <strong>Jack</strong> <small class="muted"> - 19 hours ago</small></a></li>
                        <li><a href=""><span class="glyphicon glyphicon-envelope"></span> New message from <strong>Daniel</strong> <small class="muted"> - 2 days ago</small></a></li>
                        <li><a href=""><span class="glyphicon glyphicon-envelope"></span> New message from <strong>Jane</strong> <small class="muted"> - 3 days ago</small></a></li>
                        <li><a href=""><span class="glyphicon glyphicon-envelope"></span> New message from <strong>Tanya</strong> <small class="muted"> - 1 week ago</small></a></li>
                        <li><a href=""><span class="glyphicon glyphicon-envelope"></span> New message from <strong>Lee</strong> <small class="muted"> - 1 week ago</small></a></li>
                        <li class="viewmore"><a href="messages.html">View More Messages</a></li>
                    </ul>
                </li>
                <li>
                    <a class="dropdown-toggle" data-toggle="dropdown" data-target="#">
                    <span class="count">10</span>
                    <span class="head-icon head-users"></span>
                    <span class="headmenu-label">New Users</span>
                    </a>
                    <ul class="dropdown-menu newusers">
                        <li class="nav-header">New Users</li>
                        <li>
                            <a href="">
                                <img src="images/photos/thumb1.png" alt="" class="userthumb" />
                                <strong>Draniem Daamul</strong>
                                <small>April 20, 2013</small>
                            </a>
                        </li>
                        <li>
                            <a href="">
                                <img src="images/photos/thumb2.png" alt="" class="userthumb" />
                                <strong>Shamcey Sindilmaca</strong>
                                <small>April 19, 2013</small>
                            </a>
                        </li>
                        <li>
                            <a href="">
                                <img src="images/photos/thumb3.png" alt="" class="userthumb" />
                                <strong>Nusja Paul Nawancali</strong>
                                <small>April 19, 2013</small>
                            </a>
                        </li>
                        <li>
                            <a href="">
                                <img src="images/photos/thumb4.png" alt="" class="userthumb" />
                                <strong>Rose Cerona</strong>
                                <small>April 18, 2013</small>
                            </a>
                        </li>
                        <li>
                            <a href="">
                                <img src="images/photos/thumb5.png" alt="" class="userthumb" />
                                <strong>John Doe</strong>
                                <small>April 16, 2013</small>
                            </a>
                        </li>
                    </ul>
                </li>
                <li class="odd">
                    <a class="dropdown-toggle" data-toggle="dropdown" data-target="#">
                    <span class="count">1</span>
                    <span class="head-icon head-bar"></span>
                    <span class="headmenu-label">Statistics</span>
                    </a>
                    <ul class="dropdown-menu">
                        <li class="nav-header">Statistics</li>
                        <li><a href=""><span class="glyphicon glyphicon-align-left"></span> New Reports from <strong>Products</strong> <small class="muted"> - 19 hours ago</small></a></li>
                        <li><a href=""><span class="glyphicon glyphicon-align-left"></span> New Statistics from <strong>Users</strong> <small class="muted"> - 2 days ago</small></a></li>
                        <li><a href=""><span class="glyphicon glyphicon-align-left"></span> New Statistics from <strong>Comments</strong> <small class="muted"> - 3 days ago</small></a></li>
                        <li><a href=""><span class="glyphicon glyphicon-align-left"></span> Most Popular in <strong>Products</strong> <small class="muted"> - 1 week ago</small></a></li>
                        <li><a href=""><span class="glyphicon glyphicon-align-left"></span> Most Viewed in <strong>Blog</strong> <small class="muted"> - 1 week ago</small></a></li>
                        <li class="viewmore"><a href="charts.html">View More Statistics</a></li>
                    </ul>
                </li>
                <li class="right">
                    <div class="userloggedinfo hidden-sm-down   hidden-sm-down">
                        <img src="images/photos/thumb1.png" alt="" />
                        <div class="userinfo">
                            <h5>Kristyn Hopson <small>- kristyn@hopson.com</small></h5>
                            <ul>
                                <li><a href="editprofile.html">Your Profile</a></li>
                                <li><a href="">Your Xavier Account</a></li>
                                <li><a href="index.html">Sign Out</a></li>
                            </ul>
                        </div>
                    </div>
                </li>
            </ul><!--headmenu-->
        </div>
    </div>
    
    
    <div class="leftpanel">
        
        <div class="leftmenu">        
            <ul class="nav nav-tabs nav-stacked">
            	<li class="nav-header">Navigation</li>
                <li><a href="#"><span class="fa fa-envelope fa-fw"></span> Inbox</a></li>
                <li><a href="#"><span class="fa fa-road fa-fw"></span> Your Road to Xavier</a></li>
                <li><a href="#"><span class="fa fa-pencil fa-fw"></span> Registration</a></li>
                <li><a href="#"><span class="fa fa-usd fa-fw"></span> Money Matters</a></li>
                <li><a href="#"><span class="fa fa-user fa-fw"></span> Your Space</a></li>
                <li><a href="#"><span class="fa fa-home fa-fw"></span> Housing</a></li>
                <li><a href="#"><span class="fa fa-info fa-fw"></span> About Xavier</a></li>
                <li><a href="#"><span class="fa fa-map-marker fa-fw"></span> Visit</a></li>
                <li><a href="#"><span class="fa fa-gamepad fa-fw"></span> Game Center</a></li>
                <li><a href="#"><span class="fa fa-link fa-fw"></span> Manresa</a></li>
                <li><a href="#"><span class="fa fa-pencil-square-o fa-fw"></span> Contact Us</a></li>
                <li class="nav-header"><a href="#"><span class="fa fa-file fa-fw"></span> Template Pages</a></li>
                <li class="xactive"><a href="index.html"><span class="fa fa-laptop fa-fw"></span> Dashboard</a></li>
                <li><a href="buttons.html"><span class="fa fa-hand-upfa-fw"></span> Buttons &amp; Icons</a></li>
                <li class="dropdown"><a href=""><span class="fa fa-pencil fa-fw"></span> Forms</a>
                	<ul>
                    	<li><a href="forms.html">Form Styles</a></li>
                        <li><a href="wizards.html">Wizard Form</a></li>
                        <li><a href="wysiwyg.html">WYSIWYG</a></li>
                        <li><a href="registration.html">Registration Page</a></li>
                    </ul>
                </li>
                <li class="dropdown"><a href=""><span class="fa fa-briefcase"></span> UI Elements &amp; Widgets</a>
                	<ul>
                    	<li><a href="elements.html">Theme Components</a></li>
                        <li><a href="bootstrap.html">Bootstrap Components</a></li>
                        <li><a href="boxes.html">Headers &amp; Boxes</a></li>
                    </ul>
                </li>
                <li class="dropdown"><a href=""><span class="fa fa-th-list"></span> Tables</a>
                	<ul>
                    	<li><a href="table-static.html">Static Table</a></li>
                        <li class="dropdown"><a href="table-dynamic.html">Dynamic Table</a></li>
                    </ul>
                </li>
                <li><a href="media.html"><span class="fa fa-picture"></span> Media Manager</a></li>
                <li><a href="typography.html"><span class="fa fa-font"></span> Typography</a></li>
                <li><a href="charts.html"><span class="fa fa-signal"></span> Graph &amp; Charts</a></li>
                <li class="dropdown"><a href=""><span class="fa fa-envelope"></span> Messaging</a>
                    <ul>
                        <li><a href="messages.html">Mailbox</a></li>
                        <li><a href="chat.html">Chat Page</a></li>
                    </ul>
                </li>
                <li><a href="calendar.html"><span class="fa fa-calendar"></span> Calendar</a></li>
                <li class="dropdown"><a href=""><span class="fa fa-book"></span> Other Pages</a>
                    <ul>
                        <li><a href="404.html">404 Error Page</a></li>
                        <li><a href="editprofile.html">Edit Profile</a></li>
                        <li><a href="invoice.html">Invoice Page</a></li>
                        <li><a href="discussion.html">Discussion Page</a></li>
                        <li><a href="topic.html">View Topic Page</a></li>
                        <li><a href="blog.html">Grid Blog List</a></li>
                        <li><a href="blank.html">Blank Page</a></li>
                        <li><a href="timeline.html">Timeline Page</a></li>
                        <li><a href="people.html">People Directory</a></li>
                        <li><a href="lockscreen.html">Lock Screen</a></li>
                    </ul>
                </li>
                <li class="dropdown"><a href=""><span class="fa fa-th-list"></span> Three Level Menu Sample</a>
                	<ul>
                    	<li class="dropdown"><a href="">Second Level Menu</a>
                        <ul>
                            <li><a href="">Third Level Menu</a></li>
                            <li><a href="">Another Third Level Menu</a></li>
                        </ul>
                     </li>
                    </ul>
                </li>
            </ul>
        </div><!--leftmenu-->
        
    </div><!-- leftpanel -->

        
    <div class="rightpanel">
        
        <ul class="breadcrumbs">
            <li><a href="dashboard.html"><i class="fa fa-home"></i></a> <span class="separator"></span></li>
            <li>Home</li>
                 </ul>
        
        <div class="pageheader">
            <form action="results.html" method="post" class="searchbar">
                <input type="text" name="keyword" placeholder="To search type and hit enter..." />
            </form>
            <div class="pageicon"><img src="images/x.svg"  alt="X logo" width="45px" /></div>
            <div class="pagetitle">
                <h5>Hello, Kristyn</h5>
                <h1>The Road to Xavier</h1>
            </div>
        </div><!--pageheader-->
        
        <div class="maincontent">
            <div class="maincontentinner">
                <div class="row">
                    <div id="dashboard-left" class="col-md-8">
                        
                        <h5 class="subtitle">Recently Viewed Pages</h5>
                        <ul class="shortcuts">
                            <li class="events">
                                <a href="">
                                    <span class="shortcuts-icon iconsi-event"></span>
                                    <span class="shortcuts-label">Calendar</span>
                                </a>
                            </li>
                            <li class="products">
                                <a href="">
                                    <span class="shortcuts-icon iconsi-cart"></span>
                                    <span class="shortcuts-label">Products</span>
                                </a>
                            </li>
                            <li class="archive">
                                <a href="">
                                    <span class="shortcuts-icon iconsi-archive"></span>
                                    <span class="shortcuts-label">Archives</span>
                                </a>
                            </li>
                            <li class="help">
                                <a href="">
                                    <span class="shortcuts-icon iconsi-help"></span>
                                    <span class="shortcuts-label">Help</span>
                                </a>
                            </li>
                            <li class="help">
                                <a href="">
                                    <span class="shortcuts-icon iconsi-help"></span>
                                    <span class="shortcuts-label">Help</span>
                                </a>
                            </li>
                            <li class="last images">
                                <a href="">
                                    <span class="shortcuts-icon iconsi-images"></span>
                                    <span class="shortcuts-label">Images</span>
                                </a>
                            </li>
                        </ul>
                        
                        <br />
                        

                        <!--<h5 class="subtitle">Daily Statistics</h5><br />
                        <div id="chartplace" style="height:300px;"></div>
                        
                        <div class="divider30"></div>
                        
                                               
                        <br />-->
                        
                        <h4 class="widgettitle"><span class="glyphicon glyphicon-comment glyphicon-white"></span> Recent Activity</h4>
                        <div class="widgetcontent nopadding">
                            <ul class="commentlist">
                                <li>
                                    <img src="images/ambassador-OH.png" alt="" class="pull-left" />
                                    <div class="comment-info">
                                        <h4><a href="" style="color: #026f94">Brian Moore</a> is now the Ambassador of Ohio.</h4>
                                        <h5>Compare your badges with <a href="" style="color: #026f94">Brian's.</a></h5>
                                        <p></p>
                                    </div>
                                </li>
                               <li>
                                    <img src="images/miniblueblob.png" alt="" class="pull-left" />
                                    <div class="comment-info">
                                        <h4><a href="" style="color: #026f94">Dante Hamm</a>  is the new Mini Blue Blob.</h4>
                                        <h5>Compare your badges with <a href="" style="color: #026f94">Dante's.</a></h5>
                                        <p></p>
                                    </div>
                                </li>
                                <li>
                                    <img src="images/expert.png" alt="" class="pull-left" />
                                    <div class="comment-info">
                                        <h4><a href="" style="color: #026f94">olden Graham</a> has earned the Expert badge. Way to go, Holden!</h4>
                                        <h5>Compare your badges with <a href="" style="color: #026f94">Holden's.</a></h5>
                                        <p></p>
                                    </div>
                                </li>
                                     <li>
                                    <img src="images/photos/thumb1.png" alt="" class="pull-left" />
                                    <div class="comment-info">
                                        <h4><a href="" style="color: #026f94">Kristyn Hopson</a> has updated her profile.</h4>
                                        <h5>Creep on <a href="" style="color: #026f94">Kristyn.</a></h5>
                                        <p></p>
                                    </div>
                                </li>
                                      <li>
                                    <img src="images/ambassador-OH.png" alt="" class="pull-left" />
                                    <div class="comment-info">
                                        <h4><a href="" style="color: #026f94">Brian Moore</a> is now the Ambassador of Ohio.</h4>
                                        <h5>Compare your badges with <a href="" style="color: #026f94">Brian's.</a></h5>
                                        <p></p>
                                    </div>
                                </li>
                               <li>
                                    <img src="images/miniblueblob.png" alt="" class="pull-left" />
                                    <div class="comment-info">
                                        <h4><a href="" style="color: #026f94">Dante Hamm</a>  is the new Mini Blue Blob.</h4>
                                        <h5>Compare your badges with <a href="" style="color: #026f94">Dante's.</a></h5>
                                        <p></p>
                                    </div>
                                </li>
                                <li>
                                    <img src="images/expert.png" alt="" class="pull-left" />
                                    <div class="comment-info">
                                        <h4><a href="" style="color: #026f94">Holden Graham</a> has earned the Expert badge. Way to go, Holden!</h4>
                                        <h5>Compare your badges with <a href="" style="color: #026f94">Holden's.</a></h5>
                                        <p></p>
                                    </div>
                                </li>
                                     <li>
                                    <img src="images/photos/thumb1.png" alt="" class="pull-left" />
                                    <div class="comment-info">
                                        <h4><a href="" style="color: #026f94">Kristyn Hopson</a> has updated her profile.</h4>
                                        <h5>Creep on <a href="" style="color: #026f94">Kristyn.</a></h5>
                                        <p></p>
                                    </div>
                                </li>
                                      <li>
                                    <img src="images/ambassador-OH.png" alt="" class="pull-left" />
                                    <div class="comment-info">
                                        <h4><a href="" style="color: #026f94">Brian Moore</a> is now the Ambassador of Ohio.</h4>
                                        <h5>Compare your badges with <a href="" style="color: #026f94">Brian's.</a></h5>
                                        <p></p>
                                    </div>
                                </li>
                               <li>
                                    <img src="images/miniblueblob.png" alt="" class="pull-left" />
                                    <div class="comment-info">
                                        <h4><a href="" style="color: #026f94">Dante Hamm</a>  is the new Mini Blue Blob.</h4>
                                        <h5>Compare your badges with <a href="" style="color: #026f94">Dante's.</a></h5>
                                        <p></p>
                                    </div>
                                </li>
                                <li>
                                    <img src="images/expert.png" alt="" class="pull-left" />
                                    <div class="comment-info">
                                        <h4><a href="" style="color: #026f94">Holden Graham</a> has earned the Expert badge. Way to go, Holden!</h4>
                                        <h5>Compare your badges with <a href="" style="color: #026f94">Holden's.</a></h5>
                                        <p></p>
                                    </div>
                                </li>
                                     <li>
                                    <img src="images/photos/thumb1.png" alt="" class="pull-left" />
                                    <div class="comment-info">
                                        <h4><a href="" style="color: #026f94">Kristyn Hopson</a> has updated her profile.</h4>
                                        <h5>Creep on <a href="" style="color: #026f94">Kristyn.</a></h5>
                                        <p></p>
                                    </div>
                                </li>
                                <li><a href="">Load More</a></li>
                            </ul>
                        </div>
                        
                        <br />
                        
                        
                    </div><!--col-md-8-->
                    
                    <div id="dashboard-right" class="col-md-4">
                        
                        <h5 class="subtitle">Your Next Step</h5>
                        
                        <div class="divider15"></div>
                        
                        <div class="alert alert-block">
                              <!--<button data-dismiss="alert" class="close" type="button">&times;</button>-->
                              <h4><span class="fa fa-exclamation-circle"></span> Complete the Transition to College Survey</h4>
                              <p style="margin: 8px 0">Nulla vitae elit libero, a pharetra augue. Praesent commodo cursus magna.</p>
                        </div><!--alert-->
                        
                        <br />
                        
                        <h5 class="subtitle">Live on Campus</h5>
                        <p>						<SCRIPT LANGUAGE="JavaScript">
												// Set the BaseURL to the URL of your camera
												var BaseURL = "http://webcam1.xu.edu/";
												
												// DisplayWidth & DisplayHeight specifies the displayed width & height of the image.
												// You may change these numbers, the effect will be a stretched or a shrunk image
												var DisplayWidth = "100%";
												var DisplayHeight = "";
												
												// This is the path to the image generating file inside the camera itself
												var File = "axis-cgi/mjpg/video.cgi?resolution=640x360&compression=30";
												// No changes required below this point
												var output = "";
												
												var useActiveX = false;
												
												<!--- detect older IE --->
												if ( (navigator.appName == "Microsoft Internet Explorer") &&
												   (navigator.platform != "MacPPC") && (navigator.platform != "Mac68k")){
													useActiveX = true;
												}
												
												<!--- detect IE11 --->
												if (Object.hasOwnProperty.call(window, "ActiveXObject") && !window.ActiveXObject) {
												    useActiveX = true;
												}
												
												if (useActiveX)
												{
												  // If Internet Explorer under Windows then use ActiveX 
												  output  = '<div class="flex-video"><OBJECT ID="Player" width='
												  output += DisplayWidth;
												  output += ' height=';
												  output += DisplayHeight;
												  output += ' CLASSID="CLSID:DE625294-70E6-45ED-B895-CFFA13AEB044" ';
												  output += 'CODEBASE="';
												  output += BaseURL;
												  output += 'activex/AMC.cab#version=3,32,14,0">';
												  output += '<PARAM NAME="MediaURL" VALUE="';
												  output += BaseURL;
												  output += File + '">';
												  output += '<param name="MediaType" value="mjpeg-unicast">';
												  output += '<param name="ShowStatusBar" value="0">';
												  output += '<param name="ShowToolbar" value="0">';
												  output += '<param name="AutoStart" value="1">';
												  output += '<param name="StretchToFit" value="1">';
												  // Remove the '//' for the ptz settings below to use the code for click-in-image. 
												     //  output += '<param name="PTZControlURL" value="';
												     //  output += BaseURL;
												     //  output += '/axis-cgi/com/ptz.cgi?camera=1">';
												     //  output += '<param name="UIMode" value="ptz-relative">'; // or "ptz-absolute"
												  output += '<BR><B>Axis Media Control</B><BR>';
												  output += 'The AXIS Media Control, which enables you ';
												  output += 'to view live image streams in Microsoft Internet';
												  output += ' Explorer, could not be registered on your computer.';
												  output += '<BR></OBJECT></div>';
												} else {
												  // If not IE for Windows use the browser itself to display
												  theDate = new Date();
												  output  = '<IMG SRC="';
												  output += BaseURL;
												  output += File;
												  output += '&dummy=' + theDate.getTime().toString(10);
												  output += '" HEIGHT="';
												  output += DisplayHeight;
												  output += '" WIDTH="';
												  output += DisplayWidth;
												  output += '" ALT="Video Stream">';
												}
												document.write(output);
												document.Player.ToolbarConfiguration = "play,+snapshot,+fullscreen"
												// document.Player.UIMode = "MDConfig";
												// document.Player.MotionConfigURL = "/axis-cgi/operator/param.cgi?ImageSource=0"
												// document.Player.MotionDataURL = "/axis-cgi/motion/motiondata.cgi";
												</SCRIPT>
							</p>

                        
                        <br />
                        
                        <h5 class="subtitle">Summaries</h5>
                            
                        <div class="divider15"></div>
                        
                        <div class="widgetbox">                        
                        <div class="headtitle">
                            <div class="btn-group">
                                <button data-toggle="dropdown" class="btn dropdown-toggle">Action <span class="caret"></span></button>
                                <ul class="dropdown-menu">
                                  <li><a href="#">Action</a></li>
                                  <li><a href="#">Another action</a></li>
                                  <li><a href="#">Something else here</a></li>
                                  <li class="divider"></li>
                                  <li><a href="#">Separated link</a></li>
                                </ul>
                            </div>
                            <h4 class="widgettitle">Widget Box</h4>
                        </div>
                        <div class="widgetcontent">
                            Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
                        </div><!--widgetcontent-->
                        </div><!--widgetbox-->
                        
                        <h4 class="widgettitle">Xavier Calendar</h4>
                        <div class="widgetcontent nopadding">
                            <div id="datepicker"></div>
                        </div>
                        
                        <div class="tabbedwidget tab-primary">
                            <ul>
                                <li><a href="#tabs-1"><span class="fa fa-user"></span></a></li>
                                <li><a href="#tabs-2"><span class="fa fa-group"></span></a></li>
                            </ul>
                            
                            <div id="tabs-1" class="nopadding">
                                <h5 class="tabtitle">Last Logged In Users</h5>
                                <ul class="userlist">
                                    <li>
                                        <div>
                                            <img src="images/photos/thumb1.png" alt="" class="pull-left" />
                                            <div class="uinfo">
                                                <h5>Draniem Daamul</h5>
                                                <span class="pos">Cincinnati, OH</span>
                                                <span>Last Logged In: 04/20/2013 8:40PM</span>
                                            </div>
                                        </div>
                                    </li>
                                    <li>
                                        <div>
                                            <img src="images/photos/thumb2.png" alt="" class="pull-left" />
                                            <div class="uinfo">
                                                <h5>Therineka Chonpe</h5>
                                                <span class="pos">Cincinnati, OH</span>
                                                <span>Last Logged In: 04/20/2013 3:30PM</span>
                                            </div>
                                        </div>
                                    </li>
                                    <li>
                                        <div>
                                            <img src="images/photos/thumb3.png" alt="" class="pull-left" />
                                            <div class="uinfo">
                                                <h5>Zaham Sindilmaca</h5>
                                                <span class="pos">Cincinnati, OH</span>
                                                <span>Last Logged In: 04/19/2013 1:30AM</span>
                                            </div>
                                        </div>
                                    </li>
                                    <li>
                                        <div>
                                            <img src="images/photos/thumb4.png" alt="" class="pull-left" />
                                            <div class="uinfo">
                                                <h5>Annie Cerona</h5>
                                                <span class="pos">Cincinnati, OH</span>
                                                <span>Last Logged In: 04/19/2013 11:30AM</span>
                                            </div>
                                        </div>
                                    </li>
                                    <li>
                                        <div>
                                            <img src="images/photos/thumb5.png" alt="" class="pull-left" />
                                            <div class="uinfo">
                                                <h5>Delher Carasbong</h5>
                                                <span class="pos">Cincinnati, OH</span>
                                                <span>Last Logged In: 04/19/2013 11:00AM</span>
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                            <div id="tabs-2" class="nopadding">
                                <h5 class="tabtitle">Friends</h5>
                                <ul class="userlist userlist-favorites">
                                                                        <li>
                                        <div>
                                            <img src="images/photos/thumb3.png" alt="" class="pull-left" />
                                            <div class="uinfo">
                                                <h5>Zaham Sindilmaca</h5>
                                                <p class="link">
                                                    <a href=""><i class="fa fa-envelope"></i> Message</a>
                                                    <a href=""><i class="fa fa-phone"></i> Call</a>
                                                </p>
                                            </div>
                                        </div>
                                    </li>
                                    <li>
                                        <div>
                                            <img src="images/photos/thumb4.png" alt="" class="pull-left" />
                                            <div class="uinfo">
                                                <h5>Annie Cerona</h5>
                                                <p class="link">
                                                    <a href=""><i class="fa fa-envelope"></i> Message</a>
                                                    <a href=""><i class="fa fa-phone"></i> Call</a>
                                                </p>
                                            </div>
                                        </div>
                                    </li>
                                    <li>
                                        <div>
                                            <img src="images/photos/thumb5.png" alt="" class="pull-left" />
                                            <div class="uinfo">
                                                <h5>Delher Carasbong</h5>
                                                <p class="link">
                                                    <a href=""><i class="fa fa-envelope"></i> Message</a>
                                                    <a href=""><i class="fa fa-phone"></i> Call</a>
                                                </p>
                                            </div>
                                        </div>
                                    </li>
                                    <li>
                                        <div>
                                            <img src="images/photos/thumb1.png" alt="" class="pull-left" />
                                            <div class="uinfo">
                                                <h5>Draniem Daamul</h5>
                                                <p class="link">
                                                    <a href=""><i class="fa fa-envelope"></i> Message</a>
                                                    <a href=""><i class="fa fa-phone"></i> Call</a>
                                                </p>
                                            </div>
                                        </div>
                                    </li>
                                    <li>
                                        <div>
                                            <img src="images/photos/thumb2.png" alt="" class="pull-left" />
                                            <div class="uinfo">
                                                <h5>Therineka Chonpe</h5>
                                                <p class="link">
                                                    <a href=""><i class="fa fa-envelope"></i> Message</a>
                                                    <a href=""><i class="fa fa-phone"></i> Call</a>
                                                </p>
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                            </div>

                        
                        <br />
                                                
                    </div><!-- col-md-4 -->
                </div><!--row-->
                
                  <div class="maincontent">
            <div class="maincontentinner">
                <div id='calendar'></div>
                
                <div class="footer">
	                <div class='row'>
						<div class='col-xs-12 col-md-3 col-md-push-9 text-center'>
							<div class='social'>
								<a href="http://www.facebook.com/XavierUniversity" target="_blank"><span class="fa fa-facebook-square fa-2x" aria-label="Xavier on Facebook"></span></a>
								<a href="http://twitter.com/XavierUniv" target="_blank"><span class="fa fa-twitter-square fa-2x"  aria-label="Xavier on Twitter"></span></a>
								<a href="https://www.linkedin.com/groups?gid=65551&trk=hb_side_g" target="_blank"><span class="fa fa-linkedin-square fa-2x" aria-label="Xavier on LinkedIn"></span></a>
								<a href="https://www.youtube.com/user/xavieruniversity" target="_blank"><span class="fa fa-youtube-square fa-2x" aria-label="Xavier on YouTube"></span></a>
								<a href="http://instagram.com/xavieruniversity" target="_blank"><span class="fa fa-instagram fa-2x"  aria-label="Xavier on Instagram"></span></a>
							</div>
						</div>
						<div class='legal col-xs-12 col-md-6 col-md-pull-3 col-md-offset-3 text-center'>
							<div class='vcard'>
								<div class='org'>Xavier University</div>
								<div class='adr'>
									<span class='street-address'>3800 Victory Parkway</span>
									<span class='locality'>Cincinnati</span>, <span class='region'>Ohio</span> <span class='postal-code'>45207</span>
									<span class='tel'>513-745-3000</span>
								</div>
							</div>
							<div class='copyright'>&copy; 2016 Xavier University. All rights reserved.</div>
						</div>
					</div><!-- /row -->

                </div><!--footer-->
                
            </div><!--maincontentinner-->
        </div><!--maincontent-->        
    </div><!--rightpanel-->
    
</div><!--mainwrapper-->
<script type="text/javascript">
    jQuery(document).ready(function() {
        
      /* simple chart
		var flash = [[0, 11], [1, 9], [2,12], [3, 8], [4, 7], [5, 3], [6, 1]];
		var html5 = [[0, 5], [1, 4], [2,4], [3, 1], [4, 9], [5, 10], [6, 13]];
       var css3 = [[0, 6], [1, 1], [2,9], [3, 12], [4, 10], [5, 12], [6, 11]];
			
		function showTooltip(x, y, contents) {
			jQuery('<div id="tooltip" class="tooltipflot">' + contents + '</div>').css( {
				position: 'absolute',
				display: 'none',
				top: y + 5,
				left: x + 5
			}).appendTo("body").fadeIn(200);
		}
	
			
		var plot = jQuery.plot(jQuery("#chartplace"),
			   [ { data: flash, label: "Flash(x)", color: "#6fad04"},
              { data: html5, label: "HTML5(x)", color: "#06c"},
              { data: css3, label: "CSS3", color: "#666"} ], {
				   series: {
					   lines: { show: true, fill: true, fillColor: { colors: [ { opacity: 0.05 }, { opacity: 0.15 } ] } },
					   points: { show: true }
				   },
				   legend: { position: 'nw'},
				   grid: { hoverable: true, clickable: true, borderColor: '#666', borderWidth: 2, labelMargin: 10 },
				   yaxis: { min: 0, max: 15 }
				 });
		
		var previousPoint = null;
		jQuery("#chartplace").bind("plothover", function (event, pos, item) {
			jQuery("#x").text(pos.x.toFixed(2));
			jQuery("#y").text(pos.y.toFixed(2));
			
			if(item) {
				if (previousPoint != item.dataIndex) {
					previousPoint = item.dataIndex;
						
					jQuery("#tooltip").remove();
					var x = item.datapoint[0].toFixed(2),
					y = item.datapoint[1].toFixed(2);
						
					showTooltip(item.pageX, item.pageY,
									item.series.label + " of " + x + " = " + y);
				}
			
			} else {
			   jQuery("#tooltip").remove();
			   previousPoint = null;            
			}
		
		});
		
		jQuery("#chartplace").bind("plotclick", function (event, pos, item) {
			if (item) {
				jQuery("#clickdata").text("You clicked point " + item.dataIndex + " in " + item.series.label + ".");
				plot.highlight(item.series, item.datapoint);
			}
		});
    	*/
        
        //datepicker
        jQuery('#datepicker').datepicker();
        
        // tabbed widget
        jQuery('.tabbedwidget').tabs();
        
        
    
    });
</script>
</body>
</html>
