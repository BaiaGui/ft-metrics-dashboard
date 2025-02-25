test("GET courses answer proportions", async () => {
  const res = await fetch("http://localhost:3000/dashboard/answerProportion/general/0?year=2022&semester=2");
  expect(res.status).toBe(200);

  const resData = await res.json();
  expect(resData).toHaveProperty("proportionGroup");
  for (const semesterChart of resData.proportionGroup) {
    expect(semesterChart).toHaveProperty("id");
    expect(typeof semesterChart.id).toBe("string");

    expect(semesterChart).toHaveProperty("description");
    expect(typeof semesterChart.description).toBe("string");

    expect(semesterChart).toHaveProperty("proportion");
    expect(typeof semesterChart.proportion).toBe("object");
  }
});

test("GET subject group proportions", async () => {
  const res = await fetch("http://localhost:3000/dashboard/answerProportion/course/0?year=2022&semester=2");
  expect(res.status).toBe(200);
  const resData = await res.json();
  expect(resData).toHaveProperty("proportionGroup");
  for (const semesterChart of resData.proportionGroup) {
    expect(semesterChart).toHaveProperty("id");
    expect(typeof semesterChart.id).toBe("string");

    expect(semesterChart).toHaveProperty("description");
    expect(typeof semesterChart.description).toBe("string");

    expect(semesterChart).toHaveProperty("proportion");
    expect(typeof semesterChart.proportion).toBe("object");
  }
});

test("GET subjects proportions", async () => {
  const res = await fetch("http://localhost:3000/dashboard/answerProportion/subjectGroup/0?year=2022&semester=2");
  expect(res.status).toBe(200);
  const resData = await res.json();
  expect(resData).toHaveProperty("proportionGroup");
  for (const semesterChart of resData.proportionGroup) {
    expect(semesterChart).toHaveProperty("id");
    expect(typeof semesterChart.id).toBe("string");

    expect(semesterChart).toHaveProperty("description");
    expect(typeof semesterChart.description).toBe("string");

    expect(semesterChart).toHaveProperty("proportion");
    expect(typeof semesterChart.proportion).toBe("object");
  }
});

test("GET form questions proportion", async () => {
  const res = await fetch("http://localhost:3000/dashboard/answerProportion/subject/SI700?year=2022&semester=2");
  expect(res.status).toBe(200);
  const resData = await res.json();
  expect(resData).toHaveProperty("proportionGroup");
  for (const semesterChart of resData.proportionGroup) {
    expect(semesterChart).toHaveProperty("id");
    expect(typeof semesterChart.id).toBe("string");

    expect(semesterChart).toHaveProperty("description");
    expect(typeof semesterChart.description).toBe("string");

    expect(semesterChart).toHaveProperty("proportion");
    expect(typeof semesterChart.proportion).toBe("object");
  }
});

test("GET comments of a subject", async () => {
  const res = await fetch("http://localhost:3000/dashboard/answerProportion/comments/SI700?year=2022&semester=2");
  expect(res.status).toBe(200);
  const resData = await res.json();
  expect(resData).toHaveProperty("question25");

  expect(resData).toHaveProperty("question26");
});

test.todo("GET answer proportion without query params");
