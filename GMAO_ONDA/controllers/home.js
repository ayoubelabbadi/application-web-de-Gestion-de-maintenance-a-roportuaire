const bcrypt = require('bcryptjs')
const Department =require('../models/department');
const AgentSupplier =require('../models/agent_supplier');
const BreakDown =require('../models/break_down');
const ClinicalEngineer =require('../models/clinical_engineer');
const Equipment =require('../models/equipment');
const Maintenance =require('../models/maintenance');
const WorkOrder=require('../models/work_order');
const DailyInspection = require('../models/dialy_inspection');
const PpmQuestions =require('../models/ppm_questions')
const PPM =require('../models/ppm')
const moment=require('moment')
const Dashboard = require('../models/Dashboard')





exports.dashbord = async (req, res) => {
    try {
        const dashboardsPromise = Dashboard.findAll({
            include: [
                { model: Department },
                { model: WorkOrder },
                { model: BreakDown },
                { model: Maintenance }
            ]
        });

        const departmentsPromise = Department.findAll();

        const maintenancesPromise = Maintenance.findAll({
            include: [
                {
                    model: BreakDown,
                    include: [
                        { model: Equipment, include: [{ model: Department }] }
                    ]
                }
            ]
        });

        const breakDownsPromise = BreakDown.findAll({
            include: [
                { model: Equipment, include: [{ model: Department }] }
            ]
        });

        const equipmentsPromise = Equipment.findAll({
            include: [
                { model: Department }
            ]
        });

        const [dashbords, departments, maintenances, breakDowns, equipments] = await Promise.all([
            dashboardsPromise,
            departmentsPromise,
            maintenancesPromise,
            breakDownsPromise,
            equipmentsPromise
        ]);

        // Calcul des heures de maintenance pour chaque département
        const departmentMaintenanceHours = maintenances.reduce((acc, maintenance) => {
            const deptCode = maintenance.BreakDown?.Equipment?.Department?.Code;
            if (deptCode) {
                if (!acc[deptCode]) {
                    acc[deptCode] = 0;
                }
                const durationInMinutes = Math.round((new Date(maintenance.EndDate) - new Date(maintenance.StartDate)) / 60000);
                const durationInHours = (durationInMinutes / 60).toFixed(2);
                acc[deptCode] += parseFloat(durationInHours);
            }
            return acc;
        }, {});

        // Calcul de la durée totale des pannes pour chaque département
        const breakdownDurationPerDepartment = breakDowns.reduce((acc, breakDown) => {
            const deptCode = breakDown.Equipment?.Department?.Code;
            if (deptCode) {
                const breakDownDate = new Date(breakDown.DATE);
                const maintenanceEndDates = maintenances
                    .filter(m => m.BreakDown?.Code === breakDown.Code)
                    .map(m => new Date(m.EndDate));

                maintenanceEndDates.forEach(endDate => {
                    const durationInMinutes = Math.round((new Date(endDate) - breakDownDate) / 60000);
                    const durationInHours = (durationInMinutes / 60).toFixed(2);
                    if (!acc[deptCode]) {
                        acc[deptCode] = 0;
                    }
                    acc[deptCode] += parseFloat(durationInHours);
                });
            }
            return acc;
        }, {});

        // Calcul du nombre de pannes pour chaque département
        const breakdownCountPerDepartment = breakDowns.reduce((acc, breakDown) => {
            const deptCode = breakDown.Equipment?.Department?.Code;
            if (deptCode) {
                if (!acc[deptCode]) {
                    acc[deptCode] = 0;
                }
                acc[deptCode]++;
            }
            return acc;
        }, {});

        // Calcul du nombre de réparations pour chaque département
        const repairCountPerDepartment = maintenances.reduce((acc, maintenance) => {
            const deptCode = maintenance.BreakDown?.Equipment?.Department?.Code;
            if (deptCode) {
                if (!acc[deptCode]) {
                    acc[deptCode] = 0;
                }
                acc[deptCode]++;
            }
            return acc;
        }, {});

        const equipmentCountPerDepartment = equipments.reduce((acc, equipment) => {
            const deptCode = equipment.Department?.Code;
            if (deptCode) {
                if (!acc[deptCode]) {
                    acc[deptCode] = 0;
                }
                acc[deptCode]++;
            }
            return acc;
        }, {});



        

        // Préparer les données pour la vue
        const departmentHours = departments.map(department => {
            const equipmentCount = equipmentCountPerDepartment[department.Code] || 0;
            const totalHours = parseFloat(departmentMaintenanceHours[department.Code] || 0);
            const totalHoursP = parseFloat(department.TotalHoursP || 0);
            const totalBreakdownDuration = parseFloat(breakdownDurationPerDepartment[department.Code] || 0);
            const breakdownCount = breakdownCountPerDepartment[department.Code] || 0;
            const repairCount = repairCountPerDepartment[department.Code] || 0;
            const totalBreakdownRepairs = breakdownCount + repairCount;
            const totalHoursSum = (totalHours + totalHoursP ).toFixed(2) ;

            // Calcul des heures de disponibilité
            const totalAvailableHours = (744 - totalBreakdownDuration).toFixed(2);

            // Calcul du taux de disponibilité
            const availabilityRate = parseFloat(((totalAvailableHours/744)  * 100).toFixed(2)+ "%");

            // Calcul du taux de dispo
            const availabilityRate1 = ((totalHoursSum/744)  * 100).toFixed(2)+ "%";

            const trp = parseFloat(department.Trp || 0) +"%";
            const ponderation = parseFloat(department.Ponderation || 0).toFixed(2);

            // Calcul du taux de pondération
             const tauxPond = parseFloat(ponderation * (availabilityRate)).toFixed(2) + "%";

             // Calcul MTBF (le temps moyen entre les pannes réparables d'un produit technologique)
             const mtbf = parseFloat((availabilityRate / breakdownCount).toFixed(2)+ "%");

             // Calcul taux MTBF 
             const tauxmtbf = parseFloat(mtbf / ponderation).toFixed(2);

             // Calcul MTTR (le temps moyen nécessaire à la réparation)
             const mttr = parseFloat((totalHours * equipmentCount) / breakdownCount).toFixed(2);

             // Calcul taux MTTR 
             const tauxmttr = parseFloat(mttr * ponderation).toFixed(2);        
    
    
            

            


            return {
                Code: department.Code,
                Name: department.Name,
                Location: department.Location,
                //EquipmentCount: equipmentCountPerDepartment[department.Code] || 0, // Nombre d'équipements
                EquipmentCount: equipmentCount,
                TotalHours: totalHours.toFixed(2),
                TotalHoursP: totalHoursP,
                Ponderation: ponderation,
                Trp: trp,
                TotalBreakdownDuration: totalBreakdownDuration,
                BreakdownCount: breakdownCount,
                RepairCount: repairCount, // Nombre de réparations
                TotalBreakdownRepairs: totalBreakdownRepairs, // Total des pannes et réparations
                //TotalHoursSum: (totalHours + totalHoursP ).toFixed(2),
                TotalHoursSum : totalHoursSum, // Nbr d’heures Maint de réparation planifié et non planifié
                TotalAvailableHours: totalAvailableHours, // Heures de disponibilité
                AvailabilityRate: availabilityRate + "%", // Taux de disponibilité
                AvailabilityRate1 :availabilityRate1, // Taux de dispo
                TauxPond : tauxPond, // Taux de pondération 
                MTBF : mtbf + "%" , // Moyenne des temps de réponse (MTBF)
                TauxMTBF : tauxmtbf + "%", // Taux de MTBF par rapport au taux de pondération
                MTTR : mttr, // Moyenne des temps de réparation (MTTR)
                TauxMTTR : tauxmttr + "%", // Taux de MTTR par rapport au taux de pondération
                
                

                
            };
        });

      
        

        ;
        
        

        res.render('dashboard', {
            pageTitle: 'Dashboard',
            Dashboard: true,
            dashbords: dashbords.map(dashboard => ({
                Code: dashboard.Code,
                DepartmentCode: dashboard.Department ? dashboard.Department.Code : 'N/A',
                WorkOrderCode: dashboard.WorkOrders ? dashboard.WorkOrders.Code : 'N/A',
                BreakdownCode: dashboard.BreakDowns ? dashboard.BreakDowns.Code : 'N/A',
                MaintenanceId: dashboard.Maintenances ? dashboard.Maintenances.Id : 'N/A',
                TotalHours: departmentMaintenanceHours[dashboard.Department ? dashboard.Department.Code : 'N/A'] || 0
            })),
            DepartmentHours: departmentHours,
            hasDashboard: dashbords.length > 0
        });
    } catch (err) {
        console.log(err);
        res.render('error', {
            layout: false,
            pageTitle: 'Error',
            href: '/home',
            message: 'Sorry !!! Could Not Get Dashboards'
        });
    }
};


