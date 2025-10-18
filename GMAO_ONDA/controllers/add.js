const bcrypt = require('bcryptjs')
const Department = require('../models/department')
const AgentSupplier = require('../models/agent_supplier')
const ClinicalEngineer=require('../models/clinical_engineer')
const Equipment =require('../models/equipment')
const BreakDowns = require('../models/break_down')
const WorkOrders = require('../models/work_order')
const Maintenance = require('../models/maintenance')
const Dashboard = require('../models/Dashboard')





exports.addDashboard = async (req, res) => {
    try {
        const { DepartmentCode, WorkOrderCode, BreakdownCode, MaintenanceId } = req.body;

        // Remplace les valeurs vides par null
        const dashboardData = {
            DepartmentCode,
            WorkOrderCode: WorkOrderCode || null,
            BreakdownCode: BreakdownCode || null,
            MaintenanceId: MaintenanceId ? parseInt(MaintenanceId, 10) : null
        };

        await Dashboard.create(dashboardData);

        res.redirect('/dashbord');
    } catch (err) {
        console.error("ERROR!!!!!!", err);
        res.status(500).send('Internal Server Error');
    }
};







exports.addDepartment=(req,res)=>{
 code=req.body.Code
 name=req.body.Name
 location=req.body.Location
 totalHoursP=req.body.TotalHoursP
 ponderation=req.body.Ponderation
 trp=req.body.Trp
 Department.create({Code:code,Name:name,Location:location,TotalHoursP:totalHoursP,Ponderation:ponderation,Trp:trp}).then(dep =>{
 res.redirect('/department');
 }).catch(err=> {
    console.log("ERROR!!!!!!",err)
    })


}



exports.addAgentSupplier=(req,res)=>{
    id=req.body.Id
    name=req.body.Name
    address=req.body.Address
    phone=req.body.Phone
    email=req.body.Email
    notes=req.body.Notes
    AgentSupplier.findByPk(id).then(agentSupplier => {
        if(agentSupplier){
            agentSupplier.Id=id;
            agentSupplier.Name=name;
            agentSupplier.Address=address;
            agentSupplier.Phone=phone;
            agentSupplier.Email=email;
            agentSupplier.Notes=notes;
            return agentSupplier.save();
        }
        else{
            return AgentSupplier.create({Id:id,Name:name,Adress:address,
                    Phone:phone,Email:email,Notes:notes})
        }
   
   }).then(r => res.redirect('/agentSupplier'))
   .catch(err => console.log("ERROR!!!!!!",err))
}




exports.addClinicalEngineer = async (req, res) => {
    const dssn = req.body.DSSN;
    const fname = req.body.FName;
    const lname = req.body.LName;
    const address = req.body.Address;
    const phone = req.body.Phone;
    const email = req.body.Email;
    let image;
    if (req.body.edit) {
        image = req.body.Image;
    } else {
        image = req.file.path.split('\\').pop();
    }
    const age = req.body.Age;
    const workhours = req.body.workHours;
    const department = req.body.Department;
    let departmentCode = null;
    let pass = null;

    try {
        if (req.body.Password) {
            const salt = await bcrypt.genSalt(10);
            pass = await bcrypt.hash(req.body.Password, salt);
        }

        const departmentResult = await Department.findOne({ where: { Name: department } });
        if (!departmentResult) {
            return res.render('error', {
                layout: false,
                pageTitle: 'Error',
                href: '/technicienEngineer',
                message: 'Sorry !!! Could Not Get this Department',
            });
        }

        departmentCode = departmentResult.Code;

        const clinicalEngineer = await ClinicalEngineer.findByPk(dssn);
        if (clinicalEngineer) {
            clinicalEngineer.FName = fname;
            clinicalEngineer.LName = lname;
            clinicalEngineer.Adress = address;
            clinicalEngineer.Phone = phone;
            clinicalEngineer.Email = email;
            clinicalEngineer.Image = image;
            clinicalEngineer.Age = age;
            clinicalEngineer.WorkHours = workhours;
            clinicalEngineer.DepartmentCode = departmentCode;
            if (pass) clinicalEngineer.Password = pass;
            await clinicalEngineer.save();
        } else {
            await ClinicalEngineer.create({
                DSSN: dssn,
                FName: fname,
                LName: lname,
                Adress: address,
                Phone: phone,
                Image: image,
                Email: email,
                Age: age,
                WorkHours: workhours,
                DepartmentCode: departmentCode,
                Password: pass || 'default_password',  // Assurez-vous que Password ne soit pas null
            });
        }

        res.redirect('/technicienEngineer');
    } catch (err) {
        console.log("ERROR!!!!!!", err);
        res.render('error', {
            layout: false,
            pageTitle: 'Error',
            href: '/equipment',
            message: 'Sorry !!! Could Not Get Engineers',
        });
    }
};


