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
    public partial class Ads_right_slider : System.Web.UI.UserControl
    {
        #region Declare
        Propertity per = new Propertity();
        Function fun = new Function();
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            int isHome = Utils.CIntDef(HttpContext.Current.Session["Cat_id_home"]);
            if (isHome == 1)
                HttpContext.Current.Session["Cat_id"] = MVC_Kutun.Components.Const.HOMEID;

            if (!IsPostBack) Load_ads(2, ref Rpads);
        }
        #region Slider
        public void Load_ads(int position, ref Repeater rp)
        {
            try
            {
                var list = per.Load_slider(HttpContext.Current.Session["Cat_id"], position, 4).ToList();
                if (list.Count > 0)
                {
                    rp.DataSource = list;
                    rp.DataBind();
                }
            }
            catch (Exception ex)
            {
                clsVproErrorHandler.HandlerError(ex);
            }
        }
        #endregion
        #region Function

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