#import "@preview/scienceicons:0.1.0": orcid-icon, email-icon, github-icon, linkedin-icon, website-icon, mastodon-icon, bluesky-icon

#let resume(
  author: "",
  author-position: left,
  personal-info-position: left,
  pronouns: "",
  location: "",
  email: "",
  github: "",
  linkedin: "",
  mastodon: "",
  codeberg: "",
  /// the dblp PID like "l/YannLeCun" or "92/1378-1".
  dblp:"",
  phone: "",
  personal-site: "",
  orcid: "",
  accent-color: "#000000",
  font: "New Computer Modern",
  paper: "us-letter",
  author-font-size: 20pt,
  font-size: 10pt,
  lang: "en",
  body,
) = {

  // Sets document metadata
  set document(author: author, title: author)

  // Document-wide formatting, including font and margins
  set text(
    // LaTeX style font
    font: font,
    size: font-size,
    lang: lang,
    // Disable ligatures so ATS systems do not get confused when parsing fonts.
    ligatures: false
  )

  // Reccomended to have 0.5in margin on all sides
  set page(
    margin: (0.5in),
    paper: paper,
  )

  // Link styles
  show link: underline


  // Small caps for section titles
  show heading.where(level: 2): it => [
    #pad(top: 0pt, bottom: -10pt, [#smallcaps(it.body)])
    #line(length: 100%, stroke: 1pt)
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

  /// add a collection of `prefixes` to `value`; if `value` already start with prefix, do nothing
  let safe-prefix(prefixes, value) = {

    // first remove all the prefixes from the value, until fail.
    for prefix in prefixes {
      let new_val = value.trim(prefix, at: start, repeat: false)
      // terminate upon failure
      if new_val == value { break }
      value = new_val
    }

    // recover prefixes
    prefixes.join("") + value

  }

  /// Personal Info Helper
  let contact-item(
    value, 
    /// icon of the field
    icon:[], 
    /// prefix of the input text
    text-prefix: "", 
    /// type of the url, like `"mailto:"` or `https://`
    link-type: "", 
    /// the website of the link, like `orcid.org` or `github.com`
    link-prefix: "") = {
    if value != "" {
      // icon cannot be prefixed, because `safe-prefix` expect string, not content.
      let text = icon + [~] + safe-prefix((text-prefix,), value)

      if link-type != "" {
        // the nested prefix with is essential
        // if the user input `xxx`, `github.com/xxx`, or `https://github.com/xxx` will all link to the correct github account.
        link(safe-prefix((link-prefix, link-type), value))[#text]
      } else {
        text
      }
    }
  }

  // Personal Info
  pad(
    top: 0.25em,
    align(personal-info-position)[
      #{
        let items = (
          contact-item(pronouns),
          contact-item(phone, link-type: "tel:"),
          contact-item(location),
          contact-item(email, icon: [#email-icon()], link-type: "mailto:"),
          contact-item(github, icon: [#github-icon()], link-type: "https://", link-prefix: "github.com/"),
          contact-item(linkedin, icon: [#linkedin-icon(color: rgb("#0072b1"))], link-type: "https://", link-prefix: "linkedin.com/"),
          contact-item(mastodon, icon: [#mastodon-icon(color: rgb("#6364ff"))], link-type: "https://"),
          contact-item(dblp, text-prefix: "dblp.org/pid", link-type: "https://", link-prefix: "dblp.org/pid/"),
          contact-item(codeberg, link-type: "https://", text-prefix: "codeberg.com/", link-prefix: "codeberg.com"),
          contact-item(personal-site, icon: [#website-icon()], link-type: "https://"),
          contact-item(orcid, icon: [#orcid-icon(color: rgb("#AECD54"))], link-type: "https://", link-prefix: "orcid.org/"),
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
  if start-date == "" {
    end-date
  } else {
    start-date + " " + sym.dash.em + " " + end-date
  }
}

// Section components below
#let edu(
  institution: "",
  dates: "",
  degree: "",
  gpa: "",
  location: "",
  // Makes dates on upper right like rest of components
  consistent: false,
) = {
  if consistent {
    // edu-constant style (dates top-right, location bottom-right)
    generic-two-by-two(
      top-left: strong(institution),
      top-right: dates,
      bottom-left: emph(degree),
      bottom-right: emph(location),
    )
  } else {
    // original edu style (location top-right, dates bottom-right)
    generic-two-by-two(
      top-left: strong(institution),
      top-right: location,
      bottom-left: emph(degree),
      bottom-right: emph(dates),
    )
  }
}

#let work(
  title: "",
  dates: "",
  company: "",
  location: "",
) = {
  generic-two-by-two(
    top-left: strong(title),
    top-right: dates,
    bottom-left: company,
    bottom-right: emph(location),
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
