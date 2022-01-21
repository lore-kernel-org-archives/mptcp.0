Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2832CA7
	for <mptcp@lists.linux.dev>; Fri, 21 Jan 2022 07:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642749784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WieA6nEM+bnqdUTN4UqCEl6VUdzJ5Pt7SGVb1qbHTp4=;
	b=jJZwCwqpGzT3rnJpI7It+eZnBjqhqse+vvrvQtSinexnMEocSfruzQDsX2Lb3aVh3DERHn
	CpR4UYhiPSC5YOwT7OtSp1sJiRcshWkAqVODNdwg+o3lyKz9XlHnjF01lF8jffLXzkEyps
	pnAfOp2E2h7M4CkyqH7ptqt28KHeu08=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2054.outbound.protection.outlook.com [104.47.12.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-35-RB7nQwbuOMSTLYL-hqx77A-1; Fri, 21 Jan 2022 08:23:03 +0100
X-MC-Unique: RB7nQwbuOMSTLYL-hqx77A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KiHPMiRnNi6DkOZb0Tt7Dy1mhx/siKYwi7nRQSuAWylIySgWS20p11RpnykTrsQKANBbUZXzVYIVvDoe5cA9aQGUewQ6mbImDc5qjIYrCd/EZ6ESe7rbzmuvndPnUofchFJki+q4SqLJmtnDxjmtKeb4y1/4IH6Ef3mxrD/36al38nJe9sVbXnFP7eeZOfmW8VMnNVRhkvRjgFoaDjeevUJAWEeM4DIyYjNkLalEImJJiMuvpaH8QgIVKd1rDzMiMDxUUemT269kd010g3TV9XLI0NWytbn8i3HSlsA7MWXkLPe8si9+N0krFXbXEx243W3EcJvsU9si+FnbAXA9zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wKJOMtB36Ffp/kfs+iQN1fL67/IzSrx1+y42sov1qQ=;
 b=AnprUyzB+AKjkMybQ3w7U28PVBzYqZRoB/Tw+PQTnHqMb2U+/s+NBKYxuHmG7D9OuRCnnJaaofv+XILF5HB9EkaXiz1DqBjuhzOnZdqYFgPIBqWEvAknfcXzJnoKASoLHhjTHRO8a0YSwBCc7OGrzTBwebtHllocowTRlhh9e4ZE6L36bE+eGEtOBRaIg6oNrPbbjIwt1Cqy/3vy+00EsrhZnk63YKr/slwP769mMZqxBok0zoFFoh9osGop7owvcIM3MQaE5xloebbS5E0wujM4yP9ASqbNsiiVirmCzTYhKie+G6/VqEq76ONcVvx8ZVnD0DobADsL+5Hif8mtcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7600.eurprd04.prod.outlook.com (2603:10a6:102:f2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Fri, 21 Jan
 2022 07:23:02 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c%6]) with mapi id 15.20.4909.010; Fri, 21 Jan 2022
 07:23:02 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH iproute2-next v7] mptcp: add the fullmesh flag setting support
