using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using Controller;
using vpro.functions;
using MVC_Kutun.Components;
using Model;

namespace MVC_Kutun.vi_vn
{
    /// <summary>
    /// Summary description for ServiceAjax
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class ServiceAjax : System.Web.Services.WebService
    {
        Controller.Home index = new Controller.Home();
        Function fun = new Function();
        Checkcookie cki = new Checkcookie();
        Order_now order = new Order_now();
        [WebMethod]
        public string ajaxProhighlight(int type)
        {
            var list = new List<ESHOP_NEW>();
            switch (type)
            {
                case 1:list=Loadindex(1);break;
                case 2: list = loadCookiePro(cki.Listcookie_see()); break;
                case 3: list = loadCookiePro(cki.Listcookie_like()); break;
                //case 4: list = loadProBuy(); break;
                case 5: list = loadProNew(); break;
                case 6: list = Loadindex(2); break;
            }
            string _res = string.Empty;
            foreach (var i in list)
            {
                _res += "<li>";
                _res += "         <div class='product'>";
                _res += "            <div class='boxgrid'>";
                _res += "              <a href='" + GetLink(i.NEWS_URL, i.NEWS_SEO_URL, 1) + "'></a><a href='" + GetLink(i.NEWS_URL, i.NEWS_SEO_URL, 1) + "'";
                _res += "                class='img_product'>";
                _res += "                 <img alt='" + i.NEWS_TITLE + "' src='" + GetImageT(i.NEWS_ID, i.NEWS_IMAGE3) + "' /></a>";
                _res += "   </div>";
                _res += "     <h3 class='product_name'>";
                _res += "   <a href='" + GetLink(i.NEWS_URL, i.NEWS_SEO_URL, 1) + "'>";
                _res += i.NEWS_TITLE + "</a></h3>";
                _res += "  <del>";
                _res += GetPrice2(i.NEWS_PRICE1, i.NEWS_PRICE2) + "</del>";
                _res += " <div class='price'>";
                _res += "  Giá: <b>";
                _res += GetPrice1(i.NEWS_PRICE1, i.NEWS_PRICE2) + "</b></div>";
                _res += getBuy(i.NEWS_ID, i.NEWS_FIELD3);
                _res += Getgiam(i.NEWS_PRICE1, i.NEWS_PRICE2);
                _res += " </div>";
                _res += "</li>";
            }
            //_res+="<script src='//code.jquery.com/jquery-1.11.2.min.js'></script>";
            //_res += "<script src='../vi-vn/Scripts/all_scripts.js' type='text/javascript'></script>";
            return _res;


        }
        #region data
        public List<ESHOP_NEW> Loadindex(int perior)
        {
            try
            {
                var list = index.Loadindex(1, perior, 12);
                return list;
            }
            catch (Exception)
            {

                throw;
            }
        }
        private List<ESHOP_NEW> loadCookiePro(List<string> url)
        {
            var list = index.Loadpro_cookie(1, url);
            return list;
        }
        private List<ESHOP_NEW> loadProNew()
        {
            var list = index.Loadpro_new(1, 12);
            return list;
        }
        //private List<ESHOP_NEW> loadProBuy()
        //{
        //    var list = order.load_ordenowHighlight(12);
        //    return list;
        //}
        #endregion
        #region function
        public string getBuy(object news_id, object sta)
        {
            return fun.getBuy(news_id, sta);
        }
        public string Getprice(object News_Price1)
        {
            return fun.Getprice(News_Price1);
        }
        public decimal Getprice_addtocart(object News_Price1)
        {
            return fun.Getprice_addtocart(News_Price1);
        }
        public string GetPrice1(object News_Price1, object News_Price2)
        {
            try
            {
                return fun.Getprice1(News_Price1, News_Price2);
            }
            catch (Exception ex)
            {
                clsVproErrorHandler.HandlerError(ex);
                return null;
            }
        }
        public string GetPrice2(object News_Price1, object News_Price2)
        {
            try
            {
                return fun.Getprice2(News_Price1, News_Price2);
            }
            catch (Exception ex)
            {
                clsVproErrorHandler.HandlerError(ex);
                return null;
            }
        }
        public string Getgiam(object News_Price1, object News_Price2)
        {
            return fun.Getgiamgia(News_Price1, News_Price2);
        }
        public string GetLink(object News_Url, object News_Seo_Url, object cat_seo)
        {
            try
            {
                return fun.Getlink_News(News_Url, News_Seo_Url, cat_seo);
            }
            catch (Exception ex)
            {
                vpro.functions.clsVproErrorHandler.HandlerError(ex);
                return null;
            }
        }
        public string GetImageT(object News_Id, object News_Image1)
        {

            try
            {
                return fun.GetImageT_News(News_Id, News_Image1);
            }
            catch (Exception ex)
            {
                clsVproErrorHandler.HandlerError(ex);
                return null;
            }
        }
        #endregion
    }
}
