<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>    
<%@ page import="heibernate_com.stray_ani.model.*"%>	
<%@page import="util.compareVO.CompareVO"%>
<%
    Stray_AniService stray_aniSvc = new Stray_AniService();
    //List<Stray_AniVO> list_stray_ani = stray_aniSvc.getAll();
    List<Stray_AniVO> list_stray_ani =(List)session.getAttribute("list_stray_Ani");
    //pageContext.setAttribute("list_stray_ani",list_stray_ani);
    int stray_ani_map_icon_size = 48;
%>
<style>
.glyphicon-lg{font-size:3em}
.blockquote-box{border-right:5px solid #E6E6E6;margin-bottom:25px}
.blockquote-box .square{width:100px;min-height:50px;margin-right:22px;text-align:center!important;background-color:#E6E6E6;padding:20px 0}
.blockquote-box.blockquote-primary{border-color:#357EBD}
.blockquote-box.blockquote-primary .square{background-color:#428BCA;color:#FFF}
.blockquote-box.blockquote-success{border-color:#4CAE4C}
.blockquote-box.blockquote-success .square{background-color:#5CB85C;color:#FFF}
.blockquote-box.blockquote-info{border-color:#46B8DA}
.blockquote-box.blockquote-info .square{background-color:#5BC0DE;color:#FFF}
.blockquote-box.blockquote-warning{border-color:#EEA236}
.blockquote-box.blockquote-warning .square{background-color:#F0AD4E;color:#FFF}
.blockquote-box.blockquote-danger{border-color:#D43F3A}
.blockquote-box.blockquote-danger .square{background-color:#D9534F;color:#FFF}
</style>
<%
int tem_int = 0;
for(Stray_AniVO vo:list_stray_ani){
%>
<div id=ex_animal_map_stray_Ani_<%=vo.getStray_Ani_Id()%> value="<%=vo.getStray_Ani_Id()%>" hidden>
        <div style="width: 20vw;">
            <div class="">
                <div class="square pull-left" style="margin-right: 20px;">
                		<img src="<%=request.getContextPath()%>/front-end/DBGifReader_StrayaniPhoto/DBGifReader_StrayaniPhoto.do?stray_Ani_Id=<%=vo.getStray_Ani_Id()%>&stray_Pic_type=0" height="84" width="125">
                </div>
                <h4>
                	<%=vo.getStray_Ani_name()%>
                </h4>
                <hr>
                <p>
        			<%=vo.getStray_Ani_type()%>
        		</p>
            </div>
        </div> 		
        <hr>
        <button onclick="show_stray_Ani_details_page('<%=vo.getStray_Ani_Id()%>')"
	   		class="btn .btn-md btn-block btn-info" >
	   		詳細資料!
	 	</button>
</div>
<%} %>
<script>
		//======================
		map.tinyMap('modify',{
			'marker': [	
		<%
		tem_int = 0;
		for(Stray_AniVO vo:list_stray_ani){
			if(tem_int>0){
				out.print(",");
			}
			tem_int++;
		%>	
					,{
// 					    // 標記 ID
// 					    // Custom ID
					    id: 'marker_stray_ani_<%=vo.getStray_Ani_Id()%>'
					    ,index:'<%=vo.getStray_Ani_Id()%>'
					    ,type:'stray_ani'
// 					    // 標記的位置
// 					    // Marker location
					    ,addr: ['<%=vo.getStray_Ani_FinLat()%>', '<%=vo.getStray_Ani_FinLon()%>']
// 					    // 標記抬頭文字（markerControl 使用此屬性建立清單）
// 					    // Marker title (for `markerControl` to create list)
// 					    title: 'string',
// 					    // 點擊標記時顯示於資訊視窗的文字（支援 HTML）
// 					    // Content of infoWindow
					    ,text: 
					    	'<div id ="div_stray_Ani_<%=tem_int%>">'
					    	+'<button onclick="show_stray_Ani_details_page(this.value)"'
					    	+ 'class="btn .btn-md btn-block btn-info" >詳細資料!</button>'
					    	+ '</div>'
				    	,text_html:"ex_animal_map_stray_Ani_<%=vo.getStray_Ani_Id()%>"
// 					    // 標籤文字層，顯示於標記底下
// 					    // Text label of the Marker which will display below.
					    ,newLabel: 'string'
// 					    // 標籤文字層套用的 CSS 樣式名稱
// 					    // CSS class name of this text label.
// 					    newLabelCSS: 'string',
// 					    // 是否顯示 Label（預設 true）
// 					    // Show label or not. (Default to `true`)
					   	,showLabel: true
					    // 使用 modify 方法時，若標記 id 不存在，是否強制新增至地圖
					    // Force create the marker if custom id was not found.
					    ,forceInsert : true
// 					    // 標記圖示，可使用 string 指定圖示網址
// 					    // Icon URL of Marker.
// 					    icon: '圖示網址'
// 					    // 或是 Object 定義更詳細的圖示
			            ,'icon': {
			            	 // 圖示網址
			                'url': '<%=request.getContextPath()%>/front-end/homepage/imgs/map_strayani2.png'
		                	// 縮放尺寸
			                ,'scaledSize': [<%=stray_ani_map_icon_size%>, <%=stray_ani_map_icon_size%>]
			            }
// 					    // 是否將此標記加入叢集（markerCluster 必須不為 null 或 false）
// 					    // Append this marker to cluster. `markerCluster` must not be `null` or `false`.
// 					    cluster: true|false,
// 					    // 設定 infoWindow
					    ,infoWindowOptions: {
					        disableAutoPan: true
					        ,maxWidth: 200
// 					        ,pixelOffset: [X, Y],
// 					        zIndex: number
					    }
// 					    // 自訂任意名稱屬性
// 					    // You can create own properties. Just give it a name/value.
					    ,class: 'smile'
// 					    // 定義 Click 事件
// 					    event       : function () {
// 					        //console.log(this);
// 					    },
					    // 或是定義多個事件
					    ,event       : {
                            // 自訂 Click
                            mousedown: function () {
                                ////console.log($("#div_aniHome_<%=tem_int%>_<%=tem_int%>").text())
                            },
                            // 自訂 mouseover
                            mouseover: function () {
                                ////console.log($("#div_aniHome_<%=tem_int%>_<%=tem_int%>").text())
                            },
                            mouseout: {
                                func: function () {
                                    //if(infowindow_stray_Ani_<%=tem_int%>!=null){
                                        //infowindow_stray_Ani_<%=tem_int%>.close(map,this);
                                    //}
                                }
                            }
					    }
					    // 啟用 MarkerWithLabel
// 			            ,'labelContent': '<strong>Hello World</strong><div><img src="/images/_111.jpg" alt="" /></div>'
// 			            ,'labelClass'  : 'box'
// 			            ,'icon': {)
// 			                'path': 'M 0 0'
// 			            }					    
					}		
		<%}%>
			]/* marker結尾  */
		});
</script>
<script type="text/javascript">
	function show_stray_Ani_details_page(button_value) {
		var parameter_Id = button_value;
		var path_parameter = 'action=getOne_For_Display&stray_Ani_Id=' + parameter_Id;
		var src='/AnimalMap/front-end/strayani/strayani.do?'+path_parameter 
		$('#details_page_iframe').attr('src',src);      	
        $("#details_page").show();
    }        
</script>
