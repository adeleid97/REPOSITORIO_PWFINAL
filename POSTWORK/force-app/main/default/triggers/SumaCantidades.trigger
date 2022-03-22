//Trigger usado para POSTWORK4
trigger SumaCantidades on QuoteLineItem (after update) {
	QuoteLineItem Presupuesto = new QuoteLineItem();
    for(QuoteLineItem item:Trigger.New){
        Presupuesto=item;
    }
    System.debug('Cantidad disponible: '+ Presupuesto.Quantity);
    QuotationHelper Implementa = new QuotationHelper();
    Id codigo = Presupuesto.Product2Id;
    Double cantidad = Presupuesto.Quantity;
	Implementa.Actualiza(codigo,cantidad);   
}