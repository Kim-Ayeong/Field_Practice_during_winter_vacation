const port = process.env.port || 81;

const express = require('express');
const bodyParser = require('body-parser');
const path = require('path');
const mysql = require('mysql');

//MySQL 생성
var connection1 = mysql.createConnection({
    host:'localhost',
    user:'root',
    password: '1234',
    database: 'pdxendb'
});
var connection2 = mysql.createConnection({
    host:'localhost',
    user:'root',
    password: '1234',
    database: 'pdxendb2'
});
connection1.connect(); //MySQL 연결
connection2.connect();

const app = express();

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended : true}));

//get : 데이터 조회 등 동적 수행이 필요하지 않을 때,데이터 용량 한정
app.get('/', function(req, res){
 res.sendFile(path.join(__dirname, '/public', 'index_start.html')); //브라우저에 html파일 보내기
 console.log("서버 접속 성공");
});

app.get('/index_lungcancer.html', function(req, res){
 res.sendFile(path.join(__dirname, '/public', 'index_lungcancer.html'));
 console.log("서버 접속 성공");
});

app.get('/index_donor.html', function(req, res){
 res.sendFile(path.join(__dirname, '/public', 'index_donor.html'));
 console.log("서버 접속 성공");
});

app.get('/index_start.html', function(req, res){
 res.sendFile(path.join(__dirname, '/public', 'index_start.html'));
 console.log("서버 접속 성공");
});

//post : 대용량 데이터 송수신 시, 동적 수행이 필요할 경우
//폐암 검사일지 관리시스템
app.post('/upload1', function(req, res){
  var param = [
    req.body.Created,
    req.body.Subject_No,
    req.body.No,
    req.body.Name,
    req.body.Initial,
    req.body.Sex,
    req.body.Age,

    req.body.Diagnosis_date,
    req.body.Diagnosis,
    req.body.Diagnosis_pathology,
    req.body.Surgery_date,
    req.body.Recurrence,
    req.body.Recurrence_date,

    req.body.Lastcare_date,
    req.body.Death_date,
    req.body.EGFR_mutation,
    req.body.ROS1_mutation,
    req.body.ALK_mutation,
    req.body.K_RAS_mutation,
    req.body.Other,
    req.body.Tumor_stage_7th,
    req.body.Tumor_stage_8th,
    req.body.Pathology_location,
    req.body.Pathology_size_mm,
    req.body.Pathology_visceral_pleural,
    req.body.Pathology_resection_margion_fullterm,
    req.body.Pathology_lymph_node,
    req.body.Pathology_lymphovascular_invasion,
    req.body.Pathology_differentiation,
    req.body.Tobacco_smoking_history_indicator,
    req.body.Year_of_tobacco_smoking_onset,
    req.body.Year_of_tobacco_smoking_cessation,
    req.body.Regimen,

    req.body.Start_date,
    req.body.Last_date,
    req.body.Cycle_No,
    req.body.Recurrence_Progressive_disease,
    req.body.Recurrence_date_,
    req.body.Regimen_,
    req.body.RT,

    req.body.Examine_date,
    req.body.Cycle_No_,
    req.body.WBC,
    req.body.Hg,
    req.body.Hct,
    req.body.PLT,
    req.body.Seg_neutrophil,
    req.body.Lymphocyte,
    req.body.ANC,
    req.body.Sodium,
    req.body.Potassium,
    req.body.Chloride,
    req.body.Osmolality_serum,
    req.body.Calcium,
    req.body.Phosphorus,
    req.body.BUN,
    req.body.Creatinine,
    req.body.Glucose,
    req.body.Uric_acid,
    req.body.Cholesterol,
    req.body.Protein_Total,
    req.body.Albumin,
    req.body.Bilirubin_total,
    req.body.Alkaline_phosphatase,
    req.body.AST,
    req.body.ALT,
    req.body.eGFR_MDRD,
    req.body.eGFR_CKD_EPI,
    req.body.LDH
  ];
  connection1.query('insert into mytable(created, subject_no, no, name, initial, sex, age, diagnosis_date, diagnosis, diagnosis_pathology, surgery_date, recurrence, recurrence_date, lastcare_date, death_date, egfr_mutation, ros1_mutation, alk_mutation, k_ras_mutation, other, tumor_stage_7th, tumor_stage_8th, pathology_location, pathology_size_mm, pathology_visceral_pleural, pathology_resection_margion_fullterm, pathology_lymph_node, pathology_lymphovascular_invasion, pathology_differentiation, tobacco_smoking_history_indicator, year_of_tobacco_smoking_onset, year_of_tobacco_smoking_cessation, regimen, start_date, last_date, cycle_no, recurrence_progressive_disease, recurrence_date_, regimen_, rt, examine_date, cycle_no_, wbc, hg, hct, plt, seg_neutrophil, lymphocyte, anc, sodium, potassium, chloride, osmolality_serum, calcium, phosphorus, bun, creatinine, glucose, uric_acid, cholesterol, protein_total, albumin, bilirubin_total, alkaline_phosphatase, ast, alt, egfr_mdrd, egfr_ckd_epi, ldh) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)',
  param, function(err, rows, fields){
       if(err){
         console.log(err);
       } else {
         console.log("DB 업로드 성공");
       }
  });
  res.send('true');
});

