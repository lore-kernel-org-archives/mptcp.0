Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D732C80
	for <mptcp@lists.linux.dev>; Sat, 15 Jan 2022 00:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642206526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qpx4BAW7TnMesUKAsb0Ym4hBsI4V9cUDCZf9A2oD1lE=;
	b=iMUM6ZFscNCnIiCxyujM1gomd+trmGiMLsI3Wh1nCUxqm18gWTpS2poK+/JxPxa3fuSfwe
	P1FNWPQcEpuY+26QA1E+oll8po1LOP7U7z/LW/or9PDLvPmAXzjT86YX/imReUzrjCDyc1
	kZvbfyzgSgyFtC0fP4hEE9rppw5aeAE=
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur03lp2054.outbound.protection.outlook.com [104.47.10.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-20-6FsGExoLMGeqEJA4RvCyAw-1; Sat, 15 Jan 2022 01:28:45 +0100
X-MC-Unique: 6FsGExoLMGeqEJA4RvCyAw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L08Vgteclm8NAdKC3bInwJvMmdVBQPz3hO7XTk2n3LmsPsQQ8MewROXFJwz+P6Pcd7UUQNj5oQ/mipwAD5s7eUWg8IyrcbT2cu59ji+AOTlIkSScBv3Rb6cUuy4lIDf77AauKMFsc8t3yZm8YNfXPcLRPwoPQSvrQlgw8EdtQAh5lbr1IRDEGfHACiJt2oGZaKYSGDE0hmwV18EDv9y67SxrWZ7eSymI6uvZxtNNG3JJaPtYPlUCBy5Y+v0Mt0ltNpPF3ZDvCRz5p/LrqyRNyviE/ybqJQllTWKvc+R8wcWee7hcV4HOjnSFcLwFgXfE9S6o0eGWXKizzZ5DelJcdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EN0ZGSDnLlvkNHWDlRYt2Dd6jwsi61khi58GEPyBYJw=;
 b=lew4BKmXSjAt7K4c+B/c87RW4voOw0mWIH7qZudyfssKMRTZRbDyBHBDb7W3YNYch0UQS2vw4sT0w5katZ4mFf+iuITA3Np23yQjCoPTDd8bdHY8sjul2G/KdM0DeCuJqxOS4MKNdFa06xS5OOXWzVYPxKT6jBX5SOFpji9Ntcu5wfFXThuaXjctBTBdrZGGz0x/LVgHE17FyAWvVWrLzRcGZ61B1IgKgQs6andnakApvtE2YqtmE67zOiZDAfVsIjZykdYtpyMZRCHmvIejh9wqQ9Rje67vd1cvKfisJkQxm0w5gGgWeVA/gA5ZzWVZEL34eiQnICgVv5tlivFYFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7468.eurprd04.prod.outlook.com (2603:10a6:102:8d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Sat, 15 Jan
 2022 00:28:43 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3837:57a2:45dc:e879]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3837:57a2:45dc:e879%3]) with mapi id 15.20.4888.012; Sat, 15 Jan 2022
 00:28:43 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH iproute2-next v6] mptcp: add the fullmesh flag setting support
