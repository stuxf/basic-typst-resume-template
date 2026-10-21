#import "../../src/lib.typ": *

#show: resume.with(
  author: "Exemple de CV",
  paper: "a4",
  lang: "fr",
  font-size: 11pt,
  author-font-size: 24pt,
  author-position: center,
  personal-info-position: center,
  accent-color: "#26428b",
  location: "Paris, France",
  phone: "+33 1 23 45 67 89",
  github: "github.com/example",
  linkedin: "linkedin.com/in/example",
  personal-site: "example.org",
)

== Formation

#edu(
  institution: "Université Exemple",
  degree: "Informatique",
  location: "Paris",
  dates: dates-helper(end-date: "2024"),
  consistent: true,
)

== Activités

#extracurriculars(activity: "Logiciel libre", dates: "2024")
