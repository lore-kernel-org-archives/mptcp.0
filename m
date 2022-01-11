Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997FA2C9C
	for <mptcp@lists.linux.dev>; Tue, 11 Jan 2022 15:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641913609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mCJfru4+unYcE3qUohDtnc3J8ORVCn12/N2ICZxZh3A=;
	b=exHozEuyBUGWhd8rLbOoPdbe5dWJarpPao+98nNb+3pUt1GpTk1jvkggthiXFXKwHMsIOt
	qMZDevtapd3i9umt3JU8odijs+FyoGBHoBmoRs+274aeC5iYSAF0GhFAzZLTWdSo3lV1DP
	DIWVugVdbyTnP/7SOMHChHsGDdaNYr0=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2113.outbound.protection.outlook.com [104.47.18.113]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-28-ZH6qJvwMMHG9GsXGPKHXKQ-1; Tue, 11 Jan 2022 16:06:48 +0100
X-MC-Unique: ZH6qJvwMMHG9GsXGPKHXKQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=blQav0r8BnUuN6qzZF4Xnu2+fCMTxhIr/g1LePKNZqKVP5Zsh+XGffQn6dHlVTQumR/8X+DMQodUsYyAQWrzXioOAxRgefBnjpHwmFDhohRS6Ku0ko+RofoyukOxYT5eG7nZNsxHp+5MqENPcQs9Rc9HxgaVF/gEQhgo9YoiTcTCAsyjaNDmBpY3N0I4yXGo9SkL18gOSMZLgOyqW6r3K9SaOg0mz6MvEGsjZyE5rr1VBgxzgWqXj0Jo8l6avelcRP0RnIXUTQT5TDIPVSYS9hZDWljbtUybsksbY2idsXNlLTCGUxlMbg+lMI0WTbAeECd1F4+3bkXKII61vilL3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bq5mrEP9IOuT1FwxMVbGxBs1X4a4b0Zv7UuitJ8cenE=;
 b=HLQFck5mS4e7IVnV7lJvag6fgq74qiH2ABegViC27VyPHC/p/32TZQB685bQMdTTebaA6cv0Kgn+4VTJmYlS/aFCDSwZklgnwT6siFYFtn/4zJSxVrXwV/a+zpTuAOBc0Kjub/lcv0qYM23dsh+5ixpg0HEC2//KtCq59StmikZX5W3u8bgYAU2sJHbwL14joUf4vnYiuF4RDdJy7NfZ+r/eKYy8YqQkOdwpIf34JocWRtJJGHOqAgTuJA94CAY9aSiJtbh2eVZMXYbV6yFUGEU+FwubFZqs8jvZHmi2yq/iLVeQzDeGY/k2iH4+UyxNl9nX6R38depupS+iLA+aAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2458.eurprd04.prod.outlook.com (2603:10a6:3:7f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 15:06:47 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4867.011; Tue, 11 Jan 2022
 15:06:47 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH iproute2-next v2] mptcp: add the fullmesh flag setting support
