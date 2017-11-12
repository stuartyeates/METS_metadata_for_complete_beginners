<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:locmets="http://www.loc.gov/METS/" 
                              xmlns:mets="http://www.exlibrisgroup.com/xsd/dps/rosettaMets"
                              xmlns:dnx="http://www.exlibrisgroup.com/dps/dnx" 
			      xmlns:dc="http://purl.org/dc/elements/1.1/" 
			      xmlns:dcterms="http://purl.org/dc/terms/"
                              xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                              xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                              xmlns:mods="http://www.loc.gov/mods/v3"
                              xmlns:premis="http://www.loc.gov/standards/premis" 
			      xmlns:dim="http://www.dspace.org/xmlns/dspace/dim" 
			      xmlns:vuwschema="http://library.vuw.ac.nz"    
			      xmlns:thesis="http://www.ndltd.org/standards/metadata/current.html" 
			      xmlns:rights="http://cosimo.stanford.edu/sdr/metsrights/"    
			      xmlns:xlink="http://www.w3.org/1999/xlink">
	<xsl:output method="xml" indent="yes" omit-xml-declaration="no" />
	<xsl:template match="@xmlns | @xsi:schemaLocation" />
	<xsl:template match="@*|*|processing-instruction()|comment()">
		<xsl:copy>
			<xsl:apply-templates select="*|@*|text()|processing-instruction()|comment()" />
		</xsl:copy>
	</xsl:template>

	<xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
	<xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
	<xsl:template match="/">
		<mets:mets xmlns:locmets="http://www.loc.gov/METS/" 
		           xmlns:mets="http://www.exlibrisgroup.com/xsd/dps/rosettaMets" 
			   xmlns:dnx="http://www.exlibrisgroup.com/dps/dnx"		    
			   xmlns:dc="http://purl.org/dc/elements/1.1/" 
			   xmlns:dcterms="http://purl.org/dc/terms/" 
			   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
			   xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
			   xmlns:mods="http://www.loc.gov/mods/v3" 
			   xmlns:premis="http://www.loc.gov/standards/premis"
		           xmlns:dim="http://www.dspace.org/xmlns/dspace/dim" 
			   xmlns:vuwschema="http://library.vuw.ac.nz" 
			   xmlns:thesis="http://www.ndltd.org/standards/metadata/current.html"
		           xmlns:rights="http://cosimo.stanford.edu/sdr/metsrights/" 
			   xmlns:xlink="http://www.w3.org/1999/xlink">


			<!-- Test to find a preservation master representation. This test looks for file descriptions set below. -->
			<xsl:variable name="testMaster" select="//locmets:fileGrp/locmets:file[
								(
									@ADMID = //locmets:amdSec[
										(
											.//dim:field[
												@element = 'description'
												and not(starts-with(.,'Extracted'))
												and (
												(. = 'Thesis')
                                                or (. = 'Thesis: Archival Version (Admin)')
												or (. = 'Article')
												or (. = 'Thesis part 1')
												or (. = 'Thesis part 2')
												or (starts-with(.,'Technical')) 
												or (. = 'Report')
												or (starts-with(.,'Research'))
												or (starts-with(.,'Presentation'))
												or (. = 'Postprint')
												or (. = 'Poster')
												or (starts-with(.,'Portfolio'))
												or (starts-with(.,'Policy'))
												or (. = 'Paper')
												or (starts-with(.,'Occasional'))
												or (starts-with(.,'NetCDF'))
												or (starts-with(.,'Main'))
												or (starts-with(.,'Newsletter'))
												or (starts-with(.,'Journal'))
												or (starts-with(.,'Discussion'))
												or (starts-with(.,'Conference'))
												or (. = 'Chapter')
                                                or (. = 'Calendar')
												or (starts-with(.,'Case'))
												or (starts-with(.,'Book'))
												or (starts-with(.,'Working'))
												or (starts-with(.,'RelaxNG'))
												or (starts-with(.,'Schema'))
												or (starts-with(.,'Seminar'))
												)
											])
									]/@ID
								)                                                                                                   
							]" />

			<!-- Test to find a modified master representation. This test looks for access copies of files theses and calendars. -->
			<xsl:variable name="testModified" select="//locmets:fileGrp/locmets:file[
								(
									@ADMID = //locmets:amdSec[
										(
											.//dim:field[
												@element = 'description' 
												and not(. = 'Thesis')
												and ( 
												(. = 'Thesis Access')
                                                or (. = 'Access Calendar')
                                                )
											])
									]/@ID
								) 
							]" />

			<!-- Test to find a supplamentary file representation. This test looks for not specified in the Preservation and Modified master test. -->
			<xsl:variable name="testOtherFiles" select="//locmets:fileGrp/locmets:file[
	(
		@ADMID = //locmets:amdSec[
			(
				.//dim:field[
					@element = 'description' 
					and (
					not(. = 'Extracted text') 
					and 
					not(starts-with(.,'Thesis'))
					and 
					not(. = 'SWORD deposit package')
					and 
					not(starts-with(.,'Permission')) 
					and 
					not(starts-with(.,'Declaration'))
					and 
					not(starts-with(.,'Witholding'))
					and 
					not(. ='Form')
					and 
					not(. ='Non-Standard Format Permission Form (Admin)')
					and 
					not(. ='form')
					and 
					not(. ='Letter (Admin)')
					and
					not(. ='Article')
					and 
					not(starts-with(.,'Technical')) 
					and 
					not(. = 'Report')
					and 
					not(starts-with(.,'Research'))
					and 
					not(starts-with(.,'Presentation'))
					and 
					not(. = 'Postprint')
					and 
					not(. = 'Poster')
					and 
					not(starts-with(.,'Portfolio'))
					and 
					not(starts-with(.,'Policy'))            
					and 
					not(. = 'Paper')
					and 
					not(starts-with(.,'Occasional'))
					and 
					not(starts-with(.,'NetCDF'))
					and 
					not(starts-with(.,'Main'))
					and 
					not(starts-with(.,'Journal'))
					and 
					not(starts-with(.,'Discussion'))
					and 
					not(starts-with(.,'Conference'))
					and 
					not(. = 'Chapter')
					and 
					not(. = 'Calendar')
					and 
					not(. = 'Access Calendar')
					and 
					not(starts-with(.,'Case'))
					and 
					not(starts-with(.,'Book'))
					and
					not(starts-with(.,'Working'))
					and 
					not(starts-with(.,'RelaxNG'))
					and 
					not(starts-with(.,'Schema'))
					and 
					not(starts-with(.,'Seminar'))
					)
				])
		]/@ID
	) 
]" />

			<!-- Test to find a ppermission form representation. This test looks for files described as staring with Permission, Form, or Declaration . -->
			<xsl:variable name="testPermission" select="//locmets:fileGrp/locmets:file[
	(
		@ADMID = //locmets:amdSec[
			(
				.//dim:field[
					@element = 'description' 
					and (
					(starts-with(.,'Permission')) 
					or 
					(. = 'Form')
					or 
					(. = 'form')					
					or 
					(. = 'Non-Standard Format Permission Form (Admin)')
					or 
					(. ='Letter (Admin)')
					or 
					(starts-with(.,'Declaration'))
					or 
					(starts-with(.,'Withhold')) 
					)
				])
		]/@ID
	) 
]" />


			<!-- Test to find a Extracted text representation. This test looks for file descriptions set below. -->
			<xsl:variable name="testExtracted" select="//locmets:fileGrp/locmets:file[
	(
		@ADMID = //locmets:amdSec[
			(
				.//dim:field[
					@element = 'description' 
					and 
					(. = 'Extracted text') 
				])
		]/@ID
	)                                                                                                                    
]" />



			<!-- Dublin Core -->
			<mets:dmdSec ID="ie-dmd">
				<mets:mdWrap MDTYPE="DC">
					<mets:xmlData>
						<dc:record>
							<!-- consider adding //locmets:dmdSec[@ID='dmdSec_2']// to each select statement to draw only from DIM metadata. -->

							<!-- dc contributor, mapping for advisor and editor -->
							<xsl:for-each select="//dim:field[@qualifier='advisor']">
								<dc:contributor>
									<xsl:value-of select="." />
								</dc:contributor>
							</xsl:for-each>

							<xsl:for-each select="//dim:field[@qualifier='editor']">
								<dc:contributor>
									<xsl:value-of select="." />
								</dc:contributor>
							</xsl:for-each>

							<!-- dc creator, mapping for author and illustrator -->

							<xsl:for-each select="//dim:field[@qualifier='author']">
								<dc:creator>
									<xsl:value-of select="." />
								</dc:creator>
							</xsl:for-each>

							<xsl:for-each select="//dim:field[@qualifier='illustrator']">
								<dc:creator>
									<xsl:value-of select="." />
								</dc:creator>
							</xsl:for-each>

							<!-- dc coverage, spatial and temporal -->
							<xsl:for-each select="//dim:field[@equalifier='spatial']">
								<dcterms:spatial>
									<xsl:value-of select="." />
								</dcterms:spatial>
							</xsl:for-each>

							<xsl:for-each select="//dim:field[@equalifier='temporal']">
								<dcterms:temporal>
									<xsl:value-of select="." />
								</dcterms:temporal>
							</xsl:for-each>

							<!-- dc date: accessioned, available, copyright, created, issued and submitted -->
							<xsl:for-each select="//dim:field[@qualifier='accessioned']">
								<dcterms:dateAccepted>
									<xsl:value-of select="." />
								</dcterms:dateAccepted>
							</xsl:for-each>

							<xsl:for-each select="//dim:field[@qualifier='available']">
								<dcterms:available>
									<xsl:value-of select="." />
								</dcterms:available>
							</xsl:for-each>

							<xsl:for-each select="//dim:field[@qualifier='copyright']">
								<dcterms:dateCopyrighted>
									<xsl:value-of select="." />
								</dcterms:dateCopyrighted>
							</xsl:for-each>

							<xsl:for-each select="//dim:field[@qualifier='created']">
								<dcterms:created>
									<xsl:value-of select="." />
								</dcterms:created>
							</xsl:for-each>

							<xsl:for-each select="//dim:field[@qualifier='issued']">
								<dcterms:issued>
									<xsl:value-of select="." />
								</dcterms:issued>
							</xsl:for-each>

							<xsl:for-each select="//dim:field[@qualifier='submitted']">
								<dcterms:dateSubmitted>
									<xsl:value-of select="." />
								</dcterms:dateSubmitted>
							</xsl:for-each>

							<!-- dc identifier, citation, ISBN, ISMN, ISSN and identifier uri -->
							<xsl:for-each select="//dim:field[@qualifier='citation']">
								<dcterms:bibliographicCitation>
									<xsl:value-of select="." />
								</dcterms:bibliographicCitation>
							</xsl:for-each>

							<xsl:for-each select="//dim:field[@element='identifier' and @qualifier='ISBN']">
								<dc:identifier xsi:type="dcterms:ISBN">
									<xsl:value-of select="." />
								</dc:identifier>
							</xsl:for-each>

							<xsl:for-each select="//dim:field[@element='identifier' and @qualifier='ISMN']">
								<dc:identifier xsi:type="dcterms:ISMN">
									<xsl:value-of select="." />
								</dc:identifier>
							</xsl:for-each>

							<xsl:for-each select="//dim:field[@element='identifier' and @qualifier='ISSN']">
								<dc:identifier xsi:type="dcterms:ISSN">
									<xsl:value-of select="." />
								</dc:identifier>
							</xsl:for-each>

							<xsl:for-each select="//dim:field[@element='identifier' and @qualifier='uri' and (starts-with(.,'http'))]">
								<dc:identifier xsi:type="dcterms:URI">
									<xsl:value-of select="." />
								</dc:identifier>
							</xsl:for-each>
							<!-- dc description, includes abstract and provenance -->


							<!-- test to select en_NZ and correct it to be en-NZ otherwise copy the lang code as is -->
							<xsl:for-each select="//dim:field[@qualifier='abstract']">
								<dcterms:abstract>
									<xsl:attribute name="xml:lang">
										<xsl:value-of select="@lang" /></xsl:attribute>
									<xsl:value-of select="." />
								</dcterms:abstract>
							</xsl:for-each>


							<!-- dc format, includes extent and medium -->
							<xsl:for-each select="//locmets:dmdSec[@ID='dmdSec_2']//dim:field[@element='format']">
								<dc:format>
									<xsl:value-of select="." />
								</dc:format>
							</xsl:for-each>

							<xsl:for-each select="//dim:field[@qualifier='extent']">
								<dcterms:extent>
									<xsl:value-of select="." />
								</dcterms:extent>
							</xsl:for-each>

							<!-- dc language -->
							<xsl:for-each select="//dim:field[@qualifier='iso']">
								<dc:language>
									<xsl:attribute name="lang">
										<xsl:value-of select="//dim:field[@qualifier='iso']" /></xsl:attribute>
									<xsl:value-of select="." />
								</dc:language>
							</xsl:for-each>


							<xsl:for-each select="//dim:field[@qualifier='iso']">
								<dc:language xsi:type="dcterms:ISO639-2">
									<xsl:attribute name="lang">
										<xsl:value-of select="//dim:field[@qualifier='iso']" /></xsl:attribute>
									<xsl:value-of select="." />
								</dc:language>
							</xsl:for-each>

							<!-- dc publisher -->
							<xsl:for-each select="//dim:field[@element='publisher']">
								<dc:publisher>
									<xsl:attribute name="xml:lang">
										<xsl:value-of select="@lang" /></xsl:attribute>
									<xsl:value-of select="." />
								</dc:publisher>
							</xsl:for-each>

							<!-- dc relation -->
							<xsl:for-each select="//dim:field[@element='relation'][not (@qualifier)]">
								<dc:relation>]
									<xsl:value-of select="." />
								</dc:relation>
							</xsl:for-each>

							<!-- dc:terms isPartOf updated to a dc:terms element -->
							<xsl:for-each select="//dim:field[@element='relation' and @qualifier='isPartOf']">
								<dcterms:isPartOf xsi:type="dcterms:URI">
									<xsl:value-of select="." />
								</dcterms:isPartOf>
							</xsl:for-each>
							<!-- dc:terms isPartOf collection structure, Victoria unit -->

							<xsl:for-each select="//dim:field[@mdschema='vuwschema' and @qualifier='unit']">
								<dcterms:isPartOf>ResearchArchive/
									<xsl:value-of select="." />
								</dcterms:isPartOf>
							</xsl:for-each>

							<!-- dc relation isReferencedBy -->
							<xsl:for-each select="//dim:field[@element='relation' and @qualifier='isReferencedBy']">
								<dcterms:isReferencedBy>
									<xsl:value-of select="." />
								</dcterms:isReferencedBy>
							</xsl:for-each>

							<!-- dc relation isformatof -->
							<xsl:for-each select="//dim:field[@element='relation' and @qualifier='isformatof']">
								<dcterms:isFormatOf>
									<xsl:value-of select="." />
								</dcterms:isFormatOf>
							</xsl:for-each>

							<!-- dc relation ispartofseries -->
							<xsl:for-each select="//dim:field[@element='relation' and @qualifier='ispartofseries']">
								<dcterms:isPartOfSeries>
									<xsl:value-of select="." />
								</dcterms:isPartOfSeries>
							</xsl:for-each>

							<!-- dc relation haspart -->
							<xsl:for-each select="//dim:field[@element='relation' and @qualifier='hasPart']">
								<dcterms:hasPart>
									<xsl:value-of select="." />
								</dcterms:hasPart>
							</xsl:for-each>

							<!-- dc relation isversionof -->
							<xsl:for-each select="//dim:field[@element='relation' and @qualifier='isversionof']">
								<dcterms:isVersionOf>
									<xsl:value-of select="." />
								</dcterms:isVersionOf>
							</xsl:for-each>

							<!-- dc relation isbasedon -->
							<xsl:for-each select="//dim:field[@element='relation' and @qualifier='isbasedon']">
								<dcterms:isBasedOn>
									<xsl:value-of select="." />
								</dcterms:isBasedOn>
							</xsl:for-each>

							<!-- dc relation isreplacedby -->
							<xsl:for-each select="//dim:field[@element='relation' and @qualifier='isreplacedby']">
								<dcterms:isReplacedBy>
									<xsl:value-of select="." />
								</dcterms:isReplacedBy>
							</xsl:for-each>

							<!-- dc relation requires -->
							<xsl:for-each select="//dim:field[@element='relation' and @qualifier='requires']">
								<dcterms:requires>
									<xsl:value-of select="." />
								</dcterms:requires>
							</xsl:for-each>

							<!-- dc relation replaces -->
							<xsl:for-each select="//dim:field[@element='relation' and @qualifier='replaces']">
								<dcterms:replaces>
									<xsl:value-of select="." />
								</dcterms:replaces>
							</xsl:for-each>


							<!-- dc rights, includes dcterms license, rightsHolder and rights uri -->
							<xsl:for-each select="//dim:field[@mdschema='dc' and @element='rights' and @qualifier='license']">
								<dcterms:license>
									<xsl:attribute name="xml:lang">en_NZ</xsl:attribute>
									<xsl:value-of select="." />
								</dcterms:license>
							</xsl:for-each>

							<xsl:for-each select="//dim:field[@mdschema='dc' and @element='rights' and @qualifier='uri']">
								<dc:rights xsi:type="dcterms:URI">
									<xsl:value-of select="." />
								</dc:rights>
							</xsl:for-each>


							<xsl:for-each select="//dim:field[@mdschema='dc' and @element='rights' and @qualifier='holder']">
								<dcterms:rightsHolder>
									<xsl:value-of select="." />
								</dcterms:rightsHolder>
							</xsl:for-each>

							<xsl:for-each select="//dim:field[@mdschema='dc' and @element='rights']">
								<dc:rights>
									<xsl:attribute name="xml:lang">en_NZ</xsl:attribute>
									<xsl:value-of select="." />
								</dc:rights>
							</xsl:for-each>

							<!-- dc source -->
							<xsl:for-each select="//dim:field[@mdschema='dc' and @element='source']">
								<dc:source>
									<xsl:value-of select="." />
								</dc:source>
							</xsl:for-each>

							<xsl:for-each select="//dim:field[@mdschema='dc' and @element='source' and @qualifier='uri']">
								<dc:source xsi:type="dcterms:URI">
									<xsl:value-of select="." />
								</dc:source>
							</xsl:for-each>

							<!-- dc subject  -->
							<xsl:for-each select="//dim:field[@mdschema='dc' and @element='subject']">
								<dc:subject>
									<xsl:attribute name="xml:lang">
										<xsl:value-of select="@lang" /></xsl:attribute>
									<xsl:value-of select="." />
								</dc:subject>
							</xsl:for-each>

							<!-- dc type -->

							<xsl:for-each select="//dim:field[@mdschema='dc' and @element='type']">
								<dc:type>
									<xsl:attribute name="xml:lang">en-NZ</xsl:attribute>
									<xsl:value-of select="." />
								</dc:type>
							</xsl:for-each>

							<!-- dc title and alternative title -->

							<xsl:for-each select="//locmets:dmdSec[@ID='dmdSec_2']//dim:field[@mdschema='dc' and @element='title']">
								<dc:title>
									<xsl:value-of select="." />
								</dc:title>
							</xsl:for-each>

							<xsl:for-each select="//locmets:dmdSec[@ID='dmdSec_2']//dim:field[@mdschema='dc' and @element='title']">
								<dc:title>
									<xsl:attribute name="xml:lang">
										<xsl:value-of select="@lang" /></xsl:attribute>
									<xsl:value-of select="." />
								</dc:title>
							</xsl:for-each>

							<xsl:for-each select="//dcterms:alternative">
								<dcterms:alternative>
									<xsl:attribute name="xml:lang">
										<xsl:value-of select="@lang" /></xsl:attribute>
									<xsl:value-of select="." />
								</dcterms:alternative>
							</xsl:for-each>

							<!-- vuwschema mapping -->

							<xsl:for-each select="//dim:field[@mdschema='vuwschema' and @qualifier='unit']">
								<vuwschema:contributor-unit>
									<xsl:attribute name="xml:lang">
										<xsl:value-of select="@lang" /></xsl:attribute>
									<xsl:value-of select="." />
								</vuwschema:contributor-unit>
							</xsl:for-each>

							<xsl:for-each select="//dim:field[@mdschema='vuwschema' and @qualifier='vuw']">
								<vuwschema:type-vuw>
									<xsl:attribute name="xml:lang">
										<xsl:value-of select="@lang" /></xsl:attribute>
									<xsl:value-of select="." />
								</vuwschema:type-vuw>
							</xsl:for-each>
							<!-- vuwschema subjects -->
							<xsl:for-each select="//dim:field[@mdschema='vuwschema' and @qualifier='anzsrcfor']">
								<dc:subject xsi:type="dcterms:ASRCRFCD">
									<xsl:attribute name="xml:lang">
										<xsl:value-of select="@lang" /></xsl:attribute>
									<xsl:value-of select="." />
								</dc:subject>
							</xsl:for-each>

							<xsl:for-each select="//dim:field[@mdschema='vuwschema' and @qualifier='anzsrcseo']">
								<dc:subject xsi:type="dcterms:ASRCSEO">
									<xsl:attribute name="xml:lang">
										<xsl:value-of select="@lang" /></xsl:attribute>
									<xsl:value-of select="." />
								</dc:subject>
							</xsl:for-each>

							<xsl:for-each select="//dim:field[@mdschema='vuwschema' and @qualifier='anzsrctoa']">
								<dc:subject xsi:type="dcterms:ASRCTOA">
									<xsl:attribute name="xml:lang">
										<xsl:value-of select="@lang" /></xsl:attribute>
									<xsl:value-of select="." />
								</dc:subject>
							</xsl:for-each>

							<xsl:for-each select="//dim:field[@mdschema='vuwschema' and @qualifier='marsden']">
								<dc:subject xsi:type="dcterms:MARSDEN">
									<xsl:attribute name="xml:lang">
										<xsl:value-of select="@lang" /></xsl:attribute>
									<xsl:value-of select="." />
								</dc:subject>
							</xsl:for-each>

							<xsl:for-each select="//dim:field[@mdschema='vuwschema' and @qualifier='nut']">
								<dc:subject xsi:type="dcterms:REO">
									<xsl:attribute name="xml:lang">
										<xsl:value-of select="@lang" /></xsl:attribute>
									<xsl:value-of select="." />
								</dc:subject>
							</xsl:for-each>

							<xsl:for-each select="//dim:field[@mdschema='vuwschema' and @qualifier='cinahl']">
								<dc:subject xsi:type="dcterms:CINAHL">
									<xsl:attribute name="xml:lang">
										<xsl:value-of select="@lang" /></xsl:attribute>
									<xsl:value-of select="." />
								</dc:subject>
							</xsl:for-each>

							<xsl:for-each select="//dim:field[@mdschema='vuwschema' and @qualifier='studentID']">
								<vuwschema:identifier-studentID>
									<xsl:value-of select="." />
								</vuwschema:identifier-studentID>
							</xsl:for-each>
							<xsl:for-each select="//dim:field[@mdschema='vuwschema' and @qualifier='staffID']">
								<vuwschema:identifier-staffID>
									<xsl:value-of select="." />
								</vuwschema:identifier-staffID>
							</xsl:for-each>

							<!-- Thesis Schema mapping -->

							<xsl:for-each select="//dim:field[@mdschema='thesis' and @qualifier='grantor']">
								<thesis:degree-grantor>
									<xsl:attribute name="xml:lang">
										<xsl:value-of select="@lang" /></xsl:attribute>
									<xsl:value-of select="." />
								</thesis:degree-grantor>
							</xsl:for-each>

							<xsl:for-each select="//dim:field[@mdschema='thesis' and @qualifier='discipline']">
								<thesis:degree-discipline>
									<xsl:attribute name="xml:lang">
										<xsl:value-of select="@lang" /></xsl:attribute>
									<xsl:value-of select="." />
								</thesis:degree-discipline>
							</xsl:for-each>

							<xsl:for-each select="//dim:field[@mdschema='thesis' and @qualifier='level']">
								<thesis:degree-level>
									<xsl:attribute name="xml:lang">
										<xsl:value-of select="@lang" /></xsl:attribute>
									<xsl:value-of select="." />
								</thesis:degree-level>
							</xsl:for-each>

							<xsl:for-each select="//dim:field[@mdschema='thesis' and @qualifier='name']">
								<thesis:degree-name>
									<xsl:attribute name="xml:lang">
										<xsl:value-of select="@lang" /></xsl:attribute>
									<xsl:value-of select="." />
								</thesis:degree-name>
							</xsl:for-each>
						</dc:record>
					</mets:xmlData>
				</mets:mdWrap>
			</mets:dmdSec>


			<!-- file-level descriptive metadata -->
			<xsl:for-each select="//locmets:fileGrp[@USE='ORIGINAL' or @USE='TEXT']/locmets:file">
				<mets:dmdSec>
					<xsl:variable name="admID">
						<xsl:value-of select="@ADMID" /></xsl:variable>
					<xsl:attribute name="ID">
						<xsl:value-of select="$admID" />-dmd</xsl:attribute>
					<mets:mdWrap MDTYPE="DC">
						<mets:xmlData>
							<dc:record>
								<dc:description type="filename">
									<xsl:value-of select="//locmets:amdSec[@ID = $admID]//premis:originalName/text()" />
								</dc:description>
								<dc:description>
									<xsl:value-of select="//locmets:amdSec[@ID = $admID]//dim:field[@element='description']/text()" />
								</dc:description>
								<dc:identifier type="dcterms:URI">
									<xsl:value-of select="//locmets:amdSec[@ID = $admID]//premis:objectIdentifierValue/text()" />
								</dc:identifier>
								<dc:format type="dcterms:mimeType">
									<xsl:value-of select="//locmets:amdSec[@ID = $admID]//premis:formatName/text()" />
								</dc:format>
								<dcterms:hasFormat type="dcterms:mimeType">
									<xsl:value-of select="//locmets:amdSec[@ID = $admID]//premis:formatName/text()" />
								</dcterms:hasFormat>
							</dc:record>
						</mets:xmlData>
					</mets:mdWrap>
				</mets:dmdSec>
			</xsl:for-each>

			<!-- Representation Preservation master metadata -->
			<xsl:if test="$testMaster">
				<mets:amdSec ID="rep1-amd">
					<mets:techMD ID="rep1-amd-tech">
						<mets:mdWrap MDTYPE="OTHER" OTHERMDTYPE="dnx">
							<mets:xmlData>
								<dnx:dnx>
									<dnx:section id="generalRepCharacteristics">
										<dnx:record>
											<dnx:key id="preservationType">PRESERVATION_MASTER</dnx:key>
											<xsl:choose>
												<xsl:when test="//dim:field[(@mdschema = 'thesis' and @qualifier='level' and (starts-with(.,'Schema')))]">
													<dnx:key id="representationEntityType">SUPPLEMENTARY_FILES</dnx:key>
												</xsl:when>
												<xsl:when test="//dim:field[(@mdschema = 'dc' and @element='type' and (. = 'Dataset'))]">
													<dnx:key id="representationEntityType">SUPPLEMENTARY_FILES</dnx:key>
												</xsl:when>
												<xsl:otherwise>
													<dnx:key id="representationEntityType">PDF</dnx:key>
												</xsl:otherwise>
											</xsl:choose>
											<dnx:key id="usageType">VIEW</dnx:key>
										</dnx:record>
									</dnx:section>
								</dnx:dnx>
							</mets:xmlData>
						</mets:mdWrap>
					</mets:techMD>
					<mets:rightsMD ID="rep1-amd-rights">
						<mets:mdWrap MDTYPE="OTHER" OTHERMDTYPE="dnx">
							<mets:xmlData>
								<dnx:dnx>
									<dnx:section id="accessRightsPolicy">
										<dnx:record>
											<dnx:key id="policyId">1063</dnx:key>
											<dnx:key id="policyParameters" />
											<dnx:key id="policyDescription">Admin access only (content)</dnx:key>
										</dnx:record>
									</dnx:section>
								</dnx:dnx>
							</mets:xmlData>
						</mets:mdWrap>
					</mets:rightsMD>
				</mets:amdSec>
			</xsl:if>

			<!-- Modified Master Public Access -->
			<xsl:if test="$testModified">
				<mets:amdSec ID="rep2-amd">
					<mets:techMD ID="rep2-amd-tech">
						<mets:mdWrap MDTYPE="OTHER" OTHERMDTYPE="dnx">
							<mets:xmlData>
								<dnx:dnx>
									<dnx:section id="generalRepCharacteristics">
										<dnx:record>
											<dnx:key id="preservationType">MODIFIED_MASTER</dnx:key>
											<dnx:key id="representationEntityType">PDF</dnx:key>
											<dnx:key id="usageType">VIEW</dnx:key>
										</dnx:record>
									</dnx:section>
								</dnx:dnx>
							</mets:xmlData>
						</mets:mdWrap>
					</mets:techMD>
					<mets:rightsMD ID="rep2-amd-rights">
						<mets:mdWrap MDTYPE="OTHER" OTHERMDTYPE="dnx">
							<mets:xmlData>
								<dnx:dnx>
									<dnx:section id="accessRightsPolicy">
										<dnx:record>
											<dnx:key id="policyId">1063</dnx:key>
											<dnx:key id="policyParameters" />
											<dnx:key id="policyDescription">Admin access only (content)</dnx:key>
										</dnx:record>
									</dnx:section>
								</dnx:dnx>
							</mets:xmlData>
						</mets:mdWrap>
					</mets:rightsMD>
				</mets:amdSec>
			</xsl:if>

			<!-- Representation Supplementary Files -->
			<xsl:if test="$testOtherFiles">
				<mets:amdSec ID="rep3-amd">
					<mets:techMD ID="rep3-amd-tech">
						<mets:mdWrap MDTYPE="OTHER" OTHERMDTYPE="dnx">
							<mets:xmlData>
								<dnx:dnx>
									<dnx:section id="generalRepCharacteristics">
										<dnx:record>
											<dnx:key id="preservationType">ADDITIONAL_FILES</dnx:key>
											<dnx:key id="representationEntityType">SUPPLEMENTARY_FILES</dnx:key>
											<dnx:key id="usageType">VIEW</dnx:key>
										</dnx:record>
									</dnx:section>
								</dnx:dnx>
							</mets:xmlData>
						</mets:mdWrap>
					</mets:techMD>
					<mets:rightsMD ID="rep3-amd-rights">
						<mets:mdWrap MDTYPE="OTHER" OTHERMDTYPE="dnx">
							<mets:xmlData>
								<dnx:dnx>
									<dnx:section id="accessRightsPolicy">
										<dnx:record>
											<dnx:key id="policyId">AR_EVERYONE</dnx:key>
											<dnx:key id="policyParameters" />
											<dnx:key id="policyDescription">No restrictions</dnx:key>
										</dnx:record>
									</dnx:section>
								</dnx:dnx>
							</mets:xmlData>
						</mets:mdWrap>
					</mets:rightsMD>
				</mets:amdSec>
			</xsl:if>

			<!-- Representation Permission Form Files -->
			<xsl:if test="$testPermission">
				<mets:amdSec ID="rep4-amd">
					<mets:techMD ID="rep4-amd-tech">
						<mets:mdWrap MDTYPE="OTHER" OTHERMDTYPE="dnx">
							<mets:xmlData>
								<dnx:dnx>
									<dnx:section id="generalRepCharacteristics">
										<dnx:record>
											<dnx:key id="preservationType">ENTITY_DOCUMENTATION</dnx:key>
											<dnx:key id="representationEntityType">PDF</dnx:key>
											<dnx:key id="usageType">VIEW</dnx:key>
										</dnx:record>
									</dnx:section>
								</dnx:dnx>
							</mets:xmlData>
						</mets:mdWrap>
					</mets:techMD>
					<mets:rightsMD ID="rep4-amd-rights">
						<mets:mdWrap MDTYPE="OTHER" OTHERMDTYPE="dnx">
							<mets:xmlData>
								<dnx:dnx>
									<dnx:section id="accessRightsPolicy">
										<dnx:record>
											<dnx:key id="policyId">1062</dnx:key>
											<dnx:key id="policyParameters" />
											<dnx:key id="policyDescription">Admin access only (Forms)</dnx:key>
										</dnx:record>
									</dnx:section>
								</dnx:dnx>
							</mets:xmlData>
						</mets:mdWrap>
					</mets:rightsMD>
				</mets:amdSec>
			</xsl:if>

			<!-- Representation Extracted Text -->
			<xsl:if test="$testExtracted">
				<mets:amdSec ID="rep5-amd">
					<mets:techMD ID="rep5-amd-tech">
						<mets:mdWrap MDTYPE="OTHER" OTHERMDTYPE="dnx">
							<mets:xmlData>
								<dnx:dnx>
									<dnx:section id="generalRepCharacteristics">
										<dnx:record>
											<dnx:key id="preservationType">PDF_EXTRACTED_TEXT</dnx:key>
											<dnx:key id="usageType">VIEW</dnx:key>
										</dnx:record>
									</dnx:section>
								</dnx:dnx>
							</mets:xmlData>
						</mets:mdWrap>
					</mets:techMD>
					<mets:rightsMD ID="rep5-amd-rights">
						<mets:mdWrap MDTYPE="OTHER" OTHERMDTYPE="dnx">
							<mets:xmlData>
								<dnx:dnx>
									<dnx:section id="accessRightsPolicy">
										<dnx:record>
											<dnx:key id="policyId">1063</dnx:key>
											<dnx:key id="policyParameters" />
											<dnx:key id="policyDescription">Admin access only (content)</dnx:key>
										</dnx:record>
									</dnx:section>
								</dnx:dnx>
							</mets:xmlData>
						</mets:mdWrap>
					</mets:rightsMD>
				</mets:amdSec>
			</xsl:if>

			<!-- Representation Derivative Copy -->
			<xsl:if test="$testMaster">
				<mets:amdSec ID="rep6-amd">
					<mets:techMD ID="rep6-amd-tech">
						<mets:mdWrap MDTYPE="OTHER" OTHERMDTYPE="dnx">
							<mets:xmlData>
								<dnx:dnx>
									<dnx:section id="generalRepCharacteristics">
										<dnx:record>
											<dnx:key id="preservationType">DERIVATIVE_COPY</dnx:key>
											<dnx:key id="representationEntityType">PDF</dnx:key>
											<dnx:key id="usageType">VIEW</dnx:key>
										</dnx:record>
									</dnx:section>
								</dnx:dnx>
							</mets:xmlData>
						</mets:mdWrap>
					</mets:techMD>
					<mets:rightsMD ID="rep6-amd-rights">
						<mets:mdWrap MDTYPE="OTHER" OTHERMDTYPE="dnx">
							<mets:xmlData>
								<dnx:dnx>
									<dnx:section id="accessRightsPolicy">
										<dnx:record>
											<dnx:key id="policyId">AR_EVERYONE</dnx:key>
											<dnx:key id="policyParameters" />
											<dnx:key id="policyDescription">No restrictions</dnx:key>
										</dnx:record>
									</dnx:section>
								</dnx:dnx>
							</mets:xmlData>
						</mets:mdWrap>
					</mets:rightsMD>
				</mets:amdSec>
			</xsl:if>

			<!-- Construct Preservation File metadata -->
			<xsl:for-each select="//locmets:fileGrp[@USE='ORIGINAL']/locmets:file">
				<xsl:variable name="admID">
					<xsl:value-of select="@ADMID" /></xsl:variable>
				<mets:amdSec>
					<xsl:attribute name="ID">
						<xsl:value-of select="$admID" /></xsl:attribute>
					<mets:techMD>
						<xsl:attribute name="ID">
							<xsl:value-of select="$admID" />-techmd</xsl:attribute>
						<mets:mdWrap MDTYPE="OTHER" OTHERMDTYPE="dnx">
							<mets:xmlData>
								<dnx:dnx>
									<dnx:section id="fileFixity">
										<dnx:record>
											<dnx:key id="fixityType">
												<xsl:value-of select="@CHECKSUMTYPE" />
											</dnx:key>

											<dnx:key id="fixityValue">
												<xsl:value-of select="@CHECKSUM" />
											</dnx:key>

											<dnx:key id="fileMimeType">
												<xsl:value-of select="@MIMETYPE" />
											</dnx:key>

											<dnx:key id="label">
												<xsl:value-of select="//locmets:amdSec[@ID = $admID]//premis:originalName/text()" />
											</dnx:key>

											<dnx:key id="fileOriginalName">
												<xsl:value-of select="//locmets:amdSec[@ID = $admID]//premis:originalName/text()" />
											</dnx:key>
										</dnx:record>
									</dnx:section>
								</dnx:dnx>
							</mets:xmlData>
						</mets:mdWrap>
					</mets:techMD>
				</mets:amdSec>
			</xsl:for-each>

			<!-- Construct Extracted Text File metadata -->
			<xsl:for-each select="//locmets:fileGrp[@USE='TEXT']/locmets:file">
				<xsl:variable name="admID">
					<xsl:value-of select="@ADMID" /></xsl:variable>
				<mets:amdSec>
					<xsl:attribute name="ID">
						<xsl:value-of select="$admID" /></xsl:attribute>
					<mets:techMD>
						<xsl:attribute name="ID">
							<xsl:value-of select="$admID" />-techmd</xsl:attribute>
						<mets:mdWrap MDTYPE="OTHER" OTHERMDTYPE="dnx">
							<mets:xmlData>
								<dnx:dnx>
									<dnx:section id="fileFixity">
										<dnx:record>
											<dnx:key id="fixityType">
												<xsl:value-of select="@CHECKSUMTYPE" />
											</dnx:key>

											<dnx:key id="fixityValue">
												<xsl:value-of select="@CHECKSUM" />
											</dnx:key>
											<dnx:key id="fileMimeType">
												<xsl:value-of select="@MIMETYPE" />
											</dnx:key>

											<dnx:key id="label">
												<xsl:value-of select="//locmets:amdSec[@ID = $admID]//premis:originalName/text()" />
											</dnx:key>

											<dnx:key id="fileOriginalName">
												<xsl:value-of select="//locmets:amdSec[@ID = $admID]//premis:originalName/text()" />
											</dnx:key>
										</dnx:record>
									</dnx:section>
								</dnx:dnx>
							</mets:xmlData>
						</mets:mdWrap>
					</mets:techMD>
				</mets:amdSec>
			</xsl:for-each>

			<!-- IEEntity Type will change from 'other' when we are supplied entity type list  -->
			<mets:amdSec ID="ie-amd">
				<mets:techMD ID="ie-amd-tech">
					<mets:mdWrap MDTYPE="OTHER" OTHERMDTYPE="dnx">
						<mets:xmlData>
							<dnx:dnx>
								<dnx:section id="generalIECharacteristics">
									<dnx:record>
										<xsl:choose>
											<xsl:when test="//dim:field[(@mdschema = 'thesis' and @qualifier='level' and (starts-with(.,'Master')))]">
												<dnx:key id="IEEntityType">MasterThesis</dnx:key>
											</xsl:when>
											<xsl:when test="//dim:field[(@mdschema = 'vuwschema' and @qualifier='vuw' and (. = 'Masters Dissertation'))]">
												<dnx:key id="IEEntityType">MasterThesis</dnx:key>
											</xsl:when>
											<xsl:when test="//dim:field[(@mdschema = 'thesis' and @qualifier='level' and (. = 'Doctoral'))]">
												<dnx:key id="IEEntityType">DoctoralThesis</dnx:key>
											</xsl:when>
											<xsl:when test="//dim:field[(@mdschema = 'vuwschema' and @qualifier='vuw' and (. = 'Awarded Doctoral Thesis'))]">
												<dnx:key id="IEEntityType">DoctoralThesis</dnx:key>
											</xsl:when>
											<xsl:when test="//dim:field[(@mdschema = 'vuwschema' and @qualifier='vuw' and (. = 'Working or Occasional Paper'))]">
												<dnx:key id="IEEntityType">WorkingPaper</dnx:key>
											</xsl:when>
											<xsl:when test="//dim:field[(@mdschema = 'vuwschema' and @qualifier='vuw' and (. = 'Technical Paper'))]">
												<dnx:key id="IEEntityType">WorkingPaper</dnx:key>
											</xsl:when>
											<xsl:when test="//dim:field[(@mdschema = 'vuwschema' and @qualifier='vuw' and (. = 'Masters Research Paper or Project'))]">
												<dnx:key id="IEEntityType">ResearchPaper</dnx:key>
											</xsl:when>
											<xsl:when test="//dim:field[(@mdschema = 'vuwschema' and @qualifier='vuw' and (. = 'Masters Research Paper'))]">
												<dnx:key id="IEEntityType">ResearchPaper</dnx:key>
											</xsl:when>
											<xsl:when test="//dim:field[(@mdschema = 'vuwschema' and @qualifier='vuw' and (. = 'Research Paper'))]">
												<dnx:key id="IEEntityType">ResearchPaper</dnx:key>
											</xsl:when>
											<xsl:when test="//dim:field[(@mdschema = 'vuwschema' and @qualifier='vuw' and (. = 'Research Paper or Project'))]">
												<dnx:key id="IEEntityType">ResearchPaper</dnx:key>
											</xsl:when>
											<xsl:when test="//dim:field[(@mdschema = 'vuwschema' and @qualifier='vuw' and (. = 'Report for external body – PBRF'))]">
												<dnx:key id="IEEntityType">ResearchPaper</dnx:key>
											</xsl:when>
											<xsl:when test="//dim:field[(@mdschema = 'vuwschema' and @qualifier='vuw' and (. = 'Report for external body – Non PBRF'))]">
												<dnx:key id="IEEntityType">ResearchPaper</dnx:key>
											</xsl:when>
											<xsl:when test="//dim:field[(@mdschema = 'vuwschema' and @qualifier='vuw' and (. = 'Report for External Body - Non PBRF'))]">
												<dnx:key id="IEEntityType">ResearchPaper</dnx:key>
											</xsl:when>
											<xsl:when test="//dim:field[(@mdschema = 'vuwschema' and @qualifier='vuw' and (. = 'Conference Paper in Published Proceedings'))]">
												<dnx:key id="IEEntityType">ConferencePaper</dnx:key>
											</xsl:when>
											<xsl:when test="//dim:field[(@mdschema = 'vuwschema' and @qualifier='vuw' and (. = 'Full Conference Paper'))]">
												<dnx:key id="IEEntityType">ConferencePaper</dnx:key>
											</xsl:when>
											<xsl:when test="//dim:field[(@mdschema = 'vuwschema' and @qualifier='vuw' and (. = 'Conference Contribution - Other'))]">
												<dnx:key id="IEEntityType">ConferencePaper</dnx:key>
											</xsl:when>
											<xsl:when test="//dim:field[(@mdschema = 'vuwschema' and @qualifier='vuw' and (. = 'Conference Oral Contribution'))]">
												<dnx:key id="IEEntityType">ConferencePaper</dnx:key>
											</xsl:when>
											<xsl:when test="//dim:field[(@mdschema = 'dc' and @element='type' and (. = 'Dataset'))]">
												<dnx:key id="IEEntityType">Dataset</dnx:key>
											</xsl:when>
											<xsl:when test="//dim:field[(@mdschema = 'vuwschema' and @qualifier='vuw' and (. = 'Journal Contribution - Research Article'))]">
												<dnx:key id="IEEntityType">JournalArticle</dnx:key>
											</xsl:when>
											<xsl:when test="//dim:field[(@mdschema = 'vuwschema' and @qualifier='vuw' and (. = 'Journal Contribution - Professional and Other'))]">
												<dnx:key id="IEEntityType">JournalArticle</dnx:key>
											</xsl:when>
											<xsl:when test="//dim:field[(@mdschema = 'vuwschema' and @qualifier='vuw' and (. = 'Discussion Paper'))]">
												<dnx:key id="IEEntityType">JournalArticle</dnx:key>
											</xsl:when>
											<xsl:when test="//dim:field[(@mdschema = 'vuwschema' and @qualifier='vuw' and (. = 'Journal Contribution - Book Review'))]">
												<dnx:key id="IEEntityType">BookReview</dnx:key>
											</xsl:when>
											<xsl:when test="//dim:field[(@mdschema = 'vuwschema' and @qualifier='vuw' and (. = 'Chapter in Book – Research'))]">
												<dnx:key id="IEEntityType">BookChapter</dnx:key>
											</xsl:when>
											<xsl:when test="//dim:field[(@mdschema = 'vuwschema' and @qualifier='vuw' and (. = 'Authored Book – Other'))]">
												<dnx:key id="IEEntityType">Book</dnx:key>
											</xsl:when>
											<xsl:when test="//dim:field[(@mdschema = 'vuwschema' and @qualifier='vuw' and (. = 'Authored Book - Research'))]">
												<dnx:key id="IEEntityType">Book</dnx:key>
											</xsl:when>
											<xsl:when test="//dim:field[(@mdschema = 'vuwschema' and @qualifier='vuw' and (. = 'Monograph'))]">
												<dnx:key id="IEEntityType">Book</dnx:key>
											</xsl:when>
											<xsl:when test="//dim:field[(@mdschema = 'vuwschema' and @qualifier='vuw' and (. = 'Conference Poster Contribution'))]">
												<dnx:key id="IEEntityType">ConferencePoster</dnx:key>
											</xsl:when>
											<xsl:otherwise>
												<dnx:key id="IEEntityType">null</dnx:key>
											</xsl:otherwise>
										</xsl:choose>
									</dnx:record>
								</dnx:section>
							</dnx:dnx>
						</mets:xmlData>
					</mets:mdWrap>
				</mets:techMD>

				<!-- Access Rights for IE -->
				<mets:rightsMD ID="ie-amd-rights">
					<mets:mdWrap MDTYPE="OTHER" OTHERMDTYPE="dnx">
						<mets:xmlData>
							<dnx:dnx>
								<dnx:section id="accessRightsPolicy">
									<dnx:record>
										<dnx:key id="policyId">AR_EVERYONE</dnx:key>
										<dnx:key id="policyParameters" />
										<dnx:key id="policyDescription">No restrictions</dnx:key>
									</dnx:record>
								</dnx:section>
							</dnx:dnx>
						</mets:xmlData>
					</mets:mdWrap>
				</mets:rightsMD>

				<!-- Addition of MODS metadata as source -->
				<mets:sourceMD ID="ie-amd-source-MODS-1">
					<mets:mdWrap MDTYPE="MODS">
						<mets:xmlData>
							<mods:mods>
								<xsl:apply-templates select="//mods:mods/*" />
							</mods:mods>
						</mets:xmlData>
					</mets:mdWrap>
				</mets:sourceMD>

				<!-- Thie is the stub for the imported MARC data-->
				<mets:sourceMD ID="ie-amd-source-MARC">
					<mets:mdWrap MDTYPE="MARC">
						<mets:xmlData>
							<collection xmlns="http://www.loc.gov/MARC21/slim" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" />
						</mets:xmlData>
					</mets:mdWrap>
				</mets:sourceMD>

				<!-- Addition of Premis metadata as source -->
				<mets:sourceMD ID="ie-amd-source-PREMIS">
					<mets:mdWrap MDTYPE="OTHER" OTHERMDTYPE="premis">
						<mets:xmlData>
							<premis:premis>
								<xsl:apply-templates select="//premis:premis/*" />
							</premis:premis>
						</mets:xmlData>
					</mets:mdWrap>
				</mets:sourceMD>

				<!-- Addition of Dspace Intermediary Metadata (DIM) as source -->
				<mets:sourceMD ID="ie-amd-source-DIM">
					<mets:mdWrap MDTYPE="OTHER" OTHERMDTYPE="dim">
						<mets:xmlData>
							<dim:dim>
								<xsl:apply-templates select="//dim:dim/*" />
							</dim:dim>
						</mets:xmlData>
					</mets:mdWrap>
				</mets:sourceMD>
				<mets:digiprovMD ID="ie-amd-digiprov">
					<mets:mdWrap MDTYPE="OTHER" OTHERMDTYPE="dnx">
						<mets:xmlData>
							<dnx/>
						</mets:xmlData>
					</mets:mdWrap>
				</mets:digiprovMD>
			</mets:amdSec>
			<mets:fileSec>
				<!-- START OF File group section. -->

				<!-- File group section. Preservation Master for Thesis -->
				<xsl:if test="$testMaster">
					<mets:fileGrp USE="VIEW" ID="rep1" ADMID="rep1-amd">
						<xsl:for-each select="$testMaster">
							<xsl:variable name="admID">
								<xsl:value-of select="@ADMID" /></xsl:variable>
							<mets:file>
								<xsl:apply-templates select="@ID | @MIMETYPE " />
								<xsl:if test="@CHECKSUMTYPE">
									<xsl:attribute name="ADMID">
										<xsl:value-of select="$admID" /></xsl:attribute>
									<xsl:attribute name="DMDID">
										<xsl:value-of select="$admID" />-dmd</xsl:attribute>
								</xsl:if>
								<mets:FLocat>
									<xsl:apply-templates select="locmets:FLocat/@*" />
								</mets:FLocat>
							</mets:file>
						</xsl:for-each>
					</mets:fileGrp>
				</xsl:if>

				<!-- File group section. Modified Master for Redacted Thesis -->
				<xsl:if test="$testModified">
					<mets:fileGrp USE="VIEW" ID="rep2" ADMID="rep2-amd">
						<xsl:for-each select="$testModified">
							<xsl:variable name="admID">
								<xsl:value-of select="@ADMID" /></xsl:variable>
							<mets:file>
								<xsl:apply-templates select="@ID | @MIMETYPE " />
								<xsl:if test="@CHECKSUMTYPE">
									<xsl:attribute name="ADMID">
										<xsl:value-of select="$admID" /></xsl:attribute>
									<xsl:attribute name="DMDID">
										<xsl:value-of select="$admID" />-dmd</xsl:attribute>
								</xsl:if>
								<mets:FLocat>
									<xsl:apply-templates select="locmets:FLocat/@*" />
								</mets:FLocat>
							</mets:file>
						</xsl:for-each>
					</mets:fileGrp>
				</xsl:if>

				<!-- File group section. Supplementary Files-->
				<xsl:if test="$testOtherFiles">
					<mets:fileGrp USE="VIEW" ID="rep3" ADMID="rep3-amd">
						<xsl:for-each select="$testOtherFiles">
							<xsl:variable name="admID">
								<xsl:value-of select="@ADMID" /></xsl:variable>
							<mets:file>
								<xsl:apply-templates select="@ID | @MIMETYPE " />
								<xsl:if test="@CHECKSUMTYPE">
									<xsl:attribute name="ADMID">
										<xsl:value-of select="$admID" /></xsl:attribute>
									<xsl:attribute name="DMDID">
										<xsl:value-of select="$admID" />-dmd</xsl:attribute>
								</xsl:if>
								<mets:FLocat>
									<xsl:apply-templates select="locmets:FLocat/@*" />
								</mets:FLocat>
							</mets:file>
						</xsl:for-each>
					</mets:fileGrp>
				</xsl:if>

				<!-- File group section. Permission Form-->
				<xsl:if test="$testPermission">
					<mets:fileGrp USE="VIEW" ID="rep4" ADMID="rep4-amd">
						<xsl:for-each select="$testPermission">
							<xsl:variable name="admID">
								<xsl:value-of select="@ADMID" /></xsl:variable>
							<mets:file>
								<xsl:apply-templates select="@ID | @MIMETYPE " />
								<xsl:if test="@CHECKSUMTYPE">
									<xsl:attribute name="ADMID">
										<xsl:value-of select="$admID" /></xsl:attribute>
									<xsl:attribute name="DMDID">
										<xsl:value-of select="$admID" />-dmd</xsl:attribute>
								</xsl:if>
								<mets:FLocat>
									<xsl:apply-templates select="locmets:FLocat/@*" />
								</mets:FLocat>
							</mets:file>
						</xsl:for-each>
					</mets:fileGrp>
				</xsl:if>

				<!-- File group section. Extracted Text-->
				<xsl:if test="$testExtracted">
					<mets:fileGrp USE="VIEW" ID="rep5" ADMID="rep5-amd">
						<xsl:for-each select="$testExtracted">
							<xsl:variable name="admID">
								<xsl:value-of select="@ADMID" /></xsl:variable>
							<mets:file ID="{@ID}-extracted">
								<xsl:apply-templates select="@MIMETYPE " />
								<xsl:if test="@CHECKSUMTYPE">
									<xsl:attribute name="ADMID">
										<xsl:value-of select="$admID" /></xsl:attribute>
								</xsl:if>
								<mets:FLocat>
									<xsl:apply-templates select="locmets:FLocat/@*" />
								</mets:FLocat>
							</mets:file>
						</xsl:for-each>
					</mets:fileGrp>
				</xsl:if>

				<!-- File group section. Derivative Copy for Thesis -->
				<xsl:choose>
					<xsl:when test="$testModified">
						<mets:fileGrp USE="VIEW" ID="rep6" ADMID="rep6-amd">
							<xsl:for-each select="$testModified">
								<xsl:variable name="admID">
									<xsl:value-of select="@ADMID" /></xsl:variable>
								<mets:file ID="{@ID}-1">
									<xsl:apply-templates select="@MIMETYPE " />
									<xsl:if test="@CHECKSUMTYPE">
										<xsl:attribute name="ADMID">
											<xsl:value-of select="$admID" /></xsl:attribute>
									</xsl:if>
									<mets:FLocat>
										<xsl:apply-templates select="locmets:FLocat/@*" />
									</mets:FLocat>
								</mets:file>
							</xsl:for-each>
						</mets:fileGrp>
					</xsl:when>
					<xsl:otherwise>
						<mets:fileGrp USE="VIEW" ID="rep6" ADMID="rep6-amd">
							<xsl:for-each select="$testMaster">
								<xsl:variable name="admID">
									<xsl:value-of select="@ADMID" /></xsl:variable>
								<mets:file ID="{@ID}-1">
									<xsl:apply-templates select="@MIMETYPE " />
									<xsl:if test="@CHECKSUMTYPE">
										<xsl:attribute name="ADMID">
											<xsl:value-of select="$admID" /></xsl:attribute>
									</xsl:if>
									<mets:FLocat>
										<xsl:apply-templates select="locmets:FLocat/@*" />
									</mets:FLocat>
								</mets:file>
							</xsl:for-each>
						</mets:fileGrp>
					</xsl:otherwise>
				</xsl:choose>
				<!-- END OF File group section.  -->
			</mets:fileSec>

			<!-- Structure map for Preservation Master files -->
			<xsl:if test="$testMaster">
				<mets:structMap ID="rep1-1" TYPE="logical">
					<mets:div LABEL="PRESERVATION MASTER">
						<!--<mets:div LABEL="CONTENTS">-->
						<xsl:for-each select="$testMaster">
							<xsl:variable name="admID">
								<xsl:value-of select="@ADMID" /></xsl:variable>
							<mets:div TYPE="FILE">
								<xsl:attribute name="LABEL">
									<xsl:value-of select="//locmets:amdSec[@ID = $admID]//premis:originalName/text()" /></xsl:attribute>
								<mets:fptr FILEID="{@ID}" />
							</mets:div>
						</xsl:for-each>
						<!--</mets:div>-->
					</mets:div>
				</mets:structMap>
			</xsl:if>


			<!-- Structure map for Modified Master - Redacted Thesis files -->
			<xsl:if test="$testModified">
				<mets:structMap ID="rep2-1" TYPE="logical">
					<mets:div LABEL="MODIFIED MASTER">
						<!--mets:div LABEL="CONTENTS">-->
						<xsl:for-each select="$testModified">
							<xsl:variable name="admID">
								<xsl:value-of select="@ADMID" /></xsl:variable>
							<mets:div TYPE="FILE">
								<xsl:attribute name="LABEL">
									<xsl:value-of select="//locmets:amdSec[@ID = $admID]//premis:originalName/text()" /></xsl:attribute>
								<mets:fptr FILEID="{@ID}" />
							</mets:div>
						</xsl:for-each>
						<!--</mets:div>-->
					</mets:div>
				</mets:structMap>
			</xsl:if>

			<!-- Structure map section. Supplementary Files-->
			<xsl:if test="$testOtherFiles">
				<mets:structMap ID="rep3-1" TYPE="logical">
					<mets:div LABEL="SUPPORTING FILES">
						<!--mets:div LABEL="CONTENTS">-->
						<xsl:for-each select="$testOtherFiles">
							<xsl:variable name="admID">
								<xsl:value-of select="@ADMID" /></xsl:variable>
							<mets:div TYPE="FILE">
								<xsl:attribute name="LABEL">
									<xsl:value-of select="//locmets:amdSec[@ID = $admID]//premis:originalName/text()" /></xsl:attribute>
								<mets:fptr FILEID="{@ID}" />
							</mets:div>
						</xsl:for-each>
						<!--</mets:div>-->
					</mets:div>
				</mets:structMap>
			</xsl:if>

			<!-- Structure map section. Permission Form-->
			<xsl:if test="$testPermission">
				<mets:structMap ID="rep4-1" TYPE="logical">
					<mets:div LABEL="PERMISSION FORM">
						<!--mets:div LABEL="CONTENTS">-->
						<xsl:for-each select="$testPermission">
							<xsl:variable name="admID">
								<xsl:value-of select="@ADMID" /></xsl:variable>
							<mets:div TYPE="FILE">
								<xsl:attribute name="LABEL">
									<xsl:value-of select="//locmets:amdSec[@ID = $admID]//premis:originalName/text()" /></xsl:attribute>
								<mets:fptr FILEID="{@ID}" />
							</mets:div>
						</xsl:for-each>
						<!--</mets:div>-->
					</mets:div>
				</mets:structMap>
			</xsl:if>


			<!-- Structure map for extracted text files -->
			<xsl:if test="$testExtracted">
				<mets:structMap ID="rep5-1" TYPE="logical">
					<mets:div LABEL="EXTRACTED TEXT">
						<!--<mets:div LABEL="CONTENTS">-->
						<xsl:for-each select="$testExtracted">
							<xsl:variable name="admID">
								<xsl:value-of select="@ADMID" /></xsl:variable>
							<mets:div TYPE="FILE">
								<xsl:attribute name="LABEL">
									<xsl:value-of select="//locmets:amdSec[@ID = $admID]//premis:originalName/text()" /></xsl:attribute>
								<mets:fptr FILEID="{@ID}-extracted" />
							</mets:div>
						</xsl:for-each>
						<!--</mets:div>-->
					</mets:div>
				</mets:structMap>
			</xsl:if>

			<!-- Structure map for Derivative Copy -->
			<xsl:choose>
				<xsl:when test="$testModified">
					<mets:structMap ID="rep6-1" TYPE="logical">
						<mets:div LABEL="FULL TEXT">
							<!--<mets:div LABEL="DERIVATIVE COPY">-->
							<xsl:for-each select="$testModified">
								<xsl:variable name="admID">
									<xsl:value-of select="@ADMID" /></xsl:variable>
								<mets:div TYPE="FILE">
									<xsl:attribute name="LABEL">
										<xsl:value-of select="//locmets:amdSec[@ID = $admID]//premis:originalName/text()" /></xsl:attribute>
									<mets:fptr FILEID="{@ID}-1" />
								</mets:div>
							</xsl:for-each>
							<!--</mets:div>-->
						</mets:div>
					</mets:structMap>
				</xsl:when>
				<xsl:otherwise>
					<mets:structMap ID="rep6-1" TYPE="logical">
						<mets:div LABEL="FULL TEXT">
							<!--<mets:div LABEL="DERIVATIVE COPY">-->
							<xsl:for-each select="$testMaster">
								<xsl:variable name="admID">
									<xsl:value-of select="@ADMID" /></xsl:variable>
								<mets:div TYPE="FILE">
									<xsl:attribute name="LABEL">
										<xsl:value-of select="//locmets:amdSec[@ID = $admID]//premis:originalName/text()" /></xsl:attribute>
									<mets:fptr FILEID="{@ID}-1" />
								</mets:div>
							</xsl:for-each>
							<!--</mets:div>-->
						</mets:div>
					</mets:structMap>
				</xsl:otherwise>
			</xsl:choose>
		</mets:mets>
	</xsl:template>
</xsl:stylesheet>