Date: Fri, 21 Jan 2022 15:23:09 +0800
Message-ID: <1a295b3d53f3da82e8c47173fded5e679a25345d.1642748699.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0080.apcprd04.prod.outlook.com
 (2603:1096:202:15::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08ede73c-6ad0-4bac-efb6-08d9dcaedc00
X-MS-TrafficTypeDiagnostic: PA4PR04MB7600:EE_
X-Microsoft-Antispam-PRVS:
	<PA4PR04MB7600D0CA864CD8EA63D89C87F85B9@PA4PR04MB7600.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LChW3YkULhzkBgnvK6ZGP7HRwZI92UbpsCHKWddwvQPbWp+kL/hCNl7DkzxEVmdPN6d8CN4wFkXR7EHtLYgV9YzXYypYnTYphB7CDoDyAz2ys5eMNqt3p9hzQWG61N8T9QTHIs35SEi/e0G5efxjKsGi94zdG29rAGglmjrZ1eYojMew24G3dnjo8cc25ZctmIpw2tdwsGUV5hZ82QmHe6YUr6Iwl7GmRcuvvHpIfEQ4aMIb+ErzfWyUBnBXWh3T2v87BILscuoXJzY2x2WQrLw3F1L99Or+L6aw9EsQGzKJUtQcMxL6mtGU9tf1DL882etEqngi2d+EcLdx1+LO4INvzRt1RvCSemkBSgdXY1KLZmkmE2RpXg8RKpvF/m7D8G/7JM/qPolkDoP9D1YGPVXgevqzKsMOGv7zgKz/rTNJkV84G1ayGH3CrfccPGkJ2TGsNUALXss1gkMnOCvYU+kdBKEN0da1BOzv3kmzO8fW2d7T9NgxxT7CNkR0qAuBYANI3pqsPv0BuAJP1z45XO4CJx2fe61noetyseOoae2U5wVurtoyKZ9HmhbYCfC0gloG/YAqHG6KqsQv5WYiPitCo5APKJbEJhPa3hbCM0eUTjgY+zP6xLBgtwXHoWkbCokdvXdTKmpthDfU+PKeFA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2616005)(4326008)(44832011)(66556008)(8676002)(66476007)(54906003)(5660300002)(8936002)(508600001)(66946007)(6916009)(2906002)(36756003)(86362001)(83380400001)(316002)(6486002)(6506007)(38100700002)(6512007)(186003)(55236004)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GDYpZ0YbTmeyg2c4wwltKUPaHoTA0LLvys+mvlXRAI7ldJlZxWdiYZguhSz8?=
 =?us-ascii?Q?ZpDzX4vknWiUUovvmG+2/74HC1wZVKalrw6vhVb+I+KWdI36BGR10iTT9Bm+?=
 =?us-ascii?Q?qaAi8ya6JG8zlidEvM3kon4G+jujziDQiKQLyIARtyUlTlGkPKDbt9/b26Du?=
 =?us-ascii?Q?jldGM+ExQIwk1MZVgzBNxWYAZ5lxF43e43SdykFUWNNCgqaMyOYTjsvAPo0U?=
 =?us-ascii?Q?Act8ysB9Lqks+S4Ce3kf6I0yFxKBUszHRgmKFLHj15x2i+91kje8Gp7w/Cn5?=
 =?us-ascii?Q?XOPXNx0wn+H+d+4X/qKzsFpjfhlEm5HuD3dUvlnM7iy5ywRkBZiw6B5u7/w6?=
 =?us-ascii?Q?LbLszvmT5AvYLTPuamQbCLxjG0tBMUmKZgBlgIOhpD09Oc5u7SRqkQOVLDIj?=
 =?us-ascii?Q?Ali4uhI2sumWOmRUMkTlnBahFm1VGSBybU8RJy7Yv6tfn4/YRjl1XGdcCt1j?=
 =?us-ascii?Q?V8fYZAdjrhUlxtfx/a13PBwAKJMgfF0M5tg+f9vkBDh3w8Xfve9aZRArGcYy?=
 =?us-ascii?Q?YSEl5oy901AI68NtqM/MVodwSmzHnGzPDsdIsqJr3v+NG1/FJaRihklnS7ce?=
 =?us-ascii?Q?2Nncg/+I+Ln1M+bMHnQFMsx7dHLWLx/86jikrYhDcbebqy8fKj2ddSQV7736?=
 =?us-ascii?Q?nXkJZ4eFkQpxFAKL7KNzK3EVg3CqxrYFSxrF5HnpOMFIpExbqDiK785wX4ST?=
 =?us-ascii?Q?W+h1K1wPLo99GKdJh/tlk9fm6R8sX/YwkIPK6xFmx2780CWCQ/s3sXKEGwje?=
 =?us-ascii?Q?V8i04xs6KvPy0DBk8B++inBXyiftbKFpbSXFB15URIPyCIH6sORXlptkcpwD?=
 =?us-ascii?Q?7ERoheTFkTybwl/5OhlmQ2jfLR6tUxk1JOPe9ai17U532oKhCd5GRgGinEu/?=
 =?us-ascii?Q?v0ZXqCzKpAJ+dphNMPPl5j8YDzupPOmRzPFljzalxhD+J81qY5VvoFs8zlTC?=
 =?us-ascii?Q?2l5wbZUE/1KCUk8ITntYS0TvEQDerMaWz0qcw5hDhtSP5rkOGELJX2K9Sebt?=
 =?us-ascii?Q?KsGIWS1UOqfFxuGVRJoBS9p1HMp4/YRredykILIu5ENEMosvZtDhXPL0S0V8?=
 =?us-ascii?Q?ihxLhF3S0/4C0SvK4Tw3lwKu1XGlekiKdIzovWTQ9L6NpE1oaldGILpXa02Y?=
 =?us-ascii?Q?4IkWfvPjBojExyVEi8i7ERnqIxOiJ8ae7zpB0wVppv0zFe/Eh9nXAOZB81np?=
 =?us-ascii?Q?zPlo6K4JtnfL7KOLChkPvRqUPZQAKj1CKTSMBWNint2RFjGzhkwA1v3xIGF/?=
 =?us-ascii?Q?km9XEy/hpR3bMFxs+23JBOVrSFQt3wKID8mT4SilIrr2H9ZcQswnR2igzARq?=
 =?us-ascii?Q?bdNFzq59cnyEbgvjO21yChWTL8Xbzx5asqfgaRIhdo69JfZ26xlq6tB+miE2?=
 =?us-ascii?Q?haagPN/HGsLxA3TzDQlBdROgfTHcPOpaQKracp3CB12YSaPXHEPUVt7quvfJ?=
 =?us-ascii?Q?sSNYiUCnsO2inK7dCKUyW1F7yHzuuW4zWmXPAiQtsNKQwcaAsvhu27R+AyJm?=
 =?us-ascii?Q?caasSdflNCNXm40reZjWET3kqsc5+Dr0JZiTdhF3CrzHxWL05knN38sK/P82?=
 =?us-ascii?Q?S3qGriT2iitzKwOcK6zMahWh9A80lM0QjRFuB5EfACr0SRt5EaH7cvGQebrx?=
 =?us-ascii?Q?0eqcvUBlxMsVdkx6pCLrCls=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ede73c-6ad0-4bac-efb6-08d9dcaedc00
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 07:23:02.6385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JOTxL7Gh+AzzaLANk8n4avSZ4+7MD7zgWvKkabmC38I8faFfEt2U8JuO7hEMw9cdhxhvFU8IE/IYy/QPuy0kYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7600

