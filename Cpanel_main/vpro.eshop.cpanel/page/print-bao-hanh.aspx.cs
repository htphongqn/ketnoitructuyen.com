using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using vpro.functions;

namespace vpro.eshop.cpanel.page
{
    public partial class print_bao_hanh : System.Web.UI.Page
    {
        eshopdbDataContext db = new eshopdbDataContext();
        int _id = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            _id = Utils.CIntDef(Request.QueryString["id"]);
            if (!IsPostBack)
            {
                loadBaohanh();
                //loadLogo();
            }
        }
        #region loadData
        //private void loadLogo()
        //{
        //    var list = db.ESHOP_BANNERs.Where(n => n.BANNER_FIELD1 == "1").OrderByDescending(n => n.BANNER_ID).Take(1).ToList();
        //    if (list.Count > 0)
        //        Image_Logo.ImageUrl = PathFiles.GetPathBanner(list[0].BANNER_ID) + "/" + list[0].BANNER_FILE;
        //}
        private void loadBaohanh()
        {
            var list = (from a in db.BAOHANHs
                        join b in db.ESHOP_NEWs on a.NEWS_ID equals b.NEWS_ID
                        where a.ID == _id
                        select new
                        {
                            a.ID,
                            a.BH_ADDRESS,
                            a.BH_DATENHAN,
                            a.BH_DATETRA,
                            a.BH_EMAIL,
                            a.BH_NAMEKH,
                            a.BH_NOTE,
                            a.BH_NOTENHANVIEN,
                            a.BH_PHONE,
                            a.BH_SERI,
                            a.BH_SOHOADON,
                            a.BH_SOPHIEU,
                            a.BH_STATUS,
                            a.BH_TINHTRANGNHAN,
                            a.USER_ID,
                            b.NEWS_CODE,
                            b.NEWS_TITLE
                        }).ToList();
            if (list.Count > 0)
            {
                Rpbaohanh.DataSource = list;
                Rpbaohanh.DataBind();
                lbsophieu.Text = list[0].BH_SOPHIEU;
                string[] a = string.Format("{0:dd/MM/yyyy}", DateTime.Now).Split('/');
                string date = "Ngày " + a[0] + " Tháng " + a[1] + " Năm " + a[2];
                Lbdate.Text = date;
                lbnamekh.Text = list[0].BH_NAMEKH;
                lbphone.Text = list[0].BH_PHONE;
                lbadd.Text = list[0].BH_ADDRESS;
                lbtinhtrang.Text = list[0].BH_TINHTRANGNHAN;
                string[] ab = string.Format("{0:dd/MM/yyyy}", list[0].BH_DATETRA).Split('/');
                string datetra = "Ngày " + ab[0] + " Tháng " + ab[1] + " Năm " + ab[2];
                //Lbdatetra.Text = datetra;
            }
        }
        #endregion
        #region function
        public string getName(object id)
        {
            int _idus = Utils.CIntDef(id);
            var list = db.ESHOP_USERs.Where(n => n.USER_ID == _idus).ToList();
            if (list.Count > 0)
                return list[0].USER_NAME;
            return "";
        }
        public string getDate(object date)
        {
            return string.Format("0:dd/MM/yyyy", date);
        }
        #endregion
    }
}