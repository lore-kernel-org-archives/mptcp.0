Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D6420F9
	for <mptcp@lists.linux.dev>; Mon, 21 Feb 2022 06:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645423944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I7fEPjR3MlWt1lo1qlSLeG7RTScXOJ579J3jtddHCfI=;
	b=EIWTquPtq3+gLXnD6noh/q9z+kfuyzigPKRPnWeVRPrtqsijnRbSo74IDCHcNuE1E+f3gS
	iALMMROK/07AWjQkPRrKTk4+ZyKzBjHM8EwMYx24B8s1P2qM6ZLl3vRCsXZgHfeCTJJ6Fe
	GdKmwPfEgwZx175e3f+2WHy2nE0xo90=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2113.outbound.protection.outlook.com [104.47.18.113]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-2-ji2dWDl3OgidpgFETUBMiQ-1; Mon, 21 Feb 2022 07:12:23 +0100
X-MC-Unique: ji2dWDl3OgidpgFETUBMiQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQhwnuo5QNhBgh8arVDkli1ij8o+Qp2Tcu5fdHDaQjE1y9pl+aTQKIS3PMF5gfEa7mv4VNZdCG6c0zJdkRpJA6R4pOYmjERakQlB5FIgRnCQxLZCWduWlFSPO+2AEa2djtsQY5ROii532YsBRqwqUJGs97R6weEwYLjmx9pvii2PtAiJRYBZSnO7eXYdYKliQ+nFQWEP7p7o4H/zULjZHLAkTAmYb7gYWDNpqYl+hPHosXngOjR1GF3BlxUyv1QKVQULvpL56Wq68YOVbknr8Xx3Fv0FXdZ2Pds7c75OyfC2oCTuWe8S7nYRlYsfhy3Mfgfyp2INhW9gCx+pyt8C3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ie8GHK4pZ97/2v2yL3M5gGw41FClcEuA8gxWdFb7F+4=;
 b=BHytjy1aTk9qwooZUWvwXhI9cIk2FDoBx1yuAAvCHlz7k5L5U75gvN3MRy2zCRJFMSc7wINiwCQ434E+06YSLawl27otKZhlYJG0jEiibavdOTnbpV8MAOc1gnC21mCqlvfdndxhINB7qu0NeNAnLYHfSk2SpO8PEZf+Uu9qvfRsZQjUgU+/mAEH2ZBg86eyQ+4+2GLyn1gIrA5Ns+NuCOM9C028X5wJcPRlnxPtks8eWt7lJFDhmOXu0IXQmfOdRT7nJxx4Hyb/fp1kdBL/ZPWcVS4zrgUP1BvLJW/NXjVYbV1mzs9qHh3ibGQOlh5fdvDH/9A6IenMdHkgcThssQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB3053.eurprd04.prod.outlook.com (2603:10a6:802:6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.26; Mon, 21 Feb
 2022 06:12:22 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Mon, 21 Feb 2022
 06:12:22 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH iproute2-next v2 2/3] mptcp: add fullmesh support for setting flags
