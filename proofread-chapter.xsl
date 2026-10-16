<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/1999/xhtml"
  xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
  version="3.0">
  <!-- ================================================================== -->
  <!-- Transform single chapter of Instytutka to XHTML 5 for proofreading -->
  <!-- ================================================================== -->
  <xsl:output method="xhtml" version="1.0" html-version="5.0" indent="no" include-content-type="no"/>
  <!-- ================================================================== -->
  <!-- No mode: create superstructure                                     -->
  <!-- ================================================================== -->
  <xsl:template match="/">
    <html>
      <head>
        <title>
          <xsl:value-of select="'Chapter', chapter/@n"/>
        </title>
        <style type="text/css">
          :root {
            background-color: lightyellow;
            color: black;
            --faded: gray;
          }
          body {
            display: flex;
            flex-direction: row;
          }
          #reading {
            flex: 1;
            min-width: 0; /* lets content shrink without overflowing */
          }
          
          #ling {
            flex: 0 0 360px; /* fixed width */
          }
          .ukrainian {
            font-style: italic;
          }
          .abridged {
            color: var(--faded);
          }</style>
      </head>
      <body>
        <section id="reading">
          <xsl:apply-templates mode="reading"/>
        </section>
        <section id="ling">
          <xsl:apply-templates mode="ling" select="descendant::ling"/>
        </section>
      </body>
    </html>
  </xsl:template>
  <!-- ================================================================== -->
  <!-- Reading mode: create reading text, with links to ling              -->
  <!-- ================================================================== -->
  <xsl:template match="ling" mode="reading">
    <xsl:apply-templates select="lingText"/>
  </xsl:template>
  <xsl:template match="lingText" mode="reading">
    <xsl:apply-templates/>
  </xsl:template>
  <!-- ================================================================== -->
  <!-- Ling mode: create ling panel, with links back to reading           -->
  <!-- ================================================================== -->
  <xsl:template match="ling" mode="ling">
    <p>
      <xsl:apply-templates mode="ling"/>
    </p>
  </xsl:template>
  <xsl:template match="lingText" mode="ling">
    <b>
      <xsl:apply-templates/>
    </b>
  </xsl:template>
  <!-- ================================================================== -->
  <!-- All modes                                                          -->
  <!-- ================================================================== -->
  <xsl:template mode="#all" match="p">
    <p>
      <xsl:if test="@abridgement eq 'true'">
        <xsl:attribute name="class" select="'abridged'"/>
      </xsl:if>
      <xsl:apply-templates mode="#current"/>
    </p>
  </xsl:template>
  <xsl:template mode="#all" match="ukrainian">
    <span class="ukrainian">
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  <xsl:template mode="#all" match="gloss">
    <xsl:text>‘</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>’</xsl:text>
  </xsl:template>

</xsl:stylesheet>
