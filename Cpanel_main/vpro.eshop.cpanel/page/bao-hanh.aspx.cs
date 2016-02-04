using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using vpro.functions;
using vpro.eshop.cpanel.ucControls;

namespace vpro.eshop.cpanel.page
{
    public partial class bao_hanh : System.Web.UI.Page
    {
        eshopdbDataContext db = new eshopdbDataContext();
        int _idbaohanh = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            _idbaohanh = Utils.CIntDef(Request["id"]);
            if (!IsPostBack)
            {
                //pickdatereciever.returnDate = DateTime.Now;
                pickdelivery.returnDate = DateTime.Now;
                ucHeader.HeaderLevel1 = "Bảo hành";
                ucHeader.HeaderLevel1_Url = "../page/bao-hanh.aspx";
                ucHeader.HeaderLevel2 = "Bảo hàng";
                ucHeader.HeaderLevel2_Url = "../page/bao-hanh.aspx";
                setSophieu();
                if (_idbaohanh != 0)
                    getInfo();
            }
        }
        private void setSophieu()
        {

            var list = db.BAOHANHs.OrderByDescending(n => n.ID).ToList();
            if (list.Count > 0)
            {
                int no = Utils.CIntDef(list[0].ID);
                txtsophieu.Value = "BH" + no++;
            }
            else txtsophieu.Value = "BH1";
        }
        private void getInfo()
        {
            var list = db.BAOHANHs.Where(n => n.ID == _idbaohanh).ToList();
            if (list.Count > 0)
            {
               
                txtcode.Text = getCode(Utils.CIntDef(list[0].NEWS_ID));
                Hynews.Text = getName();
                Hynews.NavigateUrl = "news.aspx?type=1&news_id=" + getIdnews();
                //pickdatereciever.returnDate =Utils.CDateDef(list[0].BH_DATENHAN,DateTime.Now);
                txtsophieu.Value = list[0].BH_SOPHIEU;
                txtnamekhachhang.Value = list[0].BH_NAMEKH;
                txtadd.Value = list[0].BH_ADDRESS;
                txtphone.Value = list[0].BH_PHONE;
                txtemail.Value = list[0].BH_EMAIL;
                txtsohoadon.Value = list[0].BH_SOHOADON;
                txtseri.Value = list[0].BH_SERI;
                pickdelivery.returnDate = Utils.CDateDef(list[0].BH_DATETRA, DateTime.Now);
                txttinhtrang.Value = list[0].BH_TINHTRANGNHAN;
                txtnotenhanvien.Value = list[0].BH_NOTENHANVIEN;
                txtnote.Value = list[0].BH_NOTE;
                Rdstatus.SelectedValue = list[0].BH_STATUS.ToString();
            }
        }
        protected void lbtSave_Click(object sender, EventArgs e)
        {
            Save();
        }
        private string getCode(int id)
        {
            var list = db.ESHOP_NEWs.Where(n => n.NEWS_ID == id).ToList();
            if (list.Count > 0)
            {
                return list[0].NEWS_CODE;
            }
            return "";
        }
        private string getName()
        {
            var list = db.ESHOP_NEWs.Where(n => n.NEWS_CODE == txtcode.Text.Trim()).ToList();
            if (list.Count > 0)
            {
                return list[0].NEWS_TITLE;
            }
            return "";
        }
        private int getIdnews()
        {
            var list = db.ESHOP_NEWs.Where(n => n.NEWS_CODE == txtcode.Text.Trim()).ToList();
            if (list.Count > 0)
            {
                return list[0].NEWS_ID;
            }
            return 0;
        }
        private void Save(string link = "")
        {
            int id = getIdnews();
            if (_idbaohanh != 0)
            {
                var list = db.BAOHANHs.Where(n => n.ID == _idbaohanh).ToList();
                if (list.Count > 0)
                {
                    
                    list[0].NEWS_ID = id;
                    list[0].USER_ID = Utils.CIntDef(Session["USER_ID"]);
                    //list[0].BH_DATENHAN = pickdatereciever.returnDate;
                    list[0].BH_DATETRA = pickdelivery.returnDate;
                    list[0].BH_SOPHIEU=txtsophieu.Value;
                    list[0].BH_NAMEKH = txtnamekhachhang.Value;
                    list[0].BH_ADDRESS = txtadd.Value;
                    list[0].BH_PHONE = txtphone.Value;
                    list[0].BH_EMAIL = txtemail.Value;
                    list[0].BH_SOHOADON = txtsohoadon.Value;
                    list[0].BH_SERI = txtseri.Value;
                    list[0].BH_TINHTRANGNHAN = txttinhtrang.Value;
                    list[0].BH_NOTENHANVIEN = txtnotenhanvien.Value;
                    list[0].BH_NOTE = txtnote.Value;
                    list[0].BH_STATUS = Utils.CIntDef(Rdstatus.SelectedValue);
                    db.SubmitChanges();

                }

            }
            else
            {
                if (id != 0)
                {
                    BAOHANH bh = new BAOHANH();
                    bh.NEWS_ID = id;
                    bh.USER_ID = Utils.CIntDef(Session["USER_ID"]);
                    bh.BH_DATENHAN = DateTime.Now;
                    bh.BH_DATETRA = pickdelivery.returnDate;
                    bh.BH_SOPHIEU = txtsophieu.Value;
                    bh.BH_NAMEKH = txtnamekhachhang.Value;
                    bh.BH_ADDRESS = txtadd.Value;
                    bh.BH_PHONE = txtphone.Value;
                    bh.BH_EMAIL = txtemail.Value;
                    bh.BH_SOHOADON = txtsohoadon.Value;
                    bh.BH_SERI = txtseri.Value;
                    bh.BH_TINHTRANGNHAN = txttinhtrang.Value;
                    bh.BH_NOTENHANVIEN = txtnotenhanvien.Value;
                    bh.BH_NOTE = txtnote.Value;
                    bh.BH_STATUS = Utils.CIntDef(Rdstatus.SelectedValue);
                    db.BAOHANHs.InsertOnSubmit(bh);
                    db.SubmitChanges();
                    var list = db.BAOHANHs.OrderByDescending(n => n.ID).ToList();
                    if (list.Count > 0)
                        _idbaohanh = list[0].ID;
                   
                }

            }

            if (String.IsNullOrEmpty(link)) link = "bao-hanh.aspx?id=" + _idbaohanh;
            if (!String.IsNullOrEmpty(link))
                Response.Redirect(link);
        }
   

        protected void lbtSaveNew_Click(object sender, EventArgs e)
        {
            Save("bao-hanh.aspx");
        }

        protected void txtcode_TextChanged(object sender, EventArgs e)
        {
            Hynews.Text = getName();
            Hynews.NavigateUrl = "news.aspx?type=1&news_id=" + getIdnews();
        }

        protected void Lbprint_Click(object sender, EventArgs e)
        {
            Response.Redirect("print-bao-hanh.aspx?id=" + _idbaohanh);
        }
    }
}