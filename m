Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFE420F9
	for <mptcp@lists.linux.dev>; Mon, 21 Feb 2022 06:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645423952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J/WWkrKIdxBqKtuQ+M1jfSmc5WJGxQXYBhGNno54OjM=;
	b=X8UISZS+L3oZyP/LJXIZnV++z6NLvceq678i9K5Locy6/Q18/rQUj9v/fDST+G0crSraqS
	rx738SFrRHJ2TQC98xF/4C+u1OXlLzmezpWYYry3js+6b5bLtcXp+Vs227axzffC3KfDmG
	ymEyyzAZqyRwSm6rzpKfVslFBu9MQG0=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2105.outbound.protection.outlook.com [104.47.18.105]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-31-BaxUMpMEN8eLYc5VHde1Aw-1; Mon, 21 Feb 2022 07:12:31 +0100
X-MC-Unique: BaxUMpMEN8eLYc5VHde1Aw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/9rNXYiR3cPrB7SRRovRolaSH7vg+z93svfi8xuo3fs6Q51cOrHVFKaH0GMv+Y5meIvaJKmp2ernNbFwWHRfeEHH/1jMmna8rZpW+sWQvjSWCKfyiO/Gx8XkAKnROD6BxL8LZsfBok0Xs0vZWnMIqSTOgS7kYtMawz+Vs1ivIqllT5XsnJWMxFzQaT456pH8KIzdWWW1MhT7gqv1pBSe7AhMPq+1Ml7AFuJSGckzOgWBcpg/M+6IiU7bgYmCDjkayr62SO7mo0FgQyTY+mI1JL+OYzVO3qOBOOERGnnCQ9gE00BDil4I8EGyZ3spZ/J/najfkjRNG/E5stNnQvhRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7TNmfSsTYeiwxbo4rbwO298n2C1IdCvhgweo4Avhpvg=;
 b=MoXywOvhW8LljJHaWX+cc7/yFdwm4Aw/PzspzlEk/CMdD/eSBKLvI9JN48EKj96HsXXPugWjFeB0WSDTx6kJQpN4VgeyLagh+ASqmuFCbwMci1Bp6/NiGfYm1heXF39ASS6MUsDvdKnagAetefqcHaYeJFR0kp1qxrShQppvVDRpndm4Vf2/7gYilhGydYfODimtuBgg6PZoSmSsDxw6Hmb8fKHeakiK6wA+u9VqrCyoZRhURu/XrpodG1oEzM0vGK3XcDmKblnpP1jVNyxy6sOwXPdJBlfb+BRsCjpbds3/NOlY6WkZk6Vu6uvSndjkqyLYpqg5GGdJ9Pq8jvYFXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB3053.eurprd04.prod.outlook.com (2603:10a6:802:6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.26; Mon, 21 Feb
 2022 06:12:30 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Mon, 21 Feb 2022
 06:12:30 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH iproute2-next v2 3/3] mptcp: add port support for setting flags
