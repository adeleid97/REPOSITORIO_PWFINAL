public class PW6_CONTROLLER {
    private final sObject parent;
    public String codigo {get;set;}
    public List<Inventario__c> lstInv {get;set;}
    public PW6_CONTROLLER(ApexPages.StandardController controller){
        parent = Controller.getRecord();
    }
    public void buscar(){
        String query = 'SELECT 	CodigoProd__c, Cantidad_dis__c, Cantidad_apart__c FROM Inventario__c Where 	CodigoProd__c = :codigo';
        lstInv = Database.query(query);
    }
    public void limpiar(){
        lstInv.clear();
    }
}