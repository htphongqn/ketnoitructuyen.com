using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Controller;

namespace MVC_Kutun.UIs
{
    public partial class List_thuonghieu : System.Web.UI.UserControl
    {
        #region Declare
        Propertity per = new Propertity();
        Function fun = new Function();
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                loadList();
        }
        private void loadList()
        {
            RplistThuonghieu.DataSource = per.loadListThuonghieu();
            RplistThuonghieu.DataBind();
        }
        #region function
        public string getLinkCat(object cat_url, object cat_seo)
        {
            return fun.Getlink_Cat(cat_url, cat_seo);
        }
        public string getImgCat(object cat_id, object cat_img)
        {
            return fun.Getimages_Cat(cat_id, cat_img);
        }
        #endregion
    }
}