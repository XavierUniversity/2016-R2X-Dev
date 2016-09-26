financial-literacy<cfcomponent>
	<cffunction name="generateContent" access="public" returntype="string">
		<cfargument name="pageIn" type="string" required="yes">
	
    	<cfsavecontent variable="content">
        	<cfoutput>
        
        	<cfswitch expression="#arguments.pageIn#">
            
            	<!--- Why Xavier? The Xavier Advantage --->
                <cfcase value="advantage">
                                           
                    <p class="static-head-descr">There are many reasons to choose Xavier as your college <cfif session.studentType EQ 'T'>to transfer<cfelse>for the next four years</cfif>. Here is a listing of some opportunities that our students feel make their time at Xavier an even richer and broader experience. Be sure to check out the links for even more information.</p>
                    
                    <a name="study-abroad"></a>
                    <h3 class="title">Study Abroad</h3>
                    
                    <p>It's a chance to enlarge the classroom beyond campus, beyond Cincinnati; broaden your perspective and understanding of the world. Xavier offers a variety of ways to study abroad and to immerse yourself in another culture. <a target="_blank" href="http://www.xavier.edu/study-abroad/">Learn more &raquo;</a></p>
                    
                    <a name="honors"></a>
                    <h3 class="title">Honors Program</h3>
                    
                    <p>Xavier offers three honors programs which have their unique qualities, yet all offer participation in a unique fraternity of highly-motivated students and top-notch professors. The programs are challenging but the rewards great, and the amenities are designed to augment and support the stepped-up expectations. <a target="_blank" href="http://www.xavier.edu/honors/">Learn more &raquo;</a></p>
                    
                    <p><strong>University Scholars</strong></p>
                    
                    <p>Courses are held in the University's Core Curriculum. Admission to the program is by invitation and other interested students can apply.</p>
                    
                    <p><strong>Honors AB Program</strong></p>
                    
                    <p>This is Xavier's first and oldest honors program. True to Xavier's Jesuit heritage, the program emphasizes the interdisciplinary study of philosophy and the classics. Admission is by application only.</p>
                    
                    <p><strong>Philosophy, Politics &amp; the Public</strong></p>
                    
                    <p>Interdisciplinary in nature and rigorous in its pursuits, it's ideally suited for the student who enjoys experiential learning situations and is committed to becoming an active and engaged citizen in the public sphere. Admission is by application only.</p>
                    
                    <a name="core"></a>
                    <h3 class="title">Core Curriculum</h3>
                    
                    <p>The core curriculum embodies Xavier's mission and philosophy of education and serves as the educational foundation for all undergraduate students. Students are exposed to a wide variety of disciplines which encourage critical thinking and problem solving and a study of religious, ethical and moral issues in a rapidly changing society. <a target="_blank" href="http://www.xavier.edu/academic-advising/Core-curriculum.cfm">Learn more &raquo;</a></p>
                    
                    <a name="cincinnati"></a>
                    <h3 class="title">Cincinnati</h3>
                    
                    <p>Xavier is situated in a residential neighborhood of Cincinnati, a metropolitan city with many shops, restaurants, concerts, parks, cultural events and major league sports to enjoy. Students have access to major employers, including 14 Fortune 1000 companies. Networking, internships and co-op opportunities surround the campus. <a target="_blank" href="http://www.xavier.edu/explore/get-local.cfm">Learn more &raquo;</a></p>
                    
                    <a name="career"></a>
                    <h3 class="title">Career Preparation</h3>
                    
                    <p>The overarching goal of the Career Development Office is to help students with their major and career decision making process as well as the transition to professional life. The Career Development Office staff is ready to begin the exploration during the student's freshman year and offers a variety of tools and resources to help a student find their path to a career. <a target="_blank" href="http://www.xavier.edu/career/students/">Learn more &raquo;</a></p>
                
                </cfcase>
                
                <cfcase value="academics">
                                       
                    <p>We know you're a really good student and, like many others, you might be looking 
                    for ideas about what classes to take and majors to pursue. We're here to help plot your degree path.</p>
                    
                    <h3 class="title">Areas of Study</h3>
                    
                    <p>Students at Xavier choose from 90 majors within the three colleges: Arts and Sciences; Social Sciences, Health and Education; and the Williams College of Business. While the options for a particular major are many, all students complete the University's core curriculum, which builds a strong foundation in the liberal arts. Xavier also offers a wide range of minors and co-curricular activities, as well as pre-professional programs in medicine, dentistry, law, pharmacy and veterinary medicine.</p>
                    <p><a href="http://www.xavier.edu/majors/" target="_blank">Learn more about all of Xavier's areas of study.</a></p>
                    <h3 class="title">The Honors Programs at Xavier</h3>
                    
                    <img src="#application.appimagepath#images/about/honors.jpg" class="imageright-border" alt="honors" />
                    <p>The three honors programs (Honors Bachelor of Arts; University Scholars; and Philosophy, 
                    Politics and the Public) are designed for exceptional students who want to participate in 
                    seminar-style classes that probe topics in greater depth and intensity, and push the limits
                    of their critical-thinking skills.</p>
                    
                    <p>The tradition of honors studies at Xavier dates back more than 50 years. Small class 
                    sizes, interdisciplinary coursework, foreign study and a community of fellow students and 
                    teachers characterize the programs. Though each has a unique focus and emphasis, all three 
                    honors programs allow students to pursue a traditional liberal arts curriculum embracing the 
                    humanities, the natural sciences and the social sciences. Infused throughout is the 
                    centuries-old Jesuit emphasis on intellectual values and ethics.</p>
                    
                    <p>Admission is competitive. Students who are accepted take the same core curriculum expected 
                    of all Xavier students, though at an honors level and with additional requirements.</p>
                    
                    <p><a href="http://www.xavier.edu/honors" target="_blank">Learn more about Xavier's honors programs.</a></p>
                    
                    
                    <h3 class="title">Choosing a Major</h3>
                    
                    <img src="#application.appimagepath#images/about/gsc.jpg" class="imageright-border" alt="student center" />
                    <p><strong>The undecided student is not uncommon</strong></p>
                    <p><cfif session.studentType EQ 'T'>Many college freshmen<cfelse>Many high school seniors and college freshmen</cfif> feel uncertain about the subject area they would like to study. Almost a third of the students in a typical freshman class at 
                    Xavier are undecided. Xavier's emphasis on the liberal arts and a balanced education allows 
                    students to explore a number of fields of study; however, the academic advising center guides 
                    students through this period of exploration. Undeclared students are assigned academic advisors 
                    during the freshman and sophomore years.</p>
                    
                    <p><a href="http://www.xavier.edu/undergraduate-admission/life-at-xavier/academic-support.cfm" target="_blank">Learn more about choosing a major and Xavier's academic support services.</a></p>
                    
                    
                    <h3 class="title">AP/IB College Credit</h3>
                    
                    <p><strong>How credits transfer</strong></p>
                    <p>Congratulations, academic high achiever. You've got some Advanced Placement, International Baccalaureate or college courses under your belt. Just get your hands on an official transcript or test results and submit it to the Office of Admission. </p>
                    
                    <p>Click here to review how Xavier grants credit in a number of disciplines on an individual basis for <a href="http://www.xavier.edu/undergraduate-admission/admission-process/ib-chart.cfm" target="_blank">International Baccalaureate</a> and <a href="http://www.xavier.edu/undergraduate-admission/admission-process/ap-chart.cfm" target="_blank">Advanced Placement courses</a><!---, or complete and return our <a href="http://www.xavier.edu/transfer-admission/credit-evaluation.cfm" target="_blank">transcript evaluation form</a>--->.</p>                
                </cfcase>
                
                <cfcase value="cincinnati">
                                           
                    <p class="static-head-descr">Centrally located and easily accessible to more than half of the nation's population, Cincinnati is a vibrant, prosperous city with numerous points of pride.</p>
                    <img src="#application.appimagepath#images/about/cincinnati.jpg" class="imageright-border" alt="cincinnati" />
                    <p>Xavier University's 190-acre campus is located in a residential neighborhood only a short drive from downtown Cincinnati, a diverse, bustling community that <i>Places Rated Almanac</i> calls America's 11th most livable city. Cincinnati is accessible, affordable, safe and blessed with small-town charm, big-city excitement, mild weather and its own famous brand of chili. </p>
                    
                    <p>The nation's 25th largest region, Greater Cincinnati is home to 2 million people, two major league sports teams and the headquarters of 14 Fortune 1000 companies. Cincinnati is located on the banks of the Ohio River and at the convergence of three states: Ohio, Kentucky and Indiana.</p>
                    
                    
                    <h3 class="title">Xavier students' favorite leisure activities include</h3>
                    
                    <ul class="bulletList">
                        <li>Visiting shops and restaurants at nearby <a href="http://hydeparksquare.org/" target="_blank">Hyde Park Square</a></li>
                        <li>Attending outdoor concerts at <a href="http://www.riverbend.org/" target="_blank">Riverbend Music Center</a></li>
                        <li>Viewing the annual <a href="http://www.webn.com/pages/FWX.html" target="_blank">Labor Day fireworks festival</a></li>
                        <li>Enjoying the nation's largest <a href="http://www.oktoberfestzinzinnati.com/okt.aspx" target="_blank">Oktoberfest</a> celebration</li>
                        <li>Shopping at <a href="http://www.kenwoodtownecentre.com" target="_blank">Kenwood Towne Centre</a> and <a href="http://www.shoprookwood.com/" target="_blank">Rookwood Commons</a></li>
                        <li>Cheering the <a href="http://www.goxavier.com" target="_blank">Xavier men's and women's basketball teams</a> on to victory </li>
                        <li>Eating <a href="http://www.skylinechili.com" target="_blank">Skyline Chili</a>, <a href="http://www.graeters.com" target="_blank">Graeter's Ice Cream</a> and <a href="http://www.larosas.com" target="_blank">LaRosa's Pizza</a></li>
                    </ul>
                     
                    <h3 class="title">Professional sports include</h3>
                    <img src="#application.appimagepath#images/about/reds.jpg" class="imageright-border" alt="cincinnati reds" /> 
                    <ul class="bulletList">
                        <li><a href="http://www.bengals.com/" target="_blank">Cincinnati Bengals</a> (football)</li>
                        <li><a href="http://www.cincinnatireds.com" target="_blank">Cincinnati Reds</a> (baseball)</li>
                        <li><a href="http://www.cincytennis.com/" target="_blank">Tennis Masters Series</a> (formerly ATP)</li>
                    </ul>
                    
                    <h3 class="title" style="clear:both;">Cultural Resources include</h3>
                    
                    <ul class="bulletList">
                        <li><a href="http://www.cincinnatiartmuseum.org/" target="_blank">Cincinnati Art Museum</a></li>
                        <li><a href="http://www.cincinnatiballet.com/" target="_blank">Cincinnati Ballet</a></li>
                        <li><a href="http://www.cincinnatiarts.org/aronoff" target="_blank">Aronoff Center for the Arts</a></li>
                        <li><a href="http://www.cincinnatisymphony.org/" target="_blank">Cincinnati Symphony Orchestra</a></li>
                        <li><a href="http://www.contemporaryartscenter.org/" target="_blank">Contemporary Arts Center</a></li>
                        <li><a href="http://www.cincymuseum.org/" target="_blank">Union Terminal</a></li>
                        <li><a href="http://www.freedomcenter.org/" target="_blank">National Underground Railroad Freedom Center</a></li>
                    </ul>
                     
                    <h3 class="title">Amusements</h3>
                    <img src="#application.appimagepath#images/about/aquarium.jpg" class="imageright-border" alt="newport aquarium" />  
                    <ul class="bulletList">
                      <li><a href="http://www.pki.com/" target="_blank">Kings Island Amusement Park</a></li>
                      <li><a href="http://www.cincyzoo.org/" target="_blank">Cincinnati Zoo</a></li>
                      <li><a href="http://www.newportaquarium.com/" target="_blank">Newport Aquarium</a></li>
                      <li><a href="http://www.coneyislandpark.com" target="_blank">Coney Island and Sunlite Pool</a></li>
                      <li><a href="http://www.thebeachwaterpark.com/" target="_blank">The Beach Waterpark</a></li>
                      <li><a href="http://www.newportonthelevee.com" target="_blank">Newport on the Levee</a></li>
                    </ul>                
            	</cfcase>
                
                <cfcase value="study-abroad">                            
                    <p class="static-head-descr">While studying at Xavier many students choose to enhance their experience through participation in a study abroad program. The Center for International Education (CIE) will work with students individually to facilitate a successful study abroad experience. Some Xavier students have recently studied in Argentina, Australia, Austria, Costa Rica, Spain, Nicaragua, and South Africa.</p>
                    
                    <h3 class="title">Faculty-Led Study Abroad Opportunities</h3>
                    <p>Xavier University offers many opportunities for students to study abroad with Xavier faculty members.</p>
                    <div class="row">
	                    <div class="small-12 medium-6 columns">
		                    <ul class="bulletList">
			                    <li>Australia</li>
								<li>Douala, Cameroon</li>
								<li>Quebec/Montreal, Canada</li>
								<li>Costa Rica</li>
								<li>London, England</li> 
								<li>Paris, France </li>
								<li>Guatemala</li>
								<li>Greece </li>
		                    </ul>
	                    </div>
	                    <div class="small-12 medium-6 columns">
		                    <ul class="bulletList">
			                    <li>Ireland</li>
								<li>Jerusalem, Israel</li>
								<li>Rome, Italy </li>
								<li>Maastricht, Netherlands</li>
								<li>Lima/Machu Pichu, Peru</li>
								<li>Comillas, Spain</li>
								<li>&hellip;and more</li>
		                    </ul>
	                    </div>
                    </div>
                    
                    <h3 class="title">Direct Exchange Programs</h3>
                    
                    <p>Xavier students may take advantage of exchange agreements with several international universities. A Xavier student pays the equivalent of tuition and fees at home and then studies at one of these universities while a student from that institution studies at Xavier.</p>
                    
                    <ul class="bulletList">
                        <li>Sophia University - Tokyo, Japan</li>
                        <li>Sogang University - Seoul, South Korea</li>
                        <li>Universidad de Valencia - Valencia, Spain</li>
                        <li>Universite de Marne-la-Vallee - Paris, France</li>
                        <li>Katholische Universitat Eichstatt - Eichstatt, Germany</li>
                        <li>&hellip;and more</li>
                    </ul>
                                  
                    <h3 class="title">Solidarity Semester: Nicaragua</h3>
                    
                    <p>Xavier's Solidarity Semester experience combines 12-15 credit hours of academic study with volunteer work in the community under the guidance and supervision of Xavier University faculty.  Integration and reflection are key components to this program.  2015 marks Xavier's 20th year in Managua.</p>
                    
                    <h3 class="title">Other Study Abroad Opportunities</h3>
                    <p>Beyond faculty-led and direct exchange opportunities, students may choose to participate in academic year, semester, and/or short term program options through outside program providers.  The CIE works with students to select the program that best suits their academic, financial, and personal needs.</p>
                    
                    <h3 class="title">Other International Opportunities</h3>
                    
                    <p>Xavier offers many other opportunities to study abroad.</p>
                    
                    <ul class="bulletList">
	                    <li>Brueggeman Fellows Program</li>
						<li>Alternative Breaks Program</li>
						<li>Guatemala Medical Mission</li>
						<li>International Coffee Hour</li>
						<li>International related student organizations</li>
                    </ul>
                </cfcase> 
                
                <cfcase value="jesuit">                    
                    <!---<cfif findNoCase('student',application.applicationname) gt 0>
                    	<h3 style="padding-bottom: .5em; margin-bottom: .5em; border-bottom: 1px solid ##999;"><a href="http://www.xavier.edu/cfj/retreats-and-discernment/GetAway.cfm" target="_blank">&raquo; Sign up now for the GetAway Retreat for first-year students, September 13-14</h3>
                      
                    </cfif>--->
                    <div class="videowrapper">
                    <iframe width="560" height="315" frameborder="0" src="https://www.youtube.com/embed/a4k_N4OCJeI?rel=0" allowfullscreen=""></iframe>
                    </div>
                    <p><a href="https://roadto.xavier.edu/documents/R2X-Jesuit-Identity.pdf" target="_blank">View a transcript of the Jesuit Identity video</a> (PDF)</p>
                    <h3 class="title">Whole Person</h3>
                    <img src="https://roadto.xavier.edu/images/about/service.jpg" class="imageright-border" alt="" />
                    <p>Book smarts will only get you so far. At Xavier,  you'll develop knowledge for sure. But you'll also develop values,  spiritual growth, responsibility for others and a love for learning -  the stuff that really prepares you to function as an active member of  the global community.</p>
                    <p>Formal instruction is only one path to an education at Xavier. <a href="http://www.xavier.edu/cfj/" target="_blank">The Dorothy Day Center for Faith and Justice</a> is a place where you can more fully engage. Our mission is to challenge and support students as they deepen their spiritual lives, pursue justice, and promote pluralism. As a Jesuit Catholic University, we are committed to deepening our recognition of the sacred and pursuing the common good. We seek to equip students to live in a diverse world where faith matters and justice is imperative through retreats, monthly or weekly service, avenues to explore social issues, worship opportunities, a whole host of interest groups and more. The Center is built on the Ignatian invitation to find God in all things and the principle of solidarity. Check out our website to explore the opportunities to engage in faith, service, and justice you&rsquo;ll have over the next four years. One such opportunity is the <a href="http://www.xavier.edu/cfj/first-year/GetAway-for-First-Year-Students.cfm" target="_blank">GetAway Retreat</a> which is a 24 hour retreat for first year students.</p>
                    <h3 class="title">Jesuit Values</h3>
                    <p>Xavier University considers the <a href="http://www.xavier.edu/mission-identity/heritage-tradition/ignatian-heritage-and-vision.cfm">Gifts of our Ignatian Heritage</a> to be:</p>
                    <p><strong>MISSION</strong> invites us to understand the history and importance of our Jesuit heritage and Ignatian spirituality. Mission focuses on the centrality of academic excellence, grounded in a Catholic faith tradition.</p>
                    <p><strong>REFLECTION</strong> invites us to pause and consider the world around us and our place within it.</p>
                    <p><strong>DISCERNMENT</strong> invites us to be open to God's spirit as we consider our feelings and rational thought in order to make decisions and take action that will contribute good to our lives and the world around us.</p>
                    <p><strong>SOLIDARITY</strong> and <strong>KINSHIP</strong> invites us to walk alongside and learn from our companions, both local and afar, as we journey through life.</p>
                    <p><strong>SERVICE ROOTED IN JUSTICE AND LOVE</strong> invites us to invest our lives into the well-being of our neighbors, particularly those who suffer injustice</p>
                    <h3 class="title">Catholic Heritage</h3>
                    <p>At Xavier, faith and learning are partners  dedicated to ultimate truth. Xavier is committed to remain a  &ldquo;university,&rdquo; respecting a wide variety of opinion in the context of  academic freedom. Xavier is also committed to being &ldquo;Catholic&rdquo; and  &ldquo;Jesuit,&rdquo; reflecting on  centuries of Catholic and Jesuit wisdom and how  that wisdom sheds light on the perplexing questions of today.</p>
                    <h3 class="title">Core Curriculum</h3>
                    <p>As a Jesuit Catholic institution, Xavier's <a href="http://www.xavier.edu/undergraduate-admission/life-at-xavier/jesuit-tradition.cfm" target="_blank">core curriculum</a>   is built around courses in theology, philosophy and ethics. These   courses help you better understand how to apply the knowledge you gain   during the other 50-odd credit-hours you need for a bachelor&rsquo;s degree.</p>                
                </cfcase>               
                
                <cfcase value="deposit">
                    <h1>Submit Your Deposit</h1>
                    
                    <p>Our goal is to make your college experience as enjoyable and hassle-free as possible. You have two options: Deposit online or deposit via mail. </p>
                    <p><strong>Tuition Deposit:</strong> <cfif session.international>USD </cfif> $200 tuition deposit <cfif not session.international>postmarked<cfelse>submitted</cfif> by May 1, 2016, to confirm your enrollment.</p>
                    <p><strong>Housing Deposit:</strong> <cfif session.international>USD </cfif> $200 Housing deposit <cfif not session.international>postmarked<cfelse>submitted</cfif> by May 1, 2016. Housing is assigned on a first-come-first-served basis, based on your deposit date.</p>
                    
      				<form id="depositForm" action="https://www.xavier.edu/deposit/index.cfm" method="post">
                    	<input type="hidden" name="bannerid" value="#session.bannerid#">
                        <input type="hidden" name="firstname" value="#session.firstname#">
                        <input type="hidden" name="lastname" value="#session.lastname#">
                        <input type="hidden" name="birthdate" value="#dateFormat(session.birthdate,'mm-dd-yyyy')#">
                        <input type="hidden" name="phone" value="#session.homephone#">
                        <input type="hidden" name="entryTerm" value="#trim(session.entryTerm)#">
						<input type="hidden" name="studentType" value="#session.studentType#">
                    </form>
                    
                    <a href="http://www.xavier.edu/deposit/" onClick="$('##depositForm').submit(); return false;" class="button expand success" target="_blank">DEPOSIT ONLINE NOW</a>  
                    <cfif not session.international>
                        <p>If you have any questions regarding your housing/tuition payment, feel free to contact the Office of Admission at 1-877-XU-ADMIT (982-3648) or 513-745-3301. E-mail us at <a href="mailto:xuadmit@xavier.edu">xuadmit@xavier.edu</a>.</p>
                    <cfelse>
                        <p>If you have any questions regarding your housing/tuition payment, feel free to contact the Center for International Education at +1-513-745-2864 or email us at <a href="mailto:international@xavier.edu">international@xavier.edu</a>.</p>
                    </cfif>
                    
                    <cfif not session.international>
                        <h3 class="title">Deposit By Mail</h3>
                        
                        <p>Deposits must be postmarked by May 1, 2016, for the Fall 2016 semester. If you're applying for the Spring 2016 semester, submit the tuition deposit as indicated on your letter of acceptance.</p>
                        <blockquote>
                        Office of Admission<br />
                        Xavier University<br />
                        3800 Victory Parkway<br />
                        Cincinnati, Ohio 45207-5131
                        </blockquote>
                    </cfif>
                    
                    <h3 class="title">Refunds</h3>
                    
                    <p>Tuition and housing deposits for the Fall 2016 semester are refundable before May 1, 2016. <b>Please note that deposits made by students accepted to the School of Nursing are nonrefundable.</b>
                    A written request for a refund must be submitted to the Office of Admission and <cfif not session.international>postmarked<cfelse>submitted</cfif> by May 1, 2016.</p>
                    
                    <cfif not session.international>
                        <p>If you have any questions regarding your housing/tuition payment, feel free to contact the Office of Admission at 1-877-XU-ADMIT (982-3648) or 513-745-3301. E-mail us at <a href="mailto:xuadmit@xavier.edu">xuadmit@xavier.edu</a>.</p>
                    <cfelse>
                        <p>If you have any questions regarding your housing/tuition payment, feel free to contact the Center for International Education at +1-513-745-2864 or email us at <a href="mailto:international@xavier.edu">international@xavier.edu</a>.</p>
                    </cfif>
                
                
                </cfcase>
                
                <cfcase value="badges">
                	<h3 class="title">Site-Wide Leaders</h3>
                	<div class="row">
                		<div class="small-4 columns text-center">
	                		<a name="dartagnan">
		                		<img src="#application.appimagepath#images/badges/dartagnan.png" alt="dartagnan badge" />
	                		</a>
                		</div>
						<div class="small-8 columns">
							<p>Earn the D'Artagnan badge by accumulating the most points of anyone on the Road to Xavier.</p>
						</div>
					</div>
					<hr />
					<div class="row">
						<div class="small-4 columns text-center">
							<a name="minidartagnan">
								<img src="#application.appimagepath#images/badges/minidartagnan.png" alt="mini dartagnan badge" />
							</a>
						</div>
						<div class="small-8 columns">
							<p>Earn the Mini D'Artagnan badge by accumulating the most points of anyone on the Road to Xavier in the last month.</p>
						</div>
					</div>
					<hr />
					<div class="row">
						<div class="small-4 columns text-center">	
							<a name="microdartagnan">
								<img src="#application.appimagepath#images/badges/microdartagnan.png" alt="micro dartagnan badge" />
							</a>
						</div>
  						<div class="small-8 columns">
  							<p>Earn the Micro D'Artagnan badge by accumulating the most points of anyone on the Road to Xavier in the last 2 weeks.</p>
						</div>
					</div>
					<hr />
					<div class="row">
						<div class="small-4 columns text-center">
							<a name="nanodartagnan">
								<img src="#application.appimagepath#images/badges/nanodartagnan.png" alt="nano dartagnan badge" />
							</a>
						</div>
						<div class="small-8 columns">
							<p>Earn the Nano D'Artagnan badge by accumulating the least points of anyone on the Road to Xavier.
						</div>
					</div>
					<hr />
					<div class="row">
						<div class="small-4 columns text-center">
							<a name="blueblob">
								<img src="#application.appimagepath#images/badges/blueblob.png" alt="blue blob badge" />
							</a>
						</div>
						<div class="small-8 columns">
							<p>Earn the Blue Blob badge by accumulating the second most points of anyone on the Road to Xavier.</p>
						</div>
					</div>
					<hr />
					<div class="row">
						<div class="small-4 columns text-center"> <a name="miniblueblob"><img src="#application.appimagepath#images/badges/miniblueblob.png" alt="mini blue blob badge" /></a></div>
						<div class="small-8 columns">
							<p>Earn the Mini Blue Blob badge by accumulating the second most points of anyone on the Road to Xavier in the last month.</p>
						</div>
					</div>
					<hr />
					<div class="row">
						<div class="small-4 columns text-center">
							<a name="microblueblob">
								<img src="#application.appimagepath#images/badges/microblueblob.png" alt="micro blue blob badge" />
							</a>
						</div>
						<div class="small-8 columns">
							<p>Earn the Micro Blue Blob badge by accumulating the second most points of anyone on the Road to Xavier in the last 2 weeks.</p>
						</div>
					</div>
					<hr />
					<div class="row">
						<div class="small-4 columns text-center">
						<a name="nanoblueblob">
						<img src="#application.appimagepath#images/badges/nanoblueblob.png" alt="nano blue blob badge" />
						</a>
						</div>
						<div class="small-8 columns">
							<p>Earn the Nano Blue Blob badge by accumulating the second least points of anyone on the Road to Xavier.</p>
						</div>
					</div>
					<hr />
					<div class="row">
						<div class="small-4 columns text-center">
							<a name="ambassador">
								<img src="#application.appimagepath#images/badges/ambassador-OH.png" alt="ambassador badge" />
							</a>
						</div>
						<div class="small-8 columns">
							<p>Earn the ambassador badge by accumulating the most points of anyone from your home state.</p>
						</div>
					</div>
					<hr />
					<h3 class="title">Experience Level Badges</h3>
					<div class="row">
						<div class="small-4 columns text-center">
							<a name="novice">
								<img src="#application.appimagepath#images/badges/novice.png" alt="novice badge" />
							</a>
						</div>
						<div class="small-8 columns">
							<p>Anyone with less than #numberFormat(application.experiencedPoints)# points earns this badge.</p>
						</div>
					</div>
					<hr />
					<div class="row">
						<div class="small-4 columns text-center">
							<a name="experienced">
								<img src="#application.appimagepath#images/badges/experienced.png" alt="experienced badge" />
							</a>
						</div>
						<div class="small-8 columns">
							<p>Earn this badge by accumulating over #numberFormat(application.experiencedPoints)# points.</p>
						</div>
					</div>
					<hr />
					<div class="row">
						<div class="small-4 columns text-center">
							<a name="expert">
								<img src="#application.appimagepath#images/badges/expert.png" alt="expert badge" />
							</a>
						</div>
						<div class="small-8 columns">
							<p>Earn this badge by accumulating over #numberFormat(application.expertPoints)# points.</p>
						</div>
					</div>
					<hr />
					<div class="row">
						<div class="small-4 columns text-center">
							<a name="uberexpert">
								<img src="#application.appimagepath#images/badges/uberexpert.png" alt="uberexpert badge" />
							</a>
						</div>
						<div class="small-8 columns">
							<p>Earn this badge by accumulating over #numberFormat(application.uberexpertPoints)# points.</p>
						</div>
					</div>
					<hr />
					<h3 class="title">Activity Badges</h3>
					<cfif dateCompare(now(),application.bookworm_start) GT 0>
					<div class="row">
						<div class="small-4 columns text-center">
							<a name="bookworm">
								<img src="#application.appimagepath#images/badges/bookworm.png" alt="bookworm badge" />
							</a>
						</div>
						<div class="small-8 columns">
							<p>Earn the bookworm badge by filling out the favorite books section of your profile.</p>
						</div>
					</div>
					<hr />
					</cfif>
					<cfif dateCompare(now(),structFind(application,'couch_potato_start')) GT 0>
					<div class="row">
						<div class="small-4 columns text-center">
							<a name="couch_potato">
							<img src="#application.appimagepath#images/badges/couch_potato.png" alt="couch potato badge" />
							</a>
							</div>
					<div class="small-8 columns">
						<p>Earn the couch potato badge by filling out the favorite tv shows section of your profile.</p>
					</div>
					</div>
					<hr />
					</cfif>
					<cfif dateCompare(now(),application.facebook_badge) GT 0>
					<div class="row">
						<div class="small-4 columns text-center">
							<a name="facebook">
								<img src="#application.appimagepath#images/badges/facebook.png" alt="facebook badge" />
							</a>
						</div>
						<div class="small-8 columns">
							<p>Earn the facebook badge by adding your facebook link to your profile.</p>
						</div>
					</div>
					<hr />
					</cfif>
					<div class="row">
						<div class="small-4 columns text-center">
							<a name="frequent">
								<img src="#application.appimagepath#images/badges/frequent.png" alt="frequent badge" />
							</a>
						</div>
						<div class="small-8 columns">
							<p>Earn the frequent visitor badge by logging in often.</p>
						</div>
					</div>
					<hr />
					<cfif dateCompare(now(),application.gamer_start) GT 0>
					<div class="row">
						<div class="small-4 columns text-center">
							<a name="gamer">
								<img src="#application.appimagepath#images/badges/gamer.png" alt="gamer badge" />
							</a>
						</div>
						<div class="small-8 columns">
							<p>Earn the gamer badge by adding your favorite video games to your profile.</p>
						</div>
					</div>
					<hr />
					</cfif>
					<cfif dateCompare(now(),application.instagram_badge) GT 0>
					<div class="row">
						<div class="small-4 columns text-center">
							<a name="instagram">
								<img src="#application.appimagepath#images/badges/instagram.png" alt="instagram badge" />
							</a>
						</div>
						<div class="small-8 columns">
							<p>Earn the Instagram badge by adding your Instagram link to your profile.</p>
						</div>
					</div>
					<hr />
					</cfif>
					<cfif dateCompare(now(),application.mobile_start) GT 0>
					<div class="row">
						<div class="small-4 columns text-center">
							<a name="mobile">
								<img src="#application.appimagepath#images/badges/mobile.png" alt="mobile badge" />
							</a>
						</div>
						<div class="small-8 columns">
							<p>Earn the mobile badge by regularly accessing the mobile site, <a href="https://r2.xavier.edu" target="_blank">https://r2.xavier.edu</a> from your mobile device.</p>
						</div>
					</div>
					<hr />
					</cfif>
					<cfif dateCompare(now(),structFind(application,'movie_lover_start')) GT 0>
					<div class="row">
						<div class="small-4 columns text-center">
							<a name="movie_lover">
								<img src="#application.appimagepath#images/badges/movie_lover.png" alt="movie lover badge" />
							</a>
						</div>
						<div class="small-8 columns">
							<p>Earn the movie lover badge by filling out the favorite movies section of your profile.</p></div>
						</div>
					<hr />
					</cfif>
					<cfif dateCompare(now(),structFind(application,'night_owl_start')) GT 0>
					<div class="row">
						<div class="small-4 columns text-center">
							<a name="night_owl">
								<img src="#application.appimagepath#images/badges/night_owl.png" alt="night owl badge" />
							</a>
						</div>
						<div class="small-8 columns">
							<p>Earn the night owl badge by regularly visiting in the wee hours of the night.</div>
						</div>
					<hr />
					</cfif>
					<cfif dateCompare(now(),application.photogenic_start) GT 0>
					<div class="row">
						<div class="small-4 columns text-center">
							<a name="photogenic">
								<img src="#application.appimagepath#images/badges/photogenic.png" alt="photogenic badge" />
							</a>
						</div>
						<div class="small-8 columns">
							<p>Earn the photogenic badge by uploading a picture to your profile. The more pictures you add, the more points you get.</p>
						</div>
					</div>
					<hr />
					</cfif>
					<cfif dateCompare(now(),structFind(application,'rock_on_start')) GT 0>
					<div class="row">
						<div class="small-4 columns text-center">
							<a name="rock_on">
								<img src="#application.appimagepath#images/badges/rock_on.png" alt="rock on badge" />
							</a>
						</div>
						<div class="small-8 columns">
							<p>Earn the rock_on badge by filling out the favorite bands section of your profile.</p>
						</div>
					</div>
					<hr />
					</cfif>
					<div class="row">
						<div class="small-4 columns text-center">
						<a name="social">
						<img src="#application.appimagepath#images/badges/social.png" alt="social badge" />
						</a>
						</div>
						<div class="small-8 columns">
							<p>Earn the social badge by adding at least 5 friends on the Your Space tab.</p>
						</div>
					</div>
					<hr />
					<cfif dateCompare(now(),application.twitter_badge) GT 0>
					<div class="row">
						<div class="small-4 columns text-center">
							<a name="twitter">
								<img src="#application.appimagepath#images/badges/twitter.png" alt="twitter badge" />
							</a>
						</div>
						<div class="small-8 columns">
							<p>Earn the twitter badge by adding your twitter link to your profile.</p>
						</div>
					</div>
					<hr />
					</cfif>
					<cfif dateCompare(now(),application.video_start) GT 0>
					<div class="row">
						<div class="small-4 columns text-center">
							<a name="video">
								<img src="#application.appimagepath#images/badges/video.png" alt="video badge" />
							</a>
						</div>
						<div class="small-8 columns">
							<p>Earn the video badge by adding a video to your profile. How about a video of your grade school basketball game or maybe your favorite music video?</p>
						</div>
					</div>
					<hr />
					</cfif>
					<div class="row">
						<div class="small-4 columns text-center">
							<a name="currentStudent">
							<a name="headedToXavier">
								<img src="#application.appimagepath#images/badges/headedToXavier.png" alt="headed to xavier badge" />
							</a></a>
						</div>
						<div class="small-8 columns">
							<p>Earn the 'Headed to Xavier' badge by indicating on your profile that you are headed to Xavier.</p>
						</div>
					</div>
					<hr />
					<cfif dateCompare(now(),application.x_challenge_jan_start) GT 0>
					<h3 class="title">The Challenge Badges</h3>
					</cfif>
					<cfif dateCompare(now(),application.x_challenge_jan_start) GT 0>
					<div class="row">
						<div class="small-4 columns text-center">
							<a name="challenge_jan">
								<img src="#application.appimagepath#images/badges/challenge_jan.png" alt="challenge badge" />
							</a>
						</div>
						<div class="small-8 columns">
							<p>Earn The X Challenge: The Class of ##XU2020 badge by participating in The X Challenge: Class of ##XU2020 Edition.</p>
						</div>
					</div>
					<hr />
					</cfif>
					<cfif dateCompare(now(),application.x_challenge_feb_start) GT 0>
					<div class="row">
						<div class="small-4 columns text-center">
							<a name="challenge_feb">
								<img src="#application.appimagepath#images/badges/challenge_feb.png" alt="challenge badge" />
							</a>
						</div>
						<div class="small-8 columns">
							<p>Earn The X Challenge: Get ##Xcited About Xavier badge by participating in The X Challenge: Get ##Xcited About Xavier.</p>
						</div>
					</div>
					<hr />
					</cfif>
					<cfif dateCompare(now(),application.x_challenge_mar_start) GT 0>
					<div class="row">
						<div class="small-4 columns text-center">
							<a name="challenge_mar">
								<img src="#application.appimagepath#images/badges/challenge_mar.png" alt="challenge badge" />
							</a>
						</div>
						<div class="small-8 columns">
							<p>Earn The X Challenge: Get Social @ Xavier.</p>
						</div>
					</div>
					<hr />
					</cfif>
					<cfif dateCompare(now(),application.x_challenge_apr_start) GT 0>
					<div class="row">
						<div class="small-4 columns text-center">
							<a name="challenge_apr">
								<img src="#application.appimagepath#images/badges/challenge_apr.png" alt="challenge badge" />
							</a>
						</div>
						<div class="small-8 columns">
							<p>Earn The X Challenge: Show your ##XavierPride with a selfie in your favorite Xavier gear.</p>
						</div>
					</div>
					<hr />
					</cfif>
					
					<h3 class="title">Special Badges</h3>
					<div class="row">
						<div class="small-4 columns text-center">
							<a name="first_login">
								<img src="#application.appimagepath#images/badges/first_login.png" alt="first login badge" />
							</a>
						</div>
						<div class="small-8 columns">
							<p>The First Login badge is awarded to the first person to log in to the Road to Xavier each year. Only one First Login badge is awarded.</p>
						</div>
					</div>
					<hr />
					<div class="row">
						<div class="small-4 columns text-center">
							<a name="first_deposit">
								<img src="#application.appimagepath#images/badges/first_deposit.png" alt="first deposit badge" />
							</a>
						</div>
						<div class="small-8 columns">
							<p>The First Deposit badge is awarded to the first person to deposit each year. Only one First Deposit badge is awarded.</p>
						</div>
					</div>
					<hr />
					<p>Stay tuned! More badges and challenges will be added throughout the year.</p>

                
                
                </cfcase>
                
                <!--- *** Money Matters Pages *** --->
                
                <cfcase value="MMinvestment">                    
                    <p class="static-head-descr">It may be hard to fully understand now, but the closer you get to graduation from college the more you'll appreciate the value of a Xavier education. Why? The competition for getting good jobs and getting into good graduate schools may be fierce, but Xavier graduates excel. <!---Within eight months of graduating, 81 percent of the class of 2009 were either employed or in graduate school. That's why a Xavier degree becomes, quite literally, money in the bank.---></p>
                    
                    <h3 class="title">Fortune 1000 Companies</h3>
                    
                    <p><img src="https://roadto.xavier.edu/images/money/investment.jpg" class="imageright-border" alt="investment" />Greater Cincinnati is headquarters for 14 Fortune 1000 companies&mdash;more than Midwest cities such as Columbus, Pittsburgh or Indianapolis&mdash;and where many Xavier graduates land jobs. These include:</p>
                    
                    <ul class="bulletList">
                        <li>AK Steel</li>
                        <li>American Financial Corp.</li>
                        <li>Ashland Inc.</li>
                        <li>Chiquita Brands International</li>
                        <li>Cincinnati Financial</li>
                        <li>Cintas Corp</li>
                        <li>Convergys</li>
                        <li>E.W. Scripps Co.</li>
                        <li>Fifth Third Bancorp</li>
                        <li>General Cable</li>
                        <li>The Kroger Company</li>
                        <li>Macy's, Inc.</li>
                        <li>Omnicare</li>
                        <li>Procter &amp; Gamble</li>
                        <li>Western &amp; Southern</li>
                   </ul>
                    
                   <h3 class="title">Newly Minted Careers</h3>
                    
                 <p><img src="https://roadto.xavier.edu/images/money/fortune500.jpg" class="imageright-border" alt="fortune 500" />Xavier graduates have recently been hired by employers such as these:</p>
                    
                    <ul class="bulletList">
                        <li>AC Nielson BASES</li>
                        <li>Bank One</li>
                        <li>Cincinnati Children's Hospital</li>
                        <li>Cincinnati Reds</li>
                        <li>Cintas Corporation</li>
						<li>Convergys</li>
						<li>Deloitte & Touche</li>
						<li>Federated Corporate</li>
						<li>Fidelity Investments</li>
						<li>Fifth Third Bank</li>
						<li>Google</li>
						<li>Humana</li>
						<li>The Kroger Company</li>
						<li>Ohio Legislative Service Commission</li>
						<li>Peace Corps</li>
						<li>Pfizer</li>
						<li>Procter & Gamble</li>
						<li>TriHealth</li>
					</ul>
                    
                    
					<h3 class="title">Grad Schools Attended By Recent Xavier Graduates</h3>
                    <img src="https://roadto.xavier.edu/images/money/mintedcareers.jpg" class="imageright-border" alt="careers" />
                    <ul class="bulletList">
                        <li>Xavier</li>
                        <li>Notre Dame</li>
                        <li>Johns Hopkins</li>
                        <li>Harvard</li>
                        <li>Georgetown</li>
                        <li>Loyola - Chicago</li>
                        <li>George Washington</li>
                        <li>Ohio State</li>
                        <li>Vanderbilt</li>
                        <li>Yale</li>
                    </ul>
                </cfcase>
                
                <cfcase value="MMtypes">

                    <p>What kind of aid can you expect to find in your award package? Depending on your family's circumstances, you might have a variety of options. Some types of financial aid require repayment while others do not. Below is an overview of the different types of aid.</p>
                    
                    <h3 class="title">Grants</h3>
                    
                    <p><img src="https://roadto.xavier.edu/images/money/grantsscholarships.jpg" class="imageright-border" alt="scholarships" />Grants are awarded to students based on financial eligibility.  Grants do not have to be repaid. Amounts awarded vary based on the level of financial need and the number of credit hours.</p>
                    
                    <p>For more information on grants please review the following:</p>
                    
                    <ul class="bulletList">
                        <li><a href="http://www.xavier.edu/financial-aid/undergraduate-grants.cfm##federal" target="_blank">Federal Grants</a></li>
                        <li><a href="http://www.xavier.edu/financial-aid/undergraduate-grants.cfm##ohio<li>" target="_blank">State of Ohio Grants</a></li>
                        <li><a href="http://www.xavier.edu/financial-aid/undergraduate-grants.cfm##x<li>avier" target="_blank">Xavier Grants</a></li>
                        <cfif session.studentType EQ 'T'>
                            <li><a href="http:<li>//www.xavier.edu/transfer-admission/grants.cfm##other_resources" target="_blank">Transfer Grants</a></li>
                        </cfif>
                    </ul>			  
                    
					<h3 class="title">Scholarships</h3>
                    
                    <p>Scholarships are awarded to students based on academic, athletic or artistic talents. Scholarships do not have to be repaid. All Xavier students are automatically considered for scholarships when they apply for admission. </p>
                    
                    <p>For more information on scholarships please review the following:</p>
                    
                    <ul class="bulletList">
                        <li><a href="http://www.xavier.edu/undergraduate-admission/Scholarships.cfm" target="_blank">Xavier Scholarships</a></li>
                        <li><a href="http://www.xavier.edu/undergraduate-admission/Private-Scholarships.cfm" target="_blank">Non-Xavier Scholarship List</a></li>

                        <cfif session.studentType EQ 'T'>
                         <li>   <a href="http://www.xavier.edu/transfer-and-adult/transfer-scholarships.cfm##transfer_scholarship" target="_blank">Transfer Scholarships</a></li>
                        <cfelse></cfif>	

                    </ul>
                    
					<h3 class="title">Loans</h3>
                    
                    <p>The Department of Education offers federal loans that can be borrowed in the student's or parent's name.  Other lending institutions offer additional loans which are called alternative loans.  Loans have to be repaid.  Students must be enrolled at least-half time to be eligible for a student loan. Repayment typically begins six months after graduation or if a student drops below part-time status.</p>
    
                    <p>For more information on loans please review the following visit the <a href="http://www.xavier.edu/financial-aid/undergraduate-Loans.cfm" target="_blank">loans page on the Office of Student Financial Assistance website</a>.</p>
                
                </cfcase>
                
                 <cfcase value="MMprocess">
                
                    <p><img src="https://roadto.xavier.edu/images/money/faprocess.jpg" class="imageright-border" alt="process" />Students must complete the <a href="http://www.fafsa.ed.gov" target="_blank">Free Application for Federal Student Aid (FAFSA)</a> to apply for financial aid at Xavier.  The <a href="http://www.fafsa.ed.gov" target="_blank">FAFSA</a> can be completed online.  Students whose FAFSA is received at the federal processor by February 15 will receive priority consideration. </p>
                    <ul>
                        <li> File the FAFSA as soon as possible<br> after Jan. 1.</li>
                        <li> If your taxes will not be completed by Feb. 15, complete
                        the FAFSA using reasonable estimates of your income and taxes
                        to be paid.</li>
                        <li> Use your legal name as it appears on your Social Security
                        card.</li>
                        <li> Do not leave any items blank unless the instructions tell you
                        to skip a question. If a question does not apply to you, write
                        in zero</li>
                        <li> Be sure to list the federal school code for Xavier University in
                        step six of the FAFSA. Xavier's federal school code is 003144.</li>
                        <li> Keep a copy of your FAFSA.</li>
                        <li> Keep copies of your tax returns. You may need them to complete
                        the verification process.</li>
					</ul>
                    
                    <p>Students will receive a Student Aid Report (SAR) from the federal processor within seven days of submitting the FAFSA.  Students (and parents) should review the form for accuracy.  If corrections need to be made they can be done <a href="http://www.fafsa.ed.gov" target="_blank">online</a> or by following the instructions on the SAR.</p>
                    
                    <p>The SAR may indicate that the student's application has been selected for review in a process called verification. If so, the student must submit their and their parents' federal tax return transcripts, along with a completed verification worksheet. If selected, a request for verification documents will be sent to the student by email.</p>
                    
                    <p>Once the Office of Financial Aid has received the institutional Student Aid Report, the student's financial aid eligibility will be determined. The student's financial aid award will be displayed on the Money Matters tab, and they will receive an e-mail notifying them when this is available.
	                    
                    <p>Students are eligible for federal Stafford loans as long as they are accepted into a degree program, plan to enroll at least half-time, and do not have any loans in default.  Students must complete the FAFSA before eligibility can be determined.
    </p>
                
                </cfcase>
                
                
                
                
                <cfcase value="MMglossary">				
                    <dl class="rtxDlist">
                    <img src="https://roadto.xavier.edu/images/money/financialglossary.jpg" class="imageright-border" alt="glossary" />
                        <dt>Cost of Attendance (COA)</dt>
                        <dd>Your total cost of attending a school for one academic year, including tuition and fees, 
                        books and supplies, living expenses and transportation.</dd>
                        
                        <dt>Expected Family Contribution (EFC)</dt>
                        <dd>The amount you and your family will be expected to contribute for an academic year. The 
                        federal government sets the formula that determines your contribution. The EFC is calculated once a FAFSA is successfully submitted.</dd>
                        
                        <cfif NOT session.international>
                        <dt>Free Application for Federal Student Aid (FAFSA)</dt>
                        <dd>This form is used to determine the family's expected contribution; each school uses the information to determine the student's financial aid eligibility.  The FAFSA form is available online at 
                        <a href="http://www.fafsa.ed.gov" target="_blank">www.fafsa.ed.gov</a>. Xavier's federal school code on the FAFSA is 003144.</dd>
                        </cfif>
                        
                        <dt>Student Aid Report (SAR)</dt>
                        <dd>The analysis of the FAFSA that is sent to you. You should check the accuracy of reported 
                        data and make corrections if necessary.</dd>
                        
                        <dt>Fees</dt>
                        <dd>Charges applied to your bill aside from tuition, room and board. They include your student 
                        orientation fee, instructional technology fee and any fees associated with your labs or classes.</dd>
                        
                        <dt>Financial Need/Eligibility</dt>
                        <dd>The difference between the cost of attendance at Xavier and the amount you and your family 
                        are expected to contribute.</dd>
                        
                        <dt>Scholarship</dt>
                        <dd>A gift awarded on the basis of a student's academic accomplishments.</dd>
                        
                        <dt>Grant</dt>
                        <dd>A non-repayable award made to a student on the basis of financial eligibility.</dd>
                        
                        <dt>Loan</dt>
                        <dd>Money borrowed by the student (or parent) which must be repaid in the future.</dd>
                        
                        <cfif NOT session.international>
                        <dt>Federal Work Study (FWS)</dt>
                        <dd>A federally funded program that provides job opportunities to need-qualified Xavier students. 
                        Eligibility is determined according to the results of the FAFSA.</dd>
                        </cfif>
                        
                        <dt>Package</dt>
                        <dd>The total combination of scholarships, grants, work study and loans awarded.</dd>
                    
                    </dl>
                </cfcase>
                
                <cfcase value="MMaddFinance">
                	<h4 style="border-bottom:solid 4px ##0099cc;">Additional Finance Options</h4>
                      <a class="close-reveal-modal">&##215;</a>
                  <div id="content">
                    <p> Listed below are three financing options for educational costs. Please contact your Xavier financial aid counselor for additional information. </p>
                    <p> <strong>Federal Parent Loan for Undergraduate Students (PLUS)</strong> </p>
                    <p> Parents of dependent students may borrow a PLUS loan on behalf of their child. Parents can borrow any amount up to the cost of attendance, less all financial aid awarded. The interest rate is fixed at 6.84 percent. There is a 4.272 percent origination fee. Standard repayment of principal and interest begins 60 days after the final disbursement of the loan. Other repayment options may be available.To apply complete the Direct PLUS Loan Request and Master  Promissory Note (MPN) which are available online at <a href="http://www.studentloans.gov/" target="_blank">www.studentloans.gov</a>. Parents should complete the form June 1<sup>st</sup> or after for the Fall semester. </p>
                    <p> <strong>Student Alternative Loan</strong> </p>
                    <p> Various alternative loans are available for students who need additional financial assistance. There are fixed rate as well as variable rate options. These are commercial loans that require a credit check as well as a credit-worthy cosigner. Apply for these loans through a chosen lender's website or by phone. Students can borrow up to the cost of attendance less any other financial aid that has been awarded. Alternative loan repayment begins six months after graduation, or when a student drops to less than half-time enrollment. For more information on possible lenders or how to apply for these loans, please contact your personal financial aid counselor. </p>
                    <p> <strong>Home Equity Loan</strong> </p>
                    <p> Many financial institutions will lend money on the equity in a family's home. The interest on these loans is normally one and one-half to two points higher  than the prime rate, and the interest is usually deductible on your tax return. Contact a financial institution for specific information and an application. </p>
                  </div>
                </cfcase>
                
                <cfcase value="MMpaymentTerms">
                  <div id="header">
                    <table border="0" width="100%" cellspacing="0" cellpadding="0">
                      <tr>
                        <td align="left"><p> CASH PAYMENT OPTIONS</p></td>
                        <td align="right"><div id="close"><a href="javascript:window.close();">Close Window</a></div></td>
                      </tr>
                    </table>
                  </div>
                  <div id="content">
						<p>For information on Xavier's payment plan and more, visit the <a href="http://www.xavier.edu/payment-plans/" target="_blank">Payment Plan section</a> of the Bursar's FAQ page.</p>	
                  </div>

                </cfcase>
                
                <cfcase value="MMtips">
                    <h4 style="border-bottom:solid 4px ##0099cc;">Tips for Completing the FAFSA</h4>
                 	<ul>
		                <li>File the FAFSA as soon as possible after Jan. 1.</li>
		                <li>If your taxes will not be completed by Feb. 15, complete the FAFSA using reasonable estimates of your income and taxes to be paid.</li>
						<li>Use your legal name as it appears on your Social Security card.</<li>
		                <li>Do not leave any items blank unless the instructions tell you to skip a question. If a question does not apply to you, write in zero</li>
		                <li>Be sure to list the federal school code for Xavier University in step six of the FAFSA. Xavier's federal school code is 003144.</li>
		                <li>Keep a copy of your FAFSA.</li>
		                <li>Keep copies of your tax returns. You may need them to complete the verification process.</li>
                    </ul>
               	</cfcase>
                
                   <cfcase value="visit-left">
                	<!--- Visit Programs --->    

                    <h3 class="title">XU Preview - Sunday, April 10</h3>
                    <img src="/images/visit/xavier-preview-day.jpg" class="imageright-border" alt="preview day" />
                    <!---<p><a href="http://em.422x.com/xavieru/Admissions/EventInfoPrivate.aspx?EventId=0199b045-d746-4e18-a341-977a5dd00385" target="_blank"><img src="/images/visit/register-button.png" alt="Register" /></a></p>--->
                    <p>As an admitted student, we invite you and your parents to join us at XU Preview on Sunday, April 10. The day is designed to help you get a feel for what it would be like to be a student on our campus. You will have the chance to meet and interact with faculty members in your area of interest. You will spend the day experiencing life as a Xavier student and have the chance to meet current Xavier students and other future Muskie classmates.
                    
                    <!---<p><b>Submit your deposit on or before Preview Day and be among the first to pre-register for your fall classes during your visit.</b></p>--->
                    <br><br><a href="/documents/Xavier Preview Day.pdf" target="_blank" style="font-weight: bold;"><i class="fa fa-file-text-o"></i> View the Agenda</a></p>
                    
                    <!---<p>Xavier Preview Day registration is now closed. Please call the Office of Admission for more information.(877) XU-ADMIT</p>--->
                    
                    <cfif findNoCase('student',application.applicationname) gt 0>
                        
                       <h3>Directions and Travel Info</h3> 
     
                        <ul>
                        
                        <li><a href="http://www.xavier.edu/about/documents/campusmap.pdf" target="_blank">Campus map</a></li>
                        
                        <li><a href="http://www.cintascenter.com/directions/" target="_blank">Directions to parking at the Cintas Center</a> </li>
                        
                        <li><a href="http://www.xavier.edu/undergraduate-admission/visit-xavier/hotel-accommodations.cfm" target="_blank">Hotel Accommodations</a></li>
                       
                        <li><a href="http://www.xavier.edu/undergraduate-admission/visit-xavier/airport-information.cfm" target="_blank">Airport Information</a></li>
                        
                        </ul>
                        
                        
                       <div class="small-12 columns">
                  			<!--- <a href="https://admissions.xavier.edu/register/?id=3791add1-454f-4c3f-b962-2b99288eba84" target="_blank" class="button radius small">Register for March 29, 2015</a> --->
                           <a href="https://admissions.xavier.edu/register/?id=d5df57a6-3a1b-4029-936a-189391c65ea5" target="_blank" class="button radius small">Register for April 19, 2015 </a></td>
                      </div>
                      
                        
                        
                        <p>
                        We look forward to seeing you on campus! If you have any questions,<br>please contact us at 1-877-XU-ADMIT (982-3648) or via e-mail at <a href="mailto:xuadmit@xavier.edu">xuadmit@xavier.edu</a>.
                        </p>
                        
                       <!--- <p>Due to processing time, April 6th Preview Day registration is now closed. We hope you can still join us for Preview Day this Sunday, April 6th at 10:00 a.m. When you arrive to the Cintas Center please head to the Walk-In table and we will have everything ready for you!</p>--->
                       
                       
                  
                      
					<br />
                    
                    <cfelse>
                   		<p><b>Your child can register for this event via the student Road to Xavier site.</b></p>
                    </cfif>
                    
                    <cfif <!---(session.ethnicityID EQ 1 OR session.ethnicityID EQ 2 OR session.ethnicityID EQ 3 OR session.ethnicityID EQ 4) and---> (session.studentType NEQ 'T')>
                        <h3 class="title">Destination X - Sunday, April 10</h3>
                        <img src="/images/visit/destination-x.jpg" alt="destination x" class="imageleft-border" />
                         <h2>Geared toward multicultural students!</h2>
                        
                        <p>You are invited to attend Destination X - an overnight experience for diverse students on the campus of Xavier University. Destination X is a great opportunity for you to mingle with the University community, and get a first-hand look at Xavier's social scene. You and your parents will receive important information on your next steps for becoming a Musketeer during XU Preview and then attend Destination X that evening. We hope you are able to join us. </p>
                        
                  			<!--- <a href=" https://admissions.xavier.edu/register/?id=4ae0654b-7aff-4f84-9954-58c05e627e68" target="_blank" class="button radius small">Register for March 29, 2015</a> --->
                           <a href="https://admissions.xavier.edu/register/?id=0188047b-d16a-47bc-9797-c59fe70d277a" target="_blank" class="button radius small">Register for April 10, 2016 </a></td>

                        
                        
                        <p><strong>Please note: There is a $20 fee for attending Destination X.</strong></p> 
                        
						<cfif findNoCase('student',application.applicationname) gt 0>

                        <cfelse>
                   			<p><b>Your child can register for this event via the student Road to Xavier site.</b></p>
                   	 	</cfif>
                    </cfif>
                    
                    <!--- *** Xavier After Hours *** --->
                    <h3 class="title">Xavier After Hours</h3>
                    
                    <p>If you are unable to join us for one of our Preview Days (March 29 and April 19), we invite you to join us on campus to experience Xavier After Hours. Your visit will consist of sitting in on a class, touring campus and eating dinner in the dining commons with current Xavier students. You will also learn more about your next steps as an admitted student and how to finalize your decision to attend Xavier. </p>

					<p>While this is an event for students, we will offer a short informational session for parents after which they are invited to go on a campus tour or meet with a Financial Aid counselor.</p>
                    
                    <cfif findNoCase('student',application.applicationname) gt 0>
           
          
                        <div class="row">
                        <!--- <div class="small-12 medium-6 columns"><a href="https://admissions.xavier.edu/register/?id=f36e76e9-f4cb-4db3-8566-b1c335331bd8" target="_blank" class="button radius small">Register for Thursday, March 19</a></div> --->
