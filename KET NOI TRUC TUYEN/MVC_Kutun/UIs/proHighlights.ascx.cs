using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Controller;
using vpro.functions;
using MVC_Kutun.Components;


namespace MVC_Kutun.UIs
{
    public partial class proHighlights : System.Web.UI.UserControl
    {
        #region Declare
        Home index = new Home();
        Function fun = new Function();
        Checkcookie cki = new Checkcookie();
        Order_now order = new Order_now();
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Loadindex(1,ref Rpprohighlight);
                Loadindex(2, ref Rppropromostion);
                //loadCookiePro(cki.Listcookie_see(), ref Rpprosee);
                //loadCookiePro(cki.Listcookie_like(), ref Rpprolike);
                loadProNew();
                loadProBuy();
                loadLoveorSee(0, ref Rpprosee);
                loadLoveorSee(1, ref Rpprolike);
            }
        }
        #region Lodata
        private void loadLoveorSee(int type, ref Repeater rp)
        {
            rp.DataSource = index.loadLoveOrSee(type, 20);
            rp.DataBind();
        }
        public void Loadindex(int perior,ref Repeater rp)
        {
            try
            {
                var list = index.Loadindex(1, perior, 12);
                if (list.Count > 0)
                {
                    rp.DataSource = list;
                    rp.DataBind();
                   
                }
               
                
            }
            catch (Exception)
            {

                throw;
            }
        }
        private void loadCookiePro(List<string> url,ref Repeater rp)
        {
            rp.DataSource = index.Loadpro_cookie(1, url);
            rp.DataBind();
        }
        private void loadProNew()
        {
            Rppronew.DataSource = index.Loadpro_new(1,12);
            Rppronew.DataBind();
        }
        private void loadProBuy()
        {
            Rpprobuy.DataSource = order.load_ordenowHighlight(12);
            Rpprobuy.DataBind();
        }
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