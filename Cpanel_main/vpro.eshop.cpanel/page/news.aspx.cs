using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using vpro.functions;
using System.Data;
using vpro.eshop.cpanel.ucControls;
using System.IO;
using System.Web.UI.HtmlControls;

namespace vpro.eshop.cpanel.page
{
    public partial class news : System.Web.UI.Page
    {

        #region Declare

        private int m_news_id = 0;
        int _type = 0;
        eshopdbDataContext DB = new eshopdbDataContext();
        int _gtype, _gid;
        #endregion

        #region form event

        protected void Page_Load(object sender, EventArgs e)
        {
            _gid = Utils.CIntDef(Session["GROUP_ID"]);
            _gtype = Utils.CIntDef(Session["GROUP_TYPE"]);
            m_news_id = Utils.CIntDef(Request["news_id"]);
            _type = Utils.CIntDef(Request["type"]);
            Hyperback.NavigateUrl = "news_list.aspx?type=" + _type;
            if (_type == 0)
            {
                dvProductDetails.Visible = dvPrice.Visible = div_status.Visible = false;
               
            }
            if (m_news_id == 0)
            {
                dvDelete.Visible = false;
                //trImage1.Visible = false;
                trNewsFunction.Visible = false;
                trImage3.Visible = false;
            }
            else
            {
                hplCatNews.HRef = "news_category.aspx?type=" + _type + "&news_id=" + m_news_id;
                hplEditorHTMl.HRef = "news_editor.aspx?type=" + _type + "&news_id=" + m_news_id;
                hplNewsAtt.HRef = "news_attachment.aspx?type=" + _type + "&news_id=" + m_news_id;
                hplAlbum.HRef = "news_images.aspx?type=" + _type + "&news_id=" + m_news_id;
                //bplNewsCopy.HRef = "news_copy.aspx?news_id=" + m_news_id;
                hplComment.HRef = "news_comment.aspx?type=" + _type + "&news_id=" + m_news_id;
                //hplCatProducts.HRef = "news_news.aspx?news_id=" + m_news_id;
            }
           
            if (!IsPostBack)
            {
                Pickthoigian.returnDate = DateTime.Now;
                ucHeader.HeaderLevel1 = "Sản phẩm";
                ucHeader.HeaderLevel1_Url = "../page/news_list.aspx?type="+_type;
                ucHeader.HeaderLevel2 = "Thêm mới";
                ucHeader.HeaderLevel2_Url = "../page/news.aspx?type=" + _type;
                addTime(ref Drfromhour);
                addTime(ref Drtohour);
                addItemType();
                //addItemPeriors();
                Loadhangsx();
                LoadXuatxu();
                getInfo();
                LoadCategoryParent();
                
            }
        }

        #endregion
        private void addTime(ref DropDownList dr)
        {
            for (int i = 0; i < 24; i++)
            {
                ListItem l = new ListItem();
                l.Value = i.ToString();
                l.Text = i+" Giờ";
                dr.Items.Add(l);
            }
        }
        private void addItemType()
        {
            if (_type == 0)
            {
                ListItem l = new ListItem("Tin tức", "0",true);
                l.Selected = true;
                rblNewsType.Items.Add(l);
            }
            else
            {
                ListItem l = new ListItem("Sản phẩm", "1",true);
                l.Selected = true;
                rblNewsType.Items.Add(l);
            }
        }
        private void addItemPeriors()
        {
            if (_type == 0)
            {
                List<string[]> l = new List<string[]>()
                {
                    new string[]{"7","Seo sologan giới thiệu"},
                    new string[]{"8","Tin tức slider"},
                    new string[]{"9","Tin tức xem nhiều"},
                    new string[]{"10","Video slider"},
                    new string[]{"11","Video xem nhiều"},
                    new string[]{"20","Không"},
                };
                var list = from a in l select new { id=a[0],name=a[1]};
                rblNewsPeriod.DataValueField = "id";
                rblNewsPeriod.DataTextField = "name";
                rblNewsPeriod.DataSource = list;
                rblNewsPeriod.DataBind();
                rblNewsPeriod.SelectedIndex = l.Count - 1;
            }
            else
            {
                List<string[]> l = new List<string[]>()
                {
                    new string[]{"1","Sản phẩm trên top"},
                    new string[]{"2","Sản phẩm bán chạy"},
                    new string[]{"3","Sản phẩm nổi bật"},
                    new string[]{"4","Sản phẩm mới"},
                    new string[]{"5","Sản phẩm giá sốc"},
                    new string[]{"6","Giờ vàng giá sốc"},
                    new string[]{"20","Không"},

                };
                var list = from a in l select new { id = a[0], name = a[1] };
                rblNewsPeriod.DataValueField = "id";
                rblNewsPeriod.DataTextField = "name";
                rblNewsPeriod.DataSource = list;
                rblNewsPeriod.DataBind();
                rblNewsPeriod.SelectedIndex = l.Count - 1;
            }
        }
        #region Button Events

        protected void lbtSave_Click(object sender, EventArgs e)
        {
            if (CheckExitsLink(txtSeoUrl.Value))
                lblError.Text = "Đã tồn tại Seo Url, vui lòng nhập Seo Url khác cho tin.";
            else
                SaveInfo();
        }

        protected void lbtSaveNew_Click(object sender, EventArgs e)
        {
            if (CheckExitsLink(txtSeoUrl.Value))
                lblError.Text = "Đã tồn tại Seo Url, vui lòng nhập Seo Url khác cho chuyên mục.";
            else
                SaveInfo("news.aspx?type="+_type);
        }

        protected void lbtDelete_Click(object sender, EventArgs e)
        {
            DeleteInfo();
        }