<!---                            <div class="small-12 medium-6 columns last"><a href="https://admissions.xavier.edu/register/?id=6f073a34-2527-4512-8c8d-d3d746a2ccc3" target="_blank" class="button radius small">Register for Thursday, April 9</a></div>
--->                    	</div>
                    <cfelse>
                        <p><b>Your child can register for this event via the student Road to Xavier site.</b></p>
                    </cfif>
                    
                    <!---<h3 class="title">Daily Campus Visits</h3>
                    <img src="/images/visit/visit.jpg" class="imageright-border" alt="visit campus" />
                    <p>Unable to join us for Preview Day? We have a variety of daily  campus visits available throughout the spring.</p>
                    <ul style="list-style: disc; margin-left: 1.5em;">
                    
                     <li> Information sessions and campus tours are offered Monday through  Friday, as well as on designated Saturdays. <cfif session.studentType NEQ 'T'><a href="http://www.xavier.edu/visit" target="_blank"><cfelse><a href="http:<li>//www.xavier.edu/transfer-admission/visit-xavier.cfm" target="_blank"></cfif>Register for an information  session and campus tour</a>. &nbsp; </li>
                     <!---<li> If you can't join us for Preview Day or another daily visit, join us for an information session and tour for accepted seniors on  <a href="https://admissions.xavier.edu/register/?id=ee884617-8536-4e9c-8a69-7477830cca0f" target="_blank"> <li>Saturday, March 15th at noon</a>, <a href="https://admissions.xavier.edu/register/?id=2a5b378f-e91d-40ed-9bc6-25205cd60b59" target="_blank">Saturday,  March 29th at noon</a>, or Saturday, April 12th at noon.</li>--->
                      <li>Accepted students may also sit in on one class and/or  visit&nbsp;with one&nbsp;academic department per visit.&nbsp;&nbsp;To arrange  this visit, please contact us at <a href="mailto:visit@xavier.edu">visit@xavier.edu</a> or <br> 1-877-XU-ADMIT (982-3648).&nbsp;&nbsp;At least two weeks advance  notice is required.&nbsp;&nbsp; </li>
                    </ul>--->
                </cfcase>
                
                <cfcase value="visit-right">
                    
                    <a name="join"></a>
                    <!---<h1 class="visit_xavier_heading_sm">Join Us For A Game</h1>
                    <img src="/images/visit/rtx-basketballgame-sm.jpg" alt="join us for a basketball game" /><br /><br />
                    <p>Congratulations on your acceptance to Xavier! The first 50 admitted students to register below will receive 2 tickets for a Xavier Men's Basketball game. Only one registration is allowed per student. </p>
                    
					
					<cfif findNoCase('student',application.applicationname) gt 0>
                    <p><b>Register now to get your tickets:</b></p>
                    
                    <ul>
                    <a href="https://admissions.xavier.edu/register/?id=85618638-996e-458d-b943-52d3550c3e25" target="_blank">Saturday, February 23 vs. VCU</a></li>
                    <a href="https://admissions.xavier.edu/register/?id=87<li>a5499c-b8fe-4193-b555-7dd30fab7c87" target="_blank">Tuesday, February 26 vs. Memphis</a></li>
                    <a href="https://admissions.xavier.edu/register/?id<li>=c575a72f-1cf7-4aba-83a4-693ebba5ef1c" target="_blank">Saturday, March 2 vs. UMass</a></li>
                    </ul>
					<cfelse>
                   		<p><b>Your ch<li>ild can register for this event via the student Road to Xavier site.</b></p>
                   	</cfif>
					--->
                    
                    <h5 class="title">Regional Receptions</h5>
                    <cfif findNoCase('student',application.applicationname) gt 0>
                        <a href="/visit/receptions.cfm" target="_blank"><img src="/images/visit/regional-reception.png" alt="regional receptions" /></a>
                        <br /><br />
                        <p>Come meet your Xavier Admission Counselor and other students from your area who have been admitted to Xavier. Learn more about making your housing choice, registering for classes and how to finalize your Xavier decision.</p>
                        <p><a href="/visit/receptions.cfm" target="_blank" style="font-weight: bold;">&raquo; Find a Location Near You</a> <!---Check back tofind a location near you.---></p>
                    <cfelse>
                        <img src="/images/visit/regional-reception.png" alt="regional receptions" />
                        <br /><br />
                        <p>Come meet your Xavier Admission Counselor and other students from your area who have been admitted to Xavier. Learn more about making your housing choice, registering for classes and how to finalize your Xavier decision.</p>
                        <p>
						<a href="/parent/about/receptions.cfm" target="_blank" style="font-weight: bold;">&raquo; Find a Location Near You</a>
						<!---<b>Your child can register for this event via the student Road to Xavier site.</b>---></p>
					</cfif>                    

                    
                    <h5 class="title">Musketeer Chats</h5>
                    
                    <p>We know your year is keeping you busy and you are constantly on the move so we thought we would bring the Xavier community to you through online Musketeer Chats! These chats are for you as an admitted student and your parents to get real time answers to your questions from current Xavier students, an Admission Counselor and a series of special guests. Each chat is from 8-9pm EST and has a theme that you will see listed below. We hope you will participate from the comfort of your own home or as you are on-the-go!</p>
                    
                   <!---<p>Details coming soon.</p>--->
                   
                 <!---   <p><b>Register now to confirm your spot:</b></p>
                   
                   <p><a href="https://admissions.xavier.edu/register/?id=ea4a1417-05c3-406a-bea4-26473b9679c1" target="_blank" class="button radius small">
                   Register for April 9, 2015</a></p> --->

                   
                   <p><strong>View Previous Musketeer Chats.</strong>
                   <br>
                   
                  <a href="http://www.xavier.edu/undergraduate-admission/life-at-xavier/Musketeer-Chats.cfm##04232015" target="_blank">
                   &raquo; April 23, 2015 - Why I Picked Xavier
                   </a><br>
                   
                    <a href="http://www.xavier.edu/undergraduate-admission/life-at-xavier/Musketeer-Chats.cfm##04092015" target="_blank">
                   &raquo; April 9, 2015 - Housing
                   </a><br>

                        <a href="http://www.xavier.edu/undergraduate-admission/life-at-xavier/Musketeer-Chats.cfm##03122015" target="_blank">
                   &raquo; March 12, 2015 - Financial Aid and Paying your Bill
                   </a><br>

                      <a href="http://www.xavier.edu/undergraduate-admission/life-at-xavier/Musketeer-Chats.cfm##03052015" target="_blank">
                   &raquo; March 5, 2015 - Financial Aid and Paying your Bill
                   </a><br>
                   
                    
                  <a href="http://www.xavier.edu/undergraduate-admission/life-at-xavier/Musketeer-Chats.cfm##02192015" target="_blank">
                   &raquo; February 19, 2015 - The Road to Xavier
                   </a>
                     <br>
                     
                  <a href="http://www.xavier.edu/undergraduate-admission/life-at-xavier/Musketeer-Chats.cfm##02052015" target="_blank">
                   &raquo; February 5, 2015 - Financing Your Xavier Education
                   </a>
                     <br>
                  <a href="http://www.xavier.edu/undergraduate-admission/life-at-xavier/Musketeer-Chats.cfm##01212015" target="_blank">
                   &raquo; Thursday, January 21, 2015 - Student Life
                   </a>
                   </p>
                   
                   
                   
                   
                   <!---<p><strong>More dates coming soon!</strong></p>--->
                    
                    
                    
                   <h5 class="title">Daily Campus Visits</h5>
                    <img src="/images/visit/visit.jpg" class="imageleft-border" alt="visit campus" />
                    <p>Unable to join us for Preview Day? We have a variety of daily  campus visits available throughout the spring.</p>
                    <ul style="list-style: disc; margin-left: 1.5em;">
                    
                     <li> Information sessions and campus tours are offered Monday through  Friday, as well as on designated Saturdays. <cfif session.studentType NEQ 'T'><a href="http://www.xavier.edu/visit" target="_blank"><cfelse><a href="http:<li>//www.xavier.edu/transfer-admission/visit-xavier.cfm" target="_blank"></cfif>Register for an information  session and campus tour</a>. &nbsp; </li>
                     <!---<li> If you can't join us for Preview Day or another daily visit, join us for an information session and tour for accepted seniors on  <a href="https://admissions.xavier.edu/register/?id=ee884617-8536-4e9c-8a69-7477830cca0f" target="_blank"> <li>Saturday, March 15th at noon</a>, <a href="https://admissions.xavier.edu/register/?id=2a5b378f-e91d-40ed-9bc6-25205cd60b59" target="_blank">Saturday,  March 29th at noon</a>, or Saturday, April 12th at noon.</li>--->
                      <li>Accepted students may also sit in on one class and/or  visit&nbsp;with one&nbsp;academic department per visit.&nbsp;&nbsp;To arrange  this visit, please contact us at <a href="mailto:visit@xavier.edu">visit@xavier.edu</a> or <br> 1-877-XU-ADMIT (982-3648).&nbsp;&nbsp;At least two weeks advance  notice is required.&nbsp;&nbsp; </li>
                    </ul>
                 
                 
                    <cfif findNoCase('student',application.applicationname) gt 0>
						<!--- X Challenge Include --->
                        <cfinclude template="/library/elements/game-center/challenge-promo.cfm">
                    </cfif>
                    
                </cfcase>
                
                <cfcase value="financial-literacy">                    
                    <p class="static-head-descr"> While it's important to be ready for the semester academically by registering for classes, it's also important to be ready financially. Xavier students
                      have compiled some tips based on their own experiences with managing finances in college. </p>
                      <div class="videowrapper">
                    <iframe width="560" height="315" frameborder="0" allowfullscreen="" src="https://www.youtube.com/embed/ahDMb_BqWGs?rel=0"></iframe>
                      </div>
                    <p><a href="https://roadto.xavier.edu/documents/R2X-Financial-Responsibility.pdf" target="_blank">View a transcript of the Financial Responsibility video</a> (PDF)</p>
                    
                    <h3 class="title">Campus Resources</h3>
                    <p> Through the university, there are two offices on campus that can help answer questions related to financial topics like paying your tuition bill or
                      applying for scholarships. </p>
                    <h3>Office of the Bursar</h3>
                    <p> The responsibilities of the Bursar's Office include the publishing of monthly electronic bills (eBills), the collection and processing of payments,
                      providing service to students and families regarding the student's bursar account, and much more. To help you understand some of these important topics,
                      the Bursar's Office has created a guide specifically for new students. It contains information about your privacy rights as a college student, viewing
                      eBills and more. </p>
                    <p><a href="http://www.xavier.edu/2020" target="_blank">&raquo; Learn More </a> </p>
                    <p>The Bursar's Office can also help you enroll in the X-Flex Payment Plan. View the Payment Plan video to learn more: </p>
                    <div class="videowrapper">
                  <iframe width="560" height="315" src="https://www.youtube.com/embed/1XJxmS9-3d4" frameborder="0" allowfullscreen></iframe>
                    </div>
                    <p><a href="https://roadto.xavier.edu/documents/R2X-Payment-Plans.pdf" target="_blank">View a transcript of the X-Flex Payment Plan video</a> (PDF)</p>
                    <h3>Office of Student Financial Assistance</h3>
                    <p> The Office of Student Financial Assistance is here to help you and your family navigate the financial aid process. The responsibilities of the Office of
                      Student Financial Assistance include awarding Xavier, federal and state financial aid in the form of scholarships, grants, loans and student employment. </p>
                    <p> If your family has filed the Free Application for Federal Student Aid (FAFSA), the Office will electronically communicate eligibility for financial aid and
                      how to apply those funds to your student account, your bill at Xavier. If you do not file the FAFSA, your merit-based financial aid will apply
                      automatically to your student account with the Bursar. </p>
                    <p> Please visit <a href="http://www.xavier.edu/financial-aid" target="_blank">xavier.edu/financial-aid</a> to learn how the Office of Student Financial Assistance can help you. </p>

                    <h3 class="title">Financial Responsibility</h3>
                    <p> As you develop your ability to manage your academic and personal finances, consider exploring the following websites for additional tips and resources.
                      Please note, these resources are not sponsored by Xavier University. For Xavier University support, please contact the <a href="http://www.xavier.edu/bursar/for-new-students.cfm" target="_blank">Office of the Bursar</a> or the <a href="http://www.xavie.edu/financial-aid" target="_blank">Office of Financial Aid</a> or consider working with our on-campus partner <a href="http://www.xavier.edu/auxiliary-services/financial-wellness.cfm" target="_blank">US Bank</a>. </p>
                      
                    <ul class="bulletList">
                       <li><a href="http://www.cashcourse.org/" target="_blank">Cash Course</a> </li>
                       <li><a href="http://mint.com/" target="_blank">Mint.com</a> </li>
                       <li><a href="http://web.extension.illinois.edu/money/" target="_blank">More for Your Money</a> </li>
                       <li><a href="http://www.youcandealwithit.com/schools/financial-wellness-curriculum.shtml" target="_bla<li>nk">You Can Deal With It</a> </li>
                    </ul>
                    
                    <!--- old conten<li>t below this line --->
                    <!---
                    <p>After watching the following videos, please read the important information provided by the Bursar's Office about your privacy rights as a college student, enrolling in a payment plan, viewing eBills and more:</p>
                    <p><a href="http://www.xavier.edu/2019" target="_blank">&raquo;&nbsp;Read the information at http://www.xavier.edu/2019</a><br />
                    &nbsp;	</p>

                    
                    <h3>Financial Responsibility</h3>
                    <iframe width="560" height="315" frameborder="0" allowfullscreen="" src="https://www.youtube.com/embed/ahDMb_BqWGs?rel=0"></iframe>
                    <p>&nbsp;</p>
                    <p><a href="https://roadto.xavier.edu/documents/R2X-Financial-Responsibility.pdf">View a transcript of the Financial Responsibility video</a> (PDF)</p>
                    <p>As you develop your ability to manage your academic and personal finances, consider exploring the following websites for additional tips and resources.  Please note, these resources are not sponsored by Xavier University.  For Xavier University support, please contact the <a href="http://www.xavier.edu/bursar/for-new-students.cfm" target="_blank">Office of the Bursar</a> or the <a href="http://www.xavie.edu/financial-aid" target="_blank">Office of Financial Aid</a> or consider working with our on-campus partner <a href="http://www.xavier.edu/auxiliary-services/financial-wellness.cfm" target="_blank">US Bank</a>.</p>
                    <ul class="bulletList">
                        <a href="http://www.cashcourse.org/home" target="_blank">Cash Course</a></li>
                        <a href="http://mint.com" target="_blank">Mint.com</a></li>
                        <a href="http://web.extension.il<li>linois.edu/money/" target="_blank">More for Your Money</a></li>
                        <a href="http:<li>//www.youcandealwithit.com/schools/financial-wellness-curriculum.shtml" target="_blan<li>k">You Can Deal With It</a></li>
                        </ul>
    
                	<a name="xflex"></a>
           <li>         <h3>X-Flex Payment Plan</h3>
                    <p>View this video to learn about the X-Flex Payment Plan here at Xavier. You'll have to register for the X-Flex Payment Plan in order to pay your eBill.</p>
                    <iframe width="560" height="315" frameborder="0" allowfullscreen="" src="https://www.youtube.com/embed/a0mXPg7RVDg?rel=0"></iframe>
					<p>&nbsp;</p>
                    <p><a href="https://roadto.xavier.edu/documents/R2X-Payment-Plans.pdf" target="_blank">View a transcript of the X-Flex Payment Plan video</a> (PDF)</p>
					--->
  
                </cfcase>                
                
                <cfcase value="important-dates">
					<p>The beginning of the school year will be here before you know it. Be sure add these important dates on your calendar.</p>

                    <table ID="idates">
                      <tr class="heading">
                        <td colspan="2"><h3 class="subheader">2015</h3></td>
                      </tr>
                      <tr>
                        <td>Residence Hall Move-In Day</td>
                        <td>August 20</td>
                      </tr>
                      
                      <tr>
                        <td>Fall semester first day of classes</td>
                        <td> August 24</td>
                      </tr>
                      
                     <tr>
                        <td>Last day for schedule changes</td>
                        <td>August 30</td>
                      </tr>
                      
                      <tr>
                        <td>Club Day on the Yard</td>
                        <td>September 1</td>
                      </tr>
                      
                      
                      <tr>
                        <td>Fall Break</td>
                        <td>October 8 - 9</td>
                      </tr>
                      
                      <tr>
                        <td>Family Weekend</td>
                        <td>October 23 - 25</td>
                      </tr>
                      
                      <tr>
                        <td>Priority Registration for Spring 2016</td>
                        <td>November 9 - 13</td>
                      </tr>
                      <tr>
                        <td>Thanksgiving Break</td>
                        <td>November 25 - 29</td>
                      </tr>
                      <tr>
                        <td>Fall Finals Week</td>
                        <td>December 15 - 18</td>
                      </tr>
                      <tr class="heading">
                        <td colspan="2"><h3 class="subheader">2016</h3></td>
                      </tr>
                      
                      <tr>
                        <td>Residence Halls re-open</td>
                        <td>January 09</td>
                      </tr>
                      
                      <tr>
                        <td>Spring semester first day of classes</td>
                        <td>January 11</td>
                      </tr>
                      
                        <tr>
                        <td>Last day for schedule changes</td>
                        <td>January 17</td>
                      </tr>
                     
                      <tr>
                        <td>Spring Break</td>
                        <td>March 7 - 11</td>
                      </tr>
                      
                       <tr>
                        <td>Easter Break</td>
                        <td>March 24 - 28</td>
                      </tr>
                      
                      <tr>
                        <td>Priority Registration for Fall 2016</td>
                        <td>April 4 - 8</td>
                      </tr>
                      
                   
                      <tr>
                        <td>Spring Finals Week</td>
                        <td>May 3 - 6</td>
                      </tr>
                    </table>


                </cfcase>
                
                <cfcase value="safety">
	                
	                <p>Families and students are always concerned about safety and want to know "How safe is the Xavier campus?" simply and directly, <strong>Very Safe</strong>. However, it is important to note Xavier is part of a larger urban community and we make the personal safety and security of all students, faculty, staff and visitors a top priority.</p>
    
    <p>Xavier Police is located at Flynn Hall 1648 Herald Ave 
	    <a href="http://www.xavier.edu/about/map.cfm?location=Flynn%20Hall" target="_blank"
		    onclick="dataLayer.push({'event' : 'customEvent','eventCategory' : 'R2X','eventAction' : 'safety-page', 'eventLabel' : 'flynn hall map' });">
			    <i class="fa  fa-map-marker"></i> Map</a> 
 
  
         <h3 class="title">Important Numbers</h3> 

   <ul style="list-style: none;">
	   <li style="font-size: 16px; color: ##930000"> <i class="fa fa-phone"></i>  <strong>Emergencies: <span style="color: ##000000">(513) 745-1000</span> </strong></li>
	   <li style="font-size: 16px"> <i class="fa fa-phone"></i>  <strong>Non-Emergencies: (513) 745-2000 </strong></li>
	   <li style="font-size: 16px"> <i class="fa fa-twitter"></i> Follow: <a href="https://twitter.com/xavier_safety" target="_blank"
		    onclick="dataLayer.push({'event' : 'customEvent','eventCategory' : 'R2X','eventAction' : 'safety-page', 'eventLabel' : 'xavier_safety twitter' });"
			   >@Xavier_Safety</a> on Twitter</li> 
   </ul> 
  
        <a class="button radius" href="http://www.xavier.edu/mobile/" target="_blank" 
	        onclick="dataLayer.push({'event' : 'customEvent','eventCategory' : 'R2X','eventAction' : 'safety-page', 'eventLabel' : 'xavier app' });" >
	        Download the Xavier App
	    </a>   
        <p>With one click functionality, students and staff can direct dial campus police in the event of an emergency from their mobile device.</p>
    
    
    
    <h3 class="title">XU ALERT ME</h3>
