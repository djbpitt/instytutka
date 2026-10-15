<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
  xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
  <sch:pattern>
    <sch:rule context="text()">
      <sch:report test="s[matches(., '\s[,.]')]">Comma and period must not be preceded immediagely
        by whitespace</sch:report>
    </sch:rule>
  </sch:pattern>
</sch:schema>