        protected void btnDelete1_Click(object sender, ImageClickEventArgs e)
        {
            string strLink = "";
            try
            {
                var n_info = DB.GetTable<ESHOP_NEW>().Where(n => n.NEWS_ID == m_news_id);

                if (n_info.ToList().Count > 0)
                {
                    if (!string.IsNullOrEmpty(n_info.ToList()[0].NEWS_IMAGE1))
                    {
                        string imagePath = Server.MapPath(PathFiles.GetPathNews(m_news_id) + n_info.ToList()[0].NEWS_IMAGE1);
                        n_info.ToList()[0].NEWS_IMAGE1 = "";
                        DB.SubmitChanges();

                        if (File.Exists(imagePath))
                            File.Delete(imagePath);

                        strLink = "news.aspx?type="+_type+"&news_id=" + m_news_id;
                    }
                }
            }
            catch (Exception ex)
            {
                clsVproErrorHandler.HandlerError(ex);
            }
            finally
            {
                if (!string.IsNullOrEmpty(strLink))
                    Response.Redirect(strLink);
            }
        }

        #endregion

        #region My functions


        private List<string> getCatid()
        {
            List<string> l = new List<string>();
            var list = DB.ESHOP_GROUP_CATs.Where(n => n.GROUP_ID == _gid).ToList();
            foreach (var i in list)
            {
                l.Add(Utils.CStrDef(i.CAT_ID));
            }
            return l;
        }
        private void LoadCategoryParent()
        {
            try
            {
                var CatList = (
                                from t2 in DB.ESHOP_CATEGORies
                                where t2.CAT_RANK > 0 &&(_type==0 ? (t2.CAT_TYPE==0||t2.CAT_TYPE==3) : t2.CAT_TYPE==1)
                                  && (_gtype != 1 ? (getCatid().Contains(t2.CAT_ID.ToString()) || getCatid().Contains(t2.CAT_PARENT_ID.ToString())) : true)
                                select new
                                {
                                    CAT_ID = t2.CAT_NAME == "------- Root -------" ? 0 : t2.CAT_ID,
                                    CAT_NAME = (string.IsNullOrEmpty(t2.CAT_CODE) ? t2.CAT_NAME : t2.CAT_NAME + "(" + t2.CAT_CODE + ")"),
                                    CAT_NAME_EN = (string.IsNullOrEmpty(t2.CAT_CODE_EN) ? t2.CAT_NAME_EN : t2.CAT_NAME_EN + "(" + t2.CAT_CODE_EN + ")"),
                                    CAT_PARENT_ID = t2.CAT_PARENT_ID,
                                    CAT_RANK = t2.CAT_RANK
                                }
                            );

                if (CatList.ToList().Count > 0)
                {
                    DataRelation relCat;
                    DataTable tbl = DataUtil.LINQToDataTable(CatList);
                    DataSet ds = new DataSet();
                    ds.Tables.Add(tbl);

                    tbl.PrimaryKey = new DataColumn[] { tbl.Columns["CAT_ID"] };
                    relCat = new DataRelation("Category_parent", ds.Tables[0].Columns["CAT_ID"], ds.Tables[0].Columns["CAT_PARENT_ID"], false);

                    ds.Relations.Add(relCat);
                    DataSet dsCat = ds.Clone();
                    DataTable CatTable = ds.Tables[0];

                    DataUtil.TransformTableWithSpace(ref CatTable, dsCat.Tables[0], relCat, null);
                    if (CatList.ToList()[0].CAT_RANK > 1)
                        ddlCategory.DataSource = CatList;
                    else
                        ddlCategory.DataSource = dsCat.Tables[0];
                    ddlCategory.DataTextField = "CAT_NAME";
                    ddlCategory.DataValueField = "CAT_ID";
                    ddlCategory.DataBind();

                }
                else
                {
                    DataTable dt = new DataTable("Newtable");

                    dt.Columns.Add(new DataColumn("CAT_ID"));
                    dt.Columns.Add(new DataColumn("CAT_NAME"));
                    dt.Columns.Add(new DataColumn("CAT_NAME_EN"));

                    DataRow row = dt.NewRow();
                    row["CAT_ID"] = 0;
                    row["CAT_NAME"] = "--------Root--------";
                    row["CAT_NAME_EN"] = "--------Root--------";
                    dt.Rows.Add(row);

                    ddlCategory.DataTextField = "CAT_NAME";
                    ddlCategory.DataValueField = "CAT_ID";
                    ddlCategory.DataSource = dt;
                    ddlCategory.DataBind();
                }

            }
            catch (Exception ex)
            {
                clsVproErrorHandler.HandlerError(ex);
            }
        }
        private void Loadhangsx()
        {
            var list = DB.ESHOP_CATEGORies.Where(n => n.CAT_TYPE == 2 && n.CAT_RANK == 2);
            Drhangsx.DataValueField = "CAT_ID";
            Drhangsx.DataTextField = "CAT_NAME";
            Drhangsx.DataSource = list;
            Drhangsx.DataBind();
            ListItem l = new ListItem("--- Chọn hãng sản xuất ---", "0");
            l.Selected = true;
            Drhangsx.Items.Insert(0, l);
        }
        private void LoadXuatxu()
        {
            var list = DB.ESHOP_CATEGORies.Where(n => n.CAT_TYPE == 3 && n.CAT_RANK == 2);
            Drxuatxu.DataValueField = "CAT_ID";
            Drxuatxu.DataTextField = "CAT_NAME";
            Drxuatxu.DataSource = list;
            Drxuatxu.DataBind();
            ListItem l = new ListItem("--- Chọn xuất xứ ---", "0");
            l.Selected = true;
            Drxuatxu.Items.Insert(0, l);
        }
        //private void LoadUnits()
        //{
        //    try
        //    {
        //        var units = DB.GetTable<ESHOP_UNIT>();

        //        ddlUnit1.DataSource = units;
        //        ddlUnit1.DataTextField = "UNIT_NAME";
        //        ddlUnit1.DataValueField = "UNIT_ID";
        //        ddlUnit1.DataBind();

        //        ddlUnit2.DataSource = units;
        //        ddlUnit2.DataTextField = "UNIT_NAME";
        //        ddlUnit2.DataValueField = "UNIT_ID";
        //        ddlUnit2.DataBind();
        //    }
        //    catch (Exception ex)
        //    {
        //        clsVproErrorHandler.HandlerError(ex);
        //    }
        //}

