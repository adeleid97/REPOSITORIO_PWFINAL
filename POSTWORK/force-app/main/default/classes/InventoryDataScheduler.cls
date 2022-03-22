public class InventoryDataScheduler implements Schedulable{
    
    public void execute(SchedulableContext sc){
        ExternalLegacyConnection();
    }
    
@future(callout=true)//Para hacer una llamada de servicio web a un servicio o una API externos
    public static void ExternalLegacyConnection(){
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://64bjp0q5wg.execute-api.us-east-2.amazonaws.com/Implement/');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        //id
        if(response.getStatusCode()==200){
            //Para la revisión del Objeto del JSON, el string está dividido en "Niveles"
            //Para partir jerarquías
         Map<String, Object> resultados = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());//Para el primer nivel
         Map<String, Object> resultados2 = (Map<String, Object>) resultados.get('body');//Segundo nivel
         List<Object> listProducts = (List<Object>) resultados2.get('Inventory');//Tercer nivel
            //--------------------------------------------------
         List<Map<String,Object>> data = new List<Map<String, Object>>();
            //--------------------------------------------------
            for(Object item: listProducts){
                data.add((Map<String,Object>)item);
            }
          //Almacenar los datos en una lista tipo inventario
          //QuotationHelper productos = new QuotationHelper();
          //List<Inventario__c> listRestInv = productos.productsInInventory();
          List<Inventario__c> listRestInv = new List<Inventario__c>();
          //Inventario__c[] listRestInv = [SELECT Id, Name,Cantidad_apart__c,Cantidad_dis__c,CodigoProd__c FROM Inventario__c];
            //Convertimos en un SObject 
            for(Map<String,Object> key:data){
                Inventario__c inventario =new Inventario__c();
                Integer posicion = 0;
                
                for(object item:key.values()){
                    if(posicion==0){
                        
                        inventario.Name=''+item;
                    }else if (posicion==1){
                        inventario.CodigoProd__c=''+item;
                    }else if(posicion==2){
                        inventario.Cantidad_dis__c=(Double)item;
                    }else if(posicion==3){
                        inventario.Cantidad_apart__c=(Double)item;
                        posicion=0;
                        listRestInv.add(inventario);
                    }
                    posicion++;
                }
            }
            //Muestra el resultado
            system.debug('Productos obtenidos desde REST:'+listRestInv);
//-------------------- Método obtenido de Javier para la conversión de datos, muchas gracias Javier
            QuotationHelper Quote1 = new QuotationHelper();
            List<Inventario__c> Lista_Inventario = Quote1.productsInInventory();//Retorna productos del inventario
            
            for(inventario__c inven:listRestInv){
                for(Inventario__c nuevo_inv:Lista_Inventario){
                    if(inven.CodigoProd__c==nuevo_inv.CodigoProd__c){
                     inven.Id=nuevo_inv.Id; //Actualiza el ID del inventario 
                    }
                }
            }
            update listRestInv;
        }
    }
}