This patch added the fullmesh flag setting support, use it like this:

 ip mptcp endpoint change id 1 fullmesh
 ip mptcp endpoint change id 1 nofullmesh
 ip mptcp endpoint change id 1 backup fullmesh
 ip mptcp endpoint change id 1 nobackup nofullmesh

Add the fullmesh flag check for the adding address, the fullmesh flag
can't be used with the signal flag in that case.

Update the port keyword check for the setting flags, allow to use the
port keyword with the non-signal flags. Don't allow to use the port
keyword with the id number.

Update the usage of 'ip mptcp endpoint change', it can be used in two
forms, using the address directly or the id number of the address:

 ip mptcp endpoint change id 1 fullmesh
 ip mptcp endpoint change 10.0.2.1 fullmesh
 ip mptcp endpoint change 10.0.2.1 port 10100 fullmesh

Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 v7:
 - allow to use the port keyword with the non-signal flags for the
   setting flags, then we can use the address argument for "ip mptcp
   endpoint change" too.
 - update the usage and man-page.

 v6:
 - update the flags check as Mat suggested.

 v5:
 - support to set backup and fullmesh flags together.
---
 ip/ipmptcp.c        | 26 +++++++++++++++++++-------
 man/man8/ip-mptcp.8 | 17 ++++++++++++-----
 2 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
index eef7c6f4..efda7ef2 100644
--- a/ip/ipmptcp.c
+++ b/ip/ipmptcp.c
@@ -25,14 +25,15 @@ static void usage(void)
 		"Usage:	ip mptcp endpoint add ADDRESS [ dev NAME ] [ id ID ]\n"
 		"				      [ port NR ] [ FLAG-LIST ]\n"
 		"	ip mptcp endpoint delete id ID [ ADDRESS ]\n"
-		"	ip mptcp endpoint change id ID [ backup | nobackup ]\n"
+		"	ip mptcp endpoint change [ id ID ] [ ADDRESS ] CHANGE-OPT\n"
 		"	ip mptcp endpoint show [ id ID ]\n"
 		"	ip mptcp endpoint flush\n"
 		"	ip mptcp limits set [ subflows NR ] [ add_addr_accepted NR ]\n"
 		"	ip mptcp limits show\n"
 		"	ip mptcp monitor\n"
 		"FLAG-LIST :=3D [ FLAG-LIST ] FLAG\n"
-		"FLAG  :=3D [ signal | subflow | backup | fullmesh ]\n");
+		"FLAG  :=3D [ signal | subflow | backup | fullmesh ]\n"
+		"CHANGE-OPT :=3D [ backup | nobackup | fullmesh | nofullmesh ]\n");
=20
 	exit(-1);
 }
@@ -46,7 +47,7 @@ static int genl_family =3D -1;
 	GENL_REQUEST(_req, MPTCP_BUFLEN, genl_family, 0,	\
 		     MPTCP_PM_VER, _cmd, _flags)