app.post('/view1',function(req, res) {
  connection1.query('select * from mytable', function(err, rows, fields){
    var resultData = []
    if(err){
      console.log(err);
    } else{
      for (var i=0; i<rows.length; i++) {
        resultData.push(rows[i]);
      }
      console.log("데이터 확인/검색 탭으로 DB 전송 성공");
    }
    res.json(resultData);
  });
});

//Donor 정보 관리시스템
app.post('/upload2', function(req, res){ //작성 완료 클릭
  var param = [
    req.body.created,
    req.body.identification,
    req.body.name,
    req.body.race,
    req.body.sex,
    req.body.age,
    req.body.resident_no,
    req.body.address,
    req.body.phone,
    req.body.suitable,
    req.body.cell_origin,
    req.body.doctor_hospital,
    req.body.doctor_department,
    req.body.doctor_name,
    req.body.surgery_date,
    req.body.amount,
    req.body.charge_pdxen,
    req.body.charge_hospital,
    req.body.consent_date,
    req.body.evaluate_date,

    req.body.check_1,
    req.body.check_1_note,
    req.body.check_2,
    req.body.check_2_note,
    req.body.check_3,
    req.body.check_3_note,
    req.body.check_4,
    req.body.check_4_note,
    req.body.check_5,
    req.body.check_5_note,
    req.body.check_6,
    req.body.check_6_note,

    req.body.blood_test_1,
    req.body.blood_test_2,
    req.body.blood_test_3,
    req.body.blood_test_4,
    req.body.blood_test_5,
    req.body.blood_test_6,
    req.body.blood_test_7,
    req.body.blood_test_8,
    req.body.blood_test_9,
    req.body.blood_test_10,
    req.body.blood_test_11,
    req.body.blood_test_12,
    req.body.blood_test_13,
    req.body.blood_test_14,

    req.body.safety_test_1,
    req.body.safety_test_2,
    req.body.safety_test_3,
    req.body.safety_test_4,
    req.body.safety_test_5,
    req.body.safety_test_6,
    req.body.safety_test_7,
    req.body.safety_test_8,
    req.body.safety_test_9,
    req.body.safety_test_10,
    req.body.safety_test_11,

    req.body.page1,
    req.body.page2,
    req.body.page3,
    req.body.page4,
    req.body.page5
  ];
  connection2.query('insert into mytable(created, identification, name, race, sex, age, resident_no, address, phone, suitable, cell_origin, doctor_hospital, doctor_department, doctor_name, surgery_date, amount, charge_pdxen, charge_hospital, consent_date, evaluate_date, check_1, check_1_note, check_2, check_2_note, check_3, check_3_note, check_4, check_4_note, check_5, check_5_note, check_6, check_6_note, blood_test_1, blood_test_2, blood_test_3, blood_test_4, blood_test_5, blood_test_6, blood_test_7, blood_test_8, blood_test_9, blood_test_10, blood_test_11, blood_test_12, blood_test_13, blood_test_14, safety_test_1, safety_test_2, safety_test_3, safety_test_4, safety_test_5, safety_test_6, safety_test_7, safety_test_8, safety_test_9, safety_test_10, safety_test_11, page1, page2, page3, page4, page5) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)',
  param, function(err, rows, fields){
       if(err){
         console.log(err);
         res.send('false');
       } else {
         console.log("DB 업로드 성공");
         res.send('true');
       }
  });
});

app.post('/view2', function(req, res) { //로딩 시 DB 전송
  connection2.query('select * from mytable', function(err, rows, fields){
    var resultData = []
    if(err){
      console.log(err);
    } else{
      for (var i=0; i<rows.length; i++) {
        resultData.push(rows[i]);
      }
      console.log("첫 화면으로 DB 전송 성공");
    }
    res.json(resultData);
  });
});

