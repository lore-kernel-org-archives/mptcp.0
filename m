Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12202CA3
	for <mptcp@lists.linux.dev>; Tue, 25 Jan 2022 02:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1643076348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V6PAebVxWBUFu0iAB/WuF6CNG8KOs6LKJFvEaBiaiKQ=;
	b=BU5SFUNGKO3iLQtT08nMYzBGO6L4W4h0z0KBXX7o2GdnaY7JX7YWKums4RElz9ynj1rbvS
	QuMhG/UWAdKPCauRkUMmxi5SdDO0SRS/hKKPzaTLsG1Nwhzx4uwxwtfUtw4fdy9kd6zmiq
	XMI9ziDpe++WPustIMefBGm9vi+SG0M=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2057.outbound.protection.outlook.com [104.47.13.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-26-FUlnC9SDMfqrWnY4o3FJeA-1; Tue, 25 Jan 2022 03:05:47 +0100
X-MC-Unique: FUlnC9SDMfqrWnY4o3FJeA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/CnSO0z0Am1IkED8zuGCsW0gcFuodXeGbSoBV2nR/08XzG5t2uugr09oAr0GzOYuzmrCA611Edxpp+7JYH3nA08Md+NwGJ6QlhlFojpM8bqZOjWQhk87Vmm5xsVhDZrafBATRzWcYnJeQoLL0/EK6wsXZuOz5caM0I/SU1DvGreXYRva7AMw7q8NYy6ZFyZnj/Qsl8uoR38jPbOikw4h+3dr7s1GvFaPJBLIavFgIXDcBtI161j9dAUBwjlQE4/aS1BJZJksqmhoK7ADs/EumbVNtv8jWE4295S7h4TUZXBQdBh2XJiwJgK0SjBsVgqVn5Kqu+OHuogW7IxgsWsFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KDtS1CArsZMPRIfXbNbfDHSREI4sJariI4I2gwK03A0=;
 b=b/4kF7Eswxk2IehzeFgsUIcZ0NQ6ti2J7UZaJnvWAzvbig8nEx796n/YIwxJypq5XkKfFol0qPZSdLPQEkCqyE0irtR6iRcwWm8+9r9HcAoDBVVxb7GL6dISPlvKeFOUke31qRkFTT/SXIaQMSqE7U7Y1B3PUaKmMyjILdhfWqIv3bO0l9it6XaDoB+r2JK2KWBzuxkCpf90ZZU++NIwc6xHpToeS4YZa3rlAx2aX4GkYzU5h5LDLwtzU7RQneah1kMgyhwqaADWWAE3Akzx5+y6yGmLiUMfUu4nr0bwTELuZYKmAtrs6bwZ9W7MhfKWOjSlmFxYykNscx2DtTHAHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB7169.eurprd04.prod.outlook.com (2603:10a6:208:19a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.19; Tue, 25 Jan
 2022 02:05:45 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c%7]) with mapi id 15.20.4909.019; Tue, 25 Jan 2022
 02:05:45 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 1/2] selftests: mptcp: add the id argument for set_flags
