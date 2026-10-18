<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
  xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
  <sch:pattern>
    <sch:rule context="gloss | ukrainian | lingText | lingExplanation">
      <sch:report test="string-length(normalize-space(.)) ne 0 and starts-with(., ' ')">A
          <sch:value-of select="name(.)"/> element must not begin with a space
        character.</sch:report>
      <sch:report test="
          string-length(normalize-space(.)) ne 0 and
          ends-with(., ' ') and
          node()[last()][normalize-space(.) ne '']">A <sch:value-of select="name(.)"/> element
        must not end with a space character.</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern>
    <sch:rule context="text()">
      <sch:report test="matches(., '\s[,.]')">Comma and period must not be preceded immediately by
        whitespace</sch:report>
      <sch:report test='contains(., "&apos;")'>Use curly apostrope (’) instead of straing
        (').</sch:report>
      <sch:report test="not(following-sibling::node()) and matches(., '\S\s+$')">A text node not
        followed by a sibling node that contains non-space characters must not end in space
        characters.</sch:report>
    </sch:rule>
    <sch:rule context="ukrainian">
      <sch:assert test="matches(., '^[ :’,!…\n\(\)\-&#x0301;\p{IsCyrillic}]+$')">A &lt;ukrainian&gt;
        element must contain only Cyrillic characters and selected punctuation</sch:assert>
      <sch:report test="following-sibling::node()[1][self::text()][matches(., '^[\isLetter]')]">A
        &lt;ukrainian&gt; element must not be followed immediately by a letter.</sch:report>
    </sch:rule>
    <sch:rule context="gloss">
      <sch:assert test="matches(., '[\p{IsBasicLatin}]')">A &lt;gloss&gt; element must contain at
        least some Latin characters</sch:assert>
    </sch:rule>
    <sch:rule context="lingText">
      <sch:report test="ends-with(., ' ')">&lt;lingText&gt; must not end in a space
        character</sch:report>
      <sch:assert test="matches(., '^[ :’,!…\n\(\)\-&#x0301;\p{IsCyrillic}]+$')">A &lt;lingText&gt;
        element must contain only Cyrillic characters and selected punctuation</sch:assert>
    </sch:rule>
    <sch:rule context="lingExplanation">
      <sch:let name="last" value="node()[last()][self::text()]"/>
      <sch:report test="ends-with($last, ' ') and not(matches($last, '^\n +$'))"
        >&lt;lingExplanation&gt; must not end in space characters the entire node is one newline
        followed by spaces</sch:report>
      <sch:report test="ukrainian[not(preceding-sibling::node())] = preceding-sibling::lingText"
        >Don’t repeat the &lt;lingText&gt; at the beginning of the
        &lt;lingExplanation&gt;</sch:report>
    </sch:rule>
  </sch:pattern>
</sch:schema>
