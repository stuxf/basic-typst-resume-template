#import "../../src/lib.typ": *

// An omitted ORCID or contact field must not require an external package.
#show: resume.with(author: "Minimal Resume")

== Education

#edu(institution: "Example University", degree: "Computer Science")

== Projects

#project(name: "Name only")

#project(name: "URL only", url: "example.org")

#project(name: "Dates only", dates: "2024")

#project(name: "URL and dates", url: "example.org", dates: "2024")

#certificates(name: "Certificate", issuer: "Example Institute")

#assert.eq(dates-helper(end-date: "2024"), "2024")