<!---                 <img src="http://www.xavier.edu/business-services/images/xu-alertme.gif"> --->
				<p>The Xavier provides a voice, text message, and email system, <strong>XU ALERT ME</strong>. This communication system contacts members of the campus community through     voice, text messages and emails in the event of an urgent situation. Students may sign up for the service through the <a href="http://www.xavier.edu/safety/XU-Alert-Me.cfm/" target="_blank" onclick="dataLayer.push({'event' : 'customEvent','eventCategory' : 'R2X','eventAction' : 'safety-page', 'eventLabel' : 'XU Alert link' });">XU Alert Me page</a>.</p>
               
              <p><a class="button radius"  href="http://www.xavier.edu/safety/How-to-Sign-Up-Edit-or-Remove-You-Data-from-XU-Alert-Me1.cfm" target="_blank"
	              onclick="dataLayer.push({'event' : 'customEvent','eventCategory' : 'R2X','eventAction' : 'safety-page', 'eventLabel' : 'xu alert update' });">
	              Update Your XU Alert Me Info
	              </a>
	            </p>
      
                
				                
   <h3 class="title">Assistance Phones</h3>     
   
       <div class="medium-6 columns">
   
   <img src="/images/safety/AssistancePhones.jpg" align="left" class="img-responsive">
   
       </div>
       
       
    <div class="medium-6 columns">
   <p>
	  There are 61 assistance phones on campus that are a direct line to Campus Police.  Assistance phones can be used for both emergency and non emergency situations like:
   </p>
	  
	  <ul> 
		  <li>Locked out of your car</li>
		  <li>Need an escort on campus</li>
		  <li>Locked out of a buildig/dorm room</li>
	  </ul>
				    
    </div>
      
    <div class="clearfix"></div>



 <h3 class="title">Learn more about student safety at Xaver</h3> 
 
   
		
				<ul>
					<li>
					<a href="http://www.xavier.edu/safety/" target="_blank" 
						onclick="dataLayer.push({'event' : 'customEvent','eventCategory' : 'R2X','eventAction' : 'safety-page', 'eventLabel' : 'XU Safety Page' });">
							Xavier Safety page
					</a>
					</li>
    				<li><a href="http://www.xavier.edu/police/documents/EHSSafetyHandout.pdf" target="_blank">University Police information for students</a></li>
    				<li><a href="http://www.xavier.edu/safety/Safety-at-Xavier.cfm" target="_blank">Safety resources for students</a></li>
				</ul>
				
	<div class="flex-video">
