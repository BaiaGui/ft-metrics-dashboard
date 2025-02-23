test("GET General Survey Overview", async () => {
  const res = await fetch("http://localhost:3000/dashboard/surveyOverview/general/0?year=2022&semester=2");
  expect(res.status).toBe(200);
  const resData = await res.json();
  expect(resData).toHaveProperty("time");
  expect(resData).toHaveProperty("totalEnrolled");
  expect(resData).toHaveProperty("totalRespondents");
  expect(resData).toHaveProperty("surveyParticipation");
  expect(resData).toHaveProperty("averageIndex");
});

test("GET Course Survey Overview", async () => {
  const res = await fetch("http://localhost:3000/dashboard/surveyOverview/course/0?year=2022&semester=2");
  expect(res.status).toBe(200);
  const resData = await res.json();
  expect(resData).toHaveProperty("time");
  expect(resData).toHaveProperty("totalEnrolled");
  expect(resData).toHaveProperty("totalRespondents");
  expect(resData).toHaveProperty("surveyParticipation");
  expect(resData).toHaveProperty("averageIndex");
});

test("GET Subject Group Survey Overview", async () => {
  const res = await fetch("http://localhost:3000/dashboard/surveyOverview/subjectGroup/0?year=2022&semester=2");
  expect(res.status).toBe(200);
  const resData = await res.json();
  expect(resData).toHaveProperty("time");
  expect(resData).toHaveProperty("totalEnrolled");
  expect(resData).toHaveProperty("totalRespondents");
  expect(resData).toHaveProperty("surveyParticipation");
  expect(resData).toHaveProperty("averageIndex");
});

test("GET Subject Survey Overview", async () => {
  const res = await fetch("http://localhost:3000/dashboard/surveyOverview/subject/SI700?year=2022&semester=2");
  expect(res.status).toBe(200);
  const resData = await res.json();
  expect(resData).toHaveProperty("time");
  expect(resData).toHaveProperty("totalEnrolled");
  expect(resData).toHaveProperty("totalRespondents");
  expect(resData).toHaveProperty("surveyParticipation");
  expect(resData).toHaveProperty("averageIndex");
});