Date: Mon, 21 Feb 2022 14:12:38 +0800
Message-ID: <530ddee685e17df00034dd97484db23bbe3d1ae4.1645422873.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645422873.git.geliang.tang@suse.com>
References: <cover.1645422873.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:203:d0::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39abe1fb-46c0-4ad5-6e4a-08d9f5012419
X-MS-TrafficTypeDiagnostic: VI1PR04MB3053:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB3053CE14494921429C4AE079F83A9@VI1PR04MB3053.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	t+I0BaNH7/oNZGA0uj5T5zuRj6w29JkU07zK4H4NvKfPGhIwjFUOpyOfYhno1p9j7C/pKUllvh639bbz9bYnTi79sj2ljox6E566lrcxmyd66V83+o87cqUxmqMxJysd80jSJ0yUc5KBM8ZogfP6Ei3KbdtPeyBhNKy4Fd2pitAUWwYEoXSYfiSoJ5GMj8sZxveBUmW92R+/9TNRuTW9jOegPaNV99/CuMFQY9lp7UBCkTlgh6BdkxGElFTwZf6hS8QmaNUJ99+F4tzMmekwBDNBqDgnaRAFD24cC+YPffPJjunuhfDe6o+btor/2YHDnmBdySw9uvegsd6cMC2lRDHLg33KvgjjCl6RnfZIZTxMPRekc10WcAQD4uhFyM1G3HDJfgJm/u3KOFlahVzifB6JDcmsdDEQdTChrr+/tlkeAkIx3OCt5hvLedWVrJy9IwIULMuftt1oGmrEnsRUZpImsDamJn43PfFNSlgC0sNZjjfO8cElTDtUcCT8pNbMIhQdYLRx/MqlL3VeU2w85Tsy8vZuVy2J2myvz0S/BCX10dJ+SWn5ueZ2NaSYII3KJ41gb7gZHgo3dP5jpMzVweoEJKX2osa3807hwPgLwdYxsiWfAFlMu7/Fr6bR1OEr322873680XCpQGjvNTRFwA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(26005)(2906002)(2616005)(38100700002)(36756003)(5660300002)(44832011)(8936002)(6916009)(6486002)(508600001)(66556008)(4326008)(54906003)(8676002)(6512007)(66476007)(6506007)(66946007)(316002)(83380400001)(55236004)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VLkr+uUbIBn5TDIb8iK7ki2eo5SduQD3h0HeRWIpGTqSP3BD7dFUg4EFYFWy?=
 =?us-ascii?Q?JVHCdTgGcsi7bmYMScq4T9qSEc5UdWTYiv/oODwEIUCFxX5SkIoo4TT4ZNuP?=
 =?us-ascii?Q?7I/MJqdKQEVZpgPYP+8mzcK8N9lWm8Kn1m4+k5999TabPBREpd2LgB4ZHV5N?=
 =?us-ascii?Q?oeJHZWgyKuCqkNFN7Xm5JkKUbQk5wH+1GxZ4cr1gzHtijnH82DFQgDzeyAF7?=
 =?us-ascii?Q?V6a3xEMNQtWUaj/jXezIDrgTIrN/Xt0GSDAPA29FIqKo6Bfyi47izGhsMxmc?=
 =?us-ascii?Q?GnfNRz5QMccTvZp6XenOuN3CEFJagNyXLsrgdw3kbSktT24Isvdbh5gbySvt?=
 =?us-ascii?Q?R74pCBUqsmQ3zqiCwDjuTcnQNmaRyUszDzJWQpsjbg5jkkh+IHP4uR2URcsX?=
 =?us-ascii?Q?8CrtJ77vOPJYBWltZg2HIEvEisoBvwW06d9QN/ObeLFu2VTsCgUBP6Eay0ea?=
 =?us-ascii?Q?v5N5eS7gNNMSUVQtSvy2NNs+XPyikghICUFlXHuraBSwqe3g4mmf6K1Dk672?=
 =?us-ascii?Q?zjBskt6DY0xeEoJGrK/3BZFPum9z0ccm5TbGBVmHBOFf8VDz/mcLXRUI68h1?=
 =?us-ascii?Q?SwzrmXRfo+Gm8z5VVlO41JVX3+nYBJR077BMT12TOV+/66alGep6UEuP9P3C?=
 =?us-ascii?Q?e5ErLmM5sCUsidSFXYN7kjPBKzM2ciCAGPGHhkBf1XoZ7NbNO69PLrhGFrDy?=
 =?us-ascii?Q?Hw86Y8csntXBJgnMv25n02l/nRYDnT4udkUecqGjyQjwm/Zy5NBBqNk3jW8Q?=
 =?us-ascii?Q?a/EEHooz3VMsPAxNMw2VoNG2Gw3wnCzWL+fx6jEa6jGb/lirCN2jyO+dOtyg?=
 =?us-ascii?Q?UFanZGLt7cGOHekucjd7y31uZgJtPCgFTbYZnmoPXEUCx3I3Xv9yDvB4amod?=
 =?us-ascii?Q?d2O21EU4/l47a77lrFr1+d/nAvAKeuQ+Dx5MvKywwJ8BLNPI1z7VK3j0J8tG?=
 =?us-ascii?Q?HjjLdmuu6trLXs0hqisS5GZxsNEkEKHQSQuRDNKHJIkgDZGTrvG9mWzbEtK3?=
 =?us-ascii?Q?igoYB7/eouEFJs5mBn4uNRWJQkdDytlmFsSnI6tWt8AmGpLvmsfnKsMq8Pnz?=
 =?us-ascii?Q?/F+6xDZb3xAv901J4xkKW+mTGPqOo7+i9RpM1nJqE3xPYDwzeVD2HJcHlhV/?=
 =?us-ascii?Q?CGYb8U0X9eBzaceWkmuod/Ktaw2pGhoqcQfKOGQLrA5f0o7MHzXES73JUlOk?=
 =?us-ascii?Q?YIpUQeil3x+dRpS1FcU14tLMcPWUlaPx5l4ZXBQsybTSZtO5MVe1fg6bUVyh?=
 =?us-ascii?Q?eUkvMjyAl010d6VYzknBhFpuC8Yn6m6XHZYeVjY5AfJlZx4C9UvJnCMX66rm?=
 =?us-ascii?Q?Pq7DMoG8lKTtwxknmKE8tcmIaOeArOmzfB1A6ObAszIjWuucJ4+dlRjgzd8O?=
 =?us-ascii?Q?OIFaWpW8ojvwayRQpapwnl1GNdZ/O/XADrWrtqYSRsGiU5tEDZPBOqDE946M?=
 =?us-ascii?Q?dOxa1aRUAaYUDzyyr2/7/VUVUpFP1yN5ZuAJN1DPSaciQsSonYcw8GYL7QeQ?=
 =?us-ascii?Q?VBbS1iUEWrlIW3RwjJvfATXP+NZGdI1tV4FG4RSLA4mUeAbfCs+sGj+85RCO?=
 =?us-ascii?Q?6V/zzB4G7zKQAL7Q11g8UQAK2S3LccwtB17jyOLxwLmejRKObTz0tzpiREC7?=
 =?us-ascii?Q?sknfAfsk7e3nz3zRRlbdD28=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39abe1fb-46c0-4ad5-6e4a-08d9f5012419
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 06:12:30.2335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oeXQ50ByQcgXkGkFS1IuQ7QLEhb9UTSqcNgqfZQZLRvedxIGfWlymbq3bnXYpFm+Lnu1KhmWyO0oVD9YD7jDbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3053

