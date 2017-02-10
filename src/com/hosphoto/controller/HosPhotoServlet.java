	

package com.hosphoto.controller;
import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

import com.vet_hospital.model.*;

import com.hosphoto.model.*;
/** 
 *hosPhoto : <br>
 *	診所相片<br>
 *	英文:hosPhoto<br>
 */ 
@WebServlet(urlPatterns = { "/back-end/hosphoto/hosphoto.do" })
public class HosPhotoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L; 

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		System.out.println("HosPhoto servlet運行成功 ");
	


		//====getOne_For_Display====
		if ("getOne_For_Display".equals(action)) { 

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);		

			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("hosPhoto_Id");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("相片編號");
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				String   hosPhoto_Id = null;
				try {
					hosPhoto_Id = new String  (str);
				} catch (Exception e) {
					errorMsgs.add("相片編號格式不正確");				
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}

				/***************************2.開始查詢資料*****************************************/
	
				HosPhotoService hosphotoSvc = new HosPhotoService();
				HosPhotoVO hosphotoVO = hosphotoSvc.getOneHosPhoto(hosPhoto_Id);
				
				if (hosphotoVO == null) {
					errorMsgs.add("查無資料");
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}

				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("hosphotoVO", hosphotoVO); 
				String url = "/back-end/hosphoto/listOneHosPhoto.jsp";
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
				String hosPhoto_Id = new String(req.getParameter("hosPhoto_Id").trim());	
				
				/***************************2.開始查詢資料*****************************************/	
	
				HosPhotoService hosphotoSvc = new HosPhotoService();
				HosPhotoVO hosphotoVO = hosphotoSvc.getOneHosPhoto(hosPhoto_Id);
		
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("hosphotoVO", hosphotoVO); 		
				String url = "/back-end/hosphoto/update_hosphoto_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交update_hosphoto_input.jsp
				successView.forward(req, res);
					
				/***************************其他可能的錯誤處理************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料取出時失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher(requestURL);
				failureView.forward(req, res);
			}	
		}													


    
		if ("update".equals(action)) { // 來自update_hosPhoto_input.jsp的請求
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			String requestURL = req.getParameter("requestURL"); // 送出修改的來源網頁路徑
		
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				//==== getParameter設定 ====
				String hosPhoto_Id = req.getParameter("hosPhoto_Id").trim();
				String hosPhoto_HosId = req.getParameter("hosPhoto_HosId").trim();
				byte[] hosPhoto_photo = null;
				try {
					Part part = req.getPart("hosPhoto_photo");
					InputStream in = part.getInputStream();
					hosPhoto_photo = new byte[part.getInputStream().available()];
					in.read(hosPhoto_photo);
					in.close();
				} catch (Exception e) {
					hosPhoto_photo = null;
					//errorMsgs.add("相片請上傳照片.");
				}
				String isDisp_HosPhoto = req.getParameter("isDisp_HosPhoto").trim();
				String hosPhoto_name = req.getParameter("hosPhoto_name").trim();
				String hosPhoto_extent = req.getParameter("hosPhoto_extent").trim();

				//==== VO設定部分 ====			
				HosPhotoVO hosphotoVO = new HosPhotoVO();
				hosphotoVO.setHosPhoto_Id(hosPhoto_Id);
				hosphotoVO.setHosPhoto_HosId(hosPhoto_HosId);
				hosphotoVO.setHosPhoto_photo(hosPhoto_photo);
				hosphotoVO.setIsDisp_HosPhoto(isDisp_HosPhoto);
				hosphotoVO.setHosPhoto_name(hosPhoto_name);
				hosphotoVO.setHosPhoto_extent(hosPhoto_extent);


				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("hosphotoVO", hosphotoVO); // 含有輸入格式錯誤的hosphotoVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/hosphoto/update_hosphoto_input.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				/***************************2.開始修改資料*****************************************/

				HosPhotoService hosphotoSvc = new HosPhotoService();
				hosphotoVO = hosphotoSvc.updateHosPhoto(
					hosPhoto_Id
					,hosPhoto_HosId
					,hosPhoto_photo
					,isDisp_HosPhoto
					,hosPhoto_name
					,hosPhoto_extent
				);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/				

				if(requestURL.equals("/back-end/hosphoto/listHosPhotos_ByHos_Id.jsp") 
					|| requestURL.equals("/back-end/hosphoto/listAllHosPhoto.jsp")){
					req.setAttribute("listHosPhotos_ByHos_Id",hosphotoSvc.getHosPhotosByHos_Id(hosPhoto_HosId)); // 資料庫取出的list物件,存入request
				}
				
				
				if(requestURL.equals("/back-end/hosphoto/listHosPhotos_ByCompositeQuery.jsp")){
					HttpSession session = req.getSession();
					Map<String, String[]> map = (Map<String, String[]>)session.getAttribute("map");
					List<HosPhotoVO> list  = hosphotoSvc.getAll(map);
					req.setAttribute("listHosPhotos_ByCompositeQuery",list); //  複合查詢, 資料庫取出的list物件,存入request
				}
                
				String url = requestURL;
				RequestDispatcher successView = req.getRequestDispatcher(url);   // 修改成功後,轉交回送出修改的來源網頁
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/hosphoto/update_hosphoto_input.jsp");
				failureView.forward(req, res);
			}
		}
		
		
	
        if ("insert".equals(action)) { // 來自addHosPhoto.jsp的請求  
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/

                String hosPhoto_HosId = req.getParameter("hosPhoto_HosId").trim();	

                byte[] hosPhoto_photo = null;
                try {
                    Part part = req.getPart("hosPhoto_photo");
                    InputStream in = part.getInputStream();
                    hosPhoto_photo = new byte[part.getInputStream().available()];
                    in.read(hosPhoto_photo);
                    in.close();
                } catch (Exception e) {
                    //errorMsgs.add("相片請上傳照片.");
                    //e.printStackTrace();
                    hosPhoto_photo = null;
                }	

                String isDisp_HosPhoto = req.getParameter("isDisp_HosPhoto").trim();	

                String hosPhoto_name = req.getParameter("hosPhoto_name").trim();	

                String hosPhoto_extent = req.getParameter("hosPhoto_extent").trim();	

                HosPhotoVO hosphotoVO = new HosPhotoVO();
 
                hosphotoVO.setHosPhoto_HosId(hosPhoto_HosId);
 
                hosphotoVO.setHosPhoto_photo(hosPhoto_photo);
 
                hosphotoVO.setIsDisp_HosPhoto(isDisp_HosPhoto);
 
                hosphotoVO.setHosPhoto_name(hosPhoto_name);
 
                hosphotoVO.setHosPhoto_extent(hosPhoto_extent);
               
                // Send the use back to the form, if there were errors
                if (!errorMsgs.isEmpty()) {
                    req.setAttribute("hosphotoVO", hosphotoVO); // 含有輸入格式錯誤的hosphotoVO物件,也存入req
                    RequestDispatcher failureView = req.getRequestDispatcher("/back-end/hosphoto/addHosPhoto.jsp");
                    failureView.forward(req, res);
                    return;
                }
                
                /***************************2.開始新增資料***************************************/
                HosPhotoService hosphotoSvc = new HosPhotoService();
                hosphotoVO = hosphotoSvc.addHosPhoto(
	
                	hosPhoto_HosId
	
                	,hosPhoto_photo
	
                	,isDisp_HosPhoto
	
                	,hosPhoto_name
	
                	,hosPhoto_extent
 
                ); 
                     
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/back-end/hosphoto/listAllHosPhoto.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllHosPhoto.jsp
				successView.forward(req, res);				
				
			/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/hosphoto/addHosPhoto.jsp");
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
                String hosPhoto_Id = new String(req.getParameter("hosPhoto_Id"));

				/***************************2.開始刪除資料***************************************/
				HosPhotoService hosphotoSvc = new HosPhotoService();

				HosPhotoVO hosphotoVO = hosphotoSvc.getOneHosPhoto(hosPhoto_Id);
				hosphotoSvc.deleteHosPhoto(hosPhoto_Id);
				
				
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/

				if(requestURL.equals("/back-end/hosphoto/listHosPhotos_ByHos_Id.jsp") 
					|| requestURL.equals("/back-end/hosphoto/listAllHosPhoto.jsp")){
					req.setAttribute("listHosPhotos_ByHos_Id",hosphotoSvc.getHosPhotosByHos_Id(hosphotoVO.getHosPhoto_HosId())); // 資料庫取出的list物件,存入request
				}
				
				
				if(requestURL.equals("/back-end/hosphoto/listHosPhotos_ByCompositeQuery.jsp")){
					HttpSession session = req.getSession();
					Map<String, String[]> map = (Map<String, String[]>)session.getAttribute("map");
					List<HosPhotoVO> list  = hosphotoSvc.getAll(map);
					req.setAttribute("listHosPhotos_ByCompositeQuery",list); //  複合查詢, 資料庫取出的list物件,存入request
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
		
		
	
        if ("listHosPhotos_ByCompositeQuery".equals(action)) { // 來自select_page.jsp的複合查詢請求
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
                HosPhotoService hosphotoSvc = new HosPhotoService();
                List<HosPhotoVO> list  = hosphotoSvc.getAll(map);
                
                /***************************3.查詢完成,準備轉交(Send the Success view)************/
                req.setAttribute("listHosPhotos_ByCompositeQuery", list); // 資料庫取出的list物件,存入request
                RequestDispatcher successView = req.getRequestDispatcher("/back-end/hosphoto/listHosPhotos_ByCompositeQuery.jsp"); // 成功轉交listHosPhotos_ByCompositeQuery.jsp
                successView.forward(req, res);
                
                /***************************其他可能的錯誤處理**********************************/
            } catch (Exception e) {
                errorMsgs.add(e.getMessage());
                RequestDispatcher failureView = req
                        .getRequestDispatcher("/select_page.jsp");
                failureView.forward(req, res);
            }
        }
	


        // 來自select_page.jsp的請求                                  // 來自 hosphoto/listAllHosPhoto.jsp的請求
        if ("listHosPhotos_ByHos_Id_A".equals(action)) {

            List<String> errorMsgs = new LinkedList<String>();
            req.setAttribute("errorMsgs", errorMsgs);
            try {
                /*************************** 1.接收請求參數 ****************************************/
                String hosPhoto_HosId = new String(req.getParameter("hosPhoto_HosId"));

                /*************************** 2.開始查詢資料 ****************************************/
                HosPhotoService hosphotoSvc = new HosPhotoService();
                Set<HosPhotoVO> set = hosphotoSvc.getHosPhotosByHos_Id(hosPhoto_HosId);

                /*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
                req.setAttribute("listHosPhotos_ByHos_Id", set);    // 資料庫取出的list物件,存入request

                String url = null;
                if ("listHosPhotos_ByHos_Id_A".equals(action))
                    url = "/back-end/hosphoto/listHosPhotos_ByHos_Id.jsp";        // 成功轉交 hosphoto/listHosPhotos_ByHos_Id.jsp

                RequestDispatcher successView = req.getRequestDispatcher(url);
                successView.forward(req, res);

                /*************************** 其他可能的錯誤處理 ***********************************/
            } catch (Exception e) {
                throw new ServletException(e);
            }
        }





	}
}