Date: Tue, 25 Jan 2022 10:05:40 +0800
Message-ID: <e7f6c242f14cf7cc0e5b324d601d9fb35f1efd0a.1643076075.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1643076075.git.geliang.tang@suse.com>
References: <cover.1643076075.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0160.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 222f5265-a689-4c9b-3869-08d9dfa732c9
X-MS-TrafficTypeDiagnostic: AM0PR04MB7169:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB71695AE3726B976F57DAFDECF85F9@AM0PR04MB7169.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:243;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XfUAjPiUwOvFB1V86eP34rrmbpWFFuRHEC4BepsNcLdwydtKwk6VU7zq5pCc0uFC+H6Ez2vmOZty2FVF3/r9ym4QbJ5P4I0fyfT/4vL2+o4NA2NTFaKWlWir/k2DHOpVF62LBfScWHKcIAEV9Ou/2JSQ8vbBsP7DCvYKzzoibWgSBUPaydNnEDwDd/r9BML7GSpavzoJmv56spZG8PC354HXOd80PNhPZkenJYyCFEcurG2HuJbMlXPbEL0dPBarRXBmj8dTsvUSDCUnYv4CMN6viUp3DE7JAMazqlDstcmGt3B9Hol3xDS7PJZnEeXf70Un2jcpRNG3Xkx9PMJcH4KQPbHe77A+kZLvrNWje/6iTdvCDp36bHq3bNHzhm5L/vABONX7KWgBRFmyovzfp1gAPfMbaxMEqxn4jfSFzZ6rGkvMcPAxtz/BQ9Mit19/LIvgYklm643NXbpYvghBB1xdx7tiaWf6W8sVmJAd74JM4NuIZ2Oz6uDaCH2k+XPjzMxtV68p35EvZHkuA0HZZ3TZGNXBWdpW+8Iub4QngTPgINX06Upzk7fuRM8ululmMXr1kX7WB8jFE+xPUb0Ll/Yl4iTz5dEZo3XMbWeD1Qa/q2w4PMcSUpdRhFagHg2aNozXbpXfFf8t6AibKfZg+A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(36756003)(8936002)(6916009)(316002)(508600001)(66946007)(86362001)(5660300002)(6512007)(6666004)(38100700002)(66476007)(66556008)(6506007)(186003)(44832011)(2906002)(26005)(83380400001)(6486002)(55236004)(107886003)(4326008)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4rjtkIbdq70qsGtaZE5GtkirkEEM8TjuAZAvDxZVWPHSbTebnScj4ZlwIs9O?=
 =?us-ascii?Q?dK6ZBf2T0b3B0ngYMV+NUC4dCTBzdViaWxl9g/2aHIVZUjDD50tRm3yEv4v2?=
 =?us-ascii?Q?x7470T0GpZb0c+rNzvvzQNgHc467AVJ52uypJx4A64C9W/rkw5+sL1QsVc+w?=
 =?us-ascii?Q?Sg9UQOflqut0lBXC26ORriYQ4SBHBc25cCFOQcjr/13S/qJVZOW6W9B8jMaK?=
 =?us-ascii?Q?YkbR+/UxHhxFg0ciREGyGhskiMorBtdFOYbjCLrLfvyEosIEFQrEs/Yx6qFh?=
 =?us-ascii?Q?8GBf1eXvW+CvyIHQIl4ncAWUzKBMuS+Ei3u0ba2b4+y0KsGzYSCQ0W2swWoc?=
 =?us-ascii?Q?OZoIHT7eL0FnPFl3UEVmTojZqhceGsv5gj6uQolKFegfAElmkxhCe5kBVW0+?=
 =?us-ascii?Q?TzC5gxi+/ngtOpeWouxv+6qEnsASOjJWeKub9OKx0XTHu82rxsGAr2geMg3I?=
 =?us-ascii?Q?GmdYhaQtDnOagaqfylHhl3/9IPkCuncMdka4EgPDopQ2AoWx522+mfVLlbRY?=
 =?us-ascii?Q?Uro8gbq1rjz5Np8KGjlj/6iDEoj88JAdMyDEB2Wia2bOp/s57YAIuAB58GeV?=
 =?us-ascii?Q?WJsNlGxrnRV2Qt8TwKvKlTm5DFKfz6rFVwOjsLlshvJnQvQiENe23i2vLFd/?=
 =?us-ascii?Q?pYrYPT5bDjw+SViJuqH/1tDfoTP1D6vLL/BEx/XYV/Bdbv/irPhSJXiyhwRr?=
 =?us-ascii?Q?05qMrZiqP1X3J2gkBf7uhVa5egC8EZoZhh30CmgGSgkjHlU5zH0gTH4nDgwd?=
 =?us-ascii?Q?SDG4PSE+DY7fVM7pvjp+DLGvAAf4jNK0NDkxLHZgENM38JXEUW2DrJbFVH0P?=
 =?us-ascii?Q?gOewiTeBkRy/9AwVgmyG+mfvKo5wspmKaSAIYBpGblvao1j2t2l5b/voQvQJ?=
 =?us-ascii?Q?TPS9TYJ3Kh0k+uVmqEvp8wjsTs3oi9xmaX8WHevFvyciSrdeIrhpCmXKzTAG?=
 =?us-ascii?Q?aZX8+gZUZgzp/YwZLQwvXKOVyMLxogjRHLs0my2G99kfuIFqXMroSSt1iibH?=
 =?us-ascii?Q?Bo0Edxwt2tEI8qKsGKHEmzxItHusC+9tBJ9F55S8RHoh2dudOcLRQuAt5SaR?=
 =?us-ascii?Q?nvydIEoGc7hesR7B+7V+bC/YNL2YHccKZBxd9UNLSnXODnUm7llJUgfpwDhM?=
 =?us-ascii?Q?Eo98+AUgghyWoB3DdhUVc6vcZbUzkPvrpUd3dwhpImjVYnu+hhs29akHS+zD?=
 =?us-ascii?Q?YsLAiXWk7NBvDiqQrVZF9UF9B+KGZed16+EZcyGDxsr3wP4NL0SKlPck5s2g?=
 =?us-ascii?Q?+lCxxMiP8IA7AanKxFNi9k7/zgMYB+l7pTL3Gz+LHKMyFAQMiqTzGxxeYDuY?=
 =?us-ascii?Q?wGBNBL5eKfJ74h/7mqlcL+U6hf/6U8ja6aeDxJWvKp9eLAtwezjoxEkrzHKR?=
 =?us-ascii?Q?2EK4vbuQnDbx0pI6a9ETFoSdun92IRBQR/DCjTs/bPegnUDvMg7ZUoA71O4B?=
 =?us-ascii?Q?RwyJutfBRrKUM37elLy78Uf4DuzJYbndEvpRqCiwwRk9PNWUKyzmjehhhrI/?=
 =?us-ascii?Q?U9BZa3NEo8BS3Shbkel6qGhWY89bfZFxFyMcCemfJPPOzkAWZyHxYF7ZdMWm?=
 =?us-ascii?Q?CaHHHwRVvcqG1yL5MXIuNQ+vGaPPINxeISwREssDl/Eg6iH2YchUPRNyIurf?=
 =?us-ascii?Q?SWTbHNyBhX+rs7jek3XcoEw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 222f5265-a689-4c9b-3869-08d9dfa732c9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 02:05:45.6559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: teOxeEaoAs5MlBgZaZLyc9WJtCMmooNEiqB/m8lppYwMLmNekDfQQHZyPakYMZQb3+Gjr67VGY6qQLsx+JyG7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7169