const ExcelJS = require('exceljs');
//const { Department, WorkOrder, BreakDown, Maintenance, Equipment, Dashboard } = require('../models/Dashboard'); // Ajustez le chemin selon votre structure de projet

exports.exportDashboardToExcel = async (req, res) => {
    try {
        // Récupérer les données nécessaires
        const departmentsPromise = Department.findAll();
        const maintenancesPromise = Maintenance.findAll({
            include: [
                {
                    model: BreakDown,
                    include: [
                        { model: Equipment, include: [{ model: Department }] }
                    ]
                }
            ]
        });
        const breakDownsPromise = BreakDown.findAll({
            include: [
                { model: Equipment, include: [{ model: Department }] }
            ]
        });
        const equipmentsPromise = Equipment.findAll({
            include: [
                { model: Department }
            ]
        });

        const [departments, maintenances, breakDowns, equipments] = await Promise.all([
            departmentsPromise,
            maintenancesPromise,
            breakDownsPromise,
            equipmentsPromise
        ]);

        // Calcul des heures de maintenance pour chaque département
        const departmentMaintenanceHours = maintenances.reduce((acc, maintenance) => {
            const deptCode = maintenance.BreakDown?.Equipment?.Department?.Code;
            if (deptCode) {
                if (!acc[deptCode]) {
                    acc[deptCode] = 0;
                }
                const durationInMinutes = Math.round((new Date(maintenance.EndDate) - new Date(maintenance.StartDate)) / 60000);
                const durationInHours = (durationInMinutes / 60).toFixed(2);
                acc[deptCode] += parseFloat(durationInHours);
            }
            return acc;
        }, {});

        // Calcul de la durée totale des pannes pour chaque département
        const breakdownDurationPerDepartment = breakDowns.reduce((acc, breakDown) => {
            const deptCode = breakDown.Equipment?.Department?.Code;
            if (deptCode) {
                const breakDownDate = new Date(breakDown.DATE);
                const maintenanceEndDates = maintenances
                    .filter(m => m.BreakDown?.Code === breakDown.Code)
                    .map(m => new Date(m.EndDate));

                maintenanceEndDates.forEach(endDate => {
                    const durationInMinutes = Math.round((new Date(endDate) - breakDownDate) / 60000);
                    const durationInHours = (durationInMinutes / 60).toFixed(2);
                    if (!acc[deptCode]) {
                        acc[deptCode] = 0;
                    }
                    acc[deptCode] += parseFloat(durationInHours);
                });
            }
            return acc;
        }, {});

        // Calcul du nombre de pannes pour chaque département
        const breakdownCountPerDepartment = breakDowns.reduce((acc, breakDown) => {
            const deptCode = breakDown.Equipment?.Department?.Code;
            if (deptCode) {
                if (!acc[deptCode]) {
                    acc[deptCode] = 0;
                }
                acc[deptCode]++;
            }
            return acc;
        }, {});

        // Calcul du nombre de réparations pour chaque département
        const repairCountPerDepartment = maintenances.reduce((acc, maintenance) => {
            const deptCode = maintenance.BreakDown?.Equipment?.Department?.Code;
            if (deptCode) {
                if (!acc[deptCode]) {
                    acc[deptCode] = 0;
                }
                acc[deptCode]++;
            }
            return acc;
        }, {});

        const equipmentCountPerDepartment = equipments.reduce((acc, equipment) => {
            const deptCode = equipment.Department?.Code;
            if (deptCode) {
                if (!acc[deptCode]) {
                    acc[deptCode] = 0;
                }
                acc[deptCode]++;
            }
            return acc;
        }, {});

        // Préparer les données pour la vue
        const departmentHours = departments.map(department => {
            const equipmentCount = equipmentCountPerDepartment[department.Code] || 0;
            const totalHours = parseFloat(departmentMaintenanceHours[department.Code] || 0);
            const totalHoursP = parseFloat(department.TotalHoursP || 0);
            const totalBreakdownDuration = parseFloat(breakdownDurationPerDepartment[department.Code] || 0);
            const breakdownCount = breakdownCountPerDepartment[department.Code] || 0;
            const repairCount = repairCountPerDepartment[department.Code] || 0;
            const totalBreakdownRepairs = breakdownCount + repairCount;
            const totalHoursSum = (totalHours + totalHoursP ).toFixed(2);

            // Calcul des heures de disponibilité
            const totalAvailableHours = (744 - totalBreakdownDuration).toFixed(2);

            // Calcul du taux de disponibilité
            const availabilityRate = parseFloat(((totalAvailableHours/744)  * 100).toFixed(2)+ "%");

            // Calcul du taux de dispo
            const availabilityRate1 = ((totalHoursSum/744)  * 100).toFixed(2)+ "%";

            const trp = parseFloat(department.Trp || 0) +"%";
            const ponderation = parseFloat(department.Ponderation || 0).toFixed(2);

            // Calcul du taux de pondération
            const tauxPond = parseFloat(ponderation * (availabilityRate)).toFixed(2) + "%";

            // Calcul MTBF (le temps moyen entre les pannes réparables d'un produit technologique)
            const mtbf = parseFloat((availabilityRate / breakdownCount).toFixed(2)+ "%");

            // Calcul taux MTBF
            const tauxmtbf = parseFloat(mtbf / ponderation).toFixed(2);

            // Calcul MTTR (le temps moyen nécessaire à la réparation)
            const mttr = parseFloat((totalHours * equipmentCount) / breakdownCount).toFixed(2);

            // Calcul taux MTTR
            const tauxmttr = parseFloat(mttr * ponderation).toFixed(2);

            return {
                Code: department.Code,
                Name: department.Name,
                Location: department.Location,
                EquipmentCount: equipmentCount,
                TotalHours: totalHours.toFixed(2),
                TotalHoursP: totalHoursP,
                Ponderation: ponderation,
                Trp: trp,
                TotalBreakdownDuration: totalBreakdownDuration,
                BreakdownCount: breakdownCount,
                RepairCount: repairCount,
                TotalBreakdownRepairs: totalBreakdownRepairs,
                TotalHoursSum: totalHoursSum,
                TotalAvailableHours: totalAvailableHours,
                AvailabilityRate: availabilityRate + "%",
                AvailabilityRate1: availabilityRate1,
                TauxPond: tauxPond,
                MTBF: mtbf,
                TauxMTBF: tauxmtbf + "%",
                MTTR: mttr,
                TauxMTTR: tauxmttr + "%"
            };
        });

        // Créer un nouveau classeur
        const workbook = new ExcelJS.Workbook();
        const worksheet = workbook.addWorksheet('Department Data');

        // Ajouter les en-têtes de colonnes
        worksheet.columns = [
            { header: 'Équipements IT', key: 'Name', width: 25 },
            { header: 'Équipements', key: 'EquipmentCount', width: 15 },
            { header: 'Nbr d’heures Maintenance de réparation non planifié', key: 'TotalHours', width: 30 },
            { header: 'Nbr d’heures Maintenance d\'arrêt non Planifié', key: 'TotalBreakdownDuration', width: 30 },
            { header: 'Nbr de panne Arrêt non Planifié', key: 'BreakdownCount', width: 25 },
            { header: 'Nbr d’heures Maintenance de réparation planifié', key: 'TotalHoursP', width: 30 },
            { header: 'Nbr d’heures Maint de réparation planifié et non planifié', key: 'TotalHoursSum', width: 30 },
            { header: 'Nombre de panne et réparation', key: 'TotalBreakdownRepairs', width: 30 },
            { header: 'Nbr d’heures disponibilité', key: 'TotalAvailableHours', width: 30 },
            { header: 'Taux de Disponibilité', key: 'AvailabilityRate', width: 25 },
            { header: 'Taux de Dispo %', key: 'AvailabilityRate1', width: 25 },
            { header: 'TRP %', key: 'Trp', width: 15 },
            { header: 'Pondération', key: 'Ponderation', width: 15 },
            { header: 'Taux de Pondération', key: 'TauxPond', width: 25 },
            { header: 'MTBF', key: 'MTBF', width: 15 },
            { header: 'Taux MTBF', key: 'TauxMTBF', width: 15 },
            { header: 'MTTR', key: 'MTTR', width: 15 },
            { header: 'Taux MTTR', key: 'TauxMTTR', width: 15 },
        ];

        // Ajouter des lignes de données
        departmentHours.forEach(department => {
            worksheet.addRow(department);
        });

        // Créer un fichier Excel
        const filePath = './public/dashboard.xlsx';
        await workbook.xlsx.writeFile(filePath);

        // Envoyer le fichier Excel en réponse
        res.download(filePath, 'dashboard.xlsx');
    } catch (error) {
        console.error('Erreur lors de l\'exportation des données en Excel:', error);
        res.status(500).send('Erreur lors de l\'exportation des données en Excel.');
    }
};






