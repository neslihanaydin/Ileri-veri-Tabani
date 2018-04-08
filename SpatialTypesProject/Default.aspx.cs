using System;
using System.Collections;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    SqlConnection baglan = new SqlConnection(@"Data Source=NESLIHAN\SQLEXPRESS;Initial Catalog=Sirket;Integrated Security=True");
    public int hat = 0;
    public ArrayList plats = new ArrayList();
    public ArrayList plngs = new ArrayList();
    protected void Page_Load(object sender, EventArgs e)
    {
        
        
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        baglan.Open();

        SqlCommand da = new SqlCommand("select distinct Calisan.c_id, Calisan.ad, Servis.hat from Calisan, Servis where Servis.h_line.STDistance(Calisan.adres) < 950 and Calisan.c_id="+TextBox1.Text, baglan);
        SqlDataReader reader = da.ExecuteReader();
        try
        {
            while (reader.Read())
            {
                TextBox1.Text = reader[0].ToString();
                TextBox2.Text = reader[1].ToString();
                TextBox3.Text = reader[2].ToString();
            }
        }
        finally
        {
            // Always call Close when done reading.
            reader.Close();
        }
        TextBox2.ReadOnly = true;
        TextBox3.ReadOnly = true;
        if (TextBox3.Text == "2")
        {
            hat = 2;
        }
        if (TextBox3.Text == "1")
        {
            hat = 1;
        }
        baglan.Close();

        baglan.Open();
        SqlCommand da21 = new SqlCommand("select (Calisan.adres).STAsText() from Calisan where Calisan.c_id=" + TextBox1.Text, baglan);
        SqlDataReader reader21 = da21.ExecuteReader();
        try
        {
            while (reader21.Read())
            {
                TextBox41.Text = reader21[0].ToString();
                parcala(TextBox41.Text);
            }
        }
        finally
        {
            reader21.Close();
        }
        baglan.Close();
        /// Sirketin konumunun polygon olarak çekilmesi
        baglan.Open();
        SqlCommand da2 = new SqlCommand("select (mekanlar.konum).STAsText() from mekanlar where mekanlar.mekan_id = 1 ", baglan);
        SqlDataReader reader2 = da2.ExecuteReader();
        try
        {
            while(reader2.Read())
            {
                TextBox4.Text = reader2[0].ToString();                
            }
        }
        finally
        {
            reader2.Close();
        }
        baglan.Close();
        /// Burdan itibaren multiLine denemesi
        baglan.Open();
        SqlCommand da3 = new SqlCommand("select (Servis.h_line).STAsText() from Servis where Servis.hat = " + TextBox3.Text, baglan);
        SqlDataReader reader3 = da3.ExecuteReader();
        try
        {
            while (reader3.Read())
            {
                TextBox42.Text = reader3[0].ToString();
            }

        }
        finally
        {

            reader3.Close();
        }
        baglan.Close();
    }

  
    public void parcala(string text)
    {
        string lat = "";
        string lng = "";
        int durum = 0;
        string temp = "";
        for (int i = 0; i < text.Length; i++)
        {
            if(text[i] == '(')
            {
                durum = 1;
                i++;

            }
            if (durum==1)
            {
                if(text[i]==' ')
                {
                    lat = temp;
                    i++;
                    temp = "";
                }

                if (text[i]==')')
                {
                    lng = temp;
                }

                temp += text[i];
             
             
            }
            
        }
        Label4.Text = lat;
        Label5.Text = lng;

    }

    void kisi_goster()
    {

    }

    protected void TextBox3_TextChanged(object sender, EventArgs e)
    {
        
    }
}