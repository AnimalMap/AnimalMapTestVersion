	

package com.adopt_ani.controller;
import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

import com.mem.model.*;

import com.adopt_ani.model.*;
/** 
 *adopt_Ani : <br>
 *	送養動物<br>
 *	英文:adopt_Ani<br>
 */ 
@WebServlet(urlPatterns = { "/back-end/adopt_ani/adopt_ani.do" })
public class Adopt_AniServlet extends HttpServlet {
	private static final long serialVersionUID = 1L; 

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		System.out.println("Adopt_Ani servlet運行成功 ");
	


		//====getOne_For_Display====
		if ("getOne_For_Display".equals(action)) { 

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);		

			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("adopt_Ani_Id");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("送養動物編號");
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				String   adopt_Ani_Id = null;
				try {
					adopt_Ani_Id = new String  (str);
				} catch (Exception e) {
					errorMsgs.add("送養動物編號格式不正確");				
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}

				/***************************2.開始查詢資料*****************************************/
	
				Adopt_AniService adopt_aniSvc = new Adopt_AniService();
				Adopt_AniVO adopt_aniVO = adopt_aniSvc.getOneAdopt_Ani(adopt_Ani_Id);
				
				if (adopt_aniVO == null) {
					errorMsgs.add("查無資料");
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}

				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("adopt_aniVO", adopt_aniVO); 
				String url = "/back-end/adopt_ani/listOneAdopt_Ani.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); 
				successView.forward(req, res);