/*
exports.dashbord = async (req, res) => {
    try {
        // Récupérer les départements avec les équipements
        const departmentsPromise = Department.findAll({
            include: [{ model: Equipment }]
        });

        // Récupérer les maintenances
        const maintenancesPromise = Maintenance.findAll({
            include: [
                {
                    model: BreakDown,
                    include: [
                        { model: Equipment, include: [{ model: Department }] }
                    ]
                }
            ]
        });

        const [departments, maintenances] = await Promise.all([
            departmentsPromise,
            maintenancesPromise
        ]);

        // Calcul du total des heures de maintenance par département
        const departmentMaintenanceHours = maintenances.reduce((acc, maintenance) => {
            const deptCode = maintenance.BreakDown?.Equipment?.Department?.Code;
            if (deptCode) {
                if (!acc[deptCode]) {
                    acc[deptCode] = 0;
                }
                // Convertir la durée en heures et l'ajouter au total
                const durationInMinutes = Math.round((new Date(maintenance.EndDate) - new Date(maintenance.StartDate)) / 60000);
                const durationInHours = (durationInMinutes / 60).toFixed(2);
                acc[deptCode] += parseFloat(durationInHours);
            }
            return acc;
        }, {});

        // Préparer les données des départements pour l'affichage
        const departmentHours = departments.map(department => ({
            Code: department.Code,
            Name: department.Name,
            TotalHours: departmentMaintenanceHours[department.Code] || 0,
            Equipments: department.Equipments.length
        }));

        // Récupérer les dashboards (si nécessaire, ajustez en fonction de votre modèle)
        const dashboards = await Dashboard.findAll({
            include: [{ model: Department }, { model: WorkOrder }, { model: BreakDown }, { model: Maintenance }]
        });

        res.render('dashboard', {
            pageTitle: 'Dashboard',
            Dashboard: true,
            dashboards: dashboards.map(dashboard => ({
                Code: dashboard.Code,
                DepartmentCode: dashboard.Department ? dashboard.Department.Code : 'N/A',
                WorkOrderCode: dashboard.WorkOrders ? dashboard.WorkOrders.Code : 'N/A',
                BreakdownCode: dashboard.BreakDowns ? dashboard.BreakDowns.Code : 'N/A',
                MaintenanceId: dashboard.Maintenances ? dashboard.Maintenances.Id : 'N/A',
                TotalHours: departmentMaintenanceHours[dashboard.Department ? dashboard.Department.Code : 'N/A'] || 0
            })),
            DepartmentHours: departmentHours,
            hasDashboard: dashboards.length > 0
        });
    } catch (err) {
        console.log(err);
        res.render('error', {
            layout: false,
            pageTitle: 'Error',
            href: '/home',
            message: 'Sorry !!! Could Not Get Dashboards'
        });
    }
};
*/















