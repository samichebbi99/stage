class ProductModel {
  ProductModel(
      {this.id,
      this.categorie,
      this.nom,
      this.reference,
      this.image,
      this.marque,
      this.lien,
      this.promotion,
      this.disponibilite,
      this.prix,
      this.discountAmount,
      this.description,
      this.prixOriginal});
  final String? categorie;
  final String? nom;
  final String? reference;
  final String? image;
  final String? marque;
  final String? lien;
  final String? promotion;
  final String? disponibilite;
  final String? id;
  final String? description;
  final String? prix;
  final String? discountAmount;
  final String? prixOriginal;

  factory ProductModel.fromJson(Map<String, dynamic> data) {
    final id = data['_id'] as String?;
    final categorie = data['categorie'] as String?;
    final nom = data['nom'] as String?;
    final reference = data['reference'] as String?;
    final image = data['image'] as String?;
    final marque = data['marque'] as String?;
    final lien = data['lien'] as String?;
    final promotion = data['promotion'] as String?;
    final disponibilite = data['disponibilite'] as String?;
    final description = data['description'] as String?;
    final prix = data['prix'] as String?;
    final discountAmount = data['discount_amount'] as String?;
    final prixOriginal = data['prix_original'] as String?;

    return ProductModel(
        id: id,
        categorie: categorie,
        nom: nom,
        reference: reference,
        image: image,
        marque: marque,
        lien: lien,
        promotion: promotion,
        disponibilite: disponibilite,
        prix: prix,
        discountAmount: discountAmount,
        description: description,
        prixOriginal: prixOriginal);
  }
  //tostring
  @override
  String toString() {
    return 'ProductModel{id: $id, categorie: $categorie, nom: $nom, reference: $reference, marque: $marque, image : $image, promotion : $promotion lien: $lien, prix: $prix, discountAmount: $discountAmount, description: $description, prixOriginal: $prixOriginal, prixOriginal: $prixOriginal}';
  }
}