Date: Sat, 15 Jan 2022 08:28:39 +0800
Message-ID: <bf32abba571cea5301bf26921b0a8eac705e45d7.1642206093.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0012.apcprd06.prod.outlook.com
 (2603:1096:202:2e::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28a3e6cc-5597-4cfd-30fd-08d9d7bdfc58
X-MS-TrafficTypeDiagnostic: PR3PR04MB7468:EE_
X-Microsoft-Antispam-PRVS:
	<PR3PR04MB7468A91556D85882D1A2B709F8559@PR3PR04MB7468.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	j/P32MpPWvkqrg+FypyzRFhQlFbejN78QlCJcQbzCCGQ5HApelvN0KlGLKPm1Vwm4kDXMT1uYUNngw+YlWMsHrSCECS0c0aUBynD3aac0I2EpJxRlz9hxXmeb0XRz9ik1O5PSiJLlWuW0iSW8R3+q36WsU4fPwehOzUnQN/3TwTsngbBl/dKQTweIx6SAw+pNalGyjWLzHsmxKQSLUtitwpC3icP1eabJF2LzKMB7n6yI1fFE/msKExhvC4gphfUKOzejyBBmMyB9iM9UaX0cQ2cHzoOHv4KRuEbU5mbKw3Ob3Ztm4f8Wru6TaIPHJMDn4+1vMMuQ70awjG0f6Cj6kEPKIBORX93t9lxyT9+l+Hb7Vptw0ZAOIDg9taMADFiKjWgVgc2tFnmnJdHkKeBSKZ6WEh3OXOHAF9zj/Bezp/oxmbr83tH82jFyCviahf8NjDrD+eQty3gKRvnAoPZT1mTwFHMKWmhSBXyjDUBEQAJH2uRnvETWKRlM5laxWhz945d7MROmCQwhCWoSgGwAgQChMQlMt697bevVCzGXrozP3An6FM5wFgW/x9rCWUm10vLR5HDPR2ATmr20vZoiGr4dw2Z+ROuwRFC6UGfMJJvrYdtiamhh+vT7YZ31zGoBWqg8hB/8dSb6n+9Sa1fCA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6666004)(186003)(2906002)(6916009)(508600001)(38100700002)(5660300002)(83380400001)(6506007)(8936002)(316002)(8676002)(66476007)(44832011)(66556008)(4326008)(6512007)(107886003)(2616005)(6486002)(86362001)(36756003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ERsrtKKXrKPX34QifmHfqJp9ucSIPo5+5qAQo2479h6y/WlsSAVDH7ZwCKx0?=
 =?us-ascii?Q?9Jizen4JZK0Uzh5TRnZ/ZmP/9jiD3ZrD9U2oRXH2ui3BwXdkJqbkXvzO+TrE?=
 =?us-ascii?Q?EtGTIWjMAKbnqCIzMxjJo5KS8ZVqiwuTWro15DWdk4uqE9X6c0k5TyvuhLE+?=
 =?us-ascii?Q?j6XxLf5Pw1smW1lxGJKLKylxdE4l0tMcUtKqq5UXhAfcIqgnH21JbNTIoRlc?=
 =?us-ascii?Q?OVpDtTk9eFKPoDdWzMN7Bpa1mKt89gtFHA1yVC7+LhgKrHT5m+MJ3rcWaJ8+?=
 =?us-ascii?Q?yocieCcuELFEJB2rSvGpVgeXwlgF9PEXFG5jLbSL6/hNrRle/rosQf92e8eq?=
 =?us-ascii?Q?803vdDfm3Qt8JcTG0Qce0/gvRybcJGF4f91rSM+u0jJmCl6FoY/OGMuaiDaM?=
 =?us-ascii?Q?W0zOKcq70xM4dwyfb5lZ5RPl3nHT6jgOxvaO3FOSuc9n2UrlY3MiIqTiwjqB?=
 =?us-ascii?Q?NRcYGoeI8b7KmKey1b0/Sozk2+dD19FFlb5pwJPK8yIKGhfdct8CjiFmL8BM?=
 =?us-ascii?Q?oE9JB3K9ExTlFRPF31u3G5AEWDojvBF1fiDfPGMQMrG73DrO88UUFmDICWHo?=
 =?us-ascii?Q?J/KvjgukX1565S3lY0c1R59ZVtFdUvFX4V3P7czThjaMJzyAD5ieD/kZzmFh?=
 =?us-ascii?Q?9rBozbmKkoATw3bSWZWnuOpnuwnFRoAPmuebidZCxlQEZBYo7LeuKcJpx2BR?=
 =?us-ascii?Q?X9qsm0eh3lSWQ1ox3R+AQ0+5WQ90lASFd5VwPUkvAR7EmnEnuODnGB/D8DCM?=
 =?us-ascii?Q?zwAT3SyWGntOKtKgegw2KHLXCxmq2YKqwcJUZ28rWgG57ZWeFRpiQhd2PQvG?=
 =?us-ascii?Q?OIQRHfb5gV01JDbESgGjM2Clk5OwUY56/LLzh9NbFn+zjJrZ08CtLsCBT/77?=
 =?us-ascii?Q?YhhsGOofsxHSC2UgccDKWbmN5aBm7Wkp6khQG05/MQpTafvtd2VwM4zcV1G3?=
 =?us-ascii?Q?SJcgY28f6GAQIuJ4zQQoDTrbilwHql3btBBQQXZBkMCXIGjznR8XBFfxyI2H?=
 =?us-ascii?Q?iE/7I1qVT9NtUochMEcg8AoIvVN9Ic1vcQKFdpm4B+2nWy9i54ftOcqpLhZY?=
 =?us-ascii?Q?juxSwJAEffhwKYqnp4BtqzbrZPn8hS8AmyMPxMIUa95gbl1Mag6XNuTLe9Xu?=
 =?us-ascii?Q?nKLXZiE3yM25qOvCkzuSTnKqT9N+qj81gMXTXHeczB5ebrP0Le9sFH+ieCLp?=
 =?us-ascii?Q?AO5mPfXaRnkthwBgMiTOAkbTmq/EGvBWrgWjZQQ5vrSCgun2fe4mJqbthXXf?=
 =?us-ascii?Q?96w3arCenJg8Tv6yWvWwEeQOrsYkqeXLLea25M1348a645qnGsvj4te8KfiD?=
 =?us-ascii?Q?VdwdNO9gs3SsgfmnD/ZGT5NHw2DDwvC1m2Lh4pvp4mcNCGG3zOnoh2CJyteZ?=
 =?us-ascii?Q?dPrz+64gj0j6zQxqCWcMONa76jbd3uy/ff3a+MfBB5s0RlGzokrw5vMmKVrd?=
 =?us-ascii?Q?g7RG2B9yM3IAxeqjC9qz5097/6v2AVuuZ60+d/zaDu9E56hyGgRbP0VfQFJu?=
 =?us-ascii?Q?RgJPYot5ic4NPn9jliqCwRUcYBLUgTClenKu8SZ8j5UeNOpSV3wg38PxXXdx?=
 =?us-ascii?Q?CR7cv7V9bSY0u9IpHyk/j9U9pXfH/l9+OzrfHJYsdeBGkL8423ufRj6yEXcw?=
 =?us-ascii?Q?WjPkSNkIq3uXXlAahpEqjq6EqLa1zOKJ/r/DiKdm2OgSXTWB6TtaGESLap3V?=
 =?us-ascii?Q?M2wLKs4tecHOwkxwxSd749wniJQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28a3e6cc-5597-4cfd-30fd-08d9d7bdfc58
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2022 00:28:43.5502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qbYXVGqtugmUghMxO+gUxkqh//MtVoPcKbO+KtWapvvLPEFG4vqXbAq7vBGJlfJzTj8lLqn9KTbuAG4p2g0Rlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7468

This patch added the fullmesh flag setting support.

 ip mptcp endpoint change id 1 fullmesh
 ip mptcp endpoint change id 1 nofullmesh
 ip mptcp endpoint change id 1 backup fullmesh
 ip mptcp endpoint change id 1 nobackup nofullmesh

Added the fullmesh flag check for the adding address too.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 v6:
 - update the flags check as Mat suggested.

 v5:
 - support to set backup and fullmesh flags together.
---
 ip/ipmptcp.c        | 18 +++++++++++++-----
 man/man8/ip-mptcp.8 |  8 ++++++--
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
index 4363e753..5c8b1627 100644
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
@@ -116,9 +118,15 @@ static int mptcp_parse_opt(int argc, char **argv, stru=
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