exports.homeSignIn=(req,res) => {
    res.render('newHome',{layout:false});
}


exports.signIn=(req,res) => {
   email=req.body.email
   pass=req.body.password
   if(email == 'admin@gmail.com' && pass==0000){
    res.redirect('/home');  
   }
   else{
       ClinicalEngineer.findOne({where:{Email:email}}).then(clinicalengineer => {
           if(clinicalengineer){
            bcrypt.compare(pass, clinicalengineer.Password).then(result => {
                if(result){
                 req.session.DSSN=clinicalengineer.DSSN
                 res.redirect('/engineer/dialyInspection');  
                }
                else
                 res.redirect('/')    
                })
           }
           else
           res.redirect('/')    
            
       })
   }
   
}



exports.home=(req,res) =>{
    res.render('home',{pageTitle:'Home',Home:true});
}
exports.dialyInspectionEngineer=(req,res) =>{
    engineerId=req.session.DSSN
    Equipment.findAll({include:[{model:Department}]}).then(equipments => {
        const eqs=equipments.map(equipment => {
            return{
                Name:equipment.Name,
                Code:equipment.Code,
                Department:equipment.Department.Name
            }
        })
        ClinicalEngineer.findByPk(engineerId).then(engineer => {
            const Engineer ={
                Image:engineer.Image,
                FName:engineer.FName,
                LName:engineer.LName
            }
        res.render('dialyInspectionForm',{layout:'clinicalEngineerLayout',pageTitle:'Dialy Inspection',
        DI:true,equipments:eqs,Engineer:Engineer})
        })
    })
}

exports.dialyInspectionEngineerPost=(req,res) =>{
 code = req.body.Code
 date = req.body.DATE
 q1 = req.body.Q1
 q2 = req.body.Q2
 q3 = req.body.Q3
 q4 = req.body.Q4
 q5 = req.body.Q5
 q6 = req.body.Q6
 q7 = req.body.Q7
 q8 = req.body.Q8
 equipmentId = req.body.Device
 engineerId=req.session.DSSN


 q1 = q1 == "on" ? "on": "off"
 q2 = q2 == "on" ? "on": "off"
 q3 = q3 == "on" ? "on": "off"
 q4 = q4 == "on" ? "on": "off"
 q5 = q5 == "on" ? "on": "off"
 q6 = q6 == "on" ? "on": "off"
 q7 = q7 == "on" ? "on": "off"
 q8 = q8 == "on" ? "on": "off"

 
     

 
 Equipment.findByPk(equipmentId).then(equipment => { 
     if(equipment){
         ClinicalEngineer.findByPk(engineerId).then(clinicalengineer =>{
             if(clinicalengineer){
                    DailyInspection.create({DATE:date,Q1:q1,Q2:q2,Q3:q3,Q4:q4,Q5:q5,Q6:q6,Q7:q7,Q8:q8,EquipmentCode:equipmentId,ClinicalEnginnerDSSN:engineerId})
                        .then(dailyinspection => res.redirect('/engineer/dialyInspection') )
            }
            else{
                res.render('error',{layout:false,pageTitle:'Error',href:'/engineer/dialyInspection',message:'Sorry !!! Could Not Get this Engineer'})
            } 
         })   
     }
     else{
         res.render('error',{layout:false,pageTitle:'Error',href:'/engineer/dialyInspection',message:'Sorry !!! Could Not Get this Equipment'})
     }
 }).catch(err => {
     if(err){
         console.log(err)
      res.render('error',{layout:false,pageTitle:'Error',href:'/engineer/dialyInspection',message:'Sorry !!! Could Not Add This Report '})
     }
       
 })

}



exports.ppmEngineer=(req,res) =>{
    engineerId=req.session.DSSN
    PpmQuestions.findAll({include:[{model:Equipment,include:[{model:Department}]}]}).then(reports=>{
        const eqs=reports.map(report => {
            return {
                Name:report.Equipment.Name,
                Code:report.Equipment.Code,
                Department:report.Equipment.Department.Name
            }
        })
        ClinicalEngineer.findByPk(engineerId).then(engineer => {
            const Engineer ={
                Image:engineer.Image,
                FName:engineer.FName,
                LName:engineer.LName
            }
            res.render('deviceForm',{layout:'clinicalEngineerLayout',pageTitle:'Dialy Inspection',
                PPM:true,equipments:eqs,Engineer:Engineer})
        })
    })

}
exports.ppmEngineerPost=(req,res) =>{
    code=req.body.Code
    res.redirect('/engineer/ppm/'+code);
}