app.post('/info2-1', function(req, res) { //자세히 보기 클릭
  var index = req.body.data
  connection2.query(`select * from mytable limit 1 offset ${index}`, function(err, rows, fields){
    if(err){
      console.log(err);
    } else{
      res.json(rows);
      console.log("자세히 보기 화면으로 DB 전송 성공");
    }
  });
});

app.post('/info2-2', function(req, res) { //수정 클릭
  var index = req.body.data
  connection2.query(`select * from mytable limit 1 offset ${index}`, function(err, rows, fields){
    if(err){
      console.log(err);
    } else{
      res.json(rows);
      console.log("수정 화면으로 DB 전송 성공");
    }
  });
});

app.post('/modify2', function(req, res){ //수정 완료 클릭
  var param = [
    req.body.name,
    req.body.race,
    req.body.sex,
    req.body.age,
    req.body.resident_no,
    req.body.address,
    req.body.phone,
    req.body.suitable,
    req.body.cell_origin,
    req.body.doctor_hospital,
    req.body.doctor_department,
    req.body.doctor_name,
    req.body.surgery_date,
    req.body.amount,
    req.body.charge_pdxen,
    req.body.charge_hospital,
    req.body.consent_date,
    req.body.evaluate_date,

    req.body.check_1,
    req.body.check_1_note,
    req.body.check_2,
    req.body.check_2_note,
    req.body.check_3,
    req.body.check_3_note,
    req.body.check_4,
    req.body.check_4_note,
    req.body.check_5,
    req.body.check_5_note,
    req.body.check_6,
    req.body.check_6_note,

    req.body.blood_test_1,
    req.body.blood_test_2,
    req.body.blood_test_3,
    req.body.blood_test_4,
    req.body.blood_test_5,
    req.body.blood_test_6,
    req.body.blood_test_7,
    req.body.blood_test_8,
    req.body.blood_test_9,
    req.body.blood_test_10,
    req.body.blood_test_11,
    req.body.blood_test_12,
    req.body.blood_test_13,
    req.body.blood_test_14,

    req.body.safety_test_1,
    req.body.safety_test_2,
    req.body.safety_test_3,
    req.body.safety_test_4,
    req.body.safety_test_5,
    req.body.safety_test_6,
    req.body.safety_test_7,
    req.body.safety_test_8,
    req.body.safety_test_9,
    req.body.safety_test_10,
    req.body.safety_test_11,

    req.body.page1,
    req.body.page2,
    req.body.page3,
    req.body.page4,
    req.body.page5,

    req.body.identification
  ];
  connection2.query('update mytable set name=?, race=?, sex=?, age=?, resident_no=?, address=?, phone=?, suitable=?, cell_origin=?, doctor_hospital=?, doctor_department=?, doctor_name=?, surgery_date=?, amount=?, charge_pdxen=?, charge_hospital=?, consent_date=?, evaluate_date=?, check_1=?, check_1_note=?, check_2=?, check_2_note=?, check_3=?, check_3_note=?, check_4=?, check_4_note=?, check_5=?, check_5_note=?, check_6=?, check_6_note=?, blood_test_1=?, blood_test_2=?, blood_test_3=?, blood_test_4=?, blood_test_5=?, blood_test_6=?, blood_test_7=?, blood_test_8=?, blood_test_9=?, blood_test_10=?, blood_test_11=?, blood_test_12=?, blood_test_13=?, blood_test_14=?, safety_test_1=?, safety_test_2=?, safety_test_3=?, safety_test_4=?, safety_test_5=?, safety_test_6=?, safety_test_7=?, safety_test_8=?, safety_test_9=?, safety_test_10=?, safety_test_11=?, page1=?, page2=?, page3=?, page4=?, page5=? where identification=?',
  param, function(err, rows, fields){
    if(err){
       console.log(err);
       res.send('false');
    } else {
       console.log("DB 수정 성공");
       res.send('true');
    }
  });
});

app.post('/delete2', function(req, res){ //삭제 클릭
  var identification = req.body.identification
  connection2.query(`delete from mytable where identification='${identification}'`, function(err, rows, fields){
    if(err){
      console.log(err);
      res.send('false')
    } else{
      console.log("DB 삭제 성공");
      res.send('true');
    }
  });
});

app.listen(port, function () {
    console.log(`listening ${port} port.`);
})
