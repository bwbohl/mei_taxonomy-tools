<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
  xmlns:mei="http://www.music-encoding.org/ns/mei"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns:saxon="http://saxon.sf.net/"
  exclude-result-prefixes="xs xd"
  version="3.0">
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p><xd:b>Created on:</xd:b> Nov 27, 2017</xd:p>
      <xd:p><xd:b>Author:</xd:b> bwb</xd:p>
      <xd:p>This XSLT transforms the mei:taxonomy to two result-documents (category and class), each containing a tei:valList that can be used as closed list for attribute definitions.</xd:p>
    </xd:desc>
  </xd:doc>
  
  <xsl:output name="pe" media-type="text/xml" method="xml" indent="yes" /><!-- saxon:indent-spaces="4" --><?TODO ant skript uses homebrew saxon he and fails on stylesheet compilation whtih this serialzation option set ?>
  <xsl:output name="he" media-type="text/xml" method="xml" indent="yes" />
  <xsl:output media-type="text/plain" method="text" normalization-form="NFC" name="text"/>
  <xsl:param name="target.dir.path">../../../build/</xsl:param>
  <xsl:param name="saxon">he</xsl:param>
  
  <xsl:variable name="break">
    <xsl:text>&#xa;</xsl:text>
  </xsl:variable>
  
  <xsl:variable name="indentation">
    <xsl:text>  </xsl:text>
  </xsl:variable>
  
  <xsl:template match="/" name="xsl:initial-template">
    
    <xsl:result-document encoding="utf-8" href="{$target.dir.path}bazga.annotation.category.odd" format="{$saxon}">
      <xsl:element name="valList" namespace="http://www.tei-c.org/ns/1.0">
        <xsl:attribute name="type">closed</xsl:attribute>
        <xsl:attribute name="mode">replace</xsl:attribute>
        <xsl:apply-templates select="//mei:category[@xml:id='bazga.annotation.category']//mei:category"/>
      </xsl:element>
    </xsl:result-document>
    
    <xsl:result-document href="{$target.dir.path}categories_frameworkActions.xml" encoding="utf-8" format="{$saxon}">
      <xsl:call-template name="bazga.kb.criticalNote.add.part"/>
    </xsl:result-document>
    
    <xsl:result-document href="{$target.dir.path}categories.translation.xml" format="{$saxon}">
        <!-- ${ask('message', combobox, ('real_value1':'rendered_value1';...;'real_valueN':'rendered_valueN'), 'default')} -->
      <xsl:element name="translation">
        <xsl:for-each select="//mei:category[@xml:id='bazga.annotation.category']//mei:category">
          <xsl:sort select="mei:label[@xml:lang='de']" data-type="text"/>
          <xsl:variable name="de" select="mei:label[@xml:lang='de']"/>
          <xsl:variable name="key" select="@xml:id"/>
          
          <xsl:element name="key">
            <xsl:attribute name="value" select="$key"/>
            <xsl:element name="comment">
              <xsl:value-of select="long"/>
            </xsl:element>
            <xsl:element name="val">
              <xsl:attribute name="lang">de_DE</xsl:attribute>
              <xsl:value-of select="mei:label[@xml:lang='de']"/>
            </xsl:element>
            <xsl:element name="val">
              <xsl:attribute name="lang">en_US</xsl:attribute>
              <xsl:value-of select="mei:label[@xml:lang='en']"/>
            </xsl:element>
          </xsl:element>
        </xsl:for-each>
      </xsl:element>
    </xsl:result-document>
    
    <xsl:result-document href="{$target.dir.path}bazga.annotation.category.css" format="text"><!--  format="no-xml-indent" -->
      <xsl:for-each select="//mei:category[@xml:id='bazga.annotation.category']//mei:category">
        <xsl:sort select="mei:label[@xml:lang='de']" data-type="text"/>
        <xsl:variable name="key" select="xs:string(@xml:id)"/>

        <xsl:message select="$key"></xsl:message>
        
        <xsl:text>categoryRef[key="</xsl:text>
        <xsl:value-of select="$key"/>
        <xsl:text>"] {</xsl:text>
        <xsl:value-of select="$break"/>
        <xsl:value-of select="$indentation"/>
        <xsl:text>content: "${i18n(</xsl:text>
        <xsl:value-of select="$key"/>
        <xsl:text>)}";</xsl:text>
        <xsl:value-of select="$break"/>
        <xsl:text>}</xsl:text>
        <xsl:value-of select="$break"/>
      </xsl:for-each>
    </xsl:result-document>
    
    <xsl:result-document encoding="utf-8" href="{$target.dir.path}bazga.annotation.class.odd" format="{$saxon}">
      <xsl:element name="valList" namespace="http://www.tei-c.org/ns/1.0">
        <xsl:attribute name="type">closed</xsl:attribute>
        <xsl:attribute name="mode">replace</xsl:attribute>
        <xsl:apply-templates select="//mei:category[@xml:id='bazga.annotation.class']//mei:category"/>
      </xsl:element>
    </xsl:result-document>
    
    <xsl:result-document href="{$target.dir.path}classes_frameworkActions.xml" encoding="utf-8" format="{$saxon}">
      <xsl:call-template name="bazga.kb.classes"/>
    </xsl:result-document>
    
    <xsl:result-document href="{$target.dir.path}classes.translation.xml" format="{$saxon}">
      <!-- ${ask('message', combobox, ('real_value1':'rendered_value1';...;'real_valueN':'rendered_valueN'), 'default')} -->
      <xsl:element name="translation">
        <xsl:for-each select="//mei:category[@xml:id='bazga.annotation.class']//mei:category">
          <xsl:sort select="parent::mei:category/mei:label[@xml:lang='de']" data-type="text"/>
          <xsl:sort select="mei:label[@xml:lang='de']" data-type="text"/>
          <xsl:variable name="de" select="mei:label[@xml:lang='de']"/>
          <xsl:variable name="key" select="@xml:id"/>
          <xsl:variable name="parent.de">
            <xsl:choose>
              <xsl:when test="count(tokenize(parent::mei:category/@xml:id, '\.')) = 4">
                <xsl:value-of select="parent::mei:category/mei:label[@xml:lang='de']"/>
              </xsl:when>
              <xsl:otherwise/>
            </xsl:choose>
          </xsl:variable>
          <xsl:variable name="parent.en">
            <xsl:choose>
              <xsl:when test="count(tokenize(parent::mei:category/@xml:id, '\.')) = 4">
                <xsl:value-of select="parent::mei:category/mei:label[@xml:lang='en']"/>
              </xsl:when>
              <xsl:otherwise/>
            </xsl:choose>
          </xsl:variable>
          
          <xsl:element name="key">
            <xsl:attribute name="value" select="$key"/>
            <xsl:element name="comment">
              <xsl:value-of select="long"/>
            </xsl:element>
            <xsl:element name="val">
              <xsl:attribute name="lang">de_DE</xsl:attribute>
              <xsl:value-of select="if($parent.de != '') then($parent.de) else(), mei:label[@xml:lang='de']" separator=":"/>
            </xsl:element>
            <xsl:element name="val">
              <xsl:attribute name="lang">en_US</xsl:attribute>
              <xsl:value-of select="if($parent.en != '') then($parent.en) else(), mei:label[@xml:lang='en']" separator=":"/>
            </xsl:element>
          </xsl:element>
        </xsl:for-each>
      </xsl:element>
    </xsl:result-document>
    
    <xsl:result-document href="{$target.dir.path}bazga.annotation.class.css" format="text"><!--  format="no-xml-indent" -->
      <xsl:for-each select="//mei:category[@xml:id='bazga.annotation.class']//mei:category">
        <xsl:sort select="mei:label[@xml:lang='de']" data-type="text"/>
        <xsl:variable name="key" select="xs:string(@xml:id)"/>
        
        <xsl:message select="$key"></xsl:message>
        
        <xsl:text>classRef[key="</xsl:text>
        <xsl:value-of select="$key"/>
        <xsl:text>"] {</xsl:text>
        <xsl:value-of select="$break"/>
        <xsl:value-of select="$indentation"/>
        <xsl:text>content: "${i18n(</xsl:text>
        <xsl:value-of select="$key"/>
        <xsl:text>)}";</xsl:text>
        <xsl:value-of select="$break"/>
        <xsl:text>}</xsl:text>
        <xsl:value-of select="$break"/>
      </xsl:for-each>
    </xsl:result-document>
    
  </xsl:template>
  
  <xsl:template match="mei:category">
    <xsl:variable name="cat" select="."/>
    <xsl:variable name="lang.list" select="distinct-values($cat//@xml:lang)"/>
    <xsl:element name="valItem" namespace="http://www.tei-c.org/ns/1.0">
      <xsl:attribute name="ident" select="@xml:id"/>
      <xsl:for-each select="$lang.list">
        <xsl:variable name="label" select="$cat/mei:label[@xml:lang = current()]"/>
        <xsl:variable name="desc" select="$cat/mei:desc[@xml:lang = current()]"/>
        <xsl:element name="gloss" namespace="http://www.tei-c.org/ns/1.0">
          <xsl:attribute name="xml:lang" select="."/>
          <xsl:value-of select="$label"/>
        </xsl:element>
        <xsl:element name="desc" namespace="http://www.tei-c.org/ns/1.0">
          <xsl:attribute name="xml:lang" select="."/>
          <xsl:choose>
            <xsl:when test="$desc != ''">
              <xsl:value-of select="$desc"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$label"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:element>
      </xsl:for-each>
    </xsl:element>
  </xsl:template>
  
  <xsl:template name="bazga.kb.criticalNote.add.part">
    <xsl:variable name="id" select="'bazga.kb.criticalNote.add.categoryRef'"/>
    <xsl:element name="action">
      <xsl:element name="field">
        <xsl:attribute name="name">
          <xsl:text>id</xsl:text>
        </xsl:attribute>
        <xsl:element name="String">
          <xsl:value-of select="$id"/>
        </xsl:element>
      </xsl:element>
      <xsl:element name="field">
        <xsl:attribute name="name">
          <xsl:text>name</xsl:text>
        </xsl:attribute>
        <xsl:element name="String">
          <xsl:value-of select="concat('${i18n(', $id, '.name', ')}')"/>
        </xsl:element>
      </xsl:element>
      <xsl:element name="field">
        <xsl:attribute name="name">
          <xsl:text>description</xsl:text>
        </xsl:attribute>
        <xsl:element name="String">
          <xsl:value-of select="concat('${i18n(', $id, '.description', ')}')"/>
        </xsl:element>
      </xsl:element>
      <xsl:element name="field">
        <xsl:attribute name="name">
          <xsl:text>largeIconPath</xsl:text>
        </xsl:attribute>
        <xsl:element name="String">
          <xsl:value-of select="concat('${framework}/icons/', $id, '.large.png')"/>
        </xsl:element>
      </xsl:element>
      <xsl:element name="field">
        <xsl:attribute name="name">
          <xsl:text>smallIconPath</xsl:text>
        </xsl:attribute>
        <xsl:element name="String">
          <xsl:value-of select="concat('${framework}/icons/', $id, '.small.png')"/>
        </xsl:element>
      </xsl:element>
      <xsl:element name="field">
        <xsl:attribute name="name">
          <xsl:text>accessKey</xsl:text>
        </xsl:attribute>
        <xsl:element name="String">
          <?TODO  ?>
        </xsl:element>
      </xsl:element>
      <xsl:element name="field">
        <xsl:attribute name="name">
          <xsl:text>accelerator</xsl:text><?TODO check all fields below ?>
        </xsl:attribute>
        <xsl:element name="String">ctrl alt C</xsl:element>
      </xsl:element>
      <xsl:element name="field">
        <xsl:attribute name="name">
          <xsl:text>actionModes</xsl:text>
        </xsl:attribute>
        <xsl:element name="actionMode-array">
          <xsl:element name="actionMode">
            <xsl:element name="field">
              <xsl:attribute name="name">
                <xsl:text>xpathCondition</xsl:text>
              </xsl:attribute>
              <xsl:element name="String">
                <xsl:text>ancestor-or-self::criticalNote</xsl:text>
              </xsl:element>
            </xsl:element>
            <xsl:element name="field">
              <xsl:attribute name="name">
                <xsl:text>argValues</xsl:text>
              </xsl:attribute>
              <xsl:element name="serializableOrderedMap">
                <xsl:element name="entry">
                  <xsl:element name="String">
                    <xsl:text>fragment</xsl:text>
                  </xsl:element>
                  <xsl:element name="String">
                    <xsl:text>&lt;part key="</xsl:text>
                    <!--<xsl:value-of select="$key"/>-->
                    <xsl:call-template name="create.ask.part_key-value"/>
                    <xsl:text>" xmlns="http://zimmermann-gesamtausgabe.de/ns/kb"/&gt;</xsl:text><!--  count="" pname=""  -->
                  </xsl:element>
                </xsl:element>
                <xsl:element name="entry">
                  <xsl:element name="String">
                    <xsl:text>goToNextEditablePosition</xsl:text>
                  </xsl:element>
                  <xsl:element name="String">
                    <xsl:text>false</xsl:text>
                  </xsl:element>
                </xsl:element>
                <xsl:element name="entry">
                  <xsl:element name="String">
                    <xsl:text>insertLocation</xsl:text>
                  </xsl:element>
                  <xsl:element name="String">
                    <xsl:text>ancestor-or-self::criticalNote/categories</xsl:text>
                  </xsl:element>
                </xsl:element>
                <xsl:element name="entry">
                  <xsl:element name="String">
                    <xsl:text>insertPosition</xsl:text>
                  </xsl:element>
                  <xsl:element name="String">
                    <xsl:text>Inside as last child</xsl:text>
                  </xsl:element>
                </xsl:element>
                <xsl:element name="entry">
                  <xsl:element name="String">
                    <xsl:text>schemaAware</xsl:text>
                  </xsl:element>
                  <xsl:element name="String">
                    <xsl:text>true</xsl:text>
                  </xsl:element>
                </xsl:element>
              </xsl:element>
            </xsl:element>
            <xsl:element name="field">
              <xsl:attribute name="name">
                <xsl:text>operationID</xsl:text>
              </xsl:attribute>
              <xsl:element name="String">
                <xsl:text>ro.sync.ecss.extensions.commons.operations.InsertFragmentOperation</xsl:text>
              </xsl:element>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:element>
      <xsl:element name="field">
        <xsl:attribute name="name">
          <xsl:text>enabledInReadOnlyContext</xsl:text>
        </xsl:attribute>
        <xsl:element name="Boolean">
          <xsl:text>false</xsl:text>
        </xsl:element>
      </xsl:element>
    </xsl:element>
  </xsl:template>
  
  <xsl:template name="bazga.kb.classes">
    <xsl:variable name="id" select="'bazga.kb.criticalNote.add.classRef'"/>
    <xsl:element name="action">
      <xsl:element name="field">
        <xsl:attribute name="name">
          <xsl:text>id</xsl:text>
        </xsl:attribute>
        <xsl:element name="String">
          <xsl:value-of select="$id"/>
        </xsl:element>
      </xsl:element>
      <xsl:element name="field">
        <xsl:attribute name="name">
          <xsl:text>name</xsl:text>
        </xsl:attribute>
        <xsl:element name="String">
          <xsl:value-of select="concat('${i18n(', $id, '.name', ')}')"/>
        </xsl:element>
      </xsl:element>
      <xsl:element name="field">
        <xsl:attribute name="name">
          <xsl:text>description</xsl:text>
        </xsl:attribute>
        <xsl:element name="String">
          <xsl:value-of select="concat('${i18n(', $id, '.description', ')}')"/>
        </xsl:element>
      </xsl:element>
      <xsl:element name="field">
        <xsl:attribute name="name">
          <xsl:text>largeIconPath</xsl:text>
        </xsl:attribute>
        <xsl:element name="String">
          <xsl:value-of select="concat('${framework}/icons/', $id, '.large.png')"/>
        </xsl:element>
      </xsl:element>
      <xsl:element name="field">
        <xsl:attribute name="name">
          <xsl:text>smallIconPath</xsl:text>
        </xsl:attribute>
        <xsl:element name="String">
          <xsl:value-of select="concat('${framework}/icons/', $id, '.small.png')"/>
        </xsl:element>
      </xsl:element>
      <xsl:element name="field">
        <xsl:attribute name="name">
          <xsl:text>accessKey</xsl:text>
        </xsl:attribute>
        <xsl:element name="String">
          <?TODO  ?>
        </xsl:element>
      </xsl:element>
      <xsl:element name="field">
        <xsl:attribute name="name">
          <xsl:text>accelerator</xsl:text><?TODO check all fields below ?>
        </xsl:attribute>
        <xsl:element name="String">
          <?TODO  ?>
        </xsl:element>
      </xsl:element>
      <xsl:element name="field">
        <xsl:attribute name="name">
          <xsl:text>actionModes</xsl:text>
        </xsl:attribute>
        <xsl:element name="actionMode-array">
          <xsl:element name="actionMode">
            <xsl:element name="field">
              <xsl:attribute name="name">
                <xsl:text>xpathCondition</xsl:text>
              </xsl:attribute>
              <xsl:element name="String">
                <xsl:text>ancestor-or-self::criticalNote</xsl:text>
              </xsl:element>
            </xsl:element>
            <xsl:element name="field">
              <xsl:attribute name="name">
                <xsl:text>argValues</xsl:text>
              </xsl:attribute>
              <xsl:element name="serializableOrderedMap">
                <xsl:element name="entry">
                  <xsl:element name="String">
                    <xsl:text>fragment</xsl:text>
                  </xsl:element>
                  <xsl:element name="String">
                    <xsl:value-of select="$break"/>
                    <xsl:text>&lt;classRef xmlns="http://zimmermann-gesamtausgabe.de/ns/kb" key="</xsl:text>
                    <!--<xsl:value-of select="$key"/>-->
                    <xsl:call-template name="create.ask.class"/>
                    <xsl:text>" /&gt;</xsl:text><!--  count="" pname=""  -->
                  </xsl:element>
                </xsl:element>
                <xsl:element name="entry">
                  <xsl:element name="String">
                    <xsl:text>goToNextEditablePosition</xsl:text>
                  </xsl:element>
                  <xsl:element name="String">
                    <xsl:text>false</xsl:text>
                  </xsl:element>
                </xsl:element>
                <xsl:element name="entry">
                  <xsl:element name="String">
                    <xsl:text>insertLocation</xsl:text>
                  </xsl:element>
                  <xsl:element name="String">
                    <xsl:text>ancestor-or-self::criticalNote/classes</xsl:text>
                  </xsl:element>
                </xsl:element>
                <xsl:element name="entry">
                  <xsl:element name="String">
                    <xsl:text>insertPosition</xsl:text>
                  </xsl:element>
                  <xsl:element name="String">
                    <xsl:text>Inside as last child</xsl:text>
                  </xsl:element>
                </xsl:element>
                <xsl:element name="entry">
                  <xsl:element name="String">
                    <xsl:text>schemaAware</xsl:text>
                  </xsl:element>
                  <xsl:element name="String">
                    <xsl:text>true</xsl:text>
                  </xsl:element>
                </xsl:element>
              </xsl:element>
            </xsl:element>
            <xsl:element name="field">
              <xsl:attribute name="name">
                <xsl:text>operationID</xsl:text>
              </xsl:attribute>
              <xsl:element name="String">
                <xsl:text>ro.sync.ecss.extensions.commons.operations.InsertFragmentOperation</xsl:text>
              </xsl:element>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:element>
      <xsl:element name="field">
        <xsl:attribute name="name">
          <xsl:text>enabledInReadOnlyContext</xsl:text>
        </xsl:attribute>
        <xsl:element name="Boolean">
          <xsl:text>false</xsl:text>
        </xsl:element>
      </xsl:element>
    </xsl:element>
  </xsl:template>
  
  <xsl:template name="create.ask.part_key-value">
    <!-- ${ask('message', combobox, ('real_value1':'rendered_value1';...;'real_valueN':'rendered_valueN'), 'default')} -->
    <xsl:variable name="message">message</xsl:variable>
    <xsl:variable name="default">default</xsl:variable>
    <xsl:variable name="item.tick">'</xsl:variable>
    <xsl:variable name="item.middle">':'</xsl:variable>
    <xsl:variable name="key-value-pairs" as="item()+">
      <xsl:for-each select="//mei:category[@xml:id='bazga.annotation.category']//mei:category">
        <xsl:variable name="key" select="@xml:id"/>
        <xsl:variable name="value">
          <xsl:text>${</xsl:text>
            <xsl:text>i18n(</xsl:text>
              <xsl:value-of select="$key"/>
            <xsl:text>)</xsl:text>
          <xsl:text>}</xsl:text>
        </xsl:variable>
        <xsl:copy-of select="$item.tick||$key||$item.middle||$value||$item.tick"/>
      </xsl:for-each>
    </xsl:variable>
    <xsl:text>${ask(</xsl:text>
    <xsl:text>'</xsl:text>
    <xsl:value-of select="$message"/>
    <xsl:text>', combobox, (</xsl:text>
    <xsl:value-of select="$key-value-pairs" separator=";{$break}"/>
    <xsl:text>), </xsl:text>
    <xsl:text>'</xsl:text>
    <xsl:value-of select="$default"/>
    <xsl:text>'</xsl:text>
    <xsl:text>)}</xsl:text>
  </xsl:template>
  
  <xsl:template name="create.ask.class">
    <!-- ${ask('message', combobox, ('real_value1':'rendered_value1';...;'real_valueN':'rendered_valueN'), 'default')} -->
    <xsl:variable name="message">${i18n(bazga.kb.criticalNote.add.classRef.dialog.message)}</xsl:variable>
    <xsl:variable name="default">default</xsl:variable>
    <xsl:variable name="item.tick">'</xsl:variable>
    <xsl:variable name="item.middle">':'</xsl:variable>
    <xsl:variable name="key-value-pairs" as="item()+">
      <xsl:for-each select="//mei:category[@xml:id='bazga.annotation.class']//mei:category">
        <xsl:variable name="key" select="@xml:id"/>
        <xsl:variable name="value">
          <xsl:text>${</xsl:text>
          <xsl:text>i18n(</xsl:text>
          <xsl:value-of select="$key"/>
          <xsl:text>)</xsl:text>
          <xsl:text>}</xsl:text>
        </xsl:variable>
        <xsl:copy-of select="$item.tick||$key||$item.middle||$value||$item.tick"/>
      </xsl:for-each>
    </xsl:variable>
    <xsl:text>${ask(</xsl:text>
    <xsl:text>'</xsl:text>
    <xsl:value-of select="$message"/>
    <xsl:text>',</xsl:text>
    <xsl:value-of select="$break, $indentation"/>
    <xsl:text>combobox,</xsl:text>
    <xsl:value-of select="$break, $indentation, $indentation"/>
    <xsl:text>(</xsl:text>
    <xsl:value-of select="$key-value-pairs" separator=";{$break, $indentation, $indentation}"/>
    <xsl:text>), </xsl:text>
    <xsl:text>'</xsl:text>
    <xsl:value-of select="$default"/>
    <xsl:text>'</xsl:text>
    <xsl:text>)}</xsl:text>
  </xsl:template>
</xsl:stylesheet>