This patch added the id argument for setting the address flags in
pm_nl_ctl.

Usage:

    pm_nl_ctl set id 1 flags backup

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 63 ++++++++++++-------
 1 file changed, 42 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/=
selftests/net/mptcp/pm_nl_ctl.c
index 2a57462764d0..22a5ec1e128e 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -28,7 +28,7 @@ static void syntax(char *argv[])
 	fprintf(stderr, "\tadd [flags signal|subflow|backup|fullmesh] [id <nr>] [=
dev <name>] <ip>\n");
 	fprintf(stderr, "\tdel <id> [<ip>]\n");
 	fprintf(stderr, "\tget <id>\n");
-	fprintf(stderr, "\tset <ip> [flags backup|nobackup|fullmesh|nofullmesh] [=
port <nr>]\n");
+	fprintf(stderr, "\tset [<ip>] [id <nr>] flags [no]backup|[no]fullmesh [po=
rt <nr>]\n");
 	fprintf(stderr, "\tflush\n");
 	fprintf(stderr, "\tdump\n");
 	fprintf(stderr, "\tlimits [<rcv addr max> <subflow max>]\n");
@@ -657,8 +657,10 @@ int set_flags(int fd, int pm_family, int argc, char *a=
rgv[])
 	u_int32_t flags =3D 0;
 	u_int16_t family;
 	int nest_start;