        private void getInfo()
        {
            try
            {
                //LoadUnits();
                Components.CpanelUtils.createItemTarget(ref ddlTarget);
               
                var G_info = (from n in DB.ESHOP_NEWs
                              join c in DB.ESHOP_NEWS_CATs on n.NEWS_ID equals c.NEWS_ID into t2_join
                              from c in t2_join.DefaultIfEmpty()
                              where n.NEWS_ID == m_news_id
                              select new { 
                                  n,
                                  c.CAT_ID
                              }
                            );

                if (G_info.ToList().Count > 0)
                {

                    if (G_info.ToList()[0].n.NEWS_TYPE == 0)
                    {
                        dvProductDetails.Visible = dvPrice.Visible =div_status.Visible = false;
                       
                    }
                    else
                    {
                        dvProductDetails.Visible = dvPrice.Visible =div_status.Visible= true;
                        
                    }
                    trCat.Visible = false;
                    txtTitle.Value = G_info.ToList()[0].n.NEWS_TITLE;
                    txtcode.Value = G_info.ToList()[0].n.NEWS_CODE;
                    if (G_info.ToList()[0].n.NEWS_UPDATE!=null)
                        Pickthoigian.returnDate = Utils.CDateDef(G_info.ToList()[0].n.NEWS_UPDATE,DateTime.Now);
                    Drfromhour.SelectedValue = G_info.ToList()[0].n.NEWS_FROM_HOUR.ToString();
                    Drtohour.SelectedValue = G_info.ToList()[0].n.NEWS_TO_HOUR.ToString();
                    //Kho
                    //txtquantity.Value = G_info.ToList()[0].n.NEWS_QUANTITY.ToString();
                    //txtton.Value = G_info.ToList()[0].n.NEWS_INVENTORY.ToString();
                    txtweight.Value = G_info.ToList()[0].n.NEWS_FIELD4;
                    txtcongnghe1.Value = G_info.ToList()[0].n.NEWS_FIELD5;

                    txtDesc.Value = G_info.ToList()[0].n.NEWS_DESC;
                    txtUrl.Value = G_info.ToList()[0].n.NEWS_URL;
                    ddlTarget.SelectedValue = G_info.ToList()[0].n.NEWS_TARGET;
                    txtPrice.Value = Utils.CStrDef(Utils.CIntDef(G_info.ToList()[0].n.NEWS_PRICE1));
                    Txtprice_promos.Value = Utils.CStrDef(Utils.CIntDef(G_info.ToList()[0].n.NEWS_PRICE2));
                    txtpricegiovang.Value = Utils.CStrDef(Utils.CIntDef(G_info.ToList()[0].n.NEWS_PRICE3));
                    txtPricemuavao.Value = Utils.CStrDef(Utils.CIntDef(G_info.ToList()[0].n.NEWS_PRICEMUAVAO));
                    //drNhanHieu.SelectedValue = Utils.CStrDef(G_info.ToList()[0].n.UNIT_ID1);
                    Drhangsx.SelectedValue=G_info.ToList()[0].n.UNIT_ID2.ToString();
                    Drxuatxu.SelectedValue = G_info.ToList()[0].n.UNIT_ID1.ToString();
                    //txtcountbuy.Value = G_info.ToList()[0].n.UNIT_ID3.ToString();
                    rblNewsType.SelectedValue = Utils.CStrDef(G_info.ToList()[0].n.NEWS_TYPE);
                    rblStatus.SelectedValue = Utils.CStrDef(G_info.ToList()[0].n.NEWS_SHOWTYPE);
                    rblNewsPeriod.SelectedValue = Utils.CStrDef(G_info.ToList()[0].n.NEWS_PERIOD);
                    //rblField1.SelectedValue = Utils.CStrDef(G_info.ToList()[0].n.NEWS_FIELD1);
                    rblFeefback.SelectedValue = Utils.CStrDef(G_info.ToList()[0].n.NEWS_FEEDBACKTYPE);
                    txtOrder.Value = Utils.CStrDef(G_info.ToList()[0].n.NEWS_ORDER, "1");
                    txtOrderPeriod.Value = Utils.CStrDef(G_info.ToList()[0].n.NEWS_ORDER_PERIOD, "1");
                    txtCount.Value = Utils.CStrDef(G_info.ToList()[0].n.NEWS_COUNT);
                    //lblCount.Text = string.IsNullOrEmpty(Utils.CStrDef(G_info.ToList()[0].n.NEWS_COUNT)) ? "0" : Utils.CStrDef(G_info.ToList()[0].n.NEWS_COUNT);
                    //lblSendEmail.Text = G_info.ToList()[0].n.NEWS_SENDDATE == null ? "Chưa gửi" : "Gửi lần cuối vào " + string.Format("{0:dd/MM/yyyy HH:mm:ss}", G_info.ToList()[0].n.NEWS_SENDDATE);
                    txtbaohanh.Value = G_info.ToList()[0].n.NEWS_FIELD2;
                    Rdstatus.SelectedValue = Utils.CIntDef(G_info.ToList()[0].n.NEWS_FIELD3).ToString();
                    Rdvat.SelectedValue = Utils.CIntDef(G_info.ToList()[0].n.UNIT_ID3).ToString();
                    //txtdesc_bot.Value = G_info.ToList()[0].n.NEWS_FIELD4;
                    txtvideo.Value = G_info.ToList()[0].n.NEWS_DIET;
                    //seo
                    txtSeoTitle.Value = Utils.CStrDef(G_info.ToList()[0].n.NEWS_SEO_TITLE);
                    txtSeoKeyword.Value = Utils.CStrDef(G_info.ToList()[0].n.NEWS_SEO_KEYWORD);
                    txtSeoDescription.Value = Utils.CStrDef(G_info.ToList()[0].n.NEWS_SEO_DESC);
                    txtSeoUrl.Value = Utils.CStrDef(G_info.ToList()[0].n.NEWS_SEO_URL);

                    //PRICE
                   
                    //ddlUnit2.SelectedValue = Utils.CStrDef(G_info.ToList()[0].n.UNIT_ID2);

                    //Product Properties
                   // txtStatus.Value = G_info.ToList()[0].n.NEWS_FIELD1;
                   // txtWarranty.Value = G_info.ToList()[0].n.NEWS_FIELD2;
                   // txtOrigin.Value = G_info.ToList()[0].n.NEWS_FIELD3;
                    //txtManufacture.Value = G_info.ToList()[0].n.NEWS_FIELD4;
                   // txtWeight.Value = G_info.ToList()[0].n.NEWS_FIELD5;
                    //image
                    //if (!string.IsNullOrEmpty(G_info.ToList()[0].n.NEWS_IMAGE1))
                    //{
                    //    trUploadImage1.Visible = false;
                    //    trImage1.Visible = true;
                    //    Image1.Src = PathFiles.GetPathNews(m_news_id) + G_info.ToList()[0].n.NEWS_IMAGE1;
                    //    hplImage1.NavigateUrl = PathFiles.GetPathNews(m_news_id) + G_info.ToList()[0].n.NEWS_IMAGE1;
                    //    hplImage1.Text = G_info.ToList()[0].n.NEWS_IMAGE1;
                    //}
                    //else
                    //{
                    //    trUploadImage1.Visible = true;
                    //    trImage1.Visible = false;
                    //}

                    ////image2
                    //if (!string.IsNullOrEmpty(G_info.ToList()[0].n.NEWS_IMAGE2))
                    //{
                    //    trUploadImage2.Visible = false;
                    //    trImage2.Visible = true;
                    //    Image2.Src = PathFiles.GetPathNews(m_news_id) + G_info.ToList()[0].n.NEWS_IMAGE2;
                    //    hplImage2.NavigateUrl = PathFiles.GetPathNews(m_news_id) + G_info.ToList()[0].n.NEWS_IMAGE2;
                    //    hplImage2.Text = G_info.ToList()[0].n.NEWS_IMAGE2;
                    //}
                    //else
                    //{
                    //    trUploadImage2.Visible = true;
                    //    trImage2.Visible = false;
                    //}

                    //image3
                    if (!string.IsNullOrEmpty(G_info.ToList()[0].n.NEWS_IMAGE3))
                    {
                        trUploadImage3.Visible = false;
                        trImage3.Visible = true;
                        Image3.Src = PathFiles.GetPathNews(m_news_id) + G_info.ToList()[0].n.NEWS_IMAGE3;
                        hplImage3.NavigateUrl = PathFiles.GetPathNews(m_news_id) + G_info.ToList()[0].n.NEWS_IMAGE3;
                        hplImage3.Text = G_info.ToList()[0].n.NEWS_IMAGE3;
                    }
                    else
                    {
                        trUploadImage3.Visible = true;
                        trImage3.Visible = false;
                    }

                }
                else
                {
                    //trUploadImage1.Visible = true;
                    //trImage1.Visible = false;
                    //trUploadImage2.Visible = true;
                    //trImage2.Visible = false;
                    trUploadImage3.Visible = true;
                    trImage3.Visible = false;
                    LoadCategoryParent();
                    trCat.Visible = true;
                }

            }
            catch (Exception ex)
            {
                clsVproErrorHandler.HandlerError(ex);
            }
        }