exports.ppmEngineerEquipment =(req,res) => {
    code=req.params.code
    engineerId=req.session.DSSN
    PpmQuestions.findOne({where:{EquipmentCode:code}}).then(ppm => {
        const Ppm={
            Q1:ppm.Q1,
            Q2:ppm.Q2,
            Q3:ppm.Q3,
            Q4:ppm.Q4,
            Q5:ppm.Q5
        }
        ClinicalEngineer.findByPk(engineerId).then(engineer => {
            const Engineer ={
                Image:engineer.Image,
                FName:engineer.FName,
                LName:engineer.LName
            }

        res.render('ppmForm',{layout:'clinicalEngineerLayout',pageTitle:'Dialy Inspection',
            PPM:true,ppm:Ppm,Code:code,Engineer:Engineer})
        })
    })
}
exports.ppmEngineerEquipmentPost=(req,res) =>{
    date=req.body.DATE
    equipmentId=req.params.Code
    engineerId=req.session.DSSN
    q1 = req.body.Q1
    q2 = req.body.Q2
    q3 = req.body.Q3
    q4 = req.body.Q4
    q5 = req.body.Q5
    n1 = req.body.N1
    n2 = req.body.N2
    n3 = req.body.N3
    n4 = req.body.N4
    n5 = req.body.N5
    q1 = q1 == "on" ? "on": "off"
    q2 = q2 == "on" ? "on": "off"
    q3 = q3 == "on" ? "on": "off"
    q4 = q4 == "on" ? "on": "off"
    q5 = q5 == "on" ? "on": "off"

    Equipment.findByPk(equipmentId).then(equipment => { 
        if(equipment){
            ClinicalEngineer.findByPk(engineerId).then(clinicalengineer =>{
                if(clinicalengineer){
                       PPM.create({DATE:date,Q1:q1,Q2:q2,Q3:q3,Q4:q4,Q5:q5,N1:n1,N2:n2,N3:n3,N4:n4,N5:n5,EquipmentCode:equipmentId,ClinicalEnginnerDSSN:engineerId})
                           .then(dailyinspection => res.redirect('/engineer/ppm') )
               }
               else{
                   res.render('error',{layout:false,pageTitle:'Error',href:'/engineer/ppm',message:'Sorry !!! Could Not Get this Engineer'})
               } 
            })   
        }
        else{
            res.render('error',{layout:false,pageTitle:'Error',href:'/engineer/ppm',message:'Sorry !!! Could Not Get this Equipment'})
        }
    }).catch(err => {
        if(err){
            console.log(err)
         res.render('error',{layout:false,pageTitle:'Error',href:'/engineer/ppm',message:'Sorry !!! Could Not Add This Report '})
        }
          
    })
   



}

exports.department=(req,res)=>{
Department.findAll({
    include:[{model:ClinicalEngineer},{model:Equipment}]
    }).then(departments => {
        const deps = departments.map(department => {       
            return {
                        Name: department.Name,
                        Code: department.Code,
                        Location: department.Location,
                        TotalHoursP: department.TotalHoursP,
                        Ponderation: department.Ponderation,
                        Trp: department.Trp,
                        Engineers:department.ClinicalEnginners.length,
                        Equipments:department.Equipment.length
                    }
                })      

    res.render('department',{pageTitle:'Department',
                            Department:true,
                            departments:deps,
                            hasDepartment:deps.length>0});
                            
                    
}).catch(err => {
    if(err){
        console.log(err)    
        res.render('error',{layout:false,pageTitle:'Error',href:'/home',message:'Sorry !!! Could Not Get Departments'})
     }
    })


}








const formatDate = (date) => {
    const options = {
        day: '2-digit',
        month: '2-digit',
        year: 'numeric',
        hour: '2-digit',
        minute: '2-digit',
        second: '2-digit',
        hour12: false,
        timeZone: 'Africa/Casablanca' 
    };
    return new Intl.DateTimeFormat('fr-FR', options).format(new Date(date));
};



exports.maintenance = (req, res) => {
    Maintenance.findAll({
        include: [
            {
                model: BreakDown,
                as: 'BreakDown',
                include: [
                    {
                        model: Equipment,
                        as: 'Equipment',
                        include: [{ model: Department, as: 'Department' }]
                    }
                ]
            },
            {
                model: ClinicalEngineer,
                as: 'ClinicalEnginner' // Utilisez l'alias correct défini dans l'association
            }
        ]
    }).then(maintenances => {
        console.log("Maintenances:", maintenances);

        const m = maintenances.map(main => {
            // Calculer la durée en heures
            const durationInMinutes = Math.round((new Date(main.EndDate) - new Date(main.StartDate)) / 60000);
            const durationInHours = (durationInMinutes / 60).toFixed(2); // Limiter à 2 décimales

            return {
                Id: main.Id,
                StartDateNoTime :main.StartDateNoTime,
                EndDateNoTime :main.EndDateNoTime,
                StartDate: formatDate(main.StartDate),
                EndDate: formatDate(main.EndDate),
                Duration: durationInHours, // Ajouter la durée en heures
                BreakDownCode: main.BreakDown ? main.BreakDown.Code : 'N/A',
                EquipmentName: main.BreakDown && main.BreakDown.Equipment ? main.BreakDown.Equipment.Name : 'N/A',
                EquipmentCode: main.BreakDown && main.BreakDown.Equipment ? main.BreakDown.Equipment.Code : 'N/A',
                EquipmentImage: main.BreakDown && main.BreakDown.Equipment ? main.BreakDown.Equipment.Image : 'N/A',
                ClinicalEngineer: main.ClinicalEnginner ? main.ClinicalEnginner.FName + ' ' + main.ClinicalEnginner.LName : 'N/A',
                ClinicalEngineerImage: main.ClinicalEnginner ? main.ClinicalEnginner.Image : 'N/A',
                Department: main.BreakDown && main.BreakDown.Equipment && main.BreakDown.Equipment.Department ? main.BreakDown.Equipment.Department.Name : 'N/A',
                Description: main.Description             
            };
        });

        console.log("Mapped Maintenances:", m);

        BreakDown.findAll({
            include: [
                {
                    model: Equipment,
                    as: 'Equipment',
                    include: [{ model: Department, as: 'Department' }]
                }
            ]
        }).then(breakDowns => {
            const bd = breakDowns.map(breakDown => {
                return {
                    Code: breakDown.Code,
                    Date: breakDown.DATE,
                    EquipmentName: breakDown.Equipment ? breakDown.Equipment.Name : 'N/A',
                    EquipmentCode: breakDown.Equipment ? breakDown.Equipment.Code : 'N/A',
                    Reason: breakDown.Reason
                };
            });

            ClinicalEngineer.findAll().then(clinicalEngineers => {
                const en = clinicalEngineers.map(clinicalEngineer => {
                    return {
                        FName: clinicalEngineer.FName,
                        LName: clinicalEngineer.LName,
                        DSSN: clinicalEngineer.DSSN,
                        Image: clinicalEngineer.Image 
                    };
                });

                console.log("Clinical Engineers:", en);

                res.render('maintenance', {
                    pageTitle: 'Maintenance',
                    Maintenance: true,
                    Maintenances: m,
                    hasMaintenance: m.length > 0,
                    Engineers: en,
                    breakDowns: bd
                });
            }).catch(err => {
                console.log(err);
                res.render('error', {
                    layout: false,
                    pageTitle: 'Error',
                    href: '/home',
                    message: 'Sorry !!! Could Not get any Clinical Engineers'
                });
            });
        }).catch(err => {
            console.log(err);
            res.render('error', {
                layout: false,
                pageTitle: 'Error',
                href: '/home',
                message: 'Sorry !!! Could Not get any BreakDowns'
            });
        });
    }).catch(err => {
        console.log(err);
        res.render('error', {
            layout: false,
            pageTitle: 'Error',
            href: '/home',
            message: 'Sorry !!! Could Not get any Maintenance'
        });
    });
};







