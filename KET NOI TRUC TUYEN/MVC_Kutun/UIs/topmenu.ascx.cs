﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Controller;
using vpro.functions;

namespace MVC_Kutun.UIs
{
    public partial class topmenu : System.Web.UI.UserControl
    {
        #region Declare
        Propertity per = new Propertity();
        Function fun = new Function();
        Home index = new Home();
        string _cat_seo_url = string.Empty;
        string _sNews_Seo_Url = string.Empty;
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                Loaddanhmuc();
                
            }
            if (!Check_type())
            {
                addControlSlide();
                div_script.Visible = false;
            }
            else
                div_script.Visible = true;
        }
        private void addControlSlide()
        {
            UserControl ucslide = Page.LoadControl("/UIs/Ucslider-ads.ascx") as UserControl;
            PlSlider.Controls.Add(ucslide);
        }
        public string setStyle()
        {
            if (Check_type()) return "";
            return "style='display: block; height: 410px'";
        }
        private bool Check_type()
        {
            int _type = Utils.CIntDef(Request["type"]);
            return _type != 0 ? true : false;
        }
        #region Loaddata
        public void Loaddanhmuc()
        {
            try
            {
                Rpmenucate.DataSource = per.Load_danhmuc_position(1, 2);
                Rpmenucate.DataBind();
            }
            catch (Exception)
            {

                throw;
            }
        }
        protected IQueryable Load_Menu2(object cat_parent_id)
        {
            try
            {
                return per.Menu2(cat_parent_id);
            }
            catch (Exception ex)
            {
                clsVproErrorHandler.HandlerError(ex);
                return null;
            }

        }
       
        #endregion

        #region Function
      
        public string GetLink(object Cat_Url, object Cat_Seo_Url)
        {
            try
            {

                return fun.Getlink_Cat(Cat_Url, Cat_Seo_Url);

            }
            catch (Exception)
            {

                throw;
            }
        }
        public string getImagecat(object cat_id, object cat_img)
        {
            return fun.Getimages_Cat(cat_id, cat_img);
        }
        public string GetImageAd(object Ad_Id, object Ad_Image1, object Ad_Target, object Ad_Url)
        {
            try
            {
                return fun.GetImageAd(Ad_Id, Ad_Image1, Ad_Target, Ad_Url);
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