        private void SaveInfo(string strLink = "")
        {
            try
            {
                //get image
                //string News_Image1;

                //if (trUploadImage1.Visible == true)
                //{
                //    if (fileImage1.PostedFile != null)
                //    {
                //        News_Image1 = Path.GetFileName(fileImage1.PostedFile.FileName);
                //    }
                //    else
                //    {
                //        News_Image1 = "";
                //    }
                //}
                //else
                //{
                //    News_Image1 = hplImage1.Text;
                //}

                //string News_Image2;

                //if (trUploadImage2.Visible == true)
                //{
                //    if (fileImage2.PostedFile != null)
                //    {
                //        News_Image2 = Path.GetFileName(fileImage2.PostedFile.FileName);
                //    }
                //    else
                //    {
                //        News_Image2 = "";
                //    }
                //}
                //else
                //{
                //    News_Image2 = hplImage2.Text;
                //}

                string News_Image3;

                if (trUploadImage3.Visible == true)
                {
                    if (fileImage3.PostedFile != null)
                    {
                        News_Image3 = Path.GetFileName(fileImage3.PostedFile.FileName);
                    }
                    else
                    {
                        News_Image3 = "";
                    }
                }
                else
                {
                    News_Image3 = hplImage3.Text;
                }

                int _iType = Utils.CIntDef(rblNewsType.SelectedValue);

                if (_iType == 0 || _iType == 2)
                {
                    if (m_news_id == 0)
                    {

                        //insert
                        ESHOP_NEW news_insert = new ESHOP_NEW();

                        news_insert.NEWS_TITLE = txtTitle.Value;
                        news_insert.NEWS_DESC = txtDesc.Value;
                        news_insert.NEWS_URL = txtUrl.Value;
                        news_insert.NEWS_TARGET = ddlTarget.SelectedValue;
                        news_insert.NEWS_SEO_URL = txtSeoUrl.Value;
                        news_insert.NEWS_SEO_TITLE = txtSeoTitle.Value;
                        news_insert.NEWS_SEO_KEYWORD = txtSeoKeyword.Value;
                        news_insert.NEWS_SEO_DESC = txtSeoDescription.Value;

                        //news_insert.UNIT_ID1 = Utils.CIntDef(drNhanHieu.SelectedValue);
                        news_insert.NEWS_TYPE = Utils.CIntDef(rblNewsType.SelectedValue);
                        news_insert.NEWS_SHOWTYPE = Utils.CIntDef(rblStatus.SelectedValue);
                        news_insert.NEWS_PERIOD = Utils.CIntDef(rblNewsPeriod.SelectedValue);
                        //news_insert.NEWS_FIELD1 = Utils.CStrDef(rblField1.SelectedValue);
                        news_insert.NEWS_SHOWINDETAIL = Utils.CIntDef(rblShowDetail.SelectedValue);
                        news_insert.NEWS_FEEDBACKTYPE = Utils.CIntDef(rblFeefback.SelectedValue);
                        news_insert.NEWS_COUNT = Utils.CIntDef(txtCount.Value);
                        news_insert.NEWS_ORDER = Utils.CIntDef(txtOrder.Value);
                        news_insert.NEWS_ORDER_PERIOD = Utils.CIntDef(txtOrderPeriod.Value);
                        
                        //news_insert.UNIT_ID2 = Utils.CIntDef(ddlUnit2.SelectedValue);

                        //news_insert.NEWS_IMAGE1 = News_Image1;
                        //news_insert.NEWS_IMAGE2 = News_Image2;
                        news_insert.NEWS_IMAGE3 = News_Image3;

                        news_insert.USER_ID = Utils.CIntDef(Session["USER_ID"]);
                        news_insert.NEWS_PUBLISHDATE = DateTime.Now;
                        news_insert.NEWS_DIET = txtvideo.Value;
                       

                        DB.ESHOP_NEWs.InsertOnSubmit(news_insert);
                        DB.SubmitChanges();

                        //update cat news
                        var _new = DB.GetTable<ESHOP_NEW>().OrderByDescending(g => g.NEWS_ID).Take(1);

                        m_news_id = _new.Single().NEWS_ID;
                        SaveNewsCategory(_new.Single().NEWS_ID);

                        strLink = string.IsNullOrEmpty(strLink) ? "news.aspx?type="+_type+"&news_id=" + m_news_id : strLink;
                    }
                    else
                    {
                        //update
                        var c_update = DB.GetTable<ESHOP_NEW>().Where(g => g.NEWS_ID == m_news_id);

                        if (c_update.ToList().Count > 0)
                        {
                            c_update.ToList()[0].NEWS_TITLE = txtTitle.Value;
                            c_update.ToList()[0].NEWS_DESC = txtDesc.Value;
                            c_update.ToList()[0].NEWS_URL = txtUrl.Value;
                            c_update.ToList()[0].NEWS_TARGET = ddlTarget.SelectedValue;
                            c_update.ToList()[0].NEWS_SEO_URL = txtSeoUrl.Value;
                            c_update.ToList()[0].NEWS_SEO_TITLE = txtSeoTitle.Value;
                            c_update.ToList()[0].NEWS_SEO_KEYWORD = txtSeoKeyword.Value;
                            c_update.ToList()[0].NEWS_SEO_DESC = txtSeoDescription.Value;

                           
                            c_update.ToList()[0].NEWS_TYPE = Utils.CIntDef(rblNewsType.SelectedValue);
                            c_update.ToList()[0].NEWS_SHOWTYPE = Utils.CIntDef(rblStatus.SelectedValue);
                            c_update.ToList()[0].NEWS_PERIOD = Utils.CIntDef(rblNewsPeriod.SelectedValue);
                            //c_update.ToList()[0].NEWS_FIELD1 = Utils.CStrDef(rblField1.SelectedValue);
                            c_update.ToList()[0].NEWS_SHOWINDETAIL = Utils.CIntDef(rblShowDetail.SelectedValue);
                            c_update.ToList()[0].NEWS_FEEDBACKTYPE = Utils.CIntDef(rblFeefback.SelectedValue);
                            c_update.ToList()[0].NEWS_COUNT = Utils.CIntDef(txtCount.Value);
                            c_update.ToList()[0].NEWS_ORDER = Utils.CIntDef(txtOrder.Value);
                            c_update.ToList()[0].NEWS_ORDER_PERIOD = Utils.CIntDef(txtOrderPeriod.Value);
                            
                            //c_update.ToList()[0].UNIT_ID2 = Utils.CIntDef(ddlUnit2.SelectedValue);

                            //c_update.ToList()[0].NEWS_IMAGE1 = News_Image1;
                            //c_update.ToList()[0].NEWS_IMAGE2 = News_Image2;
                            c_update.ToList()[0].NEWS_IMAGE3 = News_Image3;
                            c_update.ToList()[0].NEWS_DIET = txtvideo.Value;
                           

                            DB.SubmitChanges();

                            strLink = string.IsNullOrEmpty(strLink) ? "news_list.aspx?type="+_type+"" : strLink;
                        }
                    }

                    //update images
                    //if (trUploadImage1.Visible)
                    //{
                    //    if (!string.IsNullOrEmpty(fileImage1.PostedFile.FileName))
                    //    {
                    //        string pathfile = Server.MapPath("/data/news/" + m_news_id);
                    //        string fullpathfile = pathfile + "/" + News_Image1;

                    //        if (!Directory.Exists(pathfile))
                    //        {
                    //            Directory.CreateDirectory(pathfile);
                    //        }

                    //        fileImage1.PostedFile.SaveAs(fullpathfile);
                    //    }

                    //}
                    //if (trUploadImage2.Visible)
                    //{
                    //    if (!string.IsNullOrEmpty(fileImage2.PostedFile.FileName))
                    //    {
                    //        string pathfile = Server.MapPath("/data/news/" + m_news_id);
                    //        string fullpathfile = pathfile + "/" + News_Image2;

                    //        if (!Directory.Exists(pathfile))
                    //        {
                    //            Directory.CreateDirectory(pathfile);
                    //        }

                    //        fileImage2.PostedFile.SaveAs(fullpathfile);
                    //    }

                    //}

                    if (trUploadImage3.Visible)
                    {
                        if (!string.IsNullOrEmpty(fileImage3.PostedFile.FileName))
                        {
                            string pathfile = Server.MapPath("/data/news/" + m_news_id);
                            string fullpathfile = pathfile + "/" + News_Image3;

                            if (!Directory.Exists(pathfile))
                            {
                                Directory.CreateDirectory(pathfile);
                            }

                            fileImage3.PostedFile.SaveAs(fullpathfile);
                        }

                    }
                }
                else
                {
                    if (CheckError())
                    {
                        if (m_news_id == 0)
                        {

                            //insert
                            ESHOP_NEW news_insert = new ESHOP_NEW();

                            news_insert.NEWS_TITLE = txtTitle.Value;
                            news_insert.NEWS_CODE = txtcode.Value;

                            //Kho
                            //news_insert.NEWS_QUANTITY = Utils.CIntDef(txtquantity.Value);
                            //news_insert.NEWS_INVENTORY = Utils.CIntDef(txtton.Value);

                            news_insert.NEWS_DESC = txtDesc.Value;
                            news_insert.NEWS_URL = txtUrl.Value;
                            news_insert.NEWS_TARGET = ddlTarget.SelectedValue;
                            news_insert.NEWS_SEO_URL = txtSeoUrl.Value;
                            news_insert.NEWS_SEO_TITLE = txtSeoTitle.Value;
                            news_insert.NEWS_SEO_KEYWORD = txtSeoKeyword.Value;
                            news_insert.NEWS_SEO_DESC = txtSeoDescription.Value;

                            //news_insert.UNIT_ID1 = Utils.CIntDef(drNhanHieu.SelectedValue);
                            news_insert.NEWS_UPDATE = Pickthoigian.returnDate;
                            news_insert.NEWS_FROM_HOUR = Utils.CIntDef(Drfromhour.SelectedValue);
                            news_insert.NEWS_TO_HOUR = Utils.CIntDef(Drtohour.SelectedValue);
                            news_insert.NEWS_TYPE = Utils.CIntDef(rblNewsType.SelectedValue);
                            news_insert.NEWS_SHOWTYPE = Utils.CIntDef(rblStatus.SelectedValue);
                            news_insert.NEWS_PERIOD = Utils.CIntDef(rblNewsPeriod.SelectedValue);
                            //news_insert.NEWS_FIELD1 = Utils.CStrDef(rblField1.SelectedValue);
                            news_insert.NEWS_SHOWINDETAIL = Utils.CIntDef(rblShowDetail.SelectedValue);
                            news_insert.NEWS_FEEDBACKTYPE = Utils.CIntDef(rblFeefback.SelectedValue);
                            news_insert.NEWS_COUNT = Utils.CIntDef(txtCount.Value);
                            news_insert.NEWS_ORDER = Utils.CIntDef(txtOrder.Value);
                            news_insert.NEWS_ORDER_PERIOD = Utils.CIntDef(txtOrderPeriod.Value);
                            news_insert.NEWS_PRICE1 = Utils.CDecDef(txtPrice.Value);
                            news_insert.NEWS_PRICE2 = Utils.CDecDef(Txtprice_promos.Value);
                            news_insert.NEWS_PRICE3 = Utils.CDecDef(txtpricegiovang.Value);
                            news_insert.NEWS_PRICEMUAVAO = Utils.CDecDef(txtPricemuavao.Value);
                            news_insert.UNIT_ID2 = Utils.CIntDef(Drhangsx.SelectedValue);
                            news_insert.UNIT_ID1 = Utils.CIntDef(Drxuatxu.SelectedValue);
                            news_insert.NEWS_FIELD4 = txtweight.Value;
                            news_insert.NEWS_FIELD5 = txtcongnghe1.Value;
                            //news_insert.UNIT_ID3 = Utils.CIntDef(txtcountbuy.Value);

                            //news_insert.NEWS_IMAGE1 = News_Image1;
                            //news_insert.NEWS_IMAGE2 = News_Image2;
                            news_insert.NEWS_IMAGE3 = News_Image3;

                            news_insert.USER_ID = Utils.CIntDef(Session["USER_ID"]);
                            news_insert.NEWS_PUBLISHDATE = DateTime.Now;


                           // news_insert.NEWS_FIELD1 = txtStatus.Value;
                            news_insert.NEWS_FIELD2 = txtbaohanh.Value;
                            news_insert.NEWS_FIELD3 = Rdstatus.SelectedValue;
                            news_insert.UNIT_ID3 = Utils.CIntDef(Rdvat.SelectedValue);
                            //news_insert.NEWS_FIELD4 = txtManufacture.Value;
                            //news_insert.NEWS_FIELD5 = txtWeight.Value;

                            DB.ESHOP_NEWs.InsertOnSubmit(news_insert);
                            DB.SubmitChanges();

                            //update cat news
                            var _new = DB.GetTable<ESHOP_NEW>().OrderByDescending(g => g.NEWS_ID).Take(1);

                            m_news_id = _new.Single().NEWS_ID;
                            SaveNewsCategory(_new.Single().NEWS_ID);

                            strLink = string.IsNullOrEmpty(strLink) ? "news.aspx?type="+_type+"&news_id=" + m_news_id : strLink;
                        }
                        else
                        {
                            //update
                            var c_update = DB.GetTable<ESHOP_NEW>().Where(g => g.NEWS_ID == m_news_id);

                            if (c_update.ToList().Count > 0)
                            {
                                c_update.ToList()[0].NEWS_TITLE = txtTitle.Value;
                                c_update.ToList()[0].NEWS_CODE = txtcode.Value;
                                c_update.ToList()[0].NEWS_UPDATE = Pickthoigian.returnDate;
                                c_update.ToList()[0].NEWS_FROM_HOUR = Utils.CIntDef(Drfromhour.SelectedValue);
                                c_update.ToList()[0].NEWS_TO_HOUR = Utils.CIntDef(Drtohour.SelectedValue);
                                //Kho
                                //c_update.ToList()[0].NEWS_QUANTITY =Utils.CIntDef(txtquantity.Value);
                                //c_update.ToList()[0].NEWS_INVENTORY = Utils.CIntDef(txtton.Value);

                                c_update.ToList()[0].NEWS_DESC = txtDesc.Value;
                                c_update.ToList()[0].NEWS_URL = txtUrl.Value;
                                c_update.ToList()[0].NEWS_TARGET = ddlTarget.SelectedValue;
                                c_update.ToList()[0].NEWS_SEO_URL = txtSeoUrl.Value;
                                c_update.ToList()[0].NEWS_SEO_TITLE = txtSeoTitle.Value;
                                c_update.ToList()[0].NEWS_SEO_KEYWORD = txtSeoKeyword.Value;
                                c_update.ToList()[0].NEWS_SEO_DESC = txtSeoDescription.Value;

                                c_update.ToList()[0].NEWS_FIELD2 = txtbaohanh.Value;
                                c_update.ToList()[0].NEWS_FIELD3 = Rdstatus.SelectedValue;
                                c_update.ToList()[0].UNIT_ID3 =Utils.CIntDef(Rdvat.SelectedValue);
                                //c_update.ToList()[0].NEWS_FIELD4 = txtdesc_bot.Value;
                   
                                c_update.ToList()[0].NEWS_TYPE = Utils.CIntDef(rblNewsType.SelectedValue);
                                c_update.ToList()[0].NEWS_SHOWTYPE = Utils.CIntDef(rblStatus.SelectedValue);
                                c_update.ToList()[0].NEWS_PERIOD = Utils.CIntDef(rblNewsPeriod.SelectedValue);
                                //c_update.ToList()[0].NEWS_FIELD1 = Utils.CStrDef(rblField1.SelectedValue);
                                c_update.ToList()[0].NEWS_SHOWINDETAIL = Utils.CIntDef(rblShowDetail.SelectedValue);
                                c_update.ToList()[0].NEWS_FEEDBACKTYPE = Utils.CIntDef(rblFeefback.SelectedValue);
                                c_update.ToList()[0].NEWS_COUNT = Utils.CIntDef(txtCount.Value);
                                c_update.ToList()[0].NEWS_ORDER = Utils.CIntDef(txtOrder.Value);
                                c_update.ToList()[0].NEWS_ORDER_PERIOD = Utils.CIntDef(txtOrderPeriod.Value);
                                c_update.ToList()[0].NEWS_PRICE1 = Utils.CDecDef(txtPrice.Value);
                                c_update.ToList()[0].NEWS_PRICE2 = Utils.CDecDef(Txtprice_promos.Value);
                                c_update.ToList()[0].NEWS_PRICE3 = Utils.CDecDef(txtpricegiovang.Value);
                                c_update.ToList()[0].NEWS_PRICEMUAVAO = Utils.CDecDef(txtPricemuavao.Value);
                                c_update.ToList()[0].UNIT_ID2 = Utils.CIntDef(Drhangsx.SelectedValue);
                                c_update.ToList()[0].UNIT_ID1 = Utils.CIntDef(Drxuatxu.SelectedValue);
                                c_update.ToList()[0].NEWS_FIELD4 = txtweight.Value;
                                c_update.ToList()[0].NEWS_FIELD5 = txtcongnghe1.Value;
                                //c_update.ToList()[0].UNIT_ID3 = Utils.CIntDef(txtcountbuy.Value);

                                //c_update.ToList()[0].NEWS_IMAGE1 = News_Image1;
                                //c_update.ToList()[0].NEWS_IMAGE2 = News_Image2;
                                c_update.ToList()[0].NEWS_IMAGE3 = News_Image3;

                                DB.SubmitChanges();

                                strLink = string.IsNullOrEmpty(strLink) ? "news_list.aspx?type="+_type+"" : strLink;
                            }
                        }

                        //update images
                        //if (trUploadImage1.Visible)
                        //{
                        //    if (!string.IsNullOrEmpty(fileImage1.PostedFile.FileName))
                        //    {
                        //        string pathfile = Server.MapPath("/data/news/" + m_news_id);
                        //        string fullpathfile = pathfile + "/" + News_Image1;

                        //        if (!Directory.Exists(pathfile))
                        //        {
                        //            Directory.CreateDirectory(pathfile);
                        //        }

                        //        fileImage1.PostedFile.SaveAs(fullpathfile);
                        //    }

                        //}
                        //if (trUploadImage2.Visible)
                        //{
                        //    if (!string.IsNullOrEmpty(fileImage2.PostedFile.FileName))
                        //    {
                        //        string pathfile = Server.MapPath("/data/news/" + m_news_id);
                        //        string fullpathfile = pathfile + "/" + News_Image2;

                        //        if (!Directory.Exists(pathfile))
                        //        {
                        //            Directory.CreateDirectory(pathfile);
                        //        }

                        //        fileImage2.PostedFile.SaveAs(fullpathfile);
                        //    }
                        //}

                        if (trUploadImage3.Visible)
                        {
                            if (!string.IsNullOrEmpty(fileImage3.PostedFile.FileName))
                            {
                                string pathfile = Server.MapPath("/data/news/" + m_news_id);
                                string fullpathfile = pathfile + "/" + News_Image3;

                                if (!Directory.Exists(pathfile))
                                {
                                    Directory.CreateDirectory(pathfile);
                                }

                                fileImage3.PostedFile.SaveAs(fullpathfile);
                            }

                        }
                    }
                    //else
                    //{
                    //    lblError.Text = "Vui lòng chọn màu sắc - kích cỡ!";
                    //}
                }
            }
            catch (Exception ex)
            {
                clsVproErrorHandler.HandlerError(ex);
            }
            finally
            {
                if (!string.IsNullOrEmpty(strLink))
                { Response.Redirect(strLink); }
            }
        }

