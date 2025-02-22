test("GET courses answer proportions", async () => {
  const res = await fetch("http://localhost:3000/dashboard/answerProportion/general/0?year=2022&semester=2");
  expect(res.status).toBe(200);
});

test("GET subject group proportions", async () => {
  const res = await fetch("http://localhost:3000/dashboard/answerProportion/course/0?year=2022&semester=2");
  expect(res.status).toBe(200);
});

test("GET subjects proportions", async () => {
  const res = await fetch("http://localhost:3000/dashboard/answerProportion/subjectGroup/0?year=2022&semester=2");
  expect(res.status).toBe(200);
});

test("GET comments of a subject", async () => {
  const res = await fetch("http://localhost:3000/dashboard/answerProportion/comments/SI700?year=2022&semester=2");
  expect(res.status).toBe(200);
});

test.todo("GET answer proportion without query params");