<iframe width="560" height="315" src="https://www.youtube.com/embed/DI9l0suCoZA" frameborder="0" allowfullscreen></iframe>
</div>			
				
			<h3 class="title">For questions about safety, please contact:</h3>	
				<p>
				<a href="javascript:void(location.href='mailto:'+String.fromCharCode(98, 114,121,99,101,115,64,120,97,118,105,101,114,46,101,100, 117)+'?')">Shawn Bryce</a><br />
Crime Prevention Sergeant<br />
513-745-2000</p>



	                
	                
	        
               
               
               
                </cfcase>
                
                <cfcase value="parent-auxiliary">
				<p>The Office of Auxiliary Services provides support for many student based business services. As parents of our incoming students we want to keep you well informed.&nbsp; Below you will find a brief description of the services we provide, as well as how we are communicating this information to your students within the Road To Xavier portal and at various on-campus events.</p>

				<h3 class="title"><a href="http://www.xavier.edu/auxiliary-services/xavier-dining.cfm" target="_blank">Meal Plans - Dining Services</a></h3>
				<img width="191" height="127" class="imageright-border" src="/images/parents/auxiliary/dining1_191_127.jpg" alt="" />
				<p><strong>What we do:</strong>&nbsp; Our office oversees your on campus dining experience, everything from our Award winning Residential&nbsp;Dining Services to retail eateries to Campus Catering.&nbsp;&nbsp; Meal Plans are required for students living in our on-campus Resident Halls, but are also available and highly popular with our campus apartment and commuter students as well.&nbsp; We have many different meal plan offerings to fit the dietary and nutritional needs of any and all students. For details on our services please visit us at <a target="_blank" href="http://www.xavier.edu/dining">www.xavier.edu/dining</a></p>
				<p><strong>How your students are finding us:&nbsp;</strong>&nbsp; Your students are being provided information both at Preview Day events and inside the Road To Xavier portal regarding all of our dining services and the meal plan options available to them.&nbsp; They are now being prompted to make their initial meal plan selection online.</p>
                <p data-alert class="alert-box alert"><strong>The deadline for making this meal plan selection is Sunday, June 21.</strong></p>

				<h3 class="title"><a target="_blank" href="https://www.usbank.com/student-banking/xavier-university/index.html ">Consumer Banking Services</a></h3>
