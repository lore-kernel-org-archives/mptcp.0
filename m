Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C1C2C80
	for <mptcp@lists.linux.dev>; Fri, 14 Jan 2022 10:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642156211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uICET4YMhKUIIlk85CQ7M5VyIQCL2OnwKM1AVheadqE=;
	b=IOW+2yomKkpuLw4C4e3a2FPy4cO7Mw/qjNcbtnkjY/lDMZTTqf+9d+ScblnHrT29HY+0c0
	0Mk2+5IcBma81SSWH1vonMU0PK9JS3hD+l9wyc/BPFtcFG1HGzS7aiZvqkAos+ATeJlWPf
	E4XoB76uTou7FoeJsKL58g/vA5HPvD8=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2109.outbound.protection.outlook.com [104.47.17.109]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-38-JtMug5UEPqera0v51RVolg-1; Fri, 14 Jan 2022 11:30:10 +0100
X-MC-Unique: JtMug5UEPqera0v51RVolg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JpoCG+6rZm7yVxkOVh8rVWptANYZwIrKbSNAnG08rzWZD1+4N0UJSRHtFTnfaotIhC5MMuBzXCgR9HWUccGR3P2NOYZTNqAkoRSaiE00xENb6z6qWhQ2ralURHVT4W+s0YkNrv582jFAhm2aUvT5jvgeyD4jy5XSJaizksJ7dprX6QgLAqrWRjIEJoMq97C1ra4Ey4xz1efMbNGHt0hsy4mOjHUQpvdcUbDCpO8XkJyon6JUi2jwZq4T14wWJ7W8w0FCBBT8+xoE2+P8e1HA8qcxVU+N2hLXvSQp0aHpPCJCACpoMp8+r5XFiEQzHQx35VN5ie4cNSB6xhYMRRbRRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SctwQSVoi4TnRXxrEkMCsmhmLDGl/sRt+yVld06OMpg=;
 b=gxEQApgZF8HPKVM9ff+4bq4FcpN9CPhRUXeF6ggQfAlgevEn0HJysQWzYJR25NJCz+9oG0ib5Ukn0aBQCq4ayNTmsyk7EbQO90cVL4Tu0WrynLSFhYT7cy8fiVwh7vWYhwTeUp9EnB9nCq0Pxc81/8QuzyEEleKf8x4K+kuxFaSbwsJj3DpLXfKR6PlY6hQ7WU4s/BSfgPnEYvs1tsKPQS1BtTNaD8L7xUVeSJVGO+Z42+3WmxZUtT2MqqYXb3su7KuEs9OmEzWyZM8WdCwHQ+JVoiJbH9/4ln7BvotNkUkcd2ztHvwVM8vkbIoOBZ7xxUdcVbIOdjTMLM7Qow9HMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by PAXPR04MB8847.eurprd04.prod.outlook.com (2603:10a6:102:20e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 14 Jan
 2022 10:30:09 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::94c7:de62:9c1b:6484]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::94c7:de62:9c1b:6484%4]) with mapi id 15.20.4888.011; Fri, 14 Jan 2022
 10:30:09 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH iproute2-next v5] mptcp: add the fullmesh flag setting support
Date: Fri, 14 Jan 2022 18:30:08 +0800
Message-ID: <9c1f1e6a704143e0d14c62dff09fc918ce1f218f.1642155488.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0143.apcprd02.prod.outlook.com
 (2603:1096:202:16::27) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33477b5a-2430-45ca-e370-08d9d748d6dd