exports.addEquipment = (req, res) => {
    const code = req.body.Code;
    const name = req.body.Name;
    const cost = req.body.Cost;
    const model = req.body.Model;
    const serialnumber = req.body.SerialNumber;
    const installationdate = req.body.InstallationDate;
    const arrivaldate = req.body.ArrivalDate;
    const warrantydate = req.body.WarrantyDate;
    const manufacturer = req.body.Manufacturer;
    const location = req.body.Location;
    const department = req.body.Department;
    const agent = req.body.Agent;
    const pm = req.body.PM;
    const eqcontrat = req.body.Eqcontrat;
    const observation = req.body.Observation;
    const notes = req.body.Notes;
    

    let image = ''; 
    let departmentCode = null;
    let agentCode = null;

    // Vérifier si un fichier a été uploadé
    if (req.file) {
        image = req.file.path.split('\\').pop(); // Récupérer le nom du fichier
    }

    Department.findOne({ where: { Name: department } })
        .then(department => {
            if (department) {
                departmentCode = department.Code;
                return AgentSupplier.findOne({ where: { Id: agent } });
            } else {
                throw new Error('Sorry !!! Could Not Get this Department');
            }
        })
        .then(agent => {
            if (agent) {
                agentCode = agent.Id;
                return Equipment.findByPk(code);
            } else {
                throw new Error('Sorry !!! Could Not Get this Agent');
            }
        })
        .then(equipment => {
            if (equipment) {
                // Mise à jour de l'équipement existant
                equipment.Code = code;
                equipment.Name = name;
                equipment.Cost = cost;
                equipment.Image = image;
                equipment.Model = model;
                equipment.PM = pm;
                equipment.ArrivalDate = arrivaldate;
                equipment.WarrantyDate = warrantydate;
                equipment.Notes = notes;
                equipment.InstallationDate = installationdate;
                equipment.SerialNumber = serialnumber;
                equipment.Manufacturer = manufacturer;
                equipment.Location = location;
                equipment.Eqcontrat = eqcontrat;
                equipment.Observation = observation;
                equipment.DepartmentCode = departmentCode;
                equipment.AgentSupplierId = agentCode;

                return equipment.save();
            } else {
                // Création d'un nouvel équipement
                return Equipment.create({
                    Code: code,
                    Name: name,
                    Image: image,
                    ArrivalDate: arrivaldate,
                    WarrantyDate: warrantydate,
                    PM: pm,
                    Cost: cost,
                    Model: model,
                    SerialNumber: serialnumber,
                    AgentSupplierId: agentCode,
                    Notes: notes,
                    Location: location,
                    Manufacturer: manufacturer,
                    Eqcontrat : eqcontrat,
                    Observation: observation,
                    InstallationDate: installationdate,
                    DepartmentCode: departmentCode
                });
            }
        })
        .then(() => res.redirect('/equipment'))
        .catch(err => {
            res.render('error', {
                layout: false,
                pageTitle: 'Error',
                href: '/equipment',
                message: err.message
            });
        });
};


/*
exports.addSpareParts=(req,res)=>{
    code=req.body.Code
    name=req.body.Name
    amount=req.body.Amount
    agentId=req.body.AgentSupplierId
    equipmentCode=req.body.EquipmentCode
    if(req.body.edit){
        image=req.body.Image
    }
    else{
        image=req.file.path.split('\\')
        if (image.length>1)
            image=req.file.path.split('\\').pop()
        else    
            image=req.file.path.split('/').pop()
           
       }
    AgentSupplier.findOne({where:{Id:agentId}}).then(agent =>{
        if(agent){
            SpareParts.findByPk(code).then(part=>{
                if(part){
                    part.Code=code
                    part.Name=name
                    part.Amount=amount
                    part.AgentSupplierId=agentId
                    part.EquipmentCode=equipmentCode
                    part.Image=image
                    part.save().then(p => res.redirect('/sparePart'))
                }
                else{
                    SpareParts.create({Code:code,Name:name,Amount:amount,AgentSupplierId:agentId,Image:image,EquipmentCode:equipmentCode})
                    .then(res.redirect('/sparePart'))
                }
        
            })
        }
        else
         return res.render('error',{layout:false,pageTitle:'Error',href:'/sparePart',message:'Sorry !!! Could Not Get this Agent'})
        
    }).catch(err=> {
        res.render('error',{layout:false,pageTitle:'Error',href:'/sparePart',message:'Sorry !!! Could Not Gey rhis page'})
        })

}

*/

