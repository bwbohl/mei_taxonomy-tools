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
  
  <xsl:attribute-set name="title">
    <xsl:attribute name="font-family">Futura</xsl:attribute>
    <xsl:attribute name="font-size">24pt</xsl:attribute>
    <xsl:attribute name="line-height">40pt</xsl:attribute>
    <xsl:attribute name="font-weight">700</xsl:attribute>
    <xsl:attribute name="space-after">24pt</xsl:attribute>
    <xsl:attribute name="span">all</xsl:attribute>
    <xsl:attribute name="provisional-distance-between-starts">24pt</xsl:attribute>
    <xsl:attribute name="hyphenate">false</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="h1">
    <xsl:attribute name="font-family">Futura</xsl:attribute>
    <xsl:attribute name="font-size">16pt</xsl:attribute>
    <xsl:attribute name="line-height">27pt</xsl:attribute>
    <xsl:attribute name="font-weight">500</xsl:attribute>
    <xsl:attribute name="space-after">8pt</xsl:attribute>
    <xsl:attribute name="space-before">16pt</xsl:attribute>
    <xsl:attribute name="span">all</xsl:attribute>
    <xsl:attribute name="provisional-distance-between-starts">24pt</xsl:attribute>
  </xsl:attribute-set>
  <!-- font-weight="bold" font-size="16pt" space-before="16pt" space-after="8pt" -->
  <xsl:attribute-set name="h2">
    <xsl:attribute name="font-family">Futura</xsl:attribute>
    <xsl:attribute name="font-size">12pt</xsl:attribute>
    <xsl:attribute name="line-height">16pt</xsl:attribute>
    <xsl:attribute name="font-weight">500</xsl:attribute>
    <xsl:attribute name="space-after">8pt</xsl:attribute>
    <xsl:attribute name="space-before">16pt</xsl:attribute>
    <xsl:attribute name="span">all</xsl:attribute>
    <xsl:attribute name="provisional-distance-between-starts">24pt</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="h3">
    <xsl:attribute name="font-family">Futura</xsl:attribute>
    <xsl:attribute name="font-size">12pt</xsl:attribute>
    <xsl:attribute name="line-height">16pt</xsl:attribute>
    <xsl:attribute name="font-weight">400</xsl:attribute>
    <xsl:attribute name="font-style">italic</xsl:attribute>
    <xsl:attribute name="space-after">8pt</xsl:attribute>
    <xsl:attribute name="space-before">8pt</xsl:attribute>
    <xsl:attribute name="span">all</xsl:attribute>
    <xsl:attribute name="provisional-distance-between-starts">24pt</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="flow-defaults">
    <xsl:attribute name="font-size">12pt</xsl:attribute>
    <xsl:attribute name="line-height">20pt</xsl:attribute>
    <xsl:attribute name="font-weight">400</xsl:attribute>
    <xsl:attribute name="font-style">normal</xsl:attribute>
    <xsl:attribute name="text-align">justify</xsl:attribute>
    <xsl:attribute name="provisional-distance-between-starts">24pt</xsl:attribute>
    <xsl:attribute name="hyphenate">true</xsl:attribute>
    <xsl:attribute name="xml:lang" select="$lang" />
  </xsl:attribute-set>
  <xsl:attribute-set name="text-flow">
    <xsl:attribute name="font-size">12pt</xsl:attribute>
    <xsl:attribute name="line-height">16pt</xsl:attribute>
    <xsl:attribute name="font-weight">400</xsl:attribute>
    <xsl:attribute name="font-style">normal</xsl:attribute>
    <xsl:attribute name="space-after">8pt</xsl:attribute>
    <xsl:attribute name="space-before">8pt</xsl:attribute>
    <xsl:attribute name="text-align">justify</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="text-margin">
    <xsl:attribute name="font-size">10pt</xsl:attribute>
    <xsl:attribute name="line-height">13pt</xsl:attribute>
    <xsl:attribute name="font-weight">300</xsl:attribute>
    <xsl:attribute name="font-style">normal</xsl:attribute>
    <xsl:attribute name="space-after">0pt</xsl:attribute>
    <xsl:attribute name="space-before">0pt</xsl:attribute>
    <xsl:attribute name="text-align">justify</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="examples-block">
    <xsl:attribute name="start-indent">1em</xsl:attribute>
    <xsl:attribute name="end-indent">1em</xsl:attribute>
    <xsl:attribute name="space-after">1em</xsl:attribute>
    <xsl:attribute name="space-before">1em</xsl:attribute>
    <xsl:attribute name="border">1px solid #999999</xsl:attribute>
    <xsl:attribute name="padding">4pt</xsl:attribute>
    <xsl:attribute name="background-color">#eeeeee</xsl:attribute>
    <xsl:attribute name="color">#333333</xsl:attribute>
  </xsl:attribute-set>
  <xd:doc scope="component">
    <xd:desc>This template avoids processing of elements that do not have the selected language.</xd:desc>
  </xd:doc>
  <xsl:template match="*[@xml:lang != $lang]"/> 
  
  <xd:doc scope="component">
    <xd:desc>Template reassuring source xml:id attributes are being replicated in the target xsl-fo.</xd:desc>
  </xd:doc>
  <xsl:template match="@xml:id">
    <xsl:attribute name="id" select="." />
  </xsl:template>
  <xd:doc scope="component">
    <xd:desc>Template to exclude certain attributes from making it to the output.</xd:desc>
  </xd:doc>
  <xsl:template match="@meiversion" />
  <xd:doc scope="component">
    <xd:desc>The root template returns the basic xsl-fo structures.</xd:desc>
  </xd:doc>
  <xsl:template match="/">
    <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
      <xsl:call-template name="fo.layout-master-set" />
      <xsl:call-template name="pdf.bookmarks" />
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
  <xd:doc scope="component">
    <xd:desc>Process tei:taxonomy element</xd:desc>
  </xd:doc>
  <xsl:template match="mei:taxonomy">
    <fo:marker marker-class-name="document-title">
      <xsl:value-of select="mei:head[@xml:lang = $lang]" />
      </fo:marker>
  <xsl:element name="fo:block" use-attribute-sets="h1">
      <xsl:apply-templates select="@*" />
      <xsl:value-of select="mei:head[@xml:lang = $lang]" />
    </xsl:element>
    <xsl:element name="fo:block" use-attribute-sets="text-flow">
      <xsl:apply-templates select="mei:desc[@xml:lang = $lang]" />
    </xsl:element>
    <xsl:apply-templates select="mei:category" />
  </xsl:template>
  
  <xd:doc scope="component">
    <xd:desc>Template for top-level mei:category elements.</xd:desc>
  </xd:doc>
  <xsl:template match="mei:category[parent::mei:taxonomy]">
    <xsl:variable name="number">
      <xsl:number format="I.1" count="mei:category" level="multiple" />
    </xsl:variable>
    <xsl:variable name="label" select="mei:label[@xml:lang = $lang]" />
    <fo:block id="{@xml:id}" page-break-before="always" span="all">
      <fo:marker marker-class-name="top-category">
        <xsl:value-of select="$number, $label" separator=" " />
      </fo:marker>
      <xsl:element name="fo:block" use-attribute-sets="h1">
        <fo:list-block>
          <fo:list-item>
            <fo:list-item-label end-indent="label-end()">
              <fo:block>
                <xsl:value-of select="$number" />
              </fo:block>
            </fo:list-item-label>
            <fo:list-item-body start-indent="body-start()">
              <fo:block>
                <xsl:value-of select="$label" />
              </fo:block>
            </fo:list-item-body>
          </fo:list-item>
        </fo:list-block>
      </xsl:element>
    </fo:block>
    <fo:block keep-with-next="0.5" text-align="justify">
      <xsl:apply-templates select="mei:desc[@xml:lang = $lang]" />
    </fo:block>
    <xsl:apply-templates select="mei:category" />
  </xsl:template>
  <xsl:template match="mei:category[parent::mei:category]">
    <xsl:variable name="nesting" select="count(ancestor-or-self::mei:category)" />
    <fo:block id="{@xml:id}">
      <!-- keep-together.within-page="{if($nesting = $levels) then 'always' else ($nesting div $levels)}" -->
      <xsl:variable name="number">
        <xsl:number format="I.1" count="mei:category" level="multiple" />
      </xsl:variable>
      <xsl:variable name="label">
        <xsl:value-of select="mei:label[@xml:lang = $lang]" />
      </xsl:variable>
      <fo:list-block font-weight="bold" font-size="12pt" space-before="8pt" provisional-label-separation="5mm" provisional-distance-between-starts="{$levels}em" keep-with-next="always">
        <fo:list-item>
          <fo:marker marker-class-name="category">
            <xsl:value-of select="$number, $label" separator=" " />
          </fo:marker>
          <fo:list-item-label end-indent="label-end()">
            <fo:block>
              <xsl:value-of select="$number" />
            </fo:block>
          </fo:list-item-label>
          <fo:list-item-body start-indent="body-start()">
            <fo:block text-align="justify" hyphenate="true" language="{$lang}" hyphenation-remain-character-count="2">
              <xsl:value-of select="$label" />
            </fo:block>
          </fo:list-item-body>
        </fo:list-item>
      </fo:list-block>
    </fo:block>
    <fo:block keep-with-next="0.5" text-align="justify">
      <xsl:apply-templates select="mei:desc[@xml:lang = $lang][not(@type = 'example')]" />
    </fo:block>
    <xsl:call-template name="examples" />
    <xsl:apply-templates select="mei:category" />
  </xsl:template>
  <xsl:template name="pdf.bookmarks">
    <fo:bookmark-tree>
      <xsl:apply-templates select="mei:taxonomy" mode="bookmark" />
    </fo:bookmark-tree>
  </xsl:template>
  <xsl:template match="mei:taxonomy" mode="bookmark">
    <fo:bookmark internal-destination="{@xml:id}">
      <fo:bookmark-title>
        <xsl:value-of select="mei:head[@xml:lang = $lang]" />
      </fo:bookmark-title>
      <xsl:apply-templates select="mei:category" mode="bookmark" />
    </fo:bookmark>
  </xsl:template>
  <xsl:template match="mei:category" mode="bookmark">
    <fo:bookmark internal-destination="{@xml:id}">
      <fo:bookmark-title>
        <xsl:value-of select="mei:label[@xml:lang = $lang]" />
      </fo:bookmark-title>
      <xsl:apply-templates select="mei:category" mode="bookmark" />
    </fo:bookmark>
  </xsl:template>
  <xsl:template name="fo.layout-master-set">
    <fo:layout-master-set>
      <fo:simple-page-master master-name="A4-portrait-titlepage" page-width="210mm" page-height="297mm" margin="10mm 25mm 25mm 25mm">
        <fo:region-body margin="10mm 0mm 10pt 0mm" column-count="1" />
      </fo:simple-page-master>
      <fo:simple-page-master master-name="A4-portrait" page-width="210mm" page-height="297mm" margin="10mm 25mm 25mm 25mm">
        <fo:region-body margin="30mm 0mm 10pt 0mm" column-count="{$columns}" />
        <fo:region-before extent="20mm" />
        <fo:region-after extent="12pt" />
      </fo:simple-page-master>
      <fo:simple-page-master master-name="A3-landscape" size="landscape" page-height="297mm" page-width="420mm" margin="10mm 25mm 10mm 25mm">
        <fo:region-body margin="30mm 0mm 30mm 0mm" column-count="1" />
        <fo:region-before extent="20mm" />
        <fo:region-after extent="10mm" />
      </fo:simple-page-master>
    </fo:layout-master-set>
  </xsl:template>
</xsl:stylesheet>
