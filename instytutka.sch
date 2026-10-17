<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
  xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
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
      <sch:assert test="matches(., '[\p{IsCyrillic}]')">A &lt;ukrainian&gt; element must contain
        Cyrillic characters</sch:assert>
    </sch:rule>
    <sch:rule context="lingText">
      <sch:report test="ends-with(., ' ')">&lt;lingText&gt; must not end in a space
        character</sch:report>
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