Date: Tue, 11 Jan 2022 23:06:13 +0800
Message-ID: <8572578300cea1a3c3f6b4979c72c1a285ee4e41.1641913190.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641913113.git.geliang.tang@suse.com>
References: <cover.1641913113.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0198.apcprd02.prod.outlook.com
 (2603:1096:201:21::34) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2adeee2d-f51f-46e6-f17d-08d9d513fca1
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2458:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB2458CF0FC42901D6EBD32BE6F8519@HE1PR0401MB2458.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Yv1RgK3Tc/mn1xM6Y+PWFUwtRxlEMOyue4PPo8wU5Tr9gAAQ7s2wMErjv9aLobmuXouY7RSnjhrM+S2xkubq6z2yWxr1YMgewzvPQW/tSDbnsTqYgRdI/7RNsNQGppwrd8VaX0DUqH21HKq8va2OoIPVevGdg3VoyztqQT6P4qrl6izWsJelEKEzh36QNp8bVA1e1aucM/sHA0cYfGHlZgUQg9jU17ZOTqvt3Kt9yV7FLYXFBX3W+sgILnJJbsLTJNwRgxwNvWxncuWCI2Xr+2o8tISuJ90JsV/SuXB9+ov2TfA+YaaLUHTyoKY4IbEutFSsm87gWRnHSYECK5Uqv99kZIPm0SC2ZuIg+h8o0o09j5GxQKIOZZ5nRC2PI2SciBopWGC9dWfD2bq3ikvpaJ7Zxml8s0tSL1+R0JICoAe5aECufIo5+xgohamlm4Nn0M0FAz0NfITgt3PT71SBNF51mWbtrhuRbjVU0QpJwB2gE4/5ls3hB0X8S7C5S14BrG+IHTKOPfP535NL/jqiE0tdVhUhaHMuYaLJ3e+LxE/aHT7UteB9NPiay3GYc+7czAcmCCSzC1OWHPJOZP3G8aNqBKhaZHAp1+lkm49wtWFWXT7x1shNuC87oNKRTiJdLTIVn+lwu8CBRVmf2DtHuQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(6512007)(66556008)(6486002)(2906002)(6916009)(66476007)(38100700002)(4326008)(508600001)(8936002)(5660300002)(107886003)(6666004)(8676002)(44832011)(186003)(36756003)(83380400001)(6506007)(2616005)(86362001)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5NvkFM3xgk4+406rsdpGgCAkh9Ihs1Y+X3tlxn9WZ71BgbRwHO4kxnsNfgiF?=
 =?us-ascii?Q?l0LHm+lYF6URZrpmxJL2ooD5k8s5K+A++vT1V5HLiHIlYkO6q3tghkTqAmx/?=
 =?us-ascii?Q?asScDdpEx2y4LzEOvUsyv/lK+OaAR6mwT6i6yEAP8NHRFMs/Qazivhpt9v0F?=
 =?us-ascii?Q?pfGSVa1Hogc6ZMGObJjLkOVvbBSgBfsvYEymWyY/8Db3sE30Br35HVSmO2Cm?=
 =?us-ascii?Q?TCVGzyq5EAxZvN11bXo45tOLJbKNkD7iBK/8mk3dO1I+lPwJnuTQqAy3CD8I?=
 =?us-ascii?Q?TgX2znYi8aQt8zMe1dbLlvTRu3zyKL4cKKKOz2B7ArXRGqxN2Sxna7xXOlmC?=
 =?us-ascii?Q?6/Ah8FPquNDh8n5WSPdoG5t+tQINU6HjApNc7Pci7Kh0Lkrw4sHIyX+6F/af?=
 =?us-ascii?Q?0OIHvRVPsqKlZ58smRuGyqz+ELTd8ZB8meX1dXcYGS30WbnAdiUntLwPiGth?=
 =?us-ascii?Q?/EhjxKBYVZHQg+xSwPaRtJwuTChpb1P2+hfIRFgbyo1CFOOIymYcIVSZakOC?=
 =?us-ascii?Q?Z1SRnjBGhYmnoHwF7c2fy6uVLMLc43Fr9GJ9YSeIhrq/K5APjon8Op04s08R?=
 =?us-ascii?Q?z2MVLk+o/irlWyN3botEGA1W1yeUYhKR/qUkODr0qz8uW4imX7xLAArj4RH2?=
 =?us-ascii?Q?Qb29o2PZcxKfARDE5v3M/wqgN3IqfAjusCxgw8WliVLVxe+FCh8ia3QejyVy?=
 =?us-ascii?Q?SktVMHoUB8+8mxkOr+65EB+2XMq7lqJ7No1vlSc3mqrztOEc62ADhr2W965E?=
 =?us-ascii?Q?RtGx2xVFQYY0v4LNpLErOY0XtqS6jt12Nr7RgOaOpPg6rcllaHKSIpsfd3mS?=
 =?us-ascii?Q?6QmRuyiPtuitgjp+ILuKDDaXzKtQGiMjbcIIeV0HQygu7/sA0D1rLGPm4fsT?=
 =?us-ascii?Q?Hny/wdGGVR8tQPw7/eRQl2fUVJ+mr+marFS2WfbwQk3iAERAXvteQDWuD6Za?=
 =?us-ascii?Q?P/WCBZqxDcsXwl7mKq1J0U72K+tkL5ylOhQx91/K7HtWJS2v7Nh9WtCe93g7?=
 =?us-ascii?Q?33Hans68/v6zAfdiv3frxK54kPne1wAxjco3+4v5aiOENikUzlkchJrpZu2O?=
 =?us-ascii?Q?zzjEjfgS0yofsLcUURcrNM/StV5tBUpcY9nNcQna3HmXvBAODDlEWbLidd5E?=
 =?us-ascii?Q?xmw6qb94YqT9mSpRnuz1DIlLiLuMbcR+1yVb0u3fvj2fHGM08tfriBxdrVst?=
 =?us-ascii?Q?qqJX34rduPHYBFpmy3UKTYH8ld7JdaO2FJydMZ45hUeOhsbqYb801gPIJfv0?=
 =?us-ascii?Q?BC43KZz/VeN38Qx5xbCcSwunYhLJKSKRpAdghcTFN9FJE/X1jo1/tMALybMn?=
 =?us-ascii?Q?fr0ja//U/BJOC0dyKfEllrIt7Phry1UjnRjsiltHqNuYjAsIl7ARdobf1WWM?=
 =?us-ascii?Q?xAHH2Bhmc9/Mk7pK8lviTGVFKm2ppMAARQoNHyJefP6GU6pJcaPgoMZfl89H?=
 =?us-ascii?Q?3d6YyP8Q6j+cJshTmaIJPs5RcltKtd9QM9w663JL4K1dv00GLY1uMMSWL97Z?=
 =?us-ascii?Q?9nS+0T+1i/JrET3zPg34wRPsmnuauJdgSxUuulF1h0J3mZD3RtST0IfGTWE1?=
 =?us-ascii?Q?9l9UcoZ9CDJfnbJRQIt9DTNLAs9bawPNdr6ZYyrnyhNWWiwJIf1SNiuOiCAC?=
 =?us-ascii?Q?9WuoNsAFpeDEvMKVIissh/6/w7WWV19lvr0j5CRjxlVkGBa+elZ5y7hm8QU0?=
 =?us-ascii?Q?HzHuWavKx4j6YC636oRxiesqX9k=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2adeee2d-f51f-46e6-f17d-08d9d513fca1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 15:06:47.2483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kOCdqqzFag1zGRk+YC5MUHz0NEuthqd9+oHK8zQVfDJ+c4B5NqgpiKg1SmGjmpm12V0Rs121LSBVl6M4np1ciA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2458

This patch added the fullmesh flag setting support.

 ip mptcp endpoint change id 1 fullmesh
 ip mptcp endpoint change id 1 nofullmesh

Added the fullmesh flag check for the adding address too.

Needs to apply the patch "mptcp: add id check for deleting address"
first.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 v2:
 - drop MPTCP_PM_ADDR_FLAG_NOFULLMESH.
 - rename MPTCP_PM_ADDR_FLAG_NOBACKUP to MPTCP_PM_ADDR_FLAG_NONE.
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