exports.clinicalEngineer=(req,res)=>{
    ClinicalEngineer.findAll({include:[{model:Department}]}).then(clinicalEngineers=>{
        const clinicalengineers=clinicalEngineers.map(clinicalengineer => {     
            return{
                DSSN:clinicalengineer.DSSN,
                FName:clinicalengineer.FName,
                LName:clinicalengineer.LName,
                Image:clinicalengineer.Image,
                Adress:clinicalengineer.Adress,
                Phone:clinicalengineer.Phone,
                Email:clinicalengineer.Email,
                Age:clinicalengineer.Age,
                WorkHours:clinicalengineer.WorkHours,
                DepartmentCode:clinicalengineer.Department.dataValues.Name
                
            }
            

        })

        Department.findAll().then(depats => {
            const dp = depats.map(depart => {
                return {
                    Name:depart.Name,
                    Code:depart.Code
                }
            })        
    res.render('clinicalEngineer',{pageTitle:'technicienEngineer',CE:true,
        clinicalEngineers:clinicalengineers,hasEngineers:clinicalengineers.length>0,Departs:dp});
                           
        })

        
       
    })
    .catch(err => {
        if(err)
         res.render('error',{layout:false,pageTitle:'Error',href:'/home',message:'Sorry !!! Could Not Get Engineers'})
    })
    
}


/*
exports.sparePart=(req,res)=>{
    SparePart.findAll({include:[{model:AgentSupplier},{model:Equipment}]}).then(sparepart => {
        const sp = sparepart.map(sparepart => {
                  return {
                    Code:sparepart.Code,
                    Name:sparepart.Name,
                    Amount:sparepart.Amount,
                    Image:sparepart.Image,
                    AgentSupplierId:sparepart.AgentSupplier.dataValues.Id,
                    AgentSupplierName:sparepart.AgentSupplier.dataValues.Name,
                    EquipmentCode:sparepart.Equipment.dataValues.Code,
                    EquipmentName:sparepart.Equipment.dataValues.Name


                  }
                })
        Equipment.findAll({include:[{model:Department}]}).then(equipments => {
            const eq = equipments.map(equipment => {
                return{
                    Code:equipment.Code,
                    Name:equipment.Name,
                    DepartmentName:equipment.Department.Name
                }
            })
        AgentSupplier.findAll().then(agents => {
            const ag = agents.map(agent => {
                return {
                    Name:agent.Name,
                    Id:agent.Id
                }
            })
        res.render('sparePart',{pageTitle:'SpareParts',SP:true,SpareParts:sp,
                                hasPart:sp.length>0,Equipments:eq,Agents:ag});
        })    
        })             

}).catch( err=> {
    if (err)
     console.log(err)
     res.render('error',{layout:false,pageTitle:'Error',href:'/home',message:'Sorry !!! Could Not Get Spare Parts'})
})
}
*/

exports.agentSupplier=(req,res)=>{
    AgentSupplier.findAll().then(agentsuppliers => {
        const as = agentsuppliers.map(agentsupplier => {

                  return {
                    Name: agentsupplier.Name,
                    Id: agentsupplier.Id,
                    Adress: agentsupplier.Adress,
                    Phone:agentsupplier.Phone,
                    Email:agentsupplier.Email,
                    Notes:agentsupplier.Notes
                  }
                })

    res.render('agentSupplier',{pageTitle:'AgentSupplier',
                                AS:true,agentSuppliers:as,
                                hasAgentSupplier:as.length>0});
    }).catch(err => {
        if(err)
        res.render('error',{layout:false,pageTitle:'Error',href:'/home',message:'Sorry !!! Could Not Get Agents'})
    })
}



exports.workOrder = (req, res) => {
    WorkOrder.findAll({
        include: [
            { model: ClinicalEngineer },
            { model: Equipment, include: [{ model: Department }] }
        ]
    }).then(workorders => {
        const wd = workorders.map(workD => {
            // Calculer la durée en heures
            const durationInMinutes = Math.round((new Date(workD.AdditionalEndDate) - new Date(workD.AdditionalStartDate)) / 60000);
            const durationInHours = (durationInMinutes / 60).toFixed(2); // Limiter à 2 décimales

            return {
                Code: workD.Code,
                Cost: workD.Cost,
                StartDate: workD.StartDate, 
                EndDate: workD.EndDate,
                AdditionalStartDate: formatDate(workD.AdditionalStartDate),
                AdditionalEndDate: formatDate(workD.AdditionalEndDate),
                Duration: durationInHours, // Ajout de la durée en heures
                med: workD.Priority === 'Medium',
                high: workD.Priority === 'High',
                low: workD.Priority === 'Low',
                EquipmentCode: workD.Equipment ? workD.Equipment.Code : null,
                EquipmentName: workD.Equipment ? workD.Equipment.Name : null,
                EquipmentImage: workD.Equipment ? workD.Equipment.Image : 'default_image.png',
                Priority: workD.Priority,
                Description: workD.Description,
                ClinicalEnginner: workD.ClinicalEnginner ? `${workD.ClinicalEnginner.FName} ${workD.ClinicalEnginner.LName}` : 'Unknown Engineer',
                ClinicalEnginnerImage: workD.ClinicalEnginner ? workD.ClinicalEnginner.Image : 'default_image.png'
            };
        });

        ClinicalEngineer.findAll().then(clinicalEngineers => {
            const en = clinicalEngineers.map(clinicalEngineer => ({
                FName: clinicalEngineer.FName,
                LName: clinicalEngineer.LName,
                DSSN: clinicalEngineer.DSSN
            }));

            Equipment.findAll({
                include: [{ model: Department }]
            }).then(equipments => {
                const eq = equipments.map(equipment => ({
                    Code: equipment.Code,
                    Name: equipment.Name,
                    DepartmentName: equipment.Department ? equipment.Department.Name : 'Unknown Department'
                }));

                res.render('workOrder', {
                    pageTitle: 'Work Orders',
                    WorkOrder: true,
                    Workorders: wd,
                    hasWorkOrder: wd.length > 0,
                    WO: true,
                    Engineers: en,
                    Equipments: eq
                });
            }).catch(err => {
                console.error("Error fetching equipments:", err);
                res.render('error', {
                    layout: false,
                    pageTitle: 'Error',
                    href: '/home',
                    message: 'Sorry !!! Could Not Get Equipments'
                });
            });
        }).catch(err => {
            console.error("Error fetching clinical engineers:", err);
            res.render('error', {
                layout: false,
                pageTitle: 'Error',
                href: '/home',
                message: 'Sorry !!! Could Not Get Clinical Engineers'
            });
        });
    }).catch(err => {
        console.error("Error fetching work orders:", err);
        res.render('error', {
            layout: false,
            pageTitle: 'Error',
            href: '/home',
            message: 'Sorry !!! Could Not Get Work Orders'
        });
    });
};




