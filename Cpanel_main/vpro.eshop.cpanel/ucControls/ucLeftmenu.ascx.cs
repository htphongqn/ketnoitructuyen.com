using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using vpro.functions;

namespace vpro.eshop.cpanel.ucControls
{
    public partial class ucLeftmenu : System.Web.UI.UserControl
    {
        #region Declare
        eshopdbDataContext db = new eshopdbDataContext();
        int _gtype, _gid;
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            _gid = Utils.CIntDef(Session["GROUP_ID"]);
            _gtype = Utils.CIntDef(Session["GROUP_TYPE"]);
            if (!IsPostBack) Loadmenu();
        }
        private void Loadmenu()
        {
            if (_gtype != 1)
            {
                var list = (from a in db.ESHOP_GROUPs
                            join b in db.GROUP_MENUs on a.GROUP_ID equals b.GROUP_ID
                            join c in db.MENUs on b.MENU_ID equals c.ID
                            where a.GROUP_ID == _gid && c.MENU_RANK==1
                            select c).OrderByDescending(n=>n.MENU_ORDER).ToList();
                if (list.Count > 0)
                {
                    Rpmenu.DataSource = list;
                    Rpmenu.DataBind();
                }
            }
            else
            {
                var list = db.MENUs.Where(n => n.MENU_RANK == 1).OrderByDescending(n => n.MENU_ORDER).ToList();
                if (list.Count > 0)
                {
                    Rpmenu.DataSource = list;
                    Rpmenu.DataBind();
                }
            }
        }
        public IQueryable loadmenuRank2(object id)
        {
            int menuid = Utils.CIntDef(id);
            var list = db.MENUs.Where(n => n.MENU_PARENT_ID == menuid);
            return list.ToList().Count > 0 ? list : null;
        }
    }
}