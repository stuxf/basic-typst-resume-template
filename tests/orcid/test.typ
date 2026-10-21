#import "../../src/lib.typ": *

#show: resume.with(
  author: "ORCID Example",
  orcid: "0000-0002-1825-0097",
  email: "researcher@example.org",
)

== Research

#work(
  title: "Researcher",
  company: "Example University",
  dates: dates-helper(start-date: "2023", end-date: "Present"),
)

The ORCID icon and identifier must render as a linked contact item.