			/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/select_page.jsp");
				failureView.forward(req, res);
			}
		}				
			
	


		//====getOne_For_Update====	
		if ("getOne_For_Update".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			String requestURL = req.getParameter("requestURL"); 
			try {			
				/***************************1.接收請求參數****************************************/
				String adopt_Ani_Id = new String(req.getParameter("adopt_Ani_Id").trim());	
				
				/***************************2.開始查詢資料*****************************************/	
	
				Adopt_AniService adopt_aniSvc = new Adopt_AniService();
				Adopt_AniVO adopt_aniVO = adopt_aniSvc.getOneAdopt_Ani(adopt_Ani_Id);
		
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("adopt_aniVO", adopt_aniVO); 		
				String url = "/back-end/adopt_ani/update_adopt_ani_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交update_adopt_ani_input.jsp
				successView.forward(req, res);
					
				/***************************其他可能的錯誤處理************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料取出時失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher(requestURL);
				failureView.forward(req, res);
			}	
		}													


    
		if ("update".equals(action)) { // 來自update_adopt_Ani_input.jsp的請求
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			String requestURL = req.getParameter("requestURL"); // 送出修改的來源網頁路徑
		
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				//==== getParameter設定 ====
				String adopt_Ani_Id = req.getParameter("adopt_Ani_Id").trim();
				String mem_Id = req.getParameter("mem_Id").trim();
				String adopt_Ani_name = req.getParameter("adopt_Ani_name").trim();
				String adopt_Ani_type = req.getParameter("adopt_Ani_type").trim();
				String adopt_Ani_gender = req.getParameter("adopt_Ani_gender").trim();
				String adopt_Ani_heal = req.getParameter("adopt_Ani_heal").trim();
				String adopt_Ani_Vac = req.getParameter("adopt_Ani_Vac").trim();
				String adopt_Ani_color = req.getParameter("adopt_Ani_color").trim();
				String adopt_Ani_body = req.getParameter("adopt_Ani_body").trim();
				String adopt_Ani_age = req.getParameter("adopt_Ani_age").trim();
				String adopt_Ani_Neu = req.getParameter("adopt_Ani_Neu").trim();
				String adopt_Ani_chip = req.getParameter("adopt_Ani_chip").trim();
				java.sql.Date adopt_Ani_date = null;
				try {
					adopt_Ani_date = java.sql.Date.valueOf(req.getParameter("adopt_Ani_date").trim());
				} catch (IllegalArgumentException e) {
					adopt_Ani_date=new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}
				String adopt_Ani_status = req.getParameter("adopt_Ani_status").trim();
				java.sql.Date adopt_Ani_CreDate = null;
				try {
					adopt_Ani_CreDate = java.sql.Date.valueOf(req.getParameter("adopt_Ani_CreDate").trim());
				} catch (IllegalArgumentException e) {
					adopt_Ani_CreDate=new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}
				Double adopt_Ani_FinLat = null;
				try {
					adopt_Ani_FinLat = new Double(req.getParameter("adopt_Ani_FinLat").trim());
				} catch (NumberFormatException e) {
					adopt_Ani_FinLat = 0.0;
					errorMsgs.add("送養地點經度請填數字.");
				}
				Double adopt_Ani_FinLon = null;
				try {
					adopt_Ani_FinLon = new Double(req.getParameter("adopt_Ani_FinLon").trim());
				} catch (NumberFormatException e) {
					adopt_Ani_FinLon = 0.0;
					errorMsgs.add("送養地點緯度請填數字.");
				}
				String adopt_Ani_city = req.getParameter("adopt_Ani_city").trim();
				String adopt_Ani_town = req.getParameter("adopt_Ani_town").trim();
				String adopt_Ani_road = req.getParameter("adopt_Ani_road").trim();
				Integer adopt_Ani_like = new Integer(req.getParameter("adopt_Ani_like").trim());

				//==== VO設定部分 ====			
				Adopt_AniVO adopt_aniVO = new Adopt_AniVO();
				adopt_aniVO.setAdopt_Ani_Id(adopt_Ani_Id);
				adopt_aniVO.setMem_Id(mem_Id);
				adopt_aniVO.setAdopt_Ani_name(adopt_Ani_name);
				adopt_aniVO.setAdopt_Ani_type(adopt_Ani_type);
				adopt_aniVO.setAdopt_Ani_gender(adopt_Ani_gender);
				adopt_aniVO.setAdopt_Ani_heal(adopt_Ani_heal);
				adopt_aniVO.setAdopt_Ani_Vac(adopt_Ani_Vac);
				adopt_aniVO.setAdopt_Ani_color(adopt_Ani_color);
				adopt_aniVO.setAdopt_Ani_body(adopt_Ani_body);
				adopt_aniVO.setAdopt_Ani_age(adopt_Ani_age);
				adopt_aniVO.setAdopt_Ani_Neu(adopt_Ani_Neu);
				adopt_aniVO.setAdopt_Ani_chip(adopt_Ani_chip);
				adopt_aniVO.setAdopt_Ani_date(adopt_Ani_date);
				adopt_aniVO.setAdopt_Ani_status(adopt_Ani_status);
				adopt_aniVO.setAdopt_Ani_CreDate(adopt_Ani_CreDate);
				adopt_aniVO.setAdopt_Ani_FinLat(adopt_Ani_FinLat);
				adopt_aniVO.setAdopt_Ani_FinLon(adopt_Ani_FinLon);
				adopt_aniVO.setAdopt_Ani_city(adopt_Ani_city);
				adopt_aniVO.setAdopt_Ani_town(adopt_Ani_town);
				adopt_aniVO.setAdopt_Ani_road(adopt_Ani_road);
				adopt_aniVO.setAdopt_Ani_like(adopt_Ani_like);


				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("adopt_aniVO", adopt_aniVO); // 含有輸入格式錯誤的adopt_aniVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/adopt_ani/update_adopt_ani_input.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				/***************************2.開始修改資料*****************************************/

				Adopt_AniService adopt_aniSvc = new Adopt_AniService();
				adopt_aniVO = adopt_aniSvc.updateAdopt_Ani(
					adopt_Ani_Id
					,mem_Id
					,adopt_Ani_name
					,adopt_Ani_type
					,adopt_Ani_gender
					,adopt_Ani_heal
					,adopt_Ani_Vac
					,adopt_Ani_color
					,adopt_Ani_body
					,adopt_Ani_age
					,adopt_Ani_Neu
					,adopt_Ani_chip
					,adopt_Ani_date
					,adopt_Ani_status
					,adopt_Ani_CreDate
					,adopt_Ani_FinLat
					,adopt_Ani_FinLon
					,adopt_Ani_city
					,adopt_Ani_town
					,adopt_Ani_road
					,adopt_Ani_like
				);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/				

				if(requestURL.equals("/back-end/adopt_ani/listAdopt_Anis_ByMem_Id.jsp") 
					|| requestURL.equals("/back-end/adopt_ani/listAllAdopt_Ani.jsp")){
					req.setAttribute("listAdopt_Anis_ByMem_Id",adopt_aniSvc.getAdopt_AnisByMem_Id(mem_Id)); // 資料庫取出的list物件,存入request
				}
				
				
				if(requestURL.equals("/back-end/adopt_ani/listAdopt_Anis_ByCompositeQuery.jsp")){
					HttpSession session = req.getSession();
					Map<String, String[]> map = (Map<String, String[]>)session.getAttribute("map");
					List<Adopt_AniVO> list  = adopt_aniSvc.getAll(map);
					req.setAttribute("listAdopt_Anis_ByCompositeQuery",list); //  複合查詢, 資料庫取出的list物件,存入request
				}
                
				String url = requestURL;
				RequestDispatcher successView = req.getRequestDispatcher(url);   // 修改成功後,轉交回送出修改的來源網頁
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/adopt_ani/update_adopt_ani_input.jsp");
				failureView.forward(req, res);
			}
		}
		
		
	
        if ("insert".equals(action)) { // 來自addAdopt_Ani.jsp的請求  
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/

                String mem_Id = req.getParameter("mem_Id").trim();	

                String adopt_Ani_name = req.getParameter("adopt_Ani_name").trim();	

                String adopt_Ani_type = req.getParameter("adopt_Ani_type").trim();	

                String adopt_Ani_gender = req.getParameter("adopt_Ani_gender").trim();	

                String adopt_Ani_heal = req.getParameter("adopt_Ani_heal").trim();	

                String adopt_Ani_Vac = req.getParameter("adopt_Ani_Vac").trim();	

                String adopt_Ani_color = req.getParameter("adopt_Ani_color").trim();	

                String adopt_Ani_body = req.getParameter("adopt_Ani_body").trim();	

                String adopt_Ani_age = req.getParameter("adopt_Ani_age").trim();	

                String adopt_Ani_Neu = req.getParameter("adopt_Ani_Neu").trim();	

                String adopt_Ani_chip = req.getParameter("adopt_Ani_chip").trim();	
	
                java.sql.Date adopt_Ani_date = null;
                try {
                    adopt_Ani_date = java.sql.Date.valueOf(req.getParameter("adopt_Ani_date").trim());
                } catch (IllegalArgumentException e) {
                    adopt_Ani_date=new java.sql.Date(System.currentTimeMillis());
                    errorMsgs.add("請輸入日期!");
                    e.printStackTrace();
                }

                String adopt_Ani_status = req.getParameter("adopt_Ani_status").trim();	
	
                java.sql.Date adopt_Ani_CreDate = null;
                try {
                    adopt_Ani_CreDate = java.sql.Date.valueOf(req.getParameter("adopt_Ani_CreDate").trim());
                } catch (IllegalArgumentException e) {
                    adopt_Ani_CreDate=new java.sql.Date(System.currentTimeMillis());
                    errorMsgs.add("請輸入日期!");
                    e.printStackTrace();
                }
	
                Double adopt_Ani_FinLat = null;
                try {
                    adopt_Ani_FinLat = new Double(req.getParameter("adopt_Ani_FinLat").trim());
                } catch (NumberFormatException e) {
                    adopt_Ani_FinLat = 0.0;
                    errorMsgs.add("送養地點經度請填數字.");
                    e.printStackTrace();
                }
	
                Double adopt_Ani_FinLon = null;
                try {
                    adopt_Ani_FinLon = new Double(req.getParameter("adopt_Ani_FinLon").trim());
                } catch (NumberFormatException e) {
                    adopt_Ani_FinLon = 0.0;
                    errorMsgs.add("送養地點緯度請填數字.");
                    e.printStackTrace();
                }

                String adopt_Ani_city = req.getParameter("adopt_Ani_city").trim();	

                String adopt_Ani_town = req.getParameter("adopt_Ani_town").trim();	

                String adopt_Ani_road = req.getParameter("adopt_Ani_road").trim();	

                Integer adopt_Ani_like = new Integer(req.getParameter("adopt_Ani_like").trim());	

                Adopt_AniVO adopt_aniVO = new Adopt_AniVO();
 
                adopt_aniVO.setMem_Id(mem_Id);
 
                adopt_aniVO.setAdopt_Ani_name(adopt_Ani_name);
 
                adopt_aniVO.setAdopt_Ani_type(adopt_Ani_type);
 
                adopt_aniVO.setAdopt_Ani_gender(adopt_Ani_gender);
 
                adopt_aniVO.setAdopt_Ani_heal(adopt_Ani_heal);
 
                adopt_aniVO.setAdopt_Ani_Vac(adopt_Ani_Vac);
 
                adopt_aniVO.setAdopt_Ani_color(adopt_Ani_color);
 
                adopt_aniVO.setAdopt_Ani_body(adopt_Ani_body);
 
                adopt_aniVO.setAdopt_Ani_age(adopt_Ani_age);
 
                adopt_aniVO.setAdopt_Ani_Neu(adopt_Ani_Neu);
 
                adopt_aniVO.setAdopt_Ani_chip(adopt_Ani_chip);
 
                adopt_aniVO.setAdopt_Ani_date(adopt_Ani_date);
 
                adopt_aniVO.setAdopt_Ani_status(adopt_Ani_status);
 
                adopt_aniVO.setAdopt_Ani_CreDate(adopt_Ani_CreDate);
 
                adopt_aniVO.setAdopt_Ani_FinLat(adopt_Ani_FinLat);
 
                adopt_aniVO.setAdopt_Ani_FinLon(adopt_Ani_FinLon);
 
                adopt_aniVO.setAdopt_Ani_city(adopt_Ani_city);
 
                adopt_aniVO.setAdopt_Ani_town(adopt_Ani_town);
 
                adopt_aniVO.setAdopt_Ani_road(adopt_Ani_road);
 
                adopt_aniVO.setAdopt_Ani_like(adopt_Ani_like);
               
                // Send the use back to the form, if there were errors
                if (!errorMsgs.isEmpty()) {
                    req.setAttribute("adopt_aniVO", adopt_aniVO); // 含有輸入格式錯誤的adopt_aniVO物件,也存入req
                    RequestDispatcher failureView = req.getRequestDispatcher("/back-end/adopt_ani/addAdopt_Ani.jsp");
                    failureView.forward(req, res);
                    return;
                }
                
                /***************************2.開始新增資料***************************************/
                Adopt_AniService adopt_aniSvc = new Adopt_AniService();
                adopt_aniVO = adopt_aniSvc.addAdopt_Ani(
	
                	mem_Id
	
                	,adopt_Ani_name
	
                	,adopt_Ani_type
	
                	,adopt_Ani_gender
	
                	,adopt_Ani_heal
	
                	,adopt_Ani_Vac
	
                	,adopt_Ani_color
	
                	,adopt_Ani_body
	
                	,adopt_Ani_age
	
                	,adopt_Ani_Neu
	
                	,adopt_Ani_chip
	
                	,adopt_Ani_date
	
                	,adopt_Ani_status
	
                	,adopt_Ani_CreDate
	
                	,adopt_Ani_FinLat
	
                	,adopt_Ani_FinLon
	
                	,adopt_Ani_city
	
                	,adopt_Ani_town
	
                	,adopt_Ani_road
	
                	,adopt_Ani_like
 
                ); 
                     
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/back-end/adopt_ani/listAllAdopt_Ani.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllAdopt_Ani.jsp
				successView.forward(req, res);				
				
			/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/adopt_ani/addAdopt_Ani.jsp");
				failureView.forward(req, res);
			}
		}			

		if ("delete".equals(action)) { 
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			String requestURL = req.getParameter("requestURL"); // 送出修改的來源網頁路徑
		
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				//==== getParameter設定 ====
                String adopt_Ani_Id = new String(req.getParameter("adopt_Ani_Id"));

				/***************************2.開始刪除資料***************************************/
				Adopt_AniService adopt_aniSvc = new Adopt_AniService();

				Adopt_AniVO adopt_aniVO = adopt_aniSvc.getOneAdopt_Ani(adopt_Ani_Id);
				adopt_aniSvc.deleteAdopt_Ani(adopt_Ani_Id);
				
				
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/

				if(requestURL.equals("/back-end/adopt_ani/listAdopt_Anis_ByMem_Id.jsp") 
					|| requestURL.equals("/back-end/adopt_ani/listAllAdopt_Ani.jsp")){
					req.setAttribute("listAdopt_Anis_ByMem_Id",adopt_aniSvc.getAdopt_AnisByMem_Id(adopt_aniVO.getMem_Id())); // 資料庫取出的list物件,存入request
				}
				
				
				if(requestURL.equals("/back-end/adopt_ani/listAdopt_Anis_ByCompositeQuery.jsp")){
					HttpSession session = req.getSession();
					Map<String, String[]> map = (Map<String, String[]>)session.getAttribute("map");
					List<Adopt_AniVO> list  = adopt_aniSvc.getAll(map);
					req.setAttribute("listAdopt_Anis_ByCompositeQuery",list); //  複合查詢, 資料庫取出的list物件,存入request
				}
                
				String url = requestURL;
				RequestDispatcher successView = req.getRequestDispatcher(url);   // 修改成功後,轉交回送出修改的來源網頁
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher(requestURL);
				failureView.forward(req, res);
			}
		}
		
		
	
        if ("listAdopt_Anis_ByCompositeQuery".equals(action)) { // 來自select_page.jsp的複合查詢請求
            List<String> errorMsgs = new LinkedList<String>();
            // Store this set in the request scope, in case we need to
            // send the ErrorPage view.
            req.setAttribute("errorMsgs", errorMsgs);

            try {
                
                /***************************1.將輸入資料轉為Map**********************************/ 
                //採用Map<String,String[]> getParameterMap()的方法 
                //注意:an immutable java.util.Map 
                //Map<String, String[]> map = req.getParameterMap();
                HttpSession session = req.getSession();
                Map<String, String[]> map = (Map<String, String[]>)session.getAttribute("map");

                if (req.getParameter("whichPage") == null){
                    HashMap<String, String[]> map1 = (HashMap<String, String[]>)req.getParameterMap();
                    HashMap<String, String[]> map2 = new HashMap<String, String[]>();
                    map2 = (HashMap<String, String[]>)map1.clone();
                    session.setAttribute("map",map2);
                    map = (HashMap<String, String[]>)req.getParameterMap();
                } 

                /***************************2.開始複合查詢***************************************/
                Adopt_AniService adopt_aniSvc = new Adopt_AniService();
                List<Adopt_AniVO> list  = adopt_aniSvc.getAll(map);
                
                /***************************3.查詢完成,準備轉交(Send the Success view)************/
                req.setAttribute("listAdopt_Anis_ByCompositeQuery", list); // 資料庫取出的list物件,存入request
                RequestDispatcher successView = req.getRequestDispatcher("/back-end/adopt_ani/listAdopt_Anis_ByCompositeQuery.jsp"); // 成功轉交listAdopt_Anis_ByCompositeQuery.jsp
                successView.forward(req, res);
                
                /***************************其他可能的錯誤處理**********************************/
            } catch (Exception e) {
                errorMsgs.add(e.getMessage());
                RequestDispatcher failureView = req
                        .getRequestDispatcher("/select_page.jsp");
                failureView.forward(req, res);
            }
        }
	


        // 來自select_page.jsp的請求                                  // 來自 adopt_ani/listAllAdopt_Ani.jsp的請求
        if ("listAdopt_Anis_ByMem_Id_A".equals(action)) {

            List<String> errorMsgs = new LinkedList<String>();
            req.setAttribute("errorMsgs", errorMsgs);
            try {
                /*************************** 1.接收請求參數 ****************************************/
                String mem_Id = new String(req.getParameter("mem_Id"));

                /*************************** 2.開始查詢資料 ****************************************/
                Adopt_AniService adopt_aniSvc = new Adopt_AniService();
                Set<Adopt_AniVO> set = adopt_aniSvc.getAdopt_AnisByMem_Id(mem_Id);

                /*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
                req.setAttribute("listAdopt_Anis_ByMem_Id", set);    // 資料庫取出的list物件,存入request

                String url = null;
                if ("listAdopt_Anis_ByMem_Id_A".equals(action))
                    url = "/back-end/adopt_ani/listAdopt_Anis_ByMem_Id.jsp";        // 成功轉交 adopt_ani/listAdopt_Anis_ByMem_Id.jsp

                RequestDispatcher successView = req.getRequestDispatcher(url);
                successView.forward(req, res);

                /*************************** 其他可能的錯誤處理 ***********************************/
            } catch (Exception e) {
                throw new ServletException(e);
            }
        }




















	}
}
