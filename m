Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19156173
	for <mptcp@lists.linux.dev>; Wed, 12 Jan 2022 09:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641980070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Aq8nMW/1tQbz/FX44tvpFPBERdCUYwyPrU3mc+zPPiQ=;
	b=FXaFBaGFLPI34RwrAjhuhowL2TmgPavcdZ+0ohOnlL2CRC8XpUZGPJhL5OA5mwt5bGpVNG
	7FrhDV/Au+RxcuWz1BES6irXwBfcdHnjOYIvnjY2yrGKrv90Cz5QvgN+Ad7FDc8Dtt1FVF
	tGPqsI6I3RWHEYnjSkLjgupFInqD3pU=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2052.outbound.protection.outlook.com [104.47.4.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-31-aeip7qQQPvOTNZDOJ5jDsQ-1; Wed, 12 Jan 2022 10:34:29 +0100
X-MC-Unique: aeip7qQQPvOTNZDOJ5jDsQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JPFPSmhw4wc73DGN59ErFFmYdQLAqD71X/4xrQDBiCpMspcVc3x9vwK4ycDiQj15NUoTXVgzxVhPNSGhCCS2mdNXhGLqa17/mryvTA1JfLvR5ZW5A2IPFRAcZWAaLokTWKC/lmse0XQbKlSRSSwD77vUJgbPCyobPIY2vpgSCLTRHurjNyNxF1YavD+GpkVtbdd1xlbQ3aBXQNyGcvJKGIEOZH06C+PXCd8iqmWMq11kZtMNHOj2/KAc8APWbgrcp0JVBx9dAy7FmSqYXR3AZTind3ftVAiCVaqU7ADzqblEEIA7BIHsp81wOduZjKkm7H68SIeX+IHGL3dhdH4jyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84S5/a4nKsAc0ow/Ih+/57+IBDMt6qgVo1q8fJzviac=;
 b=LnU8DUxrYK6M2524fadVSzim14yj5tUrkHxdaitzZ4cF71cK6mkXpqz9blcgEhIEpTzsIPVU3/9+5LeUvkt9KO73NK9/3PTNqjfVi+r5E0fBkt78OSjFcoRQbGwaoUeI2zTzPKx1Hb7vpSog6X6zJoI26UuZtexa8MoBP36omJUjogv5Vg2s2Fszq4JF6n5/YQvfq4kIaARrU0p9MakyyOYiwAjkZN1KvO/SgAvH60Homtx52KMTBooOA2zdPogdMUGyjjoJoyfOOHA3MNEdNA1ku3wZsFhbFQhRZ23OnlA7Fh7YDR41J7HdeSbWLYai1yMaY/POnsSmWWEPNn8Nog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB4290.eurprd04.prod.outlook.com (2603:10a6:208:59::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Wed, 12 Jan
 2022 09:34:28 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%5]) with mapi id 15.20.4867.011; Wed, 12 Jan 2022
 09:34:28 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH iproute-next v4 4/4] mptcp: add the fullmesh flag setting support
