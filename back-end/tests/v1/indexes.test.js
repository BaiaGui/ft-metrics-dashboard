test("GET general indexes", async () => {
  const res = await fetch("http://localhost:3000/dashboard/indexes/general/0?year=2022&semester=2");
  expect(res.status).toBe(200);
  const resData = await res.json();
  expect(resData).toHaveProperty("view");
  expect(resData).toHaveProperty("id");
  expect(resData).toHaveProperty("indexInfra");
  expect(resData).toHaveProperty("indexStudent");
  expect(resData).toHaveProperty("indexTeacher");
});

test("GET course indexes", async () => {
  const res = await fetch("http://localhost:3000/dashboard/indexes/course/0?year=2022&semester=2");
  expect(res.status).toBe(200);
  const resData = await res.json();
  expect(resData).toHaveProperty("view");
  expect(resData).toHaveProperty("id");
  expect(resData).toHaveProperty("indexInfra");
  expect(resData).toHaveProperty("indexStudent");
  expect(resData).toHaveProperty("indexTeacher");
});

test("GET subject group indexes", async () => {
  const res = await fetch("http://localhost:3000/dashboard/indexes/subjectGroup/0?year=2022&semester=2");
  expect(res.status).toBe(200);
  const resData = await res.json();
  expect(resData).toHaveProperty("view");
  expect(resData).toHaveProperty("id");
  expect(resData).toHaveProperty("indexInfra");
  expect(resData).toHaveProperty("indexStudent");
  expect(resData).toHaveProperty("indexTeacher");
});

test("GET subject indexes", async () => {
  const res = await fetch("http://localhost:3000/dashboard/indexes/subject/SI700?year=2022&semester=2");
  expect(res.status).toBe(200);
  const resData = await res.json();
  expect(resData).toHaveProperty("view");
  expect(resData).toHaveProperty("id");
  expect(resData).toHaveProperty("indexInfra");
  expect(resData).toHaveProperty("indexStudent");
  expect(resData).toHaveProperty("indexTeacher");
});