        private void DeleteInfo()
        {
            string strLink="";
            try
            {
                var G_info = DB.GetTable<ESHOP_NEW>().Where(g => g.NEWS_ID == m_news_id);

                DB.ESHOP_NEWs.DeleteAllOnSubmit(G_info);
                DB.SubmitChanges();

                //delete folder
                string fullpath = Server.MapPath(PathFiles.GetPathNews(m_news_id));
                if (Directory.Exists(fullpath))
                {
                    DeleteAllFilesInFolder(fullpath);
                    Directory.Delete(fullpath);
                }

                strLink = "news_list.aspx?type="+_type;

            }
            catch (Exception ex)
            {
                clsVproErrorHandler.HandlerError(ex);
            }
            finally
            {
                if (!string.IsNullOrEmpty(strLink))
                    Response.Redirect(strLink);
            }
        }

        private void DeleteAllFilesInFolder(string folderpath)
        {
            foreach (var f in System.IO.Directory.GetFiles(folderpath))
                System.IO.File.Delete(f);
        }

        public string getLink(object GroupId)
        {
            return "news.aspx?type="+_type+"&news_id=" + Utils.CStrDef(GroupId);
        }

        private bool CheckExitsLink(string strLink)
        {
            try
            {
                var exits = (from c in DB.ESHOP_NEWs where c.NEWS_SEO_URL == strLink && c.NEWS_ID != m_news_id select c);

                if (exits.ToList().Count > 0)
                    return true;

                return false;
            }
            catch (Exception ex)
            {clsVproErrorHandler.HandlerError(ex);
                return false;
                
            }

        }