=20
-#define MPTCP_PM_ADDR_FLAG_NOBACKUP 0x0
+#define MPTCP_PM_ADDR_FLAG_NONE 0x0
=20
 /* Mapping from argument to address flag mask */
 static const struct {
@@ -57,7 +58,8 @@ static const struct {
 	{ "subflow",		MPTCP_PM_ADDR_FLAG_SUBFLOW },
 	{ "backup",		MPTCP_PM_ADDR_FLAG_BACKUP },
 	{ "fullmesh",		MPTCP_PM_ADDR_FLAG_FULLMESH },
-	{ "nobackup",		MPTCP_PM_ADDR_FLAG_NOBACKUP }
+	{ "nobackup",		MPTCP_PM_ADDR_FLAG_NONE },
+	{ "nofullmesh",		MPTCP_PM_ADDR_FLAG_NONE }
 };
=20
 static void print_mptcp_addr_flags(unsigned int flags)
@@ -102,6 +104,7 @@ static int get_flags(const char *arg, __u32 *flags)
=20
 static int mptcp_parse_opt(int argc, char **argv, struct nlmsghdr *n, int =
cmd)
 {
+	bool setting =3D cmd =3D=3D MPTCP_PM_CMD_SET_FLAGS;
 	bool adding =3D cmd =3D=3D MPTCP_PM_CMD_ADD_ADDR;
 	bool deling =3D cmd =3D=3D MPTCP_PM_CMD_DEL_ADDR;
 	struct rtattr *attr_addr;
@@ -116,9 +119,15 @@ static int mptcp_parse_opt(int argc, char **argv, stru=
ct nlmsghdr *n, int cmd)
 	ll_init_map(&rth);
 	while (argc > 0) {
 		if (get_flags(*argv, &flags) =3D=3D 0) {
-			/* allow changing the 'backup' flag only */
+			if (adding &&
+			    (flags & MPTCP_PM_ADDR_FLAG_SIGNAL) &&
+			    (flags & MPTCP_PM_ADDR_FLAG_FULLMESH))
+				invarg("invalid flags\n", *argv);
+
+			/* allow changing the 'backup' and 'fullmesh' flags only */
 			if (cmd =3D=3D MPTCP_PM_CMD_SET_FLAGS &&
-			    (flags & ~MPTCP_PM_ADDR_FLAG_BACKUP))
+			    (flags & ~(MPTCP_PM_ADDR_FLAG_BACKUP |
+				       MPTCP_PM_ADDR_FLAG_FULLMESH)))
 				invarg("invalid flags\n", *argv);
=20
 		} else if (matches(*argv, "id") =3D=3D 0) {
@@ -166,9 +175,12 @@ static int mptcp_parse_opt(int argc, char **argv, stru=
ct nlmsghdr *n, int cmd)
 			invarg("address is needed for deleting id 0 address\n", "ID");
 	}
=20
-	if (port && !(flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
+	if (adding && port && !(flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
 		invarg("flags must have signal when using port", "port");
=20
+	if (id_set && setting && port)
+		invarg("port can't be used with id", "port");
+
 	attr_addr =3D addattr_nest(n, MPTCP_BUFLEN,
 				 MPTCP_PM_ATTR_ADDR | NLA_F_NESTED);
 	if (id_set)
diff --git a/man/man8/ip-mptcp.8 b/man/man8/ip-mptcp.8
index 0e789225..72762f49 100644
--- a/man/man8/ip-mptcp.8
+++ b/man/man8/ip-mptcp.8
@@ -38,11 +38,14 @@ ip-mptcp \- MPTCP path manager configuration
 .RB "] "
=20
 .ti -8
-.BR "ip mptcp endpoint change id "
+.BR "ip mptcp endpoint change "
+.RB "[ " id
 .I ID
-.RB "[ "
-.I BACKUP-OPT
-.RB "] "
+.RB "] [ "
+.IR IFADDR
+.RB "] [ " port
+.IR PORT " ]"
+.RB "CHANGE-OPT"
=20
 .ti -8
 .BR "ip mptcp endpoint show "
@@ -68,10 +71,14 @@ ip-mptcp \- MPTCP path manager configuration
 .RB  "]"
=20
 .ti -8
-.IR BACKUP-OPT " :=3D ["
+.IR CHANGE-OPT " :=3D ["
 .B backup
 .RB "|"
 .B nobackup
+.RB "|"
+.B fullmesh
+.RB "|"
+.B nofullmesh
 .RB  "]"
=20
 .ti -8
--=20
2.31.1

