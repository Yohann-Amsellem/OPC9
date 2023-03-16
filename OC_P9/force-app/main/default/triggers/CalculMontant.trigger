trigger CalculMontant on Order (before update) {
	GestionnaireCommande.calculMontant(Trigger.new);
}