        private bool CheckError()
        {
            //if (string.IsNullOrEmpty(txtStatus.Value))
            //{
            //    lblError.Text = "Tình trạng sản phẩm không được rỗng!";
            //    return false;
            //}
            //else if (string.IsNullOrEmpty(txtOrigin.Value))
            //{
            //    lblError.Text = "Nhà nhập khẩu sản phẩm không được rỗng!";
            //    return false;
            //}
            //else if (string.IsNullOrEmpty(txtManufacture.Value))
            //{
            //    lblError.Text = "Nhà sản xuất không được rỗng!";
            //    return false;
            //}
            //else if (string.IsNullOrEmpty(txtWeight.Value))
            //{
            //    lblError.Text = "Trọng lượng sản phẩm không được rỗng!";
            //    return false;
            //}
            return true;
        }

        private void SaveNewsCategory(int NewsId)
        {
            try
            {
                ESHOP_NEWS_CAT nc = new ESHOP_NEWS_CAT();
                nc.CAT_ID = Utils.CIntDef(ddlCategory.SelectedValue);
                nc.NEWS_ID = NewsId;

                DB.ESHOP_NEWS_CATs.InsertOnSubmit(nc);
                DB.SubmitChanges();
            }
            catch (Exception ex)
            {
                clsVproErrorHandler.HandlerError(ex);
            }
        }

