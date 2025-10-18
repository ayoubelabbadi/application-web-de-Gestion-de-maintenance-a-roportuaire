const express = require('express');
const router = express.Router();
const deleteController=require('../controllers/delete')


router.get('/agentSupplier/delete/:id',deleteController.deleteAgentSupplier);
router.get('/technicienEngineer/delete/:id',deleteController.deleteClinicalEngineer);
router.get('/equipment/delete/:id',deleteController.deleteEquipment);
router.get('/department/delete/:id',deleteController.deleteDepartment);
//router.get('/sparePart/delete/:id',deleteController.deleteSparePart);
router.get('/breakDown/delete/:id',deleteController.deleteBreakDown);
router.get('/workOrder/delete/:id',deleteController.deleteWorkOrder);
router.get('/maintenance/delete/:id',deleteController.deleteMaintenance);






module.exports=router;