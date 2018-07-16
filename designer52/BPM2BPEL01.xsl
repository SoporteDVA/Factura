<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="no" encoding="UTF-8" standalone="yes"/>
	<xsl:template match="/">
		<xsl:choose>
			<xsl:when test="BPD/Version='1.0.0.1'">
				<Process name="{BPD/Name}" BPMversion="1.0.0.1">
					<partnerLinks>
						<xsl:for-each select="BPD/Pools/Pool/Process/GraphicalElements/Task/@server">
							<partnerLink name="{.}"/>
						</xsl:for-each>
					</partnerLinks>
					<xsl:call-template name="main"/>
				</Process>
			</xsl:when>
			<xsl:otherwise>Versión(<xsl:value-of select="BPD/Version"/>) incompatible con la plantilla BPM2BPEL01.</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- Funcciones para procesar Actividades -->
	<xsl:template name="main">
		<xsl:for-each select="BPD/Pools/Pool/Process/GraphicalElements">
			<variables>
				<xsl:for-each select="*/*[contains(name(),'Message')]/Properties">
					<xsl:call-template name="variables"/>
				</xsl:for-each>
			</variables>
			<sequence>
				<receive variable="{concat(/BPD/Name,'Input')}"/>
				<xsl:call-template name="secuencia">
					<xsl:with-param name="idRight" select="Start/@IdRight"/>
					<xsl:with-param name="idBottom" select="Start/@IdBottom"/>
				</xsl:call-template>
			</sequence>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="secuencia">
		<xsl:param name="idRight"/>
		<xsl:param name="idBottom"/>
		<xsl:for-each select="/BPD/Pools/Pool/Process/GraphicalElements/SequenceFlow[@Source=$idRight or @Source=$idBottom]">
			<xsl:if test="Assignments">
				<xsl:variable name="target" select="@Target"/>
				<xsl:variable name="sigActividad" select="../*[@IdLeft=$target or @IdTop=$target or @IdRight=$target or @IdBottom=$target]"/>
				<assign>
					<xsl:for-each select="Assignments/Assignment">
						<copy>
							<from type="{@type}" value="{@from}"/>
							<to variable="{@to}"/>
						</copy>
					</xsl:for-each>
				</assign>
			</xsl:if>
			<xsl:call-template name="buscarActividad">
				<xsl:with-param name="id" select="@Target"/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="buscarActividad">
		<xsl:param name="id"/>
		<xsl:for-each select="/BPD/Pools/Pool/Process/GraphicalElements/*[@IdLeft=$id or @IdTop=$id or @IdRight=$id or @IdBottom=$id]">
			<xsl:choose>
				<xsl:when test="name()='ExclusiveGateway'">
					<switch name="{Name}">
						<xsl:variable name="idRight" select="@IdRight"/>
						<case condition="{../SequenceFlow[@Source=$idRight]/@ConditionExpression}">
							<xsl:call-template name="secuencia">
								<xsl:with-param name="idRight" select="@IdRight"/>
								<xsl:with-param name="idBottom" select="0"/>
							</xsl:call-template>
						</case>
						<otherwise>
							<xsl:call-template name="secuencia">
								<xsl:with-param name="idRight" select="@IdBottom"/>
								<xsl:with-param name="idBottom" select="0"/>
							</xsl:call-template>
						</otherwise>
					</switch>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="name()='Task'">
							<xsl:call-template name="invoke_scope">
								<xsl:with-param name="inner" select="'invoke'"/>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="name()='Subprocess'">
							<xsl:call-template name="invoke_scope">
								<xsl:with-param name="inner" select="'scope'"/>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="name()='Transformation'">
							<transformation name="{Name}" variable="{concat(Name,'Output')}">
								<xsl:copy-of select="xsl:stylesheet"/>
							</transformation>
						</xsl:when>
						<xsl:when test="name()='Converter'">
							<convert name="{Name}" inputVariable="{concat(Name,'Input')}" outputVariable="{concat(Name,'Output')}" type="{@type}"/>
						</xsl:when>
						<xsl:when test="name()='End'">
							<xsl:if test="EndResult='Message'">
								<reply variable="{OutputName}"/>
							</xsl:if>
							<xsl:if test="EndResult='Error'">
								<throw faultVariable="{OutputName}"/>
							</xsl:if>
						</xsl:when>
					</xsl:choose>
					<xsl:call-template name="secuencia">
						<xsl:with-param name="idRight" select="@IdRight"/>
						<xsl:with-param name="idBottom" select="@IdBottom"/>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="invoke_scope">
		<xsl:param name="inner"/>
		<xsl:choose>
			<!-- Se trata de un ciclo while -->
			<xsl:when test="@loopType='Standard'">
				<while testTime="{@testTime}" condition="{@miCondition}" loopCounter="{@loopCounter}">
					<xsl:call-template name="invoke_scope_inner">
						<xsl:with-param name="inner" select="$inner"/>
						<xsl:with-param name="assign" select="@assignTime"/>
					</xsl:call-template>
				</while>
			</xsl:when>
			<!-- Se trata de un ciclo forEarch -->
			<xsl:when test="@loopType='MultiInstance'">
				<foreach variable="{@miCondition}">
					<xsl:call-template name="invoke_scope_inner">
						<xsl:with-param name="inner" select="$inner"/>
						<xsl:with-param name="assign" select="@assignTime"/>
					</xsl:call-template>
				</foreach>
			</xsl:when>
			<!-- No tiene ciclo de ningun tipo -->
			<xsl:otherwise>
				<xsl:call-template name="invoke_scope_inner">
					<xsl:with-param name="inner" select="$inner"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="invoke_scope_inner">
		<xsl:param name="inner"/>
		<xsl:param name="assign"/>
		<xsl:if test="$assign='Before'">
			<xsl:for-each select="Assignments">
				<assign>
					<xsl:for-each select="Assignment">
						<copy>
							<from type="{@type}" value="{@from}"/>
							<to variable="{@to}"/>
						</copy>
					</xsl:for-each>
				</assign>
			</xsl:for-each>
		</xsl:if>
		<xsl:element name="{$inner}">
			<xsl:attribute name="name">
				<xsl:value-of select="Name"/>
			</xsl:attribute>
			<xsl:attribute name="inputVariable">
				<xsl:value-of select="concat(Name,'Input')"/>
			</xsl:attribute>
			<xsl:attribute name="outputVariable">
				<xsl:value-of select="concat(Name,'Output')"/>
			</xsl:attribute>
			<xsl:attribute name="faultVariable">
				<xsl:value-of select="concat(Name,'Fault')"/>
			</xsl:attribute>
			<xsl:choose>
				<xsl:when test="$inner='invoke'">
					<xsl:attribute name="Servidor">
						<xsl:value-of select="@server"/>
					</xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:variable name="subarchivo" select="@NombreProceso"/>
					<xsl:for-each select="document(concat($subarchivo,'.xml'))">
						<xsl:call-template name="main"/>
					</xsl:for-each>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:element>
		<xsl:if test="$assign='After'">
			<xsl:for-each select="Assignments">
				<assign>
					<xsl:for-each select="Assignment">
						<copy>
							<from type="{@type}" value="{@from}"/>
							<to variable="{@to}"/>
						</copy>
					</xsl:for-each>
				</assign>
			</xsl:for-each>
		</xsl:if>
	</xsl:template>
	<!-- Funciones miscelaneas para generar las variables del proceso o subproceso -->
	<xsl:template match="Properties" name="variables">
		<xsl:choose>
			<xsl:when test="parent::Message">
				<xsl:choose>
					<xsl:when test="ancestor::Start">
						<xsl:element name="{concat(/BPD/Name,'Input')}">
							<xsl:apply-templates/>
						</xsl:element>
					</xsl:when>
					<xsl:when test="../../OutputName">
						<xsl:element name="{../../OutputName}">
						<xsl:attribute name="Template"><xsl:value-of select="../../Template"/></xsl:attribute>
							<xsl:apply-templates/>
						</xsl:element>
					</xsl:when>
					<xsl:when test="ancestor::Transformation">
						<xsl:element name="{concat(../../Name,'Output')}">
							<xsl:apply-templates/>
						</xsl:element>
					</xsl:when>
					<xsl:when test="ancestor::Converter">
						<xsl:if test="../../@type='Split'">
							<xsl:element name="{concat(../../Name,'Input')}">
								<xsl:element name="{../../Property/@name}"/>
							</xsl:element>
							<xsl:element name="{concat(../../Name,'Output')}">
								<xsl:apply-templates/>
							</xsl:element>
						</xsl:if>
						<xsl:if test="../../@type='Join'">
							<xsl:element name="{concat(../../Name,'Input')}">
								<xsl:apply-templates/>
							</xsl:element>
							<xsl:element name="{concat(../../Name,'Output')}">
								<xsl:element name="{../../Property/@name}"/>
							</xsl:element>
						</xsl:if>
					</xsl:when>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="parent::FaultMessage">
				<xsl:element name="{concat(../../Name,'Fault')}">
					<xsl:apply-templates/>
				</xsl:element>
			</xsl:when>
			<xsl:when test="parent::InputMessage">
				<xsl:element name="{concat(../../Name,'Input')}">
					<xsl:apply-templates/>
				</xsl:element>
			</xsl:when>
			<xsl:when test="parent::OutputMessage">
				<xsl:element name="{concat(../../Name,'Output')}">
					<xsl:choose>
						<xsl:when test="../../@loopType">
							<Resultados multiple="true">
								<xsl:apply-templates/>
							</Resultados>
						</xsl:when>
						<xsl:otherwise>
							<xsl:apply-templates/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:element>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="Property">
		<xsl:element name="{@name}">
			<xsl:if test="@length">
				<xsl:attribute name="length">
					<xsl:value-of select="@length"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="@type">
				<xsl:attribute name="type">
					<xsl:value-of select="@type"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="@rep">
				<xsl:attribute name="rep">
					<xsl:value-of select="@rep"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="@multiple">
				<xsl:attribute name="multiple">
					<xsl:value-of select="@multiple"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="descendant::Properties">
				<xsl:apply-templates/>
			</xsl:if>
		</xsl:element>
	</xsl:template>
	<xsl:template match="Start">
		<xsl:apply-templates/>
	</xsl:template>
</xsl:stylesheet>
-->