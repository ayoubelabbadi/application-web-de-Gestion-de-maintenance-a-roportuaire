const express = require('express');
const router = express.Router();
const { Maintenance, Equipment } = require('../controllers/models'); // Assurez-vous d'avoir configuré vos modèles Sequelize

router.get('/maintenances', async (req, res) => {
  try {
    const { equipmentCode } = req.query;

    // Recherche des maintenances par code d'équipement
    const maintenances = await Maintenance.findAll({
      where: {
        EquipmentCode: equipmentCode
      }
    });

    res.json(maintenances);
  } catch (error) {
    console.error(error);
    res.status(500).send('Erreur serveur');
  }
});

module.exports = router;
