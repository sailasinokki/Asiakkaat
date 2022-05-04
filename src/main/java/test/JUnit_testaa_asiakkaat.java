package test;

import static org.junit.Assert.assertEquals;
import java.util.ArrayList;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;
import org.junit.jupiter.api.MethodOrderer.OrderAnnotation;
import model.Asiakas;
import model.dao.Dao;

@TestMethodOrder(OrderAnnotation.class)
class JUnit_testaa_asiakkaat {

	@Test
	@Order(1) 
	public void testPoistaKaikkiAsiakkaat() {
		Dao dao = new Dao();
		dao.poistaKaikkiAsiakkaat("nimda");
		ArrayList<Asiakas> asiakkaat = dao.listaaKaikki();
		assertEquals(0, asiakkaat.size());
	}
	
	@Test
	@Order(2) 
	public void testLisaaAsiakas() {		
		Dao dao = new Dao();
		Asiakas asiakas_1 = new Asiakas(0,"Mikki", "Hiiri", "555555555", "mm@mm.mm");
		Asiakas asiakas_2 = new Asiakas(0,"Tupu", "Ankka", "95959 5959", "tupu@ak.fi");
		Asiakas asiakas_3 = new Asiakas(0,"Minni", "Hiiri", "3333 444 44", "minhi@hh.fi");
		Asiakas asiakas_4 = new Asiakas(0,"Hannu", "Hanhi", "123456789", "onnekas@ak.ak");
		assertEquals(true, dao.lisaaAsiakas(asiakas_1));
		assertEquals(true, dao.lisaaAsiakas(asiakas_2));
		assertEquals(true, dao.lisaaAsiakas(asiakas_3));
		assertEquals(true, dao.lisaaAsiakas(asiakas_4));
	}
	
	@Test
	@Order(3) 
	public void testMuutaAsiakas() {
		//Muutetaan yhtä asiakasa
		Dao dao = new Dao();
		Asiakas muutettava = dao.etsiAsiakas("Mikki");
		muutettava.setEtunimi("MIKKI");
		muutettava.setSukunimi("HIIRI");
		muutettava.setPuhelin("000 000 000");
		muutettava.setSposti("mikkihiirin@hiiri.ak");
		dao.muutaAsiakas(muutettava, "Mikki");	
		assertEquals("Mikki", dao.etsiAsiakas("MIKKI").getEtunimi());
		assertEquals("Hiiri", dao.etsiAsiakas("MIKKI").getSukunimi());
		assertEquals("555555555", dao.etsiAsiakas("MIKKI").getPuhelin());
		assertEquals("mm@mm.mm", dao.etsiAsiakas("MIKKI").getSposti());
	}
	
	@Test
	@Order(4) 
	public void testPoistaasiakas() {
		Dao dao = new Dao();
		dao.poistaAsiakas("A-1");
		assertEquals(null, dao.etsiAsiakas("A-1"));
	}

}