        #endregion

        protected void btnDelete2_Click(object sender, ImageClickEventArgs e)
        {
            string strLink = "";
            try
            {
                var n_info = DB.GetTable<ESHOP_NEW>().Where(n => n.NEWS_ID == m_news_id);

                if (n_info.ToList().Count > 0)
                {
                    if (!string.IsNullOrEmpty(n_info.ToList()[0].NEWS_IMAGE2))
                    {
                        string imagePath = Server.MapPath(PathFiles.GetPathNews(m_news_id) + n_info.ToList()[0].NEWS_IMAGE2);
                        n_info.ToList()[0].NEWS_IMAGE2 = "";
                        DB.SubmitChanges();

                        if (File.Exists(imagePath))
                            File.Delete(imagePath);

                        strLink = "news.aspx?type="+_type+"&news_id=" + m_news_id;
                    }
                }
            }
            catch (Exception ex)
            {
                clsVproErrorHandler.HandlerError(ex);
            }
            finally
            {
                if (!string.IsNullOrEmpty(strLink))
                    Response.Redirect(strLink);
            }
        }

        

        protected void btnDelete3_Click(object sender, ImageClickEventArgs e)
        {
            string strLink = "";
            try
            {
                var n_info = DB.GetTable<ESHOP_NEW>().Where(n => n.NEWS_ID == m_news_id);

                if (n_info.ToList().Count > 0)
                {
                    if (!string.IsNullOrEmpty(n_info.ToList()[0].NEWS_IMAGE3))
                    {
                        string imagePath = Server.MapPath(PathFiles.GetPathNews(m_news_id) + n_info.ToList()[0].NEWS_IMAGE3);
                        n_info.ToList()[0].NEWS_IMAGE3 = "";
                        DB.SubmitChanges();
                        strLink = "news.aspx?type="+_type+"&news_id=" + m_news_id;
                    }
                }
            }
            catch (Exception ex)
            {
                clsVproErrorHandler.HandlerError(ex);
            }
            finally
            {
                if (!string.IsNullOrEmpty(strLink))
                    Response.Redirect(strLink);
            }
        }

        public string phamtram(decimal pri1, decimal pri2)
        {
            decimal pt = 0;
            decimal giagiam = 0;
            decimal _dPri1 = Utils.CDecDef(pri1);
            decimal _dPri2 = Utils.CDecDef(pri2);
            try
            {
                if (_dPri1 != 0 && _dPri2 != 0)
                {
                    giagiam = (_dPri1 - _dPri2);
                    pt = (giagiam / _dPri1) * 100;
                    return string.Format("{0:0,0}", pt).Replace(",", ".");
                }
                else
                {
                    return "99%";
                }
            }
            catch (Exception ex)
            {
                clsVproErrorHandler.HandlerError(ex);
                return "99";
            }
        }
        protected void rblNewsType_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                int _iType = Utils.CIntDef(rblNewsType.SelectedValue);
                switch (_iType)
                {
                    case 0:
                        dvProductDetails.Visible = dvPrice.Visible =div_status.Visible = false;
                        break;
                    case 1:
                        dvProductDetails.Visible = dvPrice.Visible = div_status.Visible = true;
  
                        break;
                    default:
                        break;
                }
            }
            catch (Exception ex)
            {
                clsVproErrorHandler.HandlerError(ex);
            }
        }
    }
}