Date: Mon, 21 Feb 2022 14:12:37 +0800
Message-ID: <5747de1784ce159db98fd81fa825c451fa0c5dcf.1645422873.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645422873.git.geliang.tang@suse.com>
References: <cover.1645422873.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:203:d0::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dfde1c8c-b418-4db1-d138-08d9f5011f73
X-MS-TrafficTypeDiagnostic: VI1PR04MB3053:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB30530248E86CA8AF9FA27A9CF83A9@VI1PR04MB3053.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tgjmLYDCgszWSmJsk7uBobFAwejmt0h+tiHgnz6Jk8bowRBnZ7gFu9Cj+DU6TOWuKSVXJjoC9SjEAB/PwbY0SRHies/IM0WYGXGfOL+zb+HTV0QUPR5Ou7Jxk+p8McnI2GHqGg7bN/tT62gsVJaIZUCzr9MhdUUfY8cYxEBY9jjWiUtEDjcz0M5PKB0Ta+I0UHan3MzB2fz4asLESHwvFGoZJyRUBgRjF2llrObk9uzb0sRZD5AD4e36WtPRONKnC4r0LCZ3KHCjZFwkDZQxtJk2kll25qce6jydK98WDnh5/M05IgnhiXsLyUDvkxyMqWQtPI8F7kQJpRguoDPzq6p8jBL7YPTLT9jssmxmHFrVw3c4lXd945rQrur3BlS4/sozN6BxHUrULbzbERaZLTISGK9EMXda3exN59Ln+kUw9MT+eMBF5V/X7X96tXB5phhSpb9+/WwQaPTIqzyaMyQj9xem4DWcVEXFNHR3QthTEKIny9EOoteIz5WmuiohM9z9s7EDXwJfRCcq3zU+5Rs2JWxLo1/hOH56tlD2fobvPS5VuzGVI31ZPHV444Wfgh6sRK8DrtHXeLw4RlGeor3YtJ29JvQ7wYHKH0868HdC3y3H9XAy+MgQ4o/R5qG5jGVp0n7WBQekxI2T4c1rug==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(26005)(2906002)(2616005)(38100700002)(36756003)(5660300002)(44832011)(8936002)(6916009)(6486002)(508600001)(66556008)(4326008)(54906003)(6666004)(8676002)(6512007)(66476007)(6506007)(66946007)(316002)(83380400001)(55236004)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZHlyVmbtXSvhmz+Leeo4njfzaxNVrw2L1LXw+6gy/5bnzlFgEZwouA7YSJJL?=
 =?us-ascii?Q?YbGjaB1RfrSvtMzw4p310icrSrKbNkpouImxgH6xWj3i9IqT8FjuztHcTUSG?=
 =?us-ascii?Q?0E7RWAOXkRSO9AdXWGH3XZ+f+PMj9qZKygloANsCwiVfp5FTNdyweUNBPejA?=
 =?us-ascii?Q?hE6TaWo77B+RGnJvwSetnqDPDGSjENDWNygQtaF0LgLSZZMmYST+/R/Q7S9U?=
 =?us-ascii?Q?Fl35P2vlECFT+A8z6BbYukodbsos27NDQAj7xgUzLZerL0SseVQEk9RsI6g2?=
 =?us-ascii?Q?cHgvCE8lBXD1GAp16VeZTHkSPNlqg+OKo+wXHwSn1UlCJAHtHopQWcjsWFDV?=
 =?us-ascii?Q?tkE5ox0duLYrwqokq9GyR+geHlnN/+1u5JT1w8jVRhsywfOOAYpEBAcs4BSb?=
 =?us-ascii?Q?+Gd8wSOcMiZ9xFl27zEt/DQZFfF3jmAAHCLN9AXAQDakTW8twumKAU6bX8WX?=
 =?us-ascii?Q?tLjyoVzg2lHT63JO5cPYlnDKKhTYxIU0llR1X147/fODWkRR19ASPmaAYL8R?=
 =?us-ascii?Q?QEtFykGrqziy9imvvoEgg4ndW59DhJVR4/yB2Y5v7oruBwir+70kof1ZgcTq?=
 =?us-ascii?Q?DLnCRfcSoqxE/a0vWDGzgK5+AL4D9McnIaswaEzMtaMJmTtusRpqTDUCg6j+?=
 =?us-ascii?Q?8HIu3OpImL8e948YAlH4MHISaAvYcPO478ldA3WwUpbibmyVm33x5MK2xUOE?=
 =?us-ascii?Q?WMLzF3fQaOtqw4c6TqlZvF0q/mCMdzZ8yilvNYZ3wQi4Zbg3VMoNJBJrqK0S?=
 =?us-ascii?Q?FjJTq7PSISZwJ4hwbklpPPQ7w80IqgOi+sYy9WZqwmbn+DL1TMLTbKVrLHSs?=
 =?us-ascii?Q?ZBbEvt0CLu6V/RckLmxgMB8jBHt22QxRaOftHEY082TnafOGtODN3yJU7o5t?=
 =?us-ascii?Q?CzpU7KXdvn5NjLa5Tid8Rat3Llu8oG5RskYnrl8MS0IVoGlemfPtDjXTPMh6?=
 =?us-ascii?Q?cXW2oxiu0MMWMG643P+AOCZ9go/PCHKU0JRuQE4ByWzAc3cqHj1h8FQPSYkV?=
 =?us-ascii?Q?VZScSIMFlPARn5Ks7ul79t8SYxpH9pevF7rQuZuGmFv1NdikLztQ7rURWzY/?=
 =?us-ascii?Q?EA32YnHATxaQZl0VkIm1HemeR4ueZl8BdTneHzcMlPwHb94CjlNUo0vBx0jD?=
 =?us-ascii?Q?kDKGYd9BEicrSHA3x4fqkGjAx0Sa7yNH5pIt9MQbyOcxPhj4/ZL8/HUAlbRR?=
 =?us-ascii?Q?vWzL2TgLkww0wPPwyX4Y0u08vppFHB26cYgs37dr6AIL3a3JHRGQzyCTJUW1?=
 =?us-ascii?Q?RNTmh4887Zys8J0gbXtO5jaI7fbZpjdPtwhxJ9LiOONbc4IjMVHeE0T9taFY?=
 =?us-ascii?Q?9iL2/MIyoE6N/C+BuAqpFbm1Va6eioahFgTp3vhurHsE4YKOir8CO5w09yN/?=
 =?us-ascii?Q?yOrptlfWAobW7T7bKggz/Uq0oWEEGT1kLF5l17giY7eGGizoodAhpukgcFc4?=
 =?us-ascii?Q?H896LUJqp8rXxKjkxYjUJUzCskqif8iWCvlTgIk0mHaISZvLsj8Ah6+7W029?=
 =?us-ascii?Q?/2Me1qrgX8Me15vG6vnJXe2a71wvgbTEFeiDM4/CmZh+3KYX/e/yVyupNcXH?=
 =?us-ascii?Q?LZzFJRBTpGGYdSQxSvJS0d0UmXOLdxhxYCr/dqRFLqZEZLBiS8fvS5WGlh8Q?=
 =?us-ascii?Q?Kb0nkJD64bNfJLdT1Bx2tlM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfde1c8c-b418-4db1-d138-08d9f5011f73
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 06:12:22.4060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zeSWfTlLvjKk4TMOst+LHLVwEjazOpVwsrBy5pEvyJDX5KKdrydzCenU/45XZebVLVTKPmRtdFvd5Gv47oC1tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3053

