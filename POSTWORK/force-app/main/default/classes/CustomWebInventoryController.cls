//Controlador para POSTWORK 6 parent inv atras
public class CustomWebInventoryController {
    private final sObject parent;//Inicial = parent
    public string codigo {get;set;}
    public list<PriceBookEntry> Lista_nueva {get;Set;}//lstinv
    
    public CustomWebInventoryController (ApexPages.StandardController controller){
        parent=controller.getRecord();
    }
    
    public void buscar(){
        //Usando el SOQL proporcionado por Javier
        Lista_nueva = [Select id, UnitPrice,Product2.Name,
                       Pricebook2Id,Product2.ExternalId,Reservados__c,	Disponibles__c
                      FROM PriceBookEntry WHERE product2.ExternalId =:codigo];
        //Buscando
        QuotationHelper busqueda = new QuotationHelper();
        Double Disponibilidad = 0;
        Disponibilidad = busqueda.searchProductByCode(codigo); //Busca la cantidad disponible del producto
        
        for (PriceBookEntry item:Lista_nueva){
            item.Disponibles__c=Disponibilidad;//Asigna el valor retornado por el objeto 
        }
        update Lista_nueva;  
    }
    
    public void guardar(){
     Quote Nuevo = (Quote) parent;
     List <QuoteLineItem> listToInsert = new List<QuoteLineItem>();
        Id pricebookId;
        
        for(PriceBookEntry item: Lista_nueva){
            PriceBookId = item.Pricebook2Id;
            QuoteLineItem cotItem = new QuoteLineItem();
            cotItem.Product2Id = item.Product2Id;
            cotItem.Quantity = item.Reservados__c;
            cotItem.QuoteId = Nuevo.Id;
            cotItem.UnitPrice=item.UnitPrice;
            cotItem.PricebookEntryId=item.Id;
            listToInsert.add(cotItem);            
        }
        
        Nuevo.Pricebook2Id=pricebookId;
        update Nuevo;
        insert listToInsert;
        codigo='';
        Lista_nueva.clear();
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'Registro guardado'));
    }
    
    public void cancelar(){
        Lista_nueva.clear();
    }
    
    public void atras(){
        codigo='Ingrese Código';
        Lista_nueva.clear();
    }
}