exports.breakDown=(req,res)=>{
    BreakDown.findAll({include:[{model:Equipment,include:[{model:Department}]}]}).then(breakdowns => {
        const bd = breakdowns.map(breakD => {
                  return {
                    Code:breakD.Code,
                    Reason:breakD.Reason,
                    DATE: formatDate(breakD.DATE),
                    EquipmentCode:breakD.EquipmentCode,
                    EquipmentName:breakD.Equipment.Name,
                    EquipmentImage:breakD.Equipment.Image,
                    Department:breakD.Equipment.Department.Name
                  }
                })
        Equipment.findAll({include:[{model:Department}]}).then(equipments => {
            const eqs = equipments.map(equipment => {
                return{
                    Name:equipment.Name,
                    Code:equipment.Code,
                    Department:equipment.Department.Name
                }
            })
        res.render('breakDown',{pageTitle:'BreakDown',BreakDown:true,breakDowns:bd,
                                    hasBreakDown:bd.length>0,Equipments:eqs});
        })

    }).catch(err => {
        if(err)
        res.render('error',{layout:false,pageTitle:'Error',href:'/home',message:'Sorry !!! Could Not Get BreakDowns'})
    })
}

/*
exports.equipment=(req,res)=>{
    Equipment.findAll({
        include:[{model:Department},{model:AgentSupplier}]
        }).then(equipments => {
        const eq = equipments.map(equipment => {
                  return {
                    Code: equipment.Code,
                    Name: equipment.Name,
                    Cost: equipment.Cost,
                    PM:equipment.PM,
                    Image:equipment.Image,
                    InstallationDate: equipment.InstallationDate,
                    ArrivalDate:equipment.ArrivalDate,
                    WarrantyDate:equipment.WarrantyDate,
                    Model:equipment.Model,
                    SerialNumber:equipment.SerialNumber,
                    Manufacturer:equipment.Manufacturer,
                    Location:equipment.Location,
                    Notes:equipment.Notes,
                    DepartmentCode:equipment.Department.dataValues.Name,
                    AgentSupplierId:equipment.AgentSupplier.dataValues.Name
                  }
                })

            AgentSupplier.findAll().then(agents => {
                const ag = agents.map(agent => {
                    return {
                        Name:agent.Name,
                        Id:agent.Id
                    }
                })        
        res.render('equipment',{pageTitle:'Equipment',Equipment:true,
                                equipments:eq,hasEquipments:eq.length>0,Agents:ag});
            })  
            
            Department.findAll().then(depats => {
                const dp = depats.map(depart => {
                    return {
                        Name:depart.Name,
                        Code:depart.Code
                    }
                })        
        res.render('equipment',{pageTitle:'Equipment',Equipment:true,
                                equipments:eq,hasEquipments:eq.length>0,Departs:dp});
            }) 



    }).catch( err => {
        if(err)
         res.render('error',{layout:false,pageTitle:'Error',href:'/home',message:'Sorry !!! Could Not Get Equipments'})
        })


   
}
*/

exports.equipment = (req, res) => {
    Promise.all([
        Equipment.findAll({ include: [{ model: Department }, { model: AgentSupplier }] }),
        AgentSupplier.findAll(),
        Department.findAll()
    ]).then(([equipments, agents, depats]) => {
        const eq = equipments.map(equipment => {
            return {
                Code: equipment.Code,
                Name: equipment.Name,
                Cost: equipment.Cost,
                PM: equipment.PM,
                Image: equipment.Image,
                InstallationDate: formatDate(equipment.InstallationDate),
                ArrivalDate: formatDate(equipment.ArrivalDate),
                WarrantyDate: equipment.WarrantyDate,
                Model: equipment.Model,
                SerialNumber: equipment.SerialNumber,
                Manufacturer: equipment.Manufacturer,
                Location: equipment.Location,
                Notes: equipment.Notes,
                Eqcontrat : equipment.Eqcontrat,
                Observation : equipment.Observation,
                DepartmentCode: equipment.Department ? equipment.Department.dataValues.Name : 'N/A',
                AgentSupplierId: equipment.AgentSupplier ? equipment.AgentSupplier.dataValues.Name : 'N/A'
            }
        });

        const ag = agents.map(agent => {
            return {
                Name: agent.Name,
                Id: agent.Id
            }
        });

        const dp = depats.map(depart => {
            return {
                Name: depart.Name,
                Code: depart.Code
            }
        });

        res.render('equipment', {
            pageTitle: 'Equipment',
            Equipment: true,
            equipments: eq,
            hasEquipments: eq.length > 0,
            Agents: ag,
            Departs: dp
        });
    }).catch(err => {
        console.log("ERROR!!!!!!", err);
        res.render('error', {
            layout: false,
            pageTitle: 'Error',
            href: '/home',
            message: 'Sorry !!! Could Not Get Equipments'
        });
    });
}