A pair of new flags, fullmesh and nofullmesh, had been added in the
setting flags of MPTCP PM netlink in kernel space recently by the commit
73c762c1f07d ("mptcp: set fullmesh flag in pm_netlink").

This patch added the corresponding logic to pass these two flags to the
netlink in user space.

These new flags can be used like this:

 ip mptcp endpoint change id 1 fullmesh
 ip mptcp endpoint change id 1 nofullmesh
 ip mptcp endpoint change id 1 backup fullmesh
 ip mptcp endpoint change id 1 nobackup nofullmesh

Acked-by: Paolo Abeni <pabeni@redhat.com>
Acked-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 ip/ipmptcp.c        | 18 +++++++++++-------
 man/man8/ip-mptcp.8 |  8 ++++++--
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
index 0b744720..247d1caf 100644
--- a/ip/ipmptcp.c
+++ b/ip/ipmptcp.c
@@ -25,14 +25,15 @@ static void usage(void)
 		"Usage:	ip mptcp endpoint add ADDRESS [ dev NAME ] [ id ID ]\n"
 		"				      [ port NR ] [ FLAG-LIST ]\n"
 		"	ip mptcp endpoint delete id ID [ ADDRESS ]\n"
-		"	ip mptcp endpoint change id ID [ backup | nobackup ]\n"
+		"	ip mptcp endpoint change id ID CHANGE-OPT\n"
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
@@ -121,9 +124,10 @@ static int mptcp_parse_opt(int argc, char **argv, stru=
ct nlmsghdr *n, int cmd)
 			    (flags & MPTCP_PM_ADDR_FLAG_FULLMESH))
 				invarg("invalid flags\n", *argv);
=20
-			/* allow changing the 'backup' flag only */
-			if (cmd =3D=3D MPTCP_PM_CMD_SET_FLAGS &&
-			    (flags & ~MPTCP_PM_ADDR_FLAG_BACKUP))
+			/* allow changing the 'backup' and 'fullmesh' flags only */
+			if (setting &&
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
2.34.1

