using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Controller;
using MVC_Kutun.Components;
using vpro.functions;

namespace MVC_Kutun.UIs
{
    public partial class List_product_deal : System.Web.UI.UserControl
    {
        #region Declare
        Function fun = new Function();
        string _txt = string.Empty;
        int _page = 0;
        int _catid = 0;
        clsFormat fm = new clsFormat();
        Home index = new Home();
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Load_list();
            }
        }
        #region Loadsearch
        public void Load_list()
        {
            try
            {
                Rpproduct.DataSource = index.loadGiovang(1, 3, 100);
                Rpproduct.DataBind();

            }
            catch (Exception ex)
            {

                clsVproErrorHandler.HandlerError(ex);
            }
        }
        #endregion
        #region function
        protected double GetTotalSecond(object fromhour,object tohour, object DateEnd)
        {
            int _fromhour = Utils.CIntDef(fromhour);
            int _tohour = Utils.CIntDef(tohour);
            DateTime _datelimit = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day, _tohour, 1, 1);
            TimeSpan diff = _datelimit - DateTime.Now;
            return diff.TotalSeconds;
        }
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
        public string getdate(object date)
        {
            return fun.getDate(date);
        }
        #endregion
    }
}