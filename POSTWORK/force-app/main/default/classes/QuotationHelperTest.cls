@isTest
public class QuotationHelperTest {

    @isTest
    public static void prueba_initialconfig(){
        Test.startTest();
        QuotationHelper pruebainitial = new QuotationHelper();
        pruebainitial.initialConfig();
        Test.stopTest();
    }
    @isTest
    public static void prueba_confirmProductExistByCode(){
        Inventario__c prueba = new Inventario__c();
        prueba.name='Angel';
        prueba.Cantidad_apart__c=1;
        prueba.Cantidad_dis__c=1;
        prueba.CodigoProd__c='Prod002';
        insert prueba;
        
        Test.startTest();
        QuotationHelper prueba_confirm = new QuotationHelper();
        prueba_confirm.confirmProductExistByCode('PROD002');
        Test.stopTest();
        
    }
    @isTest
    public static void prueba_searchProductByCode(){
        Inventario__c prueba = new Inventario__c();
        prueba.name='Angel';
        prueba.Cantidad_apart__c=1;
        prueba.Cantidad_dis__c=1;
        prueba.CodigoProd__c='Prod002';
        insert prueba;
        Test.startTest();
        QuotationHelper pruebasearch = new QuotationHelper();
        pruebasearch.searchProductByCode('PROD002');
        Test.stopTest();
    }
    
}