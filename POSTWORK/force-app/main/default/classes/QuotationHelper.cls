public class QuotationHelper{
//Para insertar nuevos registros de nombre en cuenta    
        public void initialConfig(){
        Account acc = new Account();
        acc.Name='Compumundo';    
        insert acc;   
                Account acc2 = new Account();
        acc2.Name='CompuWorld';    
        insert acc2;
        }
 //Para retornar los productos del inventario
    public void productsInInventory(){    
                List<Inventario__c> Inventario_actual = //Creamos lista Inventario_Actual
                [SELECT Id,Name,CodigoProd__c,
                Cantidad_dis__c,Cantidad_apart__c
                FROM Inventario__c];
    system.debug(Inventario_Actual);
    }
}