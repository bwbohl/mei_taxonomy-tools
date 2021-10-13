<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:mei="http://www.music-encoding.org/ns/mei" exclude-result-prefixes="mei xd xs xsl" version="2.0">
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p><xd:b>Created on:</xd:b> Apr 8, 2019</xd:p>
      <xd:p><xd:b>Author:</xd:b> bwb</xd:p>
      <xd:p/>
    </xd:desc>
  </xd:doc>
  <xsl:output indent="yes" method="xml" />
  
  <xsl:param name="lang">de</xsl:param>
  <xsl:param name="columns">1</xsl:param>
  <xsl:param name="image-url"></xsl:param>
  
  <xsl:variable name="levels" select="max(for $i in //mei:category return count($i/ancestor-or-self::mei:category))"/>
  
  <xsl:template match="*[@xml:lang != $lang]"/> 
  
  <xsl:template match="/">
    <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
      <fo:layout-master-set>
        <fo:simple-page-master master-name="A4-portrait" size="210mm 297mm">
          <fo:region-body margin="1in" column-count="2"/>
        </fo:simple-page-master>
        <fo:simple-page-master master-name="A3-landscape" size="landscape" page-height="297mm" page-width="420mm">
          <fo:region-body margin="1in" column-count="2"/>
        </fo:simple-page-master>
      </fo:layout-master-set>
      <fo:page-sequence master-reference="A4-portrait">
        <fo:flow flow-name="xsl-region-body" font="12pt Times" line-height="20pt">
          <xsl:apply-templates/>
          <!--<fo:block font="italic 14pt Helvetica">
            <fo:inline color="red">Hello</fo:inline> <fo:inline color="blue">World</fo:inline></fo:block>
          <fo:block> Attributes: <fo:inline color="green">colored</fo:inline>, <fo:inline
            font-weight="bold">bold</fo:inline>, <fo:inline font-style="italic"
              >italic</fo:inline>, <fo:inline font-size="75%">small</fo:inline>, <fo:inline
                font-size="133%">large</fo:inline>. </fo:block>
          <fo:block> Text attributes: <fo:inline text-decoration="underline"
            >underlined</fo:inline>, <fo:inline text-transform="uppercase">all capitals</fo:inline>,
            <fo:inline text-transform="capitalize">capitalized</fo:inline>, text with
            <fo:inline baseline-shift="sub" font-size="smaller">subscripts</fo:inline> and
            <fo:inline baseline-shift="super" font-size="smaller">superscripts</fo:inline>.
          </fo:block>-->
        </fo:flow>
      </fo:page-sequence>
      <fo:page-sequence master-reference="A3-landscape">
        <fo:flow flow-name="xsl-region-body">
          <fo:block break-before="page" span="all">
            <fo:external-graphic src="{$image-url}" max-width="80%" max-height="80%" scaling="uniform" content-height="scale-to-fit" margin-left="auto" margin-right="auto"/>
          </fo:block>
        </fo:flow>
      </fo:page-sequence>
    </fo:root>
  </xsl:template>
  
  <xsl:template match="mei:taxonomy">
    <fo:block>
      <fo:block font-weight="bold" font-size="16pt" space-before="16pt" space-after="8pt" span="all">
        <xsl:value-of select="mei:head[@xml:lang = $lang]"/>
      </fo:block>
      <fo:block>
        <xsl:apply-templates select="mei:desc[@xml:lang = $lang]"/>
        <xsl:apply-templates select="mei:category"/>
      </fo:block>
    </fo:block>
  </xsl:template>
  
  <xsl:template match="mei:category[parent::mei:taxonomy]">
    <fo:block>
      <fo:block font-weight="bold" font-size="14pt" space-before="8pt" keep-with-next="always">
        <xsl:value-of select="mei:label[@xml:lang = $lang]"/>
      </fo:block>
      <fo:block keep-with-next="0.5">
        <xsl:apply-templates select="mei:desc[@xml:lang = $lang]"/>
      </fo:block>
      <fo:block>
        <xsl:apply-templates select="mei:category"/>
      </fo:block>
    </fo:block>
  </xsl:template>
  
  <xsl:template match="mei:category[parent::mei:category]">
    <xsl:variable name="nesting" select="count(ancestor-or-self::mei:category)"/>
    <fo:block><!-- keep-together.within-page="{if($nesting = $levels) then 'always' else ($nesting div $levels)}" -->
      <fo:list-block font-weight="bold" font-size="12pt" space-before="8pt" provisional-label-separation="5mm" provisional-distance-between-starts="{$levels}em" keep-with-next="always">
        <fo:list-item>
          <fo:list-item-label end-indent="label-end()">
            <fo:block><xsl:number format="I.1" count="mei:category" level="multiple"/></fo:block>
          </fo:list-item-label>
          <fo:list-item-body start-indent="body-start()">
            <fo:block><xsl:value-of select="mei:label[@xml:lang = $lang]"/></fo:block>
          </fo:list-item-body>
        </fo:list-item>
      </fo:list-block>
      <fo:block keep-with-next="0.5">
        <xsl:apply-templates select="mei:desc[@xml:lang = $lang]"/>
      </fo:block>
      <fo:block>
        <xsl:apply-templates select="mei:category"/>
      </fo:block>
    </fo:block>
  </xsl:template>
  
</xsl:stylesheet>