X-MS-TrafficTypeDiagnostic: PAXPR04MB8847:EE_
X-Microsoft-Antispam-PRVS:
	<PAXPR04MB8847A5850C5B18EFE67A48C0F8549@PAXPR04MB8847.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ICJPjVKUN9/TZpzrq9DCuoxniGgUYVy/ovxhwAwaIqpmZk/zXll0peQkcB508CRq/NnEOx0jm9FPde4zlR199gSr34rWY6w5W516Bu3ksOMjkSiMqg0bN0HeaGdMABpAs48NR8GIs2KGRKb9P7GfKetl22kM1b6BkBfsd9FAPwok3FmKr/PIqD47W46QqXIlmOAyRXA7cpOaZGHwkb+5vylkZ+HlmUWSHiHdKneZoTfPaKt7L0VolPZtiT/mZdfqdALTLaRe6mZey8zgdw1W4UkzlE6nXUTRVsH/VsOJcT2gceKZcuepv/UGdHM/DinVRjg5X+2ylLM956Zh+F+sXpN2SQvkYs9lgEum2V6SMr7aO1ncrtI9c0x4FI7iOHdAcCjTcENHd/uUyrjrcZqFV3Abg2G0HE43FlSGNSe4HQQrQpbAi6mjzZA7GX+xhGFCCiyfeEDxPQLdy+8eFD2LnXmjJf1dXfwVdR9dkTrJcAgPDJZDCKTrQ/M5GHUW96p79KOJP8jYOiJW0C0+ElvZ2jUTrhK0NK4qv11mBkIOoUjTSWDc+A54GZ3U6xYty9uF85V9uATnHczoTdlpEGRyo3DNoCbY0dvFpn2OjDzEai4tYqNfDeWnAfUcfl0gsDO+jP1fvK66Giz0twF3jBPRQQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(66476007)(2616005)(316002)(36756003)(38100700002)(83380400001)(66556008)(107886003)(6512007)(6916009)(6506007)(86362001)(44832011)(55236004)(26005)(5660300002)(8676002)(4326008)(508600001)(186003)(8936002)(2906002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p5OKLt9UxgJkZ4wtnlG+jtzKLIJwJL5cdfLJL8v9sfbHmur+VrnHktyLKCZ0?=
 =?us-ascii?Q?gM+FRmsBW9HfvZP1OMj44EHWdv33AyFSrL8jBt7tqnhNhCefG0+JR5X+4uJM?=
 =?us-ascii?Q?71zq+gLiP1sgII9dWFG4uxTz8Nx3Hwsc+9ff8b90ISdICjqUPLpMGMW7hbiI?=
 =?us-ascii?Q?QBnpQssVotz0/146iAhxmRMVUF5PzbJiPjoX1w3EoHP3kxkTsi3+75BTv+cz?=
 =?us-ascii?Q?X+qh5uIk2BI2AcWtqYOl8OnBFdTwlYwA4BCzmdZz5GACK8wVevVPUAwDcAOm?=
 =?us-ascii?Q?LieoozutR6ObHpkdi816vfz/7/g9qRCRGiGYfGMWY/OAx2I5913r3JOrvbqp?=
 =?us-ascii?Q?IrD2O2XbtUMkBavIFe97bAa3F3zjHVAEd+ngeA790IJSL7UTjjSVgh1gv7q0?=
 =?us-ascii?Q?FRM41Q9n3C696tS+zNt92cM5GMrtXymC74mpyyNhsrftwSIw55Yx6XiHKuCw?=
 =?us-ascii?Q?QYzim1Vr1fwwVDCWEdXETOkCy0ghM73c8Md1tnYcbIL62YcdWldyJOF355/A?=
 =?us-ascii?Q?FFxZrOiA/ZuHEERydRzufBVJoeMrP0GLGGkjIihimg7U5YYJTJ05kNeBGLRu?=
 =?us-ascii?Q?7ikxCx3SX+Rpxn6Gj5DiP4CIPr53M1VBzdgeidZ4CrxX+czndtKgUd65z2b5?=
 =?us-ascii?Q?qlOaEyROCfyAfLnoN8poESrHta8kvq/R/9/EGuuemuNa7j/xuDNY3uG0tFja?=
 =?us-ascii?Q?OKfEOoNp/XG82ZjMWX5pyJm6u/Dg99WCSPIIBTsGv0H3zGoDUIgROxsHvh+J?=
 =?us-ascii?Q?kmNYUSxkI1+AtvQJxj/pHStZvGQfuW/+EGk83SG/dgNB/JIoG0ZpaPDO2L5H?=
 =?us-ascii?Q?/+/s0ZbwJYGF9aBZsMinWR1mWGysrZVphVCqAjQ725LYLxlRRhPSm51mnwyn?=
 =?us-ascii?Q?sBavYNYTQZgIxm8hxyXsasvrkN0UqGVAmAaN3fM8MmkaNWWOSxVF+LMwVC1s?=
 =?us-ascii?Q?6rEwb1rMImMHX3nocWLYpz0T5HtzUh7kQfMRCe7H+KejCyYVHL243KQqRIpZ?=
 =?us-ascii?Q?u1A1aCTk4a/ruDKO+fQxolWrXGTnPSkAtkNDAF6ZaM0pYFg8qJ8S1+4eufeU?=
 =?us-ascii?Q?GLNQ3opfDmtuh4vevHFut/MAIf2fzzsjVszPK7GLjQhzhEsKrgbmbk1NEEaa?=
 =?us-ascii?Q?H/+NCzFVN+lkkGQz0hTx3IQ+2RZ8bHanjF0WI22I7ku8eFAcyzTrZKS7UbPT?=
 =?us-ascii?Q?+jGwt3xY+sQJ+uILuwNTTV0+Rddpv+2iKdPhftWWvdvYiGx0KPRR5/Lrpu+h?=
 =?us-ascii?Q?nJuwkXK4A/cT0yBBxgjbvcLXz7tb+nrWeUNSErYj43WFrXtvsVST8XDpZxb/?=
 =?us-ascii?Q?H1qtSKnOaWvl2hDsqH9RddglmFg45qKgcx8I/ZXy+QptprUWVAPLuz0Lkk5Z?=
 =?us-ascii?Q?NKbf9pz8D8UCZOLcZxJcdl214xihbzgsfxKVa9d7VvKrhYNrz+IpMGvf7sXR?=
 =?us-ascii?Q?Jm8J7EHZNUvbSUvc4Re2W0HGIWE9XpoJnPllNrCh+Zub0zthN0sNPeD//+Nn?=
 =?us-ascii?Q?hRjMFobQ3oh4jcNiXg/xWPTPituzwXqeROHm0VHFPMXP176igRdm92ia3Hd+?=
 =?us-ascii?Q?wn2rB1scp8WCo3qB7iA9v0/LoUGk2j5nRHlpiQPpL1GDoJF6OAfdJLK9X0uH?=
 =?us-ascii?Q?PbzPkIhCXYaDRfJ9z0aievA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33477b5a-2430-45ca-e370-08d9d748d6dd
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 10:30:09.3368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KRpSrkwCpOPQe/xEhiJ46okI0CAQrwxatebMoOS4QOBo3uMPaVuDB5WXsYUfDehiFe28xgpRkfMGStfXqZvT1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8847

This patch added the fullmesh flag setting support.

 ip mptcp endpoint change id 1 fullmesh
 ip mptcp endpoint change id 1 nofullmesh
 ip mptcp endpoint change id 1 backup fullmesh
 ip mptcp endpoint change id 1 nobackup nofullmesh

Added the fullmesh flag check for the adding address too.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 v5:
 - support to set backup and fullmesh flags together.
---
 ip/ipmptcp.c        | 17 ++++++++++++-----
 man/man8/ip-mptcp.8 |  8 ++++++--
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
index f85c49a8..23f15219 100644
--- a/ip/ipmptcp.c
+++ b/ip/ipmptcp.c
@@ -25,7 +25,8 @@ static void usage(void)
 		"Usage:	ip mptcp endpoint add ADDRESS [ dev NAME ] [ id ID ]\n"
 		"				      [ port NR ] [ FLAG-LIST ]\n"
 		"	ip mptcp endpoint delete id ID [ ADDRESS ]\n"
-		"	ip mptcp endpoint change id ID [ backup | nobackup ]\n"
+		"	ip mptcp endpoint change id ID [ backup | nobackup |\n"
+		"					 fullmesh | nofullmesh ]\n"
 		"	ip mptcp endpoint show [ id ID ]\n"
 		"	ip mptcp endpoint flush\n"
 		"	ip mptcp limits set [ subflows NR ] [ add_addr_accepted NR ]\n"
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
@@ -116,9 +118,14 @@ static int mptcp_parse_opt(int argc, char **argv, stru=
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
+			    (flags & ~MPTCP_PM_ADDR_FLAG_BACKUP & ~MPTCP_PM_ADDR_FLAG_FULLMESH)=
)
 				invarg("invalid flags\n", *argv);
=20
 		} else if (matches(*argv, "id") =3D=3D 0) {
diff --git a/man/man8/ip-mptcp.8 b/man/man8/ip-mptcp.8
index 0e789225..bddbff3c 100644
--- a/man/man8/ip-mptcp.8
+++ b/man/man8/ip-mptcp.8
@@ -41,7 +41,7 @@ ip-mptcp \- MPTCP path manager configuration
 .BR "ip mptcp endpoint change id "
 .I ID
 .RB "[ "
-.I BACKUP-OPT
+.I CHANGE-OPT
 .RB "] "
=20
 .ti -8
@@ -68,10 +68,14 @@ ip-mptcp \- MPTCP path manager configuration
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