+	int use_id =3D 0;
+	u_int8_t id;
 	int off =3D 0;
-	int arg;
+	int arg =3D 2;
=20
 	memset(data, 0, sizeof(data));
 	nh =3D (void *)data;
@@ -674,29 +676,45 @@ int set_flags(int fd, int pm_family, int argc, char *=
argv[])
 	nest->rta_len =3D RTA_LENGTH(0);
 	off +=3D NLMSG_ALIGN(nest->rta_len);
=20
-	/* addr data */
-	rta =3D (void *)(data + off);
-	if (inet_pton(AF_INET, argv[2], RTA_DATA(rta))) {
-		family =3D AF_INET;
-		rta->rta_type =3D MPTCP_PM_ADDR_ATTR_ADDR4;
-		rta->rta_len =3D RTA_LENGTH(4);
-	} else if (inet_pton(AF_INET6, argv[2], RTA_DATA(rta))) {
-		family =3D AF_INET6;
-		rta->rta_type =3D MPTCP_PM_ADDR_ATTR_ADDR6;
-		rta->rta_len =3D RTA_LENGTH(16);
+	if (!strcmp(argv[arg], "id")) {
+		if (++arg >=3D argc)
+			error(1, 0, " missing id value");
+
+		use_id =3D 1;
+		id =3D atoi(argv[arg]);
+		rta =3D (void *)(data + off);
+		rta->rta_type =3D MPTCP_PM_ADDR_ATTR_ID;
+		rta->rta_len =3D RTA_LENGTH(1);
+		memcpy(RTA_DATA(rta), &id, 1);
+		off +=3D NLMSG_ALIGN(rta->rta_len);
 	} else {
-		error(1, errno, "can't parse ip %s", argv[2]);
+		/* addr data */
+		rta =3D (void *)(data + off);
+		if (inet_pton(AF_INET, argv[arg], RTA_DATA(rta))) {
+			family =3D AF_INET;
+			rta->rta_type =3D MPTCP_PM_ADDR_ATTR_ADDR4;
+			rta->rta_len =3D RTA_LENGTH(4);
+		} else if (inet_pton(AF_INET6, argv[arg], RTA_DATA(rta))) {
+			family =3D AF_INET6;
+			rta->rta_type =3D MPTCP_PM_ADDR_ATTR_ADDR6;
+			rta->rta_len =3D RTA_LENGTH(16);
+		} else {
+			error(1, errno, "can't parse ip %s", argv[arg]);
+		}
+		off +=3D NLMSG_ALIGN(rta->rta_len);
+
+		/* family */
+		rta =3D (void *)(data + off);
+		rta->rta_type =3D MPTCP_PM_ADDR_ATTR_FAMILY;
+		rta->rta_len =3D RTA_LENGTH(2);
+		memcpy(RTA_DATA(rta), &family, 2);
+		off +=3D NLMSG_ALIGN(rta->rta_len);
 	}
-	off +=3D NLMSG_ALIGN(rta->rta_len);
=20
-	/* family */
-	rta =3D (void *)(data + off);
-	rta->rta_type =3D MPTCP_PM_ADDR_ATTR_FAMILY;
-	rta->rta_len =3D RTA_LENGTH(2);
-	memcpy(RTA_DATA(rta), &family, 2);
-	off +=3D NLMSG_ALIGN(rta->rta_len);
+	if (++arg >=3D argc)
+		error(1, 0, " missing flags keyword");
=20
-	for (arg =3D 3; arg < argc; arg++) {
+	for (; arg < argc; arg++) {
 		if (!strcmp(argv[arg], "flags")) {
 			char *tok, *str;
=20
@@ -724,6 +742,9 @@ int set_flags(int fd, int pm_family, int argc, char *ar=
gv[])
 		} else if (!strcmp(argv[arg], "port")) {
 			u_int16_t port;
=20
+			if (use_id)
+				error(1, 0, " port can't be used with id");
+
 			if (++arg >=3D argc)
 				error(1, 0, " missing port value");
=20
--=20
2.31.1