exports.addBreakDown=(req,res)=>{
    code=req.body.Code
    reason=req.body.Reason
    date=req.body.DATE
    equipmentId=req.body.EquipmentCode
    Equipment.findOne({where:{Code:equipmentId}}).then(Equipment =>{
        if(Equipment){
            BreakDowns.findByPk(code).then(breakD=>{
                if(breakD){
                    breakD.Code=code
                    breakD.Reason=reason
                    breakD.DATE=date
                    breakD.EquipmentCode=equipmentId
                    breakD.save().then(res.redirect('/breakDown'))
                }
        
                BreakDowns.create({Code:code,Reason:reason,DATE:date,EquipmentCode:equipmentId})
                .then(res.redirect('/breakDown'))
                .catch(err=> {
                    console.log("ERROR!!!!!!",err)
                    })
                })
        }
        else
         return res.render('error',{layout:false,pageTitle:'Error',href:'/breakDown',message:'Sorry !!! Could Not Get this Equipment'})
        
    })

}

exports.addWorkOrder=(req,res) => {
    code =req.body.Code
    cost=req.body.Cost
    startdate=req.body.StartDATE
    enddate=req.body.EndDATE
    startdatetime =req.body.AdditionalStartDate
    enddatetime =req.body.AdditionalEndDate
    description=req.body.Description
    priority = req.body.Priority
    equipmentId=req.body.EquipmentCode
    engineerId=req.body.ClinicalEngineerDSSN
    var equId=null
    var engId=null
    Equipment.findOne({where:{Code:equipmentId}}).then(equipment => { 
        if(equipment){
            equId=equipment.Code
            ClinicalEngineer.findOne({where:{DSSN:engineerId}}).then(clinicalengineer =>{
                if(clinicalengineer){
                    engId = clinicalengineer.DSSN
                    WorkOrders.findByPk(code).then(workorder=>{
                        if(workorder){
                            workorder.StartDATE=startdate
                            workorder.EndDATE=enddate
                            workorder.AdditionalStartDate=startdatetime
                            workorder.AdditionalEndDate=enddatetime
                            workorder.Description=description
                            workorder.Cost=cost
                            workorder.EquipmentCode=equId
                            workorder.ClinicalEngineerDSSN=engId
                            workorder.Priority=priority
                            workorder.save().then(workorder => res.redirect('/workOrder'))
                        }
                        else {
                            WorkOrders.create({StartDate:startdate,EndDate:enddate,AdditionalStartDate:startdatetime,AdditionalEndDate:enddatetime,Description:description,
                            Cost:cost,EquipmentCode:equId,ClinicalEnginnerDSSN:engId,Priority:priority})
                            .then(workorder => res.redirect('/workOrder') )
                            }
                   })
                }
            
       

                else
                  res.render('error',{layout:false,pageTitle:'Error',href:'/workOrder',message:'Sorry !!! Could Not Get this Engineer'})  
                  
                  
            })
            
        }
        else{
            res.render('error',{layout:false,pageTitle:'Error',href:'/workOrder',message:'Sorry !!! Could Not Get this Equipment'})
        }
    }).catch(err => {
        if(err)
         res.render('error',{layout:false,pageTitle:'Error',href:'/workOrder',message:'Sorry !!! Could Not Add This Work Order '})

          
    })

}


exports.addMaintenance=(req,res)=>{
    code=req.body.Id
    dssn=req.body.DSSN
    startdatenotime=req.body.StartDateNoTime
    enddatenotime=req.body.EndDateNoTime
    startdate=req.body.StartDate
    enddate=req.body.EndDate
    breakdowncode=req.body.BreakDownID
    description=req.body.Description
    var breakdown = null
    BreakDowns.findOne({where:{Code:breakdowncode}}).then(breakdown =>{
        if(breakdown){
            Maintenance.findByPk(code).then(main=>{
                if(main){
                    main.StartDate=startdate
                    main.EndDate=enddate
                    main.BreakDownCode=breakdowncode
                    main.Description=description
                    main.ClinicalEnginnerDSSN=dssn
                    main.save().then(p => res.redirect('/maintenance'))
                }
                else{
                    Maintenance.create({StartDate:startdate,EndDate:enddate,ClinicalEnginnerDSSN:dssn,BreakDownCode:breakdowncode,Description:description,StartDateNoTime:startdatenotime,EndDateNoTime:enddatenotime})
                    .then(res.redirect('/maintenance'))
                }
        
            })
        }
        else
         return res.render('error',{layout:false,pageTitle:'Error',href:'/maintenance',message:'Sorry !!! Could Not Get this Break down'})
         console.log(err)
        
    }).catch(err=> {
        console.log("ERROR!!!!!!",err)
        })

}