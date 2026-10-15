<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/1999/xhtml"
  xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
  version="3.0">
  <!-- ================================================================== -->
  <!-- Transform single chapter of Instytutka to XHTML 5 for proofreading -->
  <!-- ================================================================== -->
  <xsl:output method="xhtml" version="1.0" html-version="5.0" indent="yes" include-content-type="no"/>
  <xsl:template match="/">
    <html>
      <head>
        <title>
          <xsl:value-of select="'Chapter', chapter/@n"/>
        </title>
      </head>
      <body>
        <xsl:apply-templates/>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
