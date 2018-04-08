<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
    #map {
        float:left;
        height: 400px;
        width: 800px;
    }
</style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <asp:Panel ID="Panel2" runat="server">
        </asp:Panel>
        <asp:Panel ID="Panel3" runat="server" BackColor="#99CCFF" BorderColor="#333399" BorderStyle="Double" Height="126px" BackImageUrl="~/images/res.jpg">      
        </asp:Panel>
    
        <asp:Label ID="Label1" runat="server" Text="Çalışan No"></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="Label2" runat="server" Text="Çalışan Ad"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="Label3" runat="server" Text="Kullanmanız gereken hat"></asp:Label>
        <br />
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
        &nbsp;&nbsp;
        <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
        &nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="TextBox3"  runat="server" OnTextChanged="TextBox3_TextChanged" ReadOnly="True"></asp:TextBox>
    
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="Button1" runat="server" Text="Öğren" OnClick="Button1_Click" />
    
        <asp:TextBox ID="TextBox42" runat="server" BorderStyle="None" ForeColor="White"></asp:TextBox>
    
        <asp:TextBox ID="TextBox4" runat="server" BorderStyle="None" ForeColor="White" ReadOnly="True"></asp:TextBox>
        <asp:TextBox ID="TextBox41" runat="server" BorderStyle="None" ForeColor="White" ReadOnly="True"></asp:TextBox>
        <asp:Label ID="Label4" runat="server" BorderStyle="None" ForeColor="White"></asp:Label>
        <asp:Label ID="Label5" runat="server" Text="Label" ForeColor="White"></asp:Label>
    
    </div>
        <asp:Panel ID="Panel1" runat="server" Height="517px" BackImageUrl="~/images/ress.jpg">
<div id="map" aria-dropeffect="popup"></div>
     <script>
         
         function initMap2() {
             var uluru = { lat: 40.112641, lng: 26.416304 };
             var map = new google.maps.Map(document.getElementById('map'), {
                 zoom: 14,
                 center: uluru
             });

             var marker = new google.maps.Marker({
                 position: uluru,
                 center: uluru,
                 map: map
             });

             var latt = document.getElementById("Label4");
             var lngg = document.getElementById("Label5");
             

             if (latt.value != "")
             {
                 var pos = { lat: parseFloat(latt.textContent), lng: parseFloat(lngg.textContent) };
                 var marker = new google.maps.Marker({
                     position: pos,
                     map: map
                 });
             }
             marker.setMap(map);
             //Multiline parçalanması
             var linecoord = document.getElementById("TextBox42");
             if (linecoord.value != "")
             {
                 var llats = new Array();
                 var llngs = new Array();
                 var ltext = linecoord.value;
                 var llat = "";
                 var llng = "";
                 var ldurum = 0;
                 var ltemp = "";
                 var li = 0;
                 for (li = 0; li < ltext.length; li++)
                 {
                    
                     if (ltext[li] == '(')
                     {
                         ldurum = 1;
                         li = li + 2;
                     }
                     if (ldurum == 1)
                     {
                         if (ltext[li] == ' ') {
                             llat = ltemp;
                             llats.push(llat);
                             li++;
                             ltemp = "";
                         }
                         if (ltext[li] == ',') {
                             llng = ltemp;
                             llngs.push(llng);
                             li = li + 2;
                             ltemp = "";
                         }
                         if (ltext[li] == ')') {
                             llng = ltemp;
                             llngs.push(llng);
                         }
                         ltemp += ltext[li];
                     }
                 }
                 var ServisLine = [
                     { lat: parseFloat(llats[0]), lng: parseFloat(llngs[0]) },
                     { lat: parseFloat(llats[1]), lng: parseFloat(llngs[1]) },
                     { lat: parseFloat(llats[2]), lng: parseFloat(llngs[2]) },
                     { lat: parseFloat(llats[3]), lng: parseFloat(llngs[3]) },
                     { lat: parseFloat(llats[4]), lng: parseFloat(llngs[4]) },
                     { lat: parseFloat(llats[5]), lng: parseFloat(llngs[5]) },
                     { lat: parseFloat(llats[6]), lng: parseFloat(llngs[6]) },
                     { lat: parseFloat(llats[7]), lng: parseFloat(llngs[7]) }
                 ];

                 var otobusler = new google.maps.Polyline({
                     path: ServisLine,
                     geodesic: true,
                     strokeColor: '#FF0000',
                     strokeOpacity: 1.0,
                     strokeWeight: 2
                 });

                 otobusler.setMap(map);
             }
          //   MULTILINESTRING((40.115598 26.414472, 40.116514 26.412412, 40.113758 26.413099, 40.106534 26.402605, 40.117594 26.41063, 40.125436 26.409686, 40.133015 26.408913, 40.14184 26.407926, 40.145874 26.407926, 40.153582 26.414106, 40.150448 26.42503))
             //////////////Polygonun parçalanması
             var polycoord = document.getElementById("TextBox4");
             if (polycoord.value != "") {
                 var plats = new Array();     var plngs = new Array();
                 var ptext = polycoord.value;  var plat = "";  var plng = "";  var pdurum = 0;  var ptemp = "";  var pi = 0;
                 for (pi = 0; pi < ptext.length; pi++)
                 {   if (ptext[pi] == '(') {
                         pdurum = 1;
                         pi = pi + 2;     // POLYGON ((40.113385 26.416874, 40.111907 26.41932, 40.110134 26.414471, 40.112168 26.413441, 40.113385 26.416874))
                     }
                     if (pdurum == 1) {
                         if (ptext[pi] == ' ') {
                             plat = ptemp;
                             plats.push(plat);
                             pi++;
                             ptemp = "";
                         }
                         if (ptext[pi] == ',') {
                             plng = ptemp;
                             plngs.push(plng);
                             pi = pi + 2;
                             ptemp = "";
                         }
                         if (ptext[pi] == ')') {
                             plng = ptemp;
                             plngs.push(plng);
                         }
                         ptemp += ptext[pi];
                     }
                 }
                 var SirketPoly = [
                     { lat: parseFloat(plats[0]), lng: parseFloat(plngs[0]) },
                     { lat: parseFloat(plats[1]), lng: parseFloat(plngs[1]) },
                     { lat: parseFloat(plats[2]), lng: parseFloat(plngs[2]) },
                     { lat: parseFloat(plats[3]), lng: parseFloat(plngs[3]) },
                     { lat: parseFloat(plats[4]), lng: parseFloat(plngs[4]) }
                 ];

                 // Construct the polygon.
                 var bermudaTriangle = new google.maps.Polygon({
                     paths: SirketPoly,
                     strokeColor: '#FF0000',
                     strokeOpacity: 0.8,
                     strokeWeight: 2,
                     fillColor: '#FF0000',
                     fillOpacity: 0.35
                 });

                 bermudaTriangle.setMap(map);
             }
                         
         }
    </script>
   
    <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDT-H6Fuhyknk2SKDrTfgM3J9N_jdFuv3s&callback=initMap2"
            ></script>
        </asp:Panel>
    </form>
</body>
</html>
