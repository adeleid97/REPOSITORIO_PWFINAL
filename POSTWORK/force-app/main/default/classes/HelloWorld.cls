public with sharing class HelloWorld {
    
    
    public HelloWorld() {
integer test_while=0;
        
        while(test_while<5){
        system.debug('Prueba'+test_while);    
        test_while++;///Para probar que onda 
        }
    }
    
    
    public void HelloSOSL(){
        List<List<sObject>>result=[FIND 'United'
      IN ALL FIELDS
      RETURNING
              Account(Id, Name, Type
              WHERE Rating = 'Hot'
              ORDER BY CreatedDate DESC),
              Lead(Id, Name, Company
              ORDER BY CreatedDate),
              Contact(Id, Name, Account.Name
              ORDER BY Account.Name, LastName),
              Opportunity(Id, Name, Account.Name
                          ORDER BY CreatedDate)];
    }
    
    public void DML(){
        Inventario__c inv = new Inventario__c();
        inv.Name = 'Test 4';
        inv.Cantidad_apart__c = 3;
        inv.CodigoProd__c = 'PROD004';
        //insert inv;
        Inventario__c inv2 = new Inventario__c();
        inv2.Name = 'Test 5';
        inv2.Cantidad_apart__c = 3;
        inv2.CodigoProd__c = 'PROD005';
        //insert inv2;
        List<Inventario__c> lst = new List<Inventario__c>();
        lst.add(inv);
        lst.add(inv2);
        insert lst;
        
        Inventario__c inv3 = [SELECT id, Name FROM Inventario__c WHERE Id = 'a058c00000da7IoAAI' LIMIT 1];
        inv3.Name='Valor nuevo con Id';
        Update inv3;
        //Inventario__c invDML = new Inventario__c(Name='Test',Cantidad_apart__c=3);
        //insert inv;
        //
        Inventario__c inv4 = [SELECT id, Name, CodigoProd__c FROM Inventario__c WHERE Id = 'a058c00000da7IoAAI' LIMIT 1];
        Delete inv4;
    }
    
}