exports.installation = (req, res) => {
    Equipment.findAll({
        include: [
            { model: Department },
            { model: AgentSupplier }
        ]
    }).then(equipments => {
        const eq = equipments.map(equipment => {
            return {
                Code: equipment.Code,
                Name: equipment.Name,
                Cost: equipment.Cost,
                PM: equipment.PM,
                Image: equipment.Image,
                InstallationDate: equipment.InstallationDate,
                ArrivalDate: equipment.ArrivalDate,
                WarrantyDate: equipment.WarrantyDate,
                Model: equipment.Model,
                SerialNumber: equipment.SerialNumber,
                Manufacturer: equipment.Manufacturer,
                Location: equipment.Location,
                Notes: equipment.Notes,
                Eqcontrat : equipment.Eqcontrat,
                Observation : equipment.Observation,
                DepartmentCode: equipment.Department ? equipment.Department.dataValues.Name : 'Unknown Department',
                AgentSupplierId: equipment.AgentSupplier ? equipment.AgentSupplier.dataValues.Name : 'Unknown Supplier'
            }
        });

        res.render('installationTable', {
            pageTitle: 'Installation',
            Reports: true,
            reports: eq,
            hasReports: eq.length > 0
        });
    }).catch(err => {
        console.log(err);
        res.render('error', {
            layout: false,
            pageTitle: 'Error',
            href: '/',
            message: 'Sorry !!! Could Not Get Reports'
        });
    });
};



exports.ppm=(req,res) =>{
PPM.findAll({include:[{model:Equipment,include:[{model:PpmQuestions}]},{model:ClinicalEngineer}]}).then(reports => {
    const reps=reports.map(report =>{
        return {
        Code:report.Code,
        DATE:report.DATE,
        Engineer:report.ClinicalEnginner.FName+' '+report.ClinicalEnginner.LName,
        EquipmentName:report.Equipment.Name,
        EquipmentCode:report.Equipment.Code,
        EquipmentModel:report.Equipment.Model,
        Qs:report.Equipment.PpmQuestion,
        Q1: report.Q1 == "on" ? true: false,
        Q2: report.Q2 == "on" ? true: false,
        Q3: report.Q3 == "on" ? true: false,
        Q4: report.Q4 == "on" ? true: false,
        Q5: report.Q5 == "on" ? true: false,
        N1:report.N1,
        N2:report.N2,
        N3:report.N3,
        N4:report.N4,
        N5:report.N5
        }
    })
    res.render('ppmReportTable',{pageTitle:'PPM',
        Reports:true,reports:reps,hasReports:reps.length>0,rep:true })   
    
}).catch(err => {
    res.render('error',{layout:false,pageTitle:'Error',href:'/home',message:'Sorry !!! Could Not Get Reports'})

})
}

exports.dailyInspection=(req,res)=>{
 DailyInspection.findAll({include:[{model:Equipment},{model:ClinicalEngineer}]})
 .then(reports => {
    const reps=reports.map(report => {
        return{
            Code:report.Code,
            DATE:report.DATE,
            Engineer:report.ClinicalEnginner.FName +' '+ report.ClinicalEnginner.LName ,
            Equipment:report.Equipment.Name,
            eq:true,
            EquipmentModel:report.Equipment.Model
        }

 })
 res.render('dialyinspectionTable',{pageTitle:'Daily Inspection',
    Reports:true,eq:true,reports:reps,hasReports:reps.length>0 })  
}).catch(err => {
    res.render('error',{layout:false,pageTitle:'Error',href:'/',message:'Sorry !!! Could Not Get Report'})

})

}



exports.workorder = (req, res) => {
    const dssn = req.session.DSSN;

    WorkOrder.findAll({ where: { ClinicalEnginnerDSSN: dssn } }).then(orders => {
        const events = orders.map(order => {
            return {
                title: order.Description,
                color: order.Priority === 'Low' ? 'green' : order.Priority === 'High' ? 'red' : 'blue',
                start: `${order.StartDate.split('-').reverse().join('/')}T00:00:00Z`,
                end: `${order.EndDate.split('-').reverse().join('/')}T23:59:59Z`,
                url: `/engineer/workOrder/description/${order.Code}`
            };
        });

        

        ClinicalEngineer.findByPk(dssn).then(engineer => {
            const Engineer = {
                Image: engineer ? engineer.Image : 'default_image_path',
                FName: engineer ? engineer.FName : 'N/A',
                LName: engineer ? engineer.LName : 'N/A'
            };

            res.render('calender', {
                layout: false,
                WO: true,
                events: events,
                pageTitle: 'Calendar',
                Engineer: Engineer
            });
        }).catch(err => {
            console.error("Error fetching engineer:", err);
            res.render('error', {
                layout: false,
                pageTitle: 'Error',
                href: '/',
                message: 'Could not fetch clinical engineer details.',
            });
        });
    }).catch(err => {
        console.error("Error fetching work orders:", err);
        res.render('error', {
            layout: false,
            pageTitle: 'Error',
            href: '/',
            message: 'Could not fetch work orders.',
        });
    });
};




exports.workorderDescription = (req, res) => {
    const code = req.params.code;
    const engineerId = req.session.DSSN;

    WorkOrder.findOne({ where: { Code: code }, include: [{ model: Equipment }] }).then(order => {
        if (!order) {
            return res.render('error', {
                layout: false,
                pageTitle: 'Error',
                href: '/',
                message: 'Work order not found.',
            });
        }

        const orderDetails = {
            Code: order.Code,
            EquipmentName: order.Equipment ? order.Equipment.Name : 'N/A',
            EquipmentModel: order.Equipment ? order.Equipment.Model : 'N/A',
            EquipmentCode: order.Equipment ? order.Equipment.Code : 'N/A',
            Priority: order.Priority,
            Cost: order.Cost,
            StartDate: order.StartDate,
            EndDate: order.EndDate,
            AdditionalStartDate: order.AdditionalStartDate,
            AdditionalEndDate: order.AdditionalEndDate,
            Description: order.Description
        };

        ClinicalEngineer.findByPk(engineerId).then(engineer => {
            const Engineer = {
                Image: engineer ? engineer.Image : 'default_image_path',
                FName: engineer ? engineer.FName : 'N/A',
                LName: engineer ? engineer.LName : 'N/A'
            };

            res.render('workOrderDetails', {
                layout: 'clinicalEngineerLayout',
                pageTitle: 'Work Order Details',
                WO: true,
                order: orderDetails,
                Engineer: Engineer
            });
        }).catch(err => {
            console.error("Error fetching engineer:", err);
            res.render('error', {
                layout: false,
                pageTitle: 'Error',
                href: '/',
                message: 'Could not fetch clinical engineer details.',
            });
        });
    }).catch(err => {
        console.error("Error fetching work order:", err);
        res.render('error', {
            layout: false,
            pageTitle: 'Error',
            href: '/',
            message: 'Could not fetch work order details.',
        });
    });
};
