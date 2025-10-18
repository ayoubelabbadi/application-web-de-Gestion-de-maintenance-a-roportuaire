const AgentSupplier = require('../models/agent_supplier');
const ClinicalEngineer = require('../models/clinical_engineer');
const Equipment =require('../models/equipment')
const BreakDown =require('../models/break_down');
const WorkOrder =require('../models/work_order');
const Maintenance =require('../models/maintenance');
const Department = require('../models/department');




exports.editDepartment = (req, res) => {
    id = req.params.id;

    Department.findByPk(id).then(department => {

        const dp = {
            Code: department.Code,
            Name: department.Name,
            Location: department.Location,
        };

        res.render('editDepartment', {
            layout: 'main-layout.handlebars',
            pageTitle: 'Edit',
            Department: true,
            department: dp
        });

    })/*.catch(err => {
        console.log("ERROR!!!!!!", err);
        res.render('error', {
            layout: false,
            pageTitle: 'Error',
            href: '/department',
            message: 'Sorry !!! Could Not Get This Department'
        });
    });*/
    .catch(err=>console.log("errorrrrr",err))
};








exports.editAgentSupplier=(req,res)=>{
    id=req.params.id
    AgentSupplier.findByPk(id).then(agentSupplier =>{ 
        const as = {
              Name: agentSupplier.Name,
              Id: agentSupplier.Id,
              Adress: agentSupplier.Adress,
              Phone:agentSupplier.Phone,
              Email:agentSupplier.Email,
              Notes:agentSupplier.Notes
            }
    
        
    res.render('editAgentSupplier',{layout:'main-layout.handlebars' ,pageTitle:'Edit',
                                     AS:true,agentSupplier:as});
 })
    .catch(err => res.render('error',{layout:false,pageTitle:'Error',href:'/agentSupplier',message:'Sorry !!! Could Not Get this Agent'}))
    
 
 
 }




exports.editClinicalEngineer = async (req, res) => {
   const dssn = req.params.id;

   try {
       const clinicalEngineer = await ClinicalEngineer.findOne({
           where: { DSSN: dssn },
           include: [{ model: Department }]
       });

       if (!clinicalEngineer) {
           return res.render('error', {
               layout: false,
               pageTitle: 'Error',
               href: '/agentSupplier',
               message: 'Sorry !!! Could Not Find This Engineer'
           });
       }

       const cs = {
           FName: clinicalEngineer.FName,
           LName: clinicalEngineer.LName,
           DSSN: clinicalEngineer.DSSN,
           Adress: clinicalEngineer.Adress,
           Phone: clinicalEngineer.Phone,
           WorkHours: clinicalEngineer.WorkHours,
           Email: clinicalEngineer.Email,
           Age: clinicalEngineer.Age,
           Image: clinicalEngineer.Image,
           DepartmentCode: clinicalEngineer.Department ? clinicalEngineer.Department.Code : 'N/A',
       };

       const departments = await Department.findAll();
       const dp = departments.map(depart => {
           return {
               Name: depart.Name,
               Code: depart.Code
           };
       });

       console.log(cs);

       res.render('editClinicalEngineer', {
           layout: 'main-layout.handlebars',
           pageTitle: 'Edit',
           CE: true,
           clinicalEngineer: cs,
           Departs: dp
       });

   } catch (err) {
       console.log("ERROR!!!!!!", err);
       res.render('error', {
           layout: false,
           pageTitle: 'Error',
           href: '/agentSupplier',
           message: 'Sorry !!! Could Not Get This Engineer'
       });
   }
};