Date: Wed, 12 Jan 2022 17:33:52 +0800
Message-ID: <743abd8f6b8311bd0f5747980982b511299e3453.1641979131.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641978967.git.geliang.tang@suse.com>
References: <cover.1641978967.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff45e7e2-6f7e-47b2-656e-08d9d5aebaad
X-MS-TrafficTypeDiagnostic: AM0PR04MB4290:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB4290C713E698743BB6050B27F8529@AM0PR04MB4290.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7hPZtuTrZxXY9J98Qqj6O/1hxxIYhcaYAry9jtZ97wTNBPmCR4g4khnKU0fx+QzRVk1sfh+oCOf7yXL5Z2mEGg9z4FAw019QYaiYOvZ8yda3SLn98AzbsASC8ThretqjD674g7syDVsLUWJtG6++mH/0DWcRlMik3vtW42PokU5lthdJrLfWbKbWZz+fL2EperxjqAr/PhZ9tS5eibmnwT48dBBZetmtHrmQEb32shD0Uqo2iqoqznZbklo65AfGqpxS+MiHPvfsU75gVXDML4a3BKQw+eZXQ9yOBCUE87GJTCngCK0Db7NT3/47zzC2ng9/T0AvxXGnuf6VmxoQBa+zN3lQkTIEp5Aa7otX2YjmxA5CexFiN1ADwSvLSBwJlWqZ0xRNZT8eYDBEkaaShzf08RBR0+y/Jpz7fxUlqllemmEM73YL50x9MofaQCEnNrSbxlJK/cgSuSu3k7Hs6ad00Tuan0B35KAax+RP3vzxQ1480g/Bok0l5hw+xbH9naKwnm/7d82sX3EXk1Vr1FTfG8IL8rwewZaTcdMUCm5yVWrfZywV6Q6UbAB6KGCAz0u3GmXfxpyt4pB4BcJgJqOv0zYaziZMm2qUxMcHDRFlhmUU6xilSwJgXMqFLtLLOaXJJmc5rk3IDVEEvD6dBQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(55236004)(6506007)(6916009)(6486002)(26005)(4326008)(83380400001)(186003)(316002)(8676002)(38100700002)(66946007)(86362001)(5660300002)(508600001)(6512007)(8936002)(6666004)(2906002)(44832011)(66556008)(66476007)(2616005)(107886003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wy79KN2hPsErWAcN3PqTSL6xt++vQNfkg3T7rda8NT4DCQdUBwMRdChU6pPo?=
 =?us-ascii?Q?2WCoyk5IH1ajBrWtECXNZudcZRu5wOt8V6I6saedKKqhgUeSvUEQUKPuz9DT?=
 =?us-ascii?Q?6r5s2NjOhO5BpJeC981xHyCnlk3hDYeKtg+nJyKnT/QoZpa+QzAcV7K2BI0O?=
 =?us-ascii?Q?sQ691OJ9tEjt4T0929zLxTPIuXCtr+lXYyBABPJezXblfoDdfxB0VgLnB8xK?=
 =?us-ascii?Q?d701r4S3JawBNvyo3ElAXKFf+uvekAPC2/SrkxEKsOJTr7Se+bwALn+fk2UE?=
 =?us-ascii?Q?diwohrEuB5J+BGdPh6mvWEDqyTOxj1Zf0xhPKC/tpC2dichZVTSaEKCQr/m4?=
 =?us-ascii?Q?P9rb0ewsq6oGhQrWThJVA5LvHysNkCgcvaNq3LkXQUX8kHAqdUW98OLQuCwj?=
 =?us-ascii?Q?yDtTHYIND2FlRtajY0LC0ssLwokiSsspOY2PhcZe11MW91bgMy/Bmn7/tn9T?=
 =?us-ascii?Q?5Hn9qz/VYuZmCjx+xbdaYd9SNJ7j/xOSGp1h9rUtb38bIJsz9d+et1MO4Bu4?=
 =?us-ascii?Q?y+S1MX0y3menGGHq9yT9xvyrPdyJao/ZIRF5H1Et2zcpZaGCxFzyMHSOtgBr?=
 =?us-ascii?Q?0lKQXOJAVHJXX8VszHFcIBirkjJSw+GRYEKcjNH8SknIogam51uXUmprYOX9?=
 =?us-ascii?Q?JKf2vJPtsdZDqTqKo2mnhle0gMi/2s5Jh1UMYgXK5FOTzLmhk1BsW0qhW2Om?=
 =?us-ascii?Q?0HQ+DYjJ95gkvukGdQjYBZmdV28xRAydQSc5Cbw44hyUNbam35uzX9UVymgS?=
 =?us-ascii?Q?I7/mh3ioxueIN/gUkOO8rdiek6Shp1NgyFmaS2tcGovDFv8eUMA88FjusMwx?=
 =?us-ascii?Q?9nYJjS+yLVTDr8cHftVgC0THs4scc7BI/jyJZyKviHePIxuBDuuPFa+fimrr?=
 =?us-ascii?Q?/HcXAmBmu2RtggHZ3j+j6rsza7ctPOwrVZUlHFqYXTbCPI7eR3+WZy6/G0mI?=
 =?us-ascii?Q?DODwexbHFNdC+Hxi/R1MkspRxAvA3TNcAQnqqSwdSazE6DjJuDF9nkdSYxn7?=
 =?us-ascii?Q?Yb4x1uk+1eU81sdVYy7OmSnVVD6GjUbJ2q/Fz5e1PkDiBzyvOTMCdIUHnjsO?=
 =?us-ascii?Q?9XOs1PWi7BnME/bgnUsp9bR2VE5WaXtKSxIin+1gF45rQjOnIc3oc/vP3wzf?=
 =?us-ascii?Q?CfTCgvQETKuLWi4nfNvFgEE1aHYdU0blaOYyDe4y1QSrDIYQry6G7gtuxCok?=
 =?us-ascii?Q?H5qHmVbs5uaBCg4iAn7ykhHlt9YmZg7tUTzXF5QhW7DjC4wR/70pYLFZAFfx?=
 =?us-ascii?Q?WS+GuyimbsLdfs0PbpKvgIT+pSskd7U9/cnvEO3aJ+8uOfLBEnccOmvIN01v?=
 =?us-ascii?Q?M/Rj2LAOqhVmd7HP/nazYHoW4Pa0XM/8BUP+Km1XWjmo5873WblOsHraG5GE?=
 =?us-ascii?Q?KIfshP+E94D2Uh/7gVFTdlgyaQ0bn9/OkR8zEZxWjN8Th9EqQpbBtCL75RIH?=
 =?us-ascii?Q?29BPsOKYj9G/7fjD5scsdSgqufMkU1UNjR05FQZ4b2mYE1j+XFbKolMnh+i5?=
 =?us-ascii?Q?3Dwt753DMHwrLI81duAPv9KFiAKKXAFh/Y+8jv+DaZJroAStCZ7PVrX4WN3C?=
 =?us-ascii?Q?JI9pHFMKacAOvlkTfJ5EzkVFmSVpThBM8hpIwD1CKBxXM9dcEYnUZ0/3uRoc?=
 =?us-ascii?Q?auR8Us7WAUhQ9h0GEgjempo=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff45e7e2-6f7e-47b2-656e-08d9d5aebaad
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 09:34:28.5868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jwRji1qLRo7DdGSSZTMrdbTKb6/5o8b/leWehiFLSebrexnoY2exjkvx8TQYkXpMFfz7SF5b5tVrO7BJjSfGxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4290

This patch added the fullmesh flag setting support.

 ip mptcp endpoint change id 1 fullmesh
 ip mptcp endpoint change id 1 nofullmesh

Added the fullmesh flag check for the adding address too.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 v4:
 - put into 'fullmesh flag setting support' serirs.
 - No code changed.

 v2:
 - drop MPTCP_PM_ADDR_FLAG_NOFULLMESH.
 - rename MPTCP_PM_ADDR_FLAG_NOBACKUP to MPTCP_PM_ADDR_FLAG_NONE.
 - Needs to apply the patch "mptcp: add id check for deleting address"
first.
---
 ip/ipmptcp.c        | 16 ++++++++++++----
 man/man8/ip-mptcp.8 |  8 ++++++--
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
index f85c49a8..564500a8 100644
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
+			if (adding &&
+			    (flags & MPTCP_PM_ADDR_FLAG_SIGNAL) &&
+			    (flags & MPTCP_PM_ADDR_FLAG_FULLMESH))
+				invarg("invalid flags\n", *argv);
+
 			/* allow changing the 'backup' flag only */
 			if (cmd =3D=3D MPTCP_PM_CMD_SET_FLAGS &&
-			    (flags & ~MPTCP_PM_ADDR_FLAG_BACKUP))
+			    (flags & ~MPTCP_PM_ADDR_FLAG_BACKUP) &&
+			    (flags & ~MPTCP_PM_ADDR_FLAG_FULLMESH))
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

