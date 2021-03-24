<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:saxon="http://saxon.sf.net/" exclude-result-prefixes="xs xd" version="3.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> March 22, 2021</xd:p>
            <xd:p><xd:b>Author:</xd:b> Benjamin W. Bohl</xd:p>
            <xd:p>This XSLT transforms an mei:taxonomy to an mei:classification profiled for Edirom-Online.</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="/">
        <xsl:element name="clasisification" namespace="http://www.music-encoding.org/ns/mei">
            <xsl:attribute name="xml:id" select="/mei:taxonomy/@xml:id"></xsl:attribute>
            <xsl:for-each select="/mei:taxonomy/mei:category">
                <xsl:element name="termList" namespace="http://www.music-encoding.org/ns/mei">
                    <xsl:attribute name="classcode">#ediromCategory</xsl:attribute>
                    <xsl:attribute name="xml:id" select="@xml:id" />
                    <xsl:for-each select="//mei:category">
                        <xsl:element name="term" namespace="http://www.music-encoding.org/ns/mei">
                            <xsl:attribute name="classcode">ediromCategory</xsl:attribute>
                            <xsl:attribute name="xml:id" select="@xml:id" />
                            <xsl:for-each select="mei:label">
                                <xsl:element name="name" namespace="http://www.music-encoding.org/ns/mei">
                                    <xsl:attribute name="xml:lang" select="@xml:lang" />
                                    <xsl:value-of select="." />
                                </xsl:element>
                            </xsl:for-each>
                        </xsl:element>
                    </xsl:for-each>
                </xsl:element>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
