const express = require('express');
const router = express.Router();
const addController = require('../controllers/add')

router.post('/department/add', addController.addDepartment)
router.post('/agentSupplier/add', addController.addAgentSupplier)
router.post('/technicienEngineer/add', addController.addClinicalEngineer)
router.post('/equipment/add', addController.addEquipment)
    //router.post('/sparePart/add',addController.addSpareParts)
router.post('/breakDown/add', addController.addBreakDown)
router.post('/workOrder/add', addController.addWorkOrder)
router.post('/maintenance/add', addController.addMaintenance)
router.post('/dashbord/add',addController.addDashboard)

// Route to render the form
router.get('/technicienEngineer/add', async(req, res) => {
    try {
        const departments = await department.findAll(); // Fetch departments from the database
        res.render('addClinicalEngineer', { departments });
    } catch (error) {
        console.error('Error fetching departments:', error);
        res.status(500).send('Internal Server Error');
    }
});





module.exports = router;