<img width="191" height="128" class="imageright-border" src="/images/parents/auxiliary/banking_191_128.jpg" alt="" />
				<p><strong>What we do:&nbsp;</strong> Our office oversees consumer banking services on campus. These services are provided by the financial professionals at U.S Bank, with whom Xavier University has had a highly successful partnership with for over 18 years.&nbsp; Xavier Consumer Banking Services provides students with an on-campus branch office in the Gallagher Student Center as well as seven (7)&nbsp;on-campus ATM machines.&nbsp; Our services also include full integration between your students' U.S. Bank account and the Xavier University student ID Card, The ALL&nbsp;Card.For more details on our services please visit the <a target="_blank" href="https://www.usbank.com/student-banking/xavier-university/index.html ">Xavier University Consumer Banking website</a>.</p>
				<p><strong>How  your students are finding us:&nbsp;</strong>&nbsp; Your students are being provided  information both at Preview Day events and inside the Road To Xavier portal regarding all of our banking services and the wealth of financial management tools available for them online and on-campus. They are being  provided with links to find out more about the consumer banking services we provide.&nbsp;</p>

				<p data-alert class="alert-box alert"><strong>Our banking professionals will be on campus during Manresa move-in from  August 19th until August 22nd  and can sit down with you and your student one-on-one to discuss your banking needs.</strong></p>

				<h3 class="title"><a href="http://www.xavier.edu/bookstore" target="_blank">Bookstore</a></h3>
				<img width="191" height="132" class="imageright-border" src="/images/parents/auxiliary/bookstore_191_132.jpg" alt="" />
				<p><strong>What we do:</strong>&nbsp; Our office oversees our campus bookstores,  your one stop shop for all things Xavier.&nbsp; Apparel and textbooks are our primary focus. For details on our services please visit us at <a target="_blank" href="http://www.xavier.edu/bookstore">www.xavier.edu/bookstore</a>.</p>
				<p><strong>How your students are finding us:&nbsp;</strong>&nbsp; Your students  are being provided information both at Preview Day events and inside the  Road To Xavier portal regarding all of our bookstore services and the options for acquiring their textbooks for the Fall semester.&nbsp;</p>

				<p data-alert class="alert-box alert"><strong>A general timeline for our bookstore to have in stock all of the necessary titles for the Fall semesters classes would be July 15.</strong></p>

				<h3 class="title"><a href="http://www.xavier.edu/parking" target="_blank">Parking Services</a></h3>
				<img width="191" height="128" class="imageright-border" src="/images/parents/auxiliary/parking_191_128.jpg" alt="" />
				<p><strong>What we do:</strong>&nbsp; Our office oversees our campus parking services program.&nbsp; We manage the distribution of all parking permits and the enforcement of our parking rules and regulations. For details on our services please visit us at <a target="_blank" href="http://www.xavier.edu/parking">www.xavier.edu/parking</a>.</p>
				<p><strong>How your students are finding us:&nbsp;</strong>&nbsp; Your students  are being provided information both at Preview Day events and inside the  Road To Xavier portal.</p>

				<p data-alert class="alert-box alert"><strong>Parking Permits for the 2016-17 Academic Year will be available through links in the Road To Xavier beginning on July 18.</strong></p>

				<h3 class="title"><a href="http://www.xavier.edu/allcard" target="_blank">ALL Card</a></h3>
				<img width="191" height="123" class="imageright-border" src="/images/parents/auxiliary/XavierAllCardNicole2005_191_123.jpg" alt="" />
				<p><strong>What we do:</strong>&nbsp; Our office oversees the distribution and management of the campus ID card,&nbsp; The ALL Card.&nbsp; This is a multifunctioning card that serves a variety of functions on campus. We also oversee the X Cash flexible spending program that is tied into the ALL Card for cashless transactions on-campus. For details on our services please visit us at <a target="_blank" href="http://www.xavier.edu/allcard">www.xavier.edu/allcard</a></p>
				<p><strong>How your students are finding us:&nbsp;</strong>&nbsp; Your students  are being provided information both at Preview Day events and inside the  Road To Xavier portal regarding the ALL Card and all of its related functions.&nbsp; They are now being prompted to submit a high quality digital photo online. This photo will be used to print the card and have it ready and waiting on Manresa move-in day.</p>

				<p data-alert class="alert-box alert"><strong>The deadline for submitting this photo is Sunday, July 31.</strong></p>
                </cfcase>
                
                <cfcase value="expanded-occupancy">
                <div class="videowrapper">
                <iframe width="560" height="315" src="//www.youtube.com/embed/MKr_8yx24QA?rel=0" frameborder="0" allowfullscreen></iframe>
                </div>
                <br />
                <p> Congratulations and welcome to Xavier! When you arrive on campus you will be a member of one of the largest freshmen class in Xavier's history - the Class of 2019. Your class is also among the most academically talented and diverse first-year classes ever at Xavier. </p>
                <p>To accommodate the growing number of Xavier students who want to live on campus, approximately 50% of the class will be assigned to "expanded occupancy" housing. This means that rooms that are typically used for two will be used for three people and rooms for three will be used for four people. Please know that we have done this before. Our current students who lived in expanded occupancy have shared with us that they had phenomenal first year experiences. We are prepared to assist you through this process. </p>
                <p>In order to maximize the space available we want to invite students to consider living in an expanded occupancy room. By doing so you will: </p>
                <ul style="list-style: disc; margin-left: 2em;">
                	 realize a cost savings of $655 per semester ($1,310 per year) for a triple room. </li>
                	 have the opportunity to have two roommates instead of one - something our students say is a great experience and <li>helps in making great friends from your roommate matches. </li>
                	 have the benefit of sel<li>ecting the roommates that you think you will be the best match with. </li>
                </ul>
                <p> I realize that you may have questions about what expanded occupancy means for<li> your individual situation so I invite you to read through our Frequently Asked Questions (FAQs). We are always available to answer any questions that you may have. Please contact the Office of Residence Life at 513-745-3203 or <a href="mailto:reslife@xavier.edu">reslife@xavier.edu</a>. We look forward to welcoming you to campus in August!</p>
                <p> Sincerely, <br/>
                <br/>
                Lauren Cobble <br/>
                Dean of Undergraduate Admission </p>


				<h3 class="title">Frequently Asked Questions</h3>
                
                <p><strong>How will it be determined who will live in &##8220;expanded occupancy&##8221; housing?</strong><br> 
                The housing selection process is based on the date of your housing deposit. The earlier you deposited, the earlier you will be assigned to a room. Please know that we received housing deposits as early as November 2013. It is also important to note that some students who are assigned early MAY select to live with two other students because they want the cost savings, they have two friends they want to live with, or because they look forward to having two roommates instead of one.</p>
				<p><strong>I have already selected one roommate, but now I need to select two?</strong><br>			 				
                You can choose to still go through the process with your one selected roommate, but if all double rooms are assigned before you, you may be assigned a  third roommate or your roommate group may be split up.</p>
				<p><strong>What is the benefit of finding two roommates now?</strong><br>
                 You will get to use the roommate matching information that is available through the Road to Xavier and make the best match for you. Additionally, there is the cost savings of $655 per semester ($1,310 per year.) There is also the possibility that if you are willing to live with two other students that you will have a better chance of securing your first choice of preferred building.</p>
				<p><strong>I would prefer to select two roommates, rather than have someone else randomly select to live with me and my preferred roommate. But, I have already made my roommate group in the housing selection system, now what should I do?</strong><br>
        		You can go back into the housing selection system at any time and add a roommate to your roommate group. You can do this up until May 30th.</p>
				<p><strong>How will we fit everything into the room?</strong><br>
        Expanded occupancy rooms will be equipped with a set of bunk beds and a lofted bed to maximize space. By lofting the third bed, a dresser or desks can be placed under the loft. Additionally, we will initially only have two desks in the room when you move in. This eases space issues on move-in day with all of the boxes and people that you will not have after your family members leave and you get settled in your room. If you and your two roommates decide that you each want a desk we will have it delivered to your room prior to the start of classes. About 50% of students in the past decided NOT to have the third desk added because they study with their laptop on their bed, or study elsewhere on-campus (library, Gallagher Student Center, other support space on-campus).</p>
				<p><strong>What if I have issues with my roommates?</strong><br>
        Resident Assistants (RAs) will assist students in completing Roommate Agreements to help set guidelines for &##8220;rules of the room&##8221;. Having the conversation PRIOR to any issues arising, tends to make any conflicts that come up later less of an issue. RAs and Hall Directors (HDs) will assist students if they are having conflicts within the room by either mediating the issue or assisting with a room change.</p>
				<p><strong>Will upperclass students also live in &##8220;expanded occupancy&##8221; rooms?</strong><br>
        Upperclass students had already selected their housing in March, prior to the size of the first year class being determined. We did not require upperclass students to live in &##8220;expanded occupancy&##8221;, but approximately 40 rising sophomores, juniors and seniors selected to expand the occupancy of their unit in order to live with their preferred roommates.</p>
				<p><strong>What if I only pick one roommate?</strong><br>
                If you only select one roommate and are not assigned a space in a double room, you will then have a third random person who will join your roommate pairing or your roommate pair may be split up.</p>
				<p><strong>Will all first-year residence halls be affected?</strong><br>
    The only first year building that will not experience expanded occupancy is Buenger Hall, due to building code. All other buildings (Kuhlman, Husman, and Brockman) will have expanded occupancy rooms.</p>

                </cfcase>
                
                <cfcase value="learning-assistance">
					<p>Xavier offers a number of resources to help you succeed throughout your college career and beyond. If you would like more information about any of the resources below, please click the &quot;Visit&quot; link beneath it.&nbsp; Don't see something you're looking for?&nbsp; Contact us at <a href="javascript:void(location.href='mailto:'+String.fromCharCode(114,111,97,100,116,111,120,97,118,105,101,114,64,120,97,118,105,101,114,46,101,100,117)+'?')">roadtoxavier@xavier.edu</a>.<br />&nbsp;</p>
					<h3 class="title">Career Development</h3>
					<p>The Career Development Office  is your one stop location for all things career exploration &ndash; from  figuring out what your interests are to providing you with options for  where your major can lead. We welcome you to peruse the <a href="http://www.xavier.edu/career/students/Major-Career-Exploration.cfm" target="_blank">Major &amp; Career Exploration page</a> as well as stop in to schedule a time to chat with us and find out all we can do with and for you.</p>
					<p><a href="http://www.xavier.edu/career" target="_blank">&raquo;&nbsp;Visit the Career Development site</a><br />&nbsp;</p>
					<h3 class="title">Language Lab</h3>
					<p>The Language Resource Center  is a place for language  students to complete electronic  assignments,  record voice samples for  class, or connect with others who share their  passion for language. Students have access to web cameras and  large-screen monitors for virtual language sessions, foreign film  screenings, or study sessions.</p>
					<p><a href="http://www.xavier.edu/modern-languages/Language-Lab.cfm" target="_blank">&raquo;&nbsp;Visit the Language Resource Center site</a><br />&nbsp;</p>
					<h3 class="title">Learning Assistance Center</h3>
					<p>The Learning Assistance Center (LAC) provides support services to facilitate learning. We provide these services in a positive and encouraging environment  which promotes appreciation for diversity and Cura Personalis.</p>
					<ul>
    					<li><a href="http://www.xavier.edu/lac/Peer-Tutoring.cfm" target="_blank">Tutoring</a>: Our free tutoring services include subject specific tutoring, drop-in sessions, study skills assistance, and Supplemental Instruction</li>
                        
    				<li>	<a href="http://www.xavier.edu/lac/student-disability-services.cfm" target="_blank">Disability Services</a>: For students with documented disabilities, our disability services provides accommodations such as extended time on exams, reduced distraction testing environment, note-taking assistance, and assistive technology.&nbsp;</li>
					</ul>
					<p><a href="http://www.xavier.edu/lac" target="_blank">&raquo;&nbsp;Visit the Learning Assistance Center site</a><br />&nbsp;</p>
					<h3 class="title">Library</h3>
					<p>Top 10 Things You need to Know About the Library:</p>
					<ol>
    					<li><a href="http://libguides.xavier.edu/content.php?pid=382098&amp;sid=3131415" target="_blank">Library and Learning Commons</a>: What our connected, collaborative buildings have to offer.</li>
    					<li><a href="http://libguides.xavier.edu/content.php?pid=382098&amp;sid=3131416" target="_blank">Library Collections</a>: All of our resources, from print to digital, books to articles, DVDs to streaming videos.</li>
    		<li>			<a href="http://libguides.xavier.edu/c.php?g=203305&p=1341709" target="_blank">Search@XU</a> : Introducing a new way to search the library. Find books, articles and more.</li>
    					<li><a href="http://libguides.xavier.edu/c.php?g=203305&p=1341602" target="_blank">Borrowing Books and More</a>: What you can check out for how long, and how to order materials from other libraries.</li>
    	<li>				<a href="http://libguides.xavier.edu/content.php?pid=382098&amp;sid=3149424" target="_blank">Finding Articles</a> : Use the library databases and online journals to find articles.</li>
    					<li><a href="http://libguides.xavier.edu/content.php?pid=382098&amp;sid=3131418" target="_blank">Reserves</a>: Electronic and Traditional</li>
    					<li><a href="http://libguides.xavier.edu/c.php?g=203305&p=1341620" target="_blank">Get Help</a> : Contact a librarian or go online for library and technical help.</li>
    					<lI><a href="http://libguides.xavier.edu/content.php?pid=382098&amp;sid=3151115" target="_blank">Connection Center</a> : The place to go for research help, circulation and technical help.</li>
    					<li><a href="http://libguides.xavier.edu/content.php?pid=382098&amp;sid=3149963" target="_blank">Fun Stuff</a> : Have fun at your library.&nbsp; Check out a leisure reading book or relax with a movie.</li>
    					<li><a href="http://libguides.xavier.edu/content.php?pid=382098&amp;sid=3131424" target="_blank">Still Need Help?</a>: Where to turn for classroom support, technical help, and more.</li>
					</ol>
					<p><a href="http://www.xavier.edu/library/index.cfm" target="_blank">&raquo;&nbsp;Visit the Library site</a><br />&nbsp;</p>
					<h3 class="title">Math Lab</h3>
					<p>The Mathematics Tutoring Lab is a free service to Xavier students in most math classes. It is a great place to come and work on homework, either by yourself  or with a small group, and have someone available to answer any  questions.</p>
					<p><a href="http://www.xavier.edu/mathematics/Math-Lab.cfm" target="_blank">&raquo;&nbsp;Visit the Mathematics Tutoring Lab site</a><br />&nbsp;</p>
					<h3 class="title">Study Abroad</h3>
					<p>Through the Center for International Education, you can learn about many ways to study abroad, including short-term and long-term academic programs, academic service learning semesters, internships, and direct exchanges. In addition to opportunities sponsored through Xavier, the office can also advise you about opportunities sponsored by other universities and program sponsors.</p>
