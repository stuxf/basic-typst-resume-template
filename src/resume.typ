// In this fork, I have turned this resume template into a 2-column layout. The left column is for the section title and the right column is for the content. This is beneficial in three ways:
// 1. Frees up vertical space by moving the section title to the left column.
// 2. A typical bullet point ideally is not too long, and should be impactful with words. This layout enforces that.
// 3. It makes the resume look more organized and easier to read.

// TODO: Move the styling to the top of the file into the variables of resume.with() function.
#import "@preview/scienceicons:0.0.6": orcid-icon

#let resume(
  author: "",
  title: "", 
  author-position: left,
  personal-info-position: left,
  pronouns: "",
  location: "",
  email: "",
  github: "",
  linkedin: "",
  phone: "",
  personal-site: "",
  orcid: "",
  accent-color: "#000000",
  font: "Lato", //"New Computer Modern"
  paper: "a4", // "us-letter"
  author-font-size: 18pt,
  title-font-size: 14pt,
  margin-y: 0.2in,
  margin-x: 0.25in,
  body,
) = {

  // Sets document metadata
  set document(author: author, title: author)

  // Document-wide formatting, including font and margins
  set text(
    // LaTeX style font
    font: font,
    size: 10pt,
    lang: "en",
    // Disable ligatures so ATS systems do not get confused when parsing fonts.
    ligatures: false
  )

  // Reccomended to have 0.5in margin on all sides
  set page(
    margin: (y: margin-y, x: margin-x),
    paper: paper,
  )

  // Link styles
  show link: underline

  // Small caps for section titles
  show heading.where(level: 2): it => [
    #pad(top: 0pt, bottom: 0pt, it.body)
    // #line(length: 100%, stroke: 1pt)
  ]

  // Accent Color Styling
  show heading: set text(
    fill: rgb(accent-color),
  )

  show link: set text(
    fill: rgb(accent-color),
  )

  // Name will be aligned left, bold and big
  show heading.where(level: 1): it => [
    #set align(author-position)
    #set text(
      weight: 700,
      size: author-font-size,
    )
    #pad(it.body)
  ]

  // Level 1 Heading
  [= #(author)]

  pad(bottom: -2pt, text(title-font-size, weight: "medium", [#title]))

  // Personal Info Helper
  let contact-item(value, prefix: "", link-type: "", label: "") = {
    if value != "" {
      if link-type != "" {
        if label != "" {
          link(link-type + value)[#(label)]  // supersedes the prefix
        } else {
          link(link-type + value)[#(prefix + value)]
        }
      } else {
        value
      }
    }
  }

  // Personal Info
  pad(
    top: 0em,
    align(personal-info-position)[
      #{
        let items = (
          contact-item(pronouns),
          contact-item(phone),
          contact-item(location),
          contact-item(email, link-type: "mailto:", label: "Email"),
          contact-item(github, link-type: "https://", label: "GitHub"),
          contact-item(linkedin, link-type: "https://", label: "LinkedIn"),
          contact-item(personal-site, link-type: "https://", label: "Personal Website"),
          contact-item(orcid, prefix: [#orcid-icon(color: rgb("#AECD54"))orcid.org/], link-type: "https://orcid.org/"),
        )
        items.filter(x => x != none).join("  |  ")
      }
    ],
  )

  // Main body.
  set par(justify: true)

  body
}

// Generic two by two component for resume
#let generic-two-by-two(
  top-left: "",
  top-right: "",
  bottom-left: "",
  bottom-right: "",
) = {
  [
    #top-left #h(1fr) #top-right \
    #bottom-left #h(1fr) #bottom-right
  ]
}

// Generic one by two component for resume
#let generic-one-by-two(
  left: "",
  right: "",
) = {
  [
    #left #h(1fr) #right
  ]
}

// Cannot just use normal --- ligature because ligatures are disabled for good reasons
#let dates-helper(
  start-date: "",
  end-date: "",
) = {
  start-date + " " + $dash.em$ + " " + end-date
}

// Section components below
#let edu(
  institution: "",
  dates: "",
  degree: "",
  gpa: "",
  location: "",
) = {
  generic-one-by-two(
    left: [#strong(institution) / #degree], 
    right: [#if gpa != "" [GPA: #gpa, ] #if dates != "" [#dates, ] #location]
    // TODO: Change the styling of right-aligned text
  )
}

#let work(
  title: "",
  dates: "",
  company: "",
  location: "",
) = {
  generic-one-by-two(
    left: [#strong(company) / #title], 
    right: [#dates, #location]
    // TODO: Change the styling of right-aligned text
  )
}

#let project(
  role: "",
  name: "",
  url: "",
  dates: "",
) = {
  generic-one-by-two(
    left: {
      if role == "" {
        [*#name* #if url != "" and dates != "" [ (#link("https://" + url)[#url])]]
      } else {
        [*#role*, #name #if url != "" and dates != ""  [ (#link("https://" + url)[#url])]]
      }
    },
    right: {
      if dates == "" and url != "" {
        link("https://" + url)[#url]
      } else {
        dates
      }
    },
  )
}

#let certificates(
  name: "",
  issuer: "",
  url: "",
  date: "",
) = {
  [
    *#name*, #issuer
    #if url != "" {
      [ (#link("https://" + url)[#url])]
    }
    #h(1fr) #date
  ]
}

#let extracurriculars(
  activity: "",
  dates: "",
) = {
  generic-one-by-two(
    left: strong(activity),
    right: dates,
  )
}

// Two-column layout for sections after Summary
#let two-col-section(leftSide, rightSide) = {
  line(length: 100%, stroke: 1pt)
  grid(
    columns: (2fr, 16fr),
    column-gutter: 1em,
    leftSide,
    rightSide,
  )
}

#let add-skill(left, right) = {
  generic-one-by-two(left: left, right: text(fill: gray)[#emph(right)])
}
