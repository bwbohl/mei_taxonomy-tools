<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
  xmlns:kb="http://zimmermann-gesamtausgabe.de/ns/kb"
  xmlns:mei="http://www.music-encoding.org/ns/mei"
  exclude-result-prefixes="xs xd"
  version="2.0">
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p><xd:b>Created on:</xd:b> Jul 27, 2018</xd:p>
      <xd:p><xd:b>Author:</xd:b> bwb</xd:p>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  
  <xsl:output encoding="UTF-8" omit-xml-declaration="yes"></xsl:output>
  <xsl:character-map name="dot">
    <xsl:output-character character="." string="_"/>
    <xsl:output-character character="-" string="_"/>
  </xsl:character-map>
  <xsl:param name="lang">de</xsl:param>
  
  <!--<xsl:template match="@*|*" mode="pre pre2">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" mode="#current"/>
    </xsl:copy>
  </xsl:template>-->
  
  <!--<xsl:template match="text()" mode="pre2">
    <xsl:analyze-string select="." regex="(\n)?(\s+\n)+">
      <xsl:matching-substring>
        <xsl:value-of select="regex-group(1)"/>
      </xsl:matching-substring>
      <xsl:non-matching-substring>
        <xsl:value-of select="."/>
      </xsl:non-matching-substring>
    </xsl:analyze-string>
  </xsl:template>-->
  
  <xsl:variable name="break">
    <xsl:text>&#xa;</xsl:text>
  </xsl:variable>
  
  <xsl:variable name="indent">
    <xsl:text>  </xsl:text>
  </xsl:variable>
  
  <xsl:template match="/">
    
    <xsl:text>graph G {</xsl:text>
    
    <!-- size -->
    <!--<xsl:value-of select="$break, $indent"/>
    <xsl:text>size ="8,11";</xsl:text>-->
    
    <!-- layout -->
    <xsl:value-of select="$break, $indent"/>
    <xsl:text>layout ="twopi";</xsl:text>
    
    <!-- ratio -->
    <!--<xsl:value-of select="$break, $indent"/>
    <xsl:text>ratio ="compress";</xsl:text>-->
    
    <!-- page -->
    <!--<xsl:value-of select="$break, $indent"/>
    <xsl:text>page ="8.27,11.69";</xsl:text>-->
    
    <!-- orientation -->
    <!--<xsl:value-of select="$break, $indent"/>
    <xsl:text>orientation ="landscape";</xsl:text>-->
    
    <!-- nodesep -->
    <!--<xsl:value-of select="$break, $indent"/>
    <xsl:text>nodesep ="3.0 equally";</xsl:text>-->
    
    <!-- ranksep -->
    <xsl:value-of select="$break, $indent"/>
    <xsl:text>ranksep ="3.0 equally";</xsl:text>
    
    <xsl:for-each select="//@xml:id">
      <xsl:variable name="node" select="parent::*" as="node()"/>
      <xsl:value-of select="$break, $indent"/>
      <xsl:value-of select="translate(., '.-', '_')"/>
      <xsl:text> </xsl:text>
      <xsl:text>[</xsl:text>
      <xsl:text>label = "</xsl:text>
      <xsl:value-of select="if(local-name($node) = 'taxonomy') then($node/mei:head[@xml:lang = $lang]) else($node/mei:label[@xml:lang = $lang])"/>
      <xsl:text>"</xsl:text>
      <xsl:text>]</xsl:text>
      <xsl:text>;</xsl:text>
    </xsl:for-each>
    
    <xsl:for-each select="//@xml:id">
      <xsl:variable name="node" select="parent::*" as="node()"/>
      <xsl:choose>
        <xsl:when test="$node/*[@xml:id]">
          <xsl:for-each select="$node/*[@xml:id]">
            <xsl:value-of select="$break, $indent"/>
            <xsl:value-of select="translate($node/@xml:id, '.-', '_')"/>
            <xsl:text disable-output-escaping="yes"> -- </xsl:text>
            <xsl:value-of select="translate(@xml:id, '.-', '_')"/>
          </xsl:for-each>
        </xsl:when>
      </xsl:choose>
      
      
    </xsl:for-each>
    
    
    <xsl:value-of select="$break"/>
    <xsl:text>}</xsl:text>
  </xsl:template> 
  
  <!--<xsl:template match="kb:sourceRef" mode="pre">
    <xsl:value-of select="@label"/>
  </xsl:template>-->
  
  <!--<xsl:template match="kb:measure | kb:parts | kb:musicalEvent | kb:categories | kb:classes | kb:body[@medium = 'online'] | kb:internalNote" mode="pre"></xsl:template>-->
  
</xsl:stylesheet>