<p><a href="http://www.xavier.edu/study-abroad/index.cfm" target="_blank">&raquo;&nbsp;Visit the Study Abroad site</a><br />&nbsp;</p>
					<h3 class="title">TRiO, Student Support Services</h3>
					<p align="left">TRiO, Student Support Services (SSS) is an educational  program funded by the U.S. Department of Education with the goal of graduating eligible students and preparing them for a  post-baccalaureate education or career. The office provides  an academic, professional and personal support system that guides  student participants to benefit from educational opportunities and  achieve a greater quality of life.</p>
					<p align="left"><a href="http://www.xavier.edu/sss/" target="_blank">&raquo;&nbsp;Visit the TRiO, Student Support Services site</a><br />&nbsp;</p>
					<h3 class="title">Writing Center</h3>
					<p>The Writing Center provides a quiet atmosphere for writing that is equipped with PCs and printers, as well as free access to tutorial assistance. The Writing  Center's library provides resources such as research guides, style  manuals and handbooks, and documentation guides.</p>
					<p><a href="http://www.xavier.edu/writingcenter/" target="_blank">&raquo;&nbsp;Visit the Writing Center site</a></p><br />
                </cfcase>
                
                <cfcase value="parentRetention">
                
                
<p>                         
Hello from the staff of Xavier's Office of Student Success and Parent/Family Outreach.  
The Office of Admission works to bring your student to campus, and our office has the privilege of ensuring he or she makes a successful transition. Our staff works with all students and their families to create an inclusive environment that promotes success and personalizes the Xavier experience.  From the moment students arrive on campus, a Success Coach is prepared to help them adjust to campus life.  We're here to help parents too, because we know a thing or two about how bittersweet it is to make that drive to campus and have our Move Crew load up that residence hall with your student's belongings.  Our office can function as a channel to other Solution Centers on campus, or work directly with you. We encourage you to visit our <a href="http://www.xavier.edu/retention/" target="_blank">website</a> to learn more about us and how you can connect with us at Manresa.  Soon we will post a message from Pat and Jackie Coan, co-presidents of the Parent/Family Advisory Board (P/FAB) welcoming you to the Xavier community.</p>
<p>
Honest communication greatly contributes to successful transitions.  Consider using these final weeks of summer to engage your student in meaningful conversations and set reasonable expectations.  Here are a few conversation topics you may find helpful:
</p>

