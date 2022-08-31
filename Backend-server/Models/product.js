
const mongoose = require('mongoose');

const testSchema = mongoose.Schema({
    nom:{ type: String, required:true},
    categorie: { type: String, required: true },
    reference: { type: String, required: true },
    marque: { type: String, required:true },
    description: { type: String, required: true },
    lien:{ type:String, required:true},
    promotion:{type: String, required:true},
    disponibilite:{type: String, required:true},
    prix:{type: String, required:true},
    prix_original:{type: String, required:true},
    discount_amount:{type: String, required:true},
    image: {
        type:String,
        required:true
    },
});

module.exports = mongoose.model('test', testSchema);
module.exports.get = function (callback, limit) {
    Product.find(callback).limit(limit);
}