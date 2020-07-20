<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:mei="http://www.music-encoding.org/ns/mei"
  xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
  xmlns="http://www.music-encoding.org/ns/mei"
  exclude-result-prefixes="xs xd"
  version="2.0">
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p><xd:b>Created on:</xd:b> Sep 25, 2018</xd:p>
      <xd:p><xd:b>Author:</xd:b> bwb</xd:p>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  
  <xsl:output indent="yes" omit-xml-declaration="yes" exclude-result-prefixes="mei" xpath-default-namespace="http://www.music-encoding.org/ns/mei"/>
  
  <xsl:template match="/">
    <xsl:element name="root" namespace="http://www.music-encoding.org/ns/mei">
      <xsl:for-each select="//mei:category[@xml:id='bazga.annotation.category']//mei:category">
        <xsl:element name="term" namespace="http://www.music-encoding.org/ns/mei">
          <xsl:attribute name="classcode">ediromCategory</xsl:attribute>
          <xsl:attribute name="xml:id" select="@xml:id"></xsl:attribute>
          <xsl:element name="name">
            <xsl:attribute name="xml:lang">de</xsl:attribute>
            <xsl:value-of select="mei:label[@xml:lang='de']"/>
          </xsl:element>
        </xsl:element>
        <!--<term classcode="ediromCategory" xml:id="bazga.annotation.category.timbre">
          <name xml:lang="de">Klangfarbe</name>
        </term>-->
      </xsl:for-each>
      
      <xsl:for-each select="//mei:category[@xml:id='bazga.annotation.class']//mei:category">
        <xsl:element name="term" namespace="http://www.music-encoding.org/ns/mei">
          <xsl:attribute name="classcode">ediromCategory</xsl:attribute>
          <xsl:attribute name="xml:id" select="@xml:id"></xsl:attribute>
          <xsl:element name="name">
            <xsl:attribute name="xml:lang">de</xsl:attribute>
            <xsl:value-of select="concat('Klasse:', mei:label[@xml:lang='de'])"/>
          </xsl:element>
        </xsl:element>
        <!--<term classcode="ediromCategory" xml:id="bazga.annotation.category.timbre">
          <name xml:lang="de">Klangfarbe</name>
        </term>-->
      </xsl:for-each>
    </xsl:element>
  </xsl:template>
  
</xsl:stylesheet>