/*
 exports.editEquipment=(req,res)=>{
    code=req.params.id
    console.log("here")
    Equipment.findOne({where:{Code:code},include:[{model:Department}]}).then(equipment => {
        const eq = {
              Code: equipment.Code,
              Name: equipment.Name,
              Cost: equipment.Cost,
              InstallationDate: equipment.InstallationDate,
              WarrantyDate: equipment.WarrantyDate,
              ArrivalDate: equipment.InstallationDate,
              Model:equipment.Model,
              SerialNumber:equipment.SerialNumber,
              Manufacturer:equipment.Manufacturer,
              Location:equipment.Location,
              Notes:equipment.Notes,
              PM:equipment.PM,
              Image:equipment.Image,
              DepartmentCode:equipment.DepartmentCode,
              AgentSupplierId:equipment.AgentSupplierId,
              IT:equipment.Department.Name =='IT' ? true : false,
              RADIONAVIGATIONTELECOM:equipment.Department.Name =='RADIONAVIGATIONTELECOM' ? true:false,
              AEROGARE:equipment.Department.Name=='AEROGARE' ? true:false,
              ELECTRICITEBALISAGE:equipment.Department.Name == 'ELECTRICITEBALISAGE' ? true:false
            }
   if(eq.PM =="Annualy"){
      res.render('editEquipment',{layout:'main-layout.handlebars' ,pageTitle:'Edit',
                                       Equipment:true,equipment:eq,A:true});

   }else{
      res.render('editEquipment',{layout:'main-layout.handlebars' ,pageTitle:'Edit',
            Equipment:true,equipment:eq,M:true});
   }     
   // res.render('editEquipment',{layout:'main-layout.handlebars' ,pageTitle:'Edit',
   //                                    Equipment:true,equipment:eq});  
    
        
 })
    .catch(err => console.log("ERROR!!!!!!",err) )

 }
 */

 exports.editEquipment = (req, res) => {
   const code = req.params.id;

   // Utilisation de Promise.all pour récupérer les équipements, départements et agents en parallèle
   Promise.all([
       Equipment.findOne({ where: { Code: code }, include: [{ model: Department }, { model: AgentSupplier }] }),
       AgentSupplier.findAll(),
       Department.findAll()
   ]).then(([equipment, agents, departments]) => {
       if (!equipment) {
           return res.render('error', { layout: false, pageTitle: 'Error', href: '/home', message: 'Sorry !!! Could Not Get Equipment' });
       }

       const eq = {
           Code: equipment.Code,
           Name: equipment.Name,
           Cost: equipment.Cost,
           InstallationDate: equipment.InstallationDate,
           WarrantyDate: equipment.WarrantyDate,
           ArrivalDate: equipment.ArrivalDate,
           Model: equipment.Model,
           SerialNumber: equipment.SerialNumber,
           Manufacturer: equipment.Manufacturer,
           Location: equipment.Location,
           Notes: equipment.Notes,
           PM: equipment.PM,
           Image: equipment.Image,
           Eqcontrat : equipment.Eqcontrat,
           Observation : equipment.Observation,
           DepartmentCode: equipment.Department ? equipment.Department.Code : 'N/A',
           AgentSupplierId: equipment.AgentSupplier ? equipment.AgentSupplier.Id : 'N/A'
       };

       const ag = agents.map(agent => {
           return {
               Name: agent.Name,
               Id: agent.Id
           };
       });

       const dp = departments.map(depart => {
           return {
               Name: depart.Name,
               Code: depart.Code
           };
       });

       if (eq.PM === "Annualy") {
           res.render('editEquipment', {
               layout: 'main-layout.handlebars',
               pageTitle: 'Edit',
               Equipment: true,
               equipment: eq,
               A: true,
               Agents: ag,
               Departs: dp
           });
       } else {
           res.render('editEquipment', {
               layout: 'main-layout.handlebars',
               pageTitle: 'Edit',
               Equipment: true,
               equipment: eq,
               M: true,
               Agents: ag,
               Departs: dp
           });
       }
   }).catch(err => {
       console.log("ERROR!!!!!!", err);
       res.render('error', { layout: false, pageTitle: 'Error', href: '/home', message: 'Sorry !!! Could Not Get Equipment' });
   });
}



/*
 exports.editSparePart=(req,res)=>{
   code=req.params.id
   SparePart.findByPk(code).then(sparePart =>{ 
       const sp = {
             Name: sparePart.Name,
             Code: sparePart.Code,
             Amount:sparePart.Amount,
             Image:sparePart.Image,
             AgentSupplierId:sparePart.AgentSupplierId,
             EquipmentCode:sparePart.EquipmentCode
           }
       
   res.render('editSparePart',{layout:'main-layout.handlebars' ,pageTitle:'Edit',
                                    SP:true,sparePart:sp});
})
   .catch(err => console.log("ERROR!!!!!!",err) )


}

*/
exports.editBreakDown=(req,res)=>{
   code=req.params.id
   BreakDown.findByPk(code).then(breakDown =>{ 
       const bd = {
         Code:breakDown.Code,
         Reason:breakDown.Reason,
         DATE:breakDown.DATE,
         EquipmentCode:breakDown.EquipmentCode
           }
   
       
   res.render('editBreakDown',{layout:'main-layout.handlebars' ,pageTitle:'Edit',
                                                   BreakDown:true,breakDown:bd});
})
   .catch(err => console.log("ERROR!!!!!!",err) )


}

exports.editWorkOrder=(req,res)=>{
   code = req.params.id
   WorkOrder.findByPk(code).then(workOrder=>{
      const wd = {
         Code:workOrder.Code,
         Cost:workOrder.Cost,
         StartDate:workOrder.StartDate,
         EndDate:workOrder.EndDate,
         startdatetime:workOrder.AdditionalStartDate,
         enddatetime:workOrder.AdditionalEndDate,
         Description:workOrder.Description,
         EquipmentCode:workOrder.EquipmentCode,
         Priority:workOrder.Priority,
         med:workOrder.Priority=='Medium'?true:false,
         high:workOrder.Priority=='High'?true:false,
         low:workOrder.Priority=='Low'?true:false,
         ClinicalEnginnerDSSN:workOrder.ClinicalEnginnerDSSN 

      }

   res.render('editWorkOrder',{layout:'main-layout.handlebars',pageTitle:'Edit',
                                       WO:true,workOrder:wd});



   })

     .catch(err=>console.log("errorrrrr",err))

}


exports.editMaintenance=(req,res)=>{
   id = req.params.id
   Maintenance.findByPk(id).then(maintenance=>{
      const m = {
         Id:maintenance.Id,
         StartDateNoTime:maintenance.StartDateNoTime,
         EndDateNoTime:maintenance.EndDateNoTime,
         StartDate:maintenance.StartDate,
         EndDate:maintenance.EndDate,
         BreakDownCode:maintenance.BreakDownCode,
         Description:maintenance.Description,
         ClinicalEnginnerDSSN:maintenance.ClinicalEnginnerDSSN
         
      }

   res.render('editMaintenance',{layout:'main-layout.handlebars',pageTitle:'Edit',
                                       Maintenance:true,maintenance:m});



   })

     .catch(err=>console.log("errorrrrr",err))

}
     