<ul>
<li>How will we stay in touch, how often will we communicate?</li>
<li> What do you think college will be like?</li>
<li> How can you adjust to living with others who may be different from you?</li>
<li> What are some of the dangers or risks of underage drinking?</li>
<li> What are precautions you can take to ensure you stay safe?</li>
<li> How can different clubs or organizations enrich your classes?</li>
<li> What are some wrong choices that can have long-lasting consequences?</li>
</ul>

<p>
Next month our office will be sending you our "Muskie Family Newsletter" with additional information.  It will be emailed to you at the address you provided on the Parent Road to Xavier.  In the meantime, feel free to call our office at 513-745-3036 or email us at <a href="mailto:studentretention@xavier.edu">studentretention@xavier.edu</a>. We can't wait to see your student grow into a happy, well-adjusted and successful sophomore.
Best Wishes,
Office of Student Success and Parent/Family Outreach
</p>
                            
                </cfcase>
                
                
                <cfcase value="ferpa">
                    <p>The Family Educational Rights and Privacy Act (FERPA), passed in 1974, is a federal law that protects the privacy of student education records. This law gives students 18 years of age or older, or students of any age if enrolled in any postsecondary educational institution, the right to privacy of their education records. For a comprehensive discussion of FERPA at Xavier please visit <a href="http://www.xavier.edu/registrar/ferpa.cfm" target="_blank">http://www.xavier.edu/registrar/ferpa.cfm</a>. Note that we can release &ldquo;directory information&rdquo; as defined at this website but all other education records are protected. We cannot release a student&rsquo;s non-directory education information to the public, including parents, unless we have a signed release from the student. Several offices at Xavier provide FERPA releases to students so that we can legally provide a student&rsquo;s family with protected information if the student desires.</p>
					<p>Please be aware that the FERPA releases provided by individual offices at Xavier are very narrow in scope. For release of student information related to student conduct matters, housing issues, and health and wellness, among other areas, we require a student to sign a FERPA release for the appropriate university office. For release of student academic information we require a student to sign a FERPA release for his or her academic dean.</p>
                    <p>On the Road to Xavier website, students have the opportunity to complete a FERPA release for the Office of Financial Aid and the Office of  Student Success and Parent/Family Outreach. This allows parents to receive midterm grades and information pertaining to a student's financial aid package. Other releases are provided by the applicable office.</p>
                    
                    <p>The Bursar release is available as a separate form. This allows families access to billing information relating to charges, payment information, eBills, and collections.</p>
                    
                    <p>Students are encouraged to complete Part A of the FERPA form and return it to the Office of the Bursar. If the student does complete Part A, then Part B does not have to be completed. However, if the student decides not to sign the FERPA form, the parent or guardian can complete <a href="http://www.xavier.edu/bursar/documents/ferpa_form.pdf"  target="_blank">Part B of this form</a> and attach a signed copy of their 2013 Federal Income Tax Return to certify that the student is their dependent according to Section 152 of the Internal Revenue Code. Part B is valid for only the current academic year. Since IRS dependency can change annually, you must submit copies of your Federal Income Tax Return each year along with this form to continue access to your student&rsquo;s financial and education records.</p>
                    
                    <p>Your Student ID is: <cfoutput>#session.bannerid#</cfoutput> </p>
                    
                    <p><a href="http://www.xavier.edu/bursar/documents/ferpa_form.pdf" target="_blank">&raquo; Download the FERPA form</a></p>
                    <p><strong>Return the completed form by scanning it to:</strong></p>
                    <p><a href="mailto:xubursar@xavier.edu">xubursar@xavier.edu</a></p>
                    <p><strong>OR faxing the completed form to:</strong></p>
                    <p>1-513-745-2926</p>
                    <p><strong>OR mail the completed form to:<br />
                    </strong></p>
                    <p>The Office of the Bursar<br />
                    Xavier University<br />
                    3800 Victory Parkway<br />
                    Cincinnati, OH 45207-3361<br />
                    &nbsp;</p>
                </cfcase>
                
                <cfcase value="parking-permit">
                	<p>The Office of Auxiliary Services is now offering the 2016-2017 parking permits. Our web-based self-service parking system will allow you to conveniently manage your own parking account online. Our online services includes the acquisition and mailing of your new parking permit directly to your home or on-campus address. <strong>Parking permits are ONLY available through this online ordering process.</strong></p>
					<p>4 Easy Steps to acquire your permit: <br> <strong>(NOTE: Your license plate number or VIN## is required to complete the process below.)</strong></p>
					<ol type="1" style="margin-left: 1.5em; list-style: decimal;">
                    
                    
                    <li>	Visit Xavier's  <a href="https://xavier.thepermitstore.com/" style="text-decoration:underline" target="_blank">Parking Permit System</a>.</li>
                    
                    	<li>Login using your Xavier user name and password.</li>
                        
                        <li>Click on the "Buy A Xavier Permit" link to get started. <br>Follow the checkout prompts for your permit, vehicle and mailing information.</li>
						
                    	<li>At checkout, a temporary permit will be available for you to print out and display until the official Xavier Parking Permit arrives in the mail in 7-10 business days.</li>
       
                    	<li>Upon receiving your official permit in the mail, please affix it inside your car, to the lower right hand, passenger side corner of your front windshield.</li>
					</ol>
					<br>
					<p>Contact Parking Services at 513-745-1050 or <a href="mailto:parkingservices@xavier.edu" target="_blank">parkingservices@xavier.edu</a> with any questions.</p>
                </cfcase>
                
                <cfcase value="provost-message">
                
                

                <p>Congratulations on all of your hard work that has brought you here to Xavier. We look forward to seeing you on campus, to officially welcome you to the Xavier family. You will meet many people during your time here, one of which is Xavier&rsquo;s Provost and Chief Academic Officer, Scott Chadwick. As you complete your Road to Xavier, please view this final message from Dr. Chadwick. We look forward to seeing you soon.</p>	 
                
                <iframe width="955" height="537" src="//www.youtube.com/embed/TmKa9RqdjMU?rel=0" frameborder="0" allowfullscreen></iframe>
                
                <p>&nbsp;</p>
            
                <p><a href="https://roadto.xavier.edu/documents/R2X-Provost.pdf" target="_blank">View a transcript of this video</a> (PDF)</p>
                
                </cfcase>
                
                <cfcase value="your-road-instructions">
                
                    <p> Through the Road to Xavier, you'll be able to take care of everything you need to prepare to be a Xavier Musketeer. Be ready for your first semester by
                  completing all of <strong>Your Next Steps</strong> on the <strong>Your Road to Xavier</strong> tab before fall, and earn badges and prizes as you go. </p>
                    <p> Types of steps you'll find along the way: </p>
                    <ul>
                       <li><strong>Required (Autocomplete):</strong> Required to move to the next steps and will automatically be marked complete when you perform a task, like uploading your All Card photo. </li>
                       <li><strong>Required (Mark Complete)</strong> : Required to move to the next steps, and you can mark each of these complete after performing a task, like reading about Xavier's Jesuit identity. </li>
                      <li> <strong>Course Registration</strong> : Presented once all other Academic Advising steps are complete. Check out the fall semester schedule created just for you with the option to schedule
                        a one-on-one phone review session with an advisor. (Complete the Academic Advising steps by <strong>May 15</strong> to receive priority in course
                        registration sessions!) </li>
                    </ul>
                    <p> Have questions? Don't hesitate to call us at 513-745-3301 or email <a href="mailto:roadtoxavier@xavier.edu">roadtoxavier@xavier.edu</a>. We're happy to help you through this process. </p>
                
                </cfcase>
                
                <cfcase value="local-resources-header">
					<cfset excelSource = '\\nocfile01\departments\Admissions\Road to Xavier\R2X-Community-Resources.xlsx'>
					<cfif  isdefined("url.action") and url.action EQ 'search'>
                        <style type="text/css">
                          ##map_canvas { height: 400px; width: 500px; padding: .5em; border: 1px solid ##ccc; margin: .5em; }
                        </style>
                        
                        <script type="text/javascript" src="//maps.googleapis.com/maps/api/js?key=AIzaSyAcARiS5jg9KZ1cW2imIeOGbCzOyGzq6Vk&sensor=false"></script>
                        
                        <script type="text/javascript">
                        
                          $(document).ready(function() { 
                              
                            var myOptions = {
                              center: new google.maps.LatLng(39.150037, -84.476264),
                              zoom: 11,
                              mapTypeId: google.maps.MapTypeId.ROADMAP
                            };
                            var map = new google.maps.Map(document.getElementById("map_canvas"),
                               myOptions);
                            
                            initMap(map);
                            
                            var marker = new google.maps.Marker({
                              position: new google.maps.LatLng(39.150037, -84.476264),
                              map: map,
                              title:"Xavier University",
                              icon: 'http://www.xavier.edu/eigelcenter/images/x.png'		  
                            });
                          });
                        </script>
                    </cfif>
                    
                    
                    <style>
                    table##categories, label.keyLabel{
                        font-size: 1.2em;
                    }
                    
                    table##categories tr td.check{
                        padding: 1em 0 1em 0;
                    }
                    
                    .subbut{padding: 1em; font-size: 1.3em;}
                    </style>
                </cfcase>
                
                <cfcase value="local-resources">
					<cfoutput>
                    <cfset excelSource = '\\nocfile01\departments\Admissions\Road to Xavier\R2X-Community-Resources.xlsx'>
                    
                    <cfparam name="url.action" default="start">
                                        
                    <!--- load the data into a query object --->
                    <cfspreadsheet action="read" src="#excelSource#" sheet="1" query="partners" headerrow="1"  excludeHeaderRow="true">
                    
                    <cfif url.action EQ 'start'>
                            
                            <!--- Sort out all of the categories --->
                            <cfset variables.categories = {}>
                            <cfloop query="partners">
                                <cfloop list="#partners.category#" index="single">
                                    <cfset structInsert(variables.categories,trim(single),1,'TRUE')>
                                </cfloop>
                            </cfloop>
                            
                            <cfset categoryArray = structKeyArray(variables.categories)>
                            <cfset arraySort(categoryArray,'text')>
                            
                            <cfoutput>
                            <p>Considering making Cincinnati your home for the next 4 years? Here are a list of some of the local resources you will be able to take advantage of as a Xavier student. If you and your parents are wondering where to pick up an extra storage bin on move-in day, where you can get a discount with your ALL Card or where you can grab dinner with friends on a Friday night next year this list of local resources will get you where you need to go.</p>
                            <form action="?action=search" method="post">
                            
                                <p>
                                <label for="keywords" class="keyLabel">Search by Keyword: </label><input type="text" name="keywords" /> <input type="submit" name="submit" value="Search" class="button secondary radius" />
                                </p>
                                
                                <cfset maxColumns = 4>
                                <cfset currentColumns = 0>
                                <table id="categories">
                                    <tr>
                                    <cfloop list="#arrayToList(categoryArray)#" index="singleCat">
                                        <cfif  currentColumns EQ maxColumns>
                                            </tr><tr>
                                            <cfset currentColumns = 0>
                                        </cfif>
                                        <td class="lab"><input type="checkbox" name="category" value="#singleCat#" id="#rereplace(singleCat,' ','-','ALL')#" /> <label  style="font-size:0.750rem; margin-right:0;" for="#rereplace(singleCat,' ','-','ALL')#"> #singleCat#</label> </td>
                                        
                                        <cfset currentColumns += 1>
                                    </cfloop>
                                    
                                </table>               
                                <input type="submit" name="submit" value="Search" class="button secondary radius" />
                            </form>
                            </cfoutput>
						<cfelseif url.action EQ 'search'>
                        
                        
                        
                            <cfquery name="checkName" dbtype="query">
                            select *
                            from partners
                            where lower(name) = <cfqueryparam value="#lcase(form.keywords)#" cfsqltype="cf_sql_varchar">
                            </cfquery>
                            
                            
                            <!--- now search the query for the results --->
                            <cfquery name="filtered" dbtype="query">
                            select *
                            from partners
                            where 1 = 1 and name <> '' and
                            <cfif isdefined("form.category") and listLen(form.category) NEQ 0>
                            (
                                <cfloop list="#form.category#" index="singleCat">
                                    category like <cfqueryparam value="%#singleCat#%" cfsqltype="cf_sql_varchar"> OR	
                                </cfloop>
                                1 = 2
                            ) and
                            </cfif>
                            <cfif isdefined("form.keywords") and listLen(form.keywords,' ') NEQ 0>
                            (
                                <cfloop list="#trim(form.keywords)#" delimiters=" " index="singleKey">
                                lower(name) like <cfqueryparam value="%#lcase(singleKey)#%" cfsqltype="cf_sql_varchar"> OR
                                lower(category) like <cfqueryparam value="%#lcase(singleKey)#%" cfsqltype="cf_sql_varchar"> OR
                                lower(description) like <cfqueryparam value="% #lcase(singleKey)# %" cfsqltype="cf_sql_varchar"> OR
                                </cfloop>
                                1 = 2
                            ) and
                            </cfif>
                            1 = 1
                            order by name
                            </cfquery>
                    
                            
                            <cfoutput>
                            
                            <p><b><a href="?action=start"><button class="button">New Search</button></a></b></p>
                            
                            <cfif form.keywords NEQ ''>
                                <p><b>Search Keywords:</b> #form.keywords#</p>
                            </cfif>
                            <cfif isdefined("form.category") and form.category NEQ ''>
                                <p><b>Search Categories:</b> #form.category#</p>
                            </cfif>        
                            
                            <cfif filtered.recordCount EQ 0>
                                <p><b>Your search returned no results. <a href="?action=start">New Search</a></b></p>
                            <cfelse>
                                
                                <div id="map_canvas"></div>
                                <hr />
                                
                                <cfloop query="checkName">
                                
                                    <cfif filtered.discount EQ 'Y'>
                                        <img src="/images/local-resources/discount1.jpg" style="float: right;" />
                                    </cfif>
                                    
                                    <h3 class="name">#checkname.name#</h3>
                                    
                                    <cfif trim(checkName.address) NEQ ''>
                                        <cfset addressString = "#checkName.address#, #checkName.city#, #checkName.state# #checkName.zip#">
                                        <p><b>Address:</b> <a href="http://maps.google.com?q=#addressString#" target="_blank">#addressString#</a></p>
                                    </cfif>	
                                    <p><b>Category:</b> #checkname.category#</p>
                                    <cfif trim(checkName.description) NEQ ''>
                                        <p><b>Description:</b> #checkname.description#</p>
                                    </cfif>
                                    
                                    <cfif isvalid('url',checkName.link)>
                                        <p><a href="#checkName.link#" class="secondary button radius" target="_blank">Visit Website</a></p>
                                    <cfelseif trim(checkName.link) NEQ ''>
                                        <p><a href="http://#checkName.link#" class="secondary button radius" target="_blank">Visit Website</a></p>
                                    </cfif>
                                
                                    <hr />
                                </cfloop>
                                
                                <cfloop query="filtered">
                                
                                
                                    <cfif filtered.discount EQ 'Y'>
                                        <img src="/images/local-resources/discount1.png" style="float: right;" />
                                    </cfif>
                                
                                    <h3 class="name">#filtered.name#</h3>
                                   
                                    <cfif trim(filtered.address) NEQ ''>
                                        <cfset addressString = "#filtered.address#, #filtered.city#, #filtered.state# #filtered.zip#">
                                        <p><b>Address:</b> <a href="http://maps.google.com?q=#addressString#" target="_blank">#addressString#</a></p>
                                    </cfif>
                                    <p><b>Category:</b> #filtered.category#</p>
                                    <cfif trim(filtered.description) NEQ ''>
                                        <p><b>Description:</b> #filtered.description#</p>
                                    </cfif>
                                    
                                    <cfif isvalid('url',filtered.link)>
                                        <p><a href="#filtered.link#" class="secondary button radius" target="_blank">Visit Website</a></p>
                                    <cfelseif trim(filtered.link) NEQ ''>
                                        <p><a href="http://#filtered.link#" class="secondary button radius" target="_blank">Visit Website</a></p>
                                    </cfif>
                                
                                    <hr />
                                </cfloop>
                                
                                <script>
                                function initMap(map){
                                <cfloop query="filtered">
                                    <cfif filtered.geocode NEQ ''>
                                    var marker = new google.maps.Marker({
                                      position: new google.maps.LatLng(#filtered.geocode#),
                                      map: map,
                                      title:"#filtered.name#"
                                    });
                                    var infoWindow = new google.maps.InfoWindow();
                                    
                                    
                                    var marker
                                    
                                    <cfsavecontent variable="details"><h3>#filtered.name#</h3><cfif filtered.address NEQ ''>#filtered.address#<br /></cfif>#filtered.city#, #filtered.state# #filtered.zip#<br /><a href="http://maps.google.com/maps?saddr=3800 Victory Pkwy, Cincinnati, OH 45207&daddr=#filtered.geocode#" target="_blank">Directions</a><br />
                    </cfsavecontent>
                                    
                                    <cfset details = trim(details)>
                                    <cfset details = rereplace(details,"'","\'",'ALL')>
                                    <cfset details = rereplace(details,":","\:",'ALL')>
                                    <cfset details = rereplace(details,"#chr(10)#","<br />",'ALL')>
                                   
                                    google.maps.event.addListener(marker, 'click', function () {
                                       infoWindow.setContent('#details#');
                                       infoWindow.setPosition(this.getPosition());
                                       infoWindow.open(map, this);
                                    });
                    
                                    
                                    </cfif>
                                
                                </cfloop>
                                }
                                </script>
                                
                                <!---<cfdump var="#filtered#">--->
                            </cfif>
                            
                            </cfoutput>
                            
                        </cfif>             
                        </cfoutput>	
                    <p>Xavier University does not endorse or support any of these establishments. This is a list of resources that are commonly used by Xavier students.</p>
                
                </cfcase>  
                
                
                <cfcase value="website-usability">
                    
                    <p>2014 is going to bring big changes for the Xavier website and we need your help to make it happen!</p>
                    
                    <p>We are planning a complete overhaul of the main Xavier website and we need to test the menu options and layout. Join the X Challenge: ##XavierLearn Edition by taking a few minutes to help us test the menu options. There are no right or wrong answers and you are not graded in any way.</p>
                    
                    <cfif isvalid('email',session.email)>
                    	<cfset qs = '?i=#trim(session.email)#'>
                    <cfelse>
                    	<cfset qs = ''>
                   	</cfif>
                    
                    <p><a href="?outbound" target="_blank">&raquo; Start the test now!</a></p>
                
                </cfcase>  
               
                
            	<cfdefaultcase>
                	<p>Conent not found.</p>
            	</cfdefaultcase>
            </cfswitch>
        	</cfoutput>
        </cfsavecontent>
    
    
		<cfreturn content>
	</cffunction>
</cfcomponent>