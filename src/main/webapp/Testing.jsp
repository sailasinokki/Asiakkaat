<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<head>
<meta charset="ISO-8859-1">
<script src="scripts/main.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/main.css">
<title>Insert title here</title>
</head>
<body>
<form id="tiedot">
	<table>
		<thead>	
			<tr>
				<th colspan="5" class="oikealle"><span id="takaisin">Takaisin listaukseen</span></th>
			</tr>		
			<tr>
				<th>Etu</th>
				<th>Suku</th>
				<th>Puh</th>
				<th>Sposti</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><input type="text" name="rekNo" id="rekNo"></td>
				<td><input type="text" name="merkki" id="merkki"></td>
				<td><input type="text" name="malli" id="malli"></td>
				<td><input type="text" name="vuosi" id="vuosi"></td> 
				<td><input type="submit" id="tallenna" value="Hyv�ksy"></td>
			</tr>
		</tbody>
	</table>
	<input type="hidden" name="vanhaasiakas_id" id="vanhaasiakas_id">	
</form>
<span id="ilmo"></span>
</body>
<script>
$(document).ready(function(){
	$("#takaisin").click(function(){
		document.location="listaaasiakkaat.jsp";
	});
	//Haetaan muutettavan auton tiedot. Kutsutaan backin GET-metodia ja v�litet��n kutsun mukana muutettavan tiedon id
	//GET /autot/haeyksi/rekno
	var asiakas_id = requestURLParam("asiakas_id"); //Funktio l�ytyy scripts/main.js 	
	$.ajax({url:"asiakkaat/haeyksi/"+asiakas_id, type:"GET", dataType:"json", success:function(result){	
		$("#vanhaasiakas_id").val(result.asiakas_id);		
		$("#asiakas_id").val(result.asiakas_id);	
		$("#etunimi").val(result.etunimi);
		$("#sukunimi").val(result.sukunimi);
		$("#puhelin").val(result.puhelin);			
		$("#sposti").val(result.sposti);	
    }});
	
	$("#tiedot").validate({						
		rules: {
			rekNo:  {
				required: true,
				minlength: 3				
			},	
			merkki:  {
				required: true,
				minlength: 2				
			},
			malli:  {
				required: true,
				minlength: 1
			},	
			vuosi:  {
				required: true,
				number: true,
				minlength: 4,
				maxlength: 4,
				min: 1900,
				max: new Date().getFullYear()+1 //Auto voi olla ensivuoden mallia
			}	
		},
		messages: {
			rekNo: {     
				required: "Puuttuu",
				minlength: "Liian lyhyt"			
			},
			merkki: {
				required: "Puuttuu",
				minlength: "Liian lyhyt"
			},
			malli: {
				required: "Puuttuu",
				minlength: "Liian lyhyt"
			},
			vuosi: {
				required: "Puuttuu",
				number: "Ei kelpaa",
				minlength: "Liian lyhyt",
				maxlength: "Liian pitk�",
				min: "Liian pieni",
				max: "Liian suuri"
			}
		},			
		submitHandler: function(form) {	
			paivitaTiedot();
		}		
	}); 	
});
//funktio tietojen p�ivitt�mist� varten. Kutsutaan backin PUT-metodia ja v�litet��n kutsun mukana uudet tiedot json-stringin�.
//PUT /autot/
function paivitaTiedot(){	
	var formJsonStr = formDataJsonStr($("#tiedot").serializeArray()); //muutetaan lomakkeen tiedot json-stringiksi
	$.ajax({url:"asiakkaar", data:formJsonStr, type:"PUT", dataType:"json", success:function(result) { //result on joko {"response:1"} tai {"response:0"}       
		if(result.response==0){
      	$("#ilmo").html("Asiakaan paivittaminen epaonnistui.");
      }else if(result.response==1){			
      	$("#ilmo").html("Auton paivittaminen onnistui.");
      	$("#asiakas_id", "#etunimi", "#sukunimi", "#puhelin", "#sposti").val("");
	  }
  }});	
}
</script>
</html>