public class InventoryRest {
    public static void ConexionRest(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://64bjp0q5wg.execute-api.us-east-2.amazonaws.com/Implement/');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        
        if(response.getStatusCode()==200){
            Map<String,Object> resultado = (Map<String,Object>)JSON.deserializeUntyped(response.getBody());   
        	List<Object> InventarioItems = (List<Object>)resultado.get('Inventory');
            for(object productos: InventarioItems){
            System.debug('Esto es lo que recibi: '+ resultado);        
        }
            }
    }}