This patch updated the port keyword check for the setting flags, allow
to use the port keyword with the non-signal flags. Don't allow to use
the port keyword with the id number.

With this patch, we can use setting flags in two forms, using the address
and port number directly or the id number of the address:

 ip mptcp endpoint change id 1 fullmesh
 ip mptcp endpoint change 10.0.2.1 fullmesh
 ip mptcp endpoint change 10.0.2.1 port 10100 fullmesh

Acked-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 ip/ipmptcp.c        |  7 +++++--
 man/man8/ip-mptcp.8 | 11 +++++++----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
index 247d1caf..b06afcf7 100644
--- a/ip/ipmptcp.c
+++ b/ip/ipmptcp.c
@@ -25,7 +25,7 @@ static void usage(void)
 		"Usage:	ip mptcp endpoint add ADDRESS [ dev NAME ] [ id ID ]\n"
 		"				      [ port NR ] [ FLAG-LIST ]\n"
 		"	ip mptcp endpoint delete id ID [ ADDRESS ]\n"
-		"	ip mptcp endpoint change id ID CHANGE-OPT\n"
+		"	ip mptcp endpoint change [ id ID ] [ ADDRESS ] [ port NR ] CHANGE-OPT\=
n"
 		"	ip mptcp endpoint show [ id ID ]\n"
 		"	ip mptcp endpoint flush\n"
 		"	ip mptcp limits set [ subflows NR ] [ add_addr_accepted NR ]\n"
@@ -175,9 +175,12 @@ static int mptcp_parse_opt(int argc, char **argv, stru=
ct nlmsghdr *n, int cmd)
 			invarg("address is needed for deleting id 0 address\n", "ID");
 	}
=20
-	if (port && !(flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
+	if (adding && port && !(flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
 		invarg("flags must have signal when using port", "port");
=20
+	if (setting && id_set && port)
+		invarg("port can't be used with id", "port");
+
 	attr_addr =3D addattr_nest(n, MPTCP_BUFLEN,
 				 MPTCP_PM_ATTR_ADDR | NLA_F_NESTED);
 	if (id_set)
diff --git a/man/man8/ip-mptcp.8 b/man/man8/ip-mptcp.8
index bddbff3c..72762f49 100644
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
-.I CHANGE-OPT
-.RB "] "
+.RB "] [ "
+.IR IFADDR
+.RB "] [ " port
+.IR PORT " ]"
+.RB "CHANGE-OPT"
=20
 .ti -8
 .BR "ip mptcp endpoint show "
--=20
2.34.1

