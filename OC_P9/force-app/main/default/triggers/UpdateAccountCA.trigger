trigger UpdateAccountCA on Order (after update) {
    GestionnaireCommande.updateAccountCA(Trigger.new);
}