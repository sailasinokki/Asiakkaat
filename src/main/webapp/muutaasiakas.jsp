<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="scripts/main.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/main.css">
<title>Muuta asiakas</title>
</head>
<body>
<form id="tiedot">
		<table>
		<thead>	
			<tr>
				<th colspan="6" class="oikealle"><span id="takaisin">Takaisin listaukseen</span></th>
			</tr>		
			<tr>
				<th>Asiakas id</th>
				<th>Etunimi</th>
				<th>Sukunimi</th>
				<th>Puhelin</th>
				<th>S�hk�posti</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><input type="hidden" name="asiakas_id" id="asiakas_id"></td>
				<td><input type="text" name="etunimi" id="etunimi"></td>
				<td><input type="text" name="sukunimi" id="sukunimi"></td>
				<td><input type="text" name="puhelin" id="puhelin"></td>
				<td><input type="text" name="sposti" id="sposti"></td> 
				<td><input type="submit" id="tallenna" value="Hyv�ksy"></td>
			</tr>
		</tbody>

		</table>
		<input type ="hidden" name="vanhaasiakas_id" id="vanhaasiakas_id">

		
	</form>
	<span id="ilmo"></span>
</body>
<script>
$(document).ready(function() {
	$("#takaisin").click(function(){
		document.location="listaaasiakkaat.jsp";
	});
	
	var asiakas_id = requestURLParam("asiakas_id"); 	
	$.ajax({url:"asiakkaat/haeyksi/"+asiakas_id, type:"GET", dataType:"json", success:function(result){	
	
		$("#etunimi").val(result.etunimi);
		$("#sukunimi").val(result.sukunimi);
		$("#puhelin").val(result.puhelin);
		$("#sposti").val(result.sposti);	
		$("#vanhaasiakas_id").val(result.asiakas_id);
    }});
	
	
		$("#tiedot").validate({						
			rules: {
				asiakas_id:  {
					required: false,
					minlength: 1				
				},
				etunimi:  {
					required: true,
					minlength: 3				
				},
				sukunimi:  {
					required: true,
					minlength: 3
				},	
				puhelin:  {
					required: true,
					minlength: 5,
				},	
				sposti:  {
					required: true,
					minlength: 4,
							
				
				}	
			},
	messages: {
		asiakas_id: {
			required: "Ei voi vaihtaa",
			
		},
		etunimi: {
			required: "Puuttuu",
			number: "Ei kelpaa",
			minlength: "Liian lyhyt"
		},
		sukunimi: {
			required: "Puuttuu",
			number: "Ei kelpaa",
			minlength: "Liian lyhyt"
		},
		puhelin: {
			required: "Puuttuu",
			minlength: "Liian lyhyt"
			
		},
		sposti: {
			required: "Puuttuu",
			minlength: "Liian lyhyt"
		}
	},			
	submitHandler: function(form) {	
		muutaTiedot();
		}		
	}); 	

}) ;

function muutaTiedot(){	
	var formJsonStr = formDataJsonStr($("#tiedot").serializeArray()); 
	$.ajax({url:"asiakkaat", data:formJsonStr, type:"PUT", dataType:"json", success:function(result) {      
		if(result.response==0){
      	$("#ilmo").html("Asiakkaan p�ivitt�minen ep�onnistui.");
      }else if(result.response==1){			
      	$("#ilmo").html("Asiakkaan p�ivitt�minen onnistui.");
      	$("#asiakas_id","#etunimi", "#sukunimi", "#puhelin", "#sposti").val("");
		}
  }});	
}
</script>
</html>