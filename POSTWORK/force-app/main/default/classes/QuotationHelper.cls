public class QuotationHelper implements QuotationSync{//Implementa la interfaz QuotationSync
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
    public list<Inventario__c> productsInInventory(){    
                List<Inventario__c> Inventario_actual = //Creamos lista Inventario_Actual
                [SELECT Id,Name,CodigoProd__c,
                Cantidad_dis__c,Cantidad_apart__c
                FROM Inventario__c];
    system.debug(Inventario_Actual);
        return Inventario_actual;
    }
//Implementación de las interfaces-----------------------------------------------------------------------
    public boolean confirmProductExistByCode(string Codigo_de_Producto){
        boolean Comprobacion = false;//Se inicialsiza la variable Comprobacion
        List <Product2> Lista_del_producto = [SELECT ID FROM Product2 WHERE ExternalId=:Codigo_de_Producto
                                             LIMIT 1];//Se ocupa 1 por qué cada codigo del producto debe ser
        											 //distinto para cada producto
        IF(Lista_del_producto.isEmpty()){
            Comprobacion=false;
        }
        else Comprobacion=true;
        return Comprobacion;
    }
    
    public double searchProductByCode(String Codigo_de_Producto){
        double Unidades_disponibles=0;//Inicializamos variable
        Inventario__c Productos_del_inventario = [SELECT Id,Name, Cantidad_dis__c FROM Inventario__c WHERE 
                                                  CodigoProd__c=:Codigo_de_Producto];  
        Unidades_disponibles=Productos_del_inventario.Cantidad_dis__c;
        return Unidades_disponibles;
    }
//Todo este apartado pertenece al POSTWORK 4 Triggers---------------------------------------------------  
    public void Actualiza(Id Product2Id, Double Cantidad_necesaria){
        
        Product2 Producto_Busqueda = [Select ID, Name, ExternalId from Product2 WHERE Id=:Product2Id];
        Boolean exist = confirmProductExistByCode(Producto_Busqueda.ExternalId);//Revisa si el producto existe 
        
        if(exist==true){
        	//Utilizando el método realizado anteriormente para la cantidad
            Double Cantidad_disponible = searchProductByCode(Producto_Busqueda.ExternalId); 
            if(Cantidad_necesaria>Cantidad_disponible)
            System.debug('No existe cantidad suficiente para esta petición'); 
            else{
      			//Muestra la cantidad apartada y disponible del inventario
            	Inventario__c Inventario = [Select Id, Cantidad_apart__c, Cantidad_dis__c FROM Inventario__c WHERE CodigoProd__c=:Producto_Busqueda.ExternalId];    
            	//Suma a la cantidad apartada existente el valor requerido por el método
                Inventario.Cantidad_apart__c = Inventario.Cantidad_apart__c + Cantidad_necesaria;
				//A la cantidad disponible restar la cantidad que ha sido apartada 
                Inventario.Cantidad_dis__c = Inventario.Cantidad_dis__c - Cantidad_necesaria;
                update Inventario;//Actualiza (Operación DML)
            	}
            		  }
        	else 
              	System.debug('No existe el producto en el inventario');
    		}
//-------------------------------------------------------------------------------------------------------------    
//Metodo para el postwork 5
    @invocableMethod(label='StockAlert ')//Existen otras dos alternativas pero me resulta más sencillo este 
    public static void StockEmptyAlert (){
        QuotationHelper prueba = new QuotationHelper();//Para usar los método de esta clase 
        List<Inventario__c> Lista_nueva = new List<Inventario__c>();
        Lista_nueva = prueba.productsInInventory();
        
        List<FeedItem> feed = new List <FeedItem>();
        
       for(Inventario__c inv_for:Lista_nueva){
           if(inv_for.Cantidad_dis__c==0){
               //Para crear un post en Chatter
               FeedItem objPost = new FeedItem();
               objPost.ParentId = UserInfo.getUserId();
               objPost.Body='Producto sin inventario';
              feed.add(objPost);
           }  
       }
    }
//-----------------------------------------------------------------------------------------------
}