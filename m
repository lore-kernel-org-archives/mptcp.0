Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4062C9C
	for <mptcp@lists.linux.dev>; Sat, 22 Jan 2022 09:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642842019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SHep4jX5OtwZ7g8+x7T1NwBT9NMnjlKvT/X5fjzUaUY=;
	b=ZeFHwK2d5l4lM8oh2oiLTal1vnwY+cgbKGQC75U2lkKgXx6ANXlqzXF6RSUX1th4+xsahj
	uhzQZsQuVWtrsBhHHswtGKDjzWQNvV53HrHg7ir5pIQouOTXY1R/VUZV9o7yN0rNma4NSq
	ryTr0hySTl3D1Cq0XPtFj/lq4wqpaa0=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2051.outbound.protection.outlook.com [104.47.12.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-16-zDpwyvYiOfmQ_FTuTJZCkg-1; Sat, 22 Jan 2022 10:00:18 +0100
X-MC-Unique: zDpwyvYiOfmQ_FTuTJZCkg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CR05N3x2wEfCSKKp2074bjALi8Up24e3KmFbFJZrgnN1KLS1eMPAmVTW8NsOVqnncK4OsFv/s4UoJIIVBYCi2uOQ4C985EdQUgTqlEa4aRrAgt5N9DOAgCqJzB8lrrXcl3CwbrQHC8ZWBa/qDaVmAr4hleTojtk5PE7tWCKLTWj8svdOs4q+6JDo7XSaFvsB7olveXMwVn7x5M7qD5fQVelKCi5vyRW/adUU+b55Ux+YlCpImX/kwopIFRtDG1A0Lut8X/DxmNN3288vGKew+oeUJEApVosK0WgrQQ0qTNBAnkaScWKde84qq20d5IVJMita1DXOfStH7CUhu5o/cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w61FA22y3+tGFq3GJx+ao9038UGOvcUlaK9nywa/LHc=;
 b=EVNROSkyhT3YluQcjS4GGdMejTtiUN1VIb7N/ux8AvdT1gQP3V6OZcAz15OLtRPbpu1hOCtyUjezQiJiK4oIs3dyO4nSQnvFymGs7ocyucsY42lHqCREcvDmfMRpwTXPI7IGirDcOtOSJYRvIUvZAapf/kjqBK9jSg70HK/YOvOr43GWukDzuR3PXPX8U1oPlazr2JmYsvYga06TZjIctRtdR/TXu+edmADeespWLkCH3yBSgKxSddnCmI6HF6f82Gm47vawU5CYZI0UcKHg8zOntPOrTXXHcbrIeoG0nlZTKPZBnP/7TNkunYD/aSV+Jajxoli2GPhChVYNl69AkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8854.eurprd04.prod.outlook.com (2603:10a6:10:2e1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.14; Sat, 22 Jan
 2022 09:00:17 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c%6]) with mapi id 15.20.4909.013; Sat, 22 Jan 2022
 09:00:17 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 1/2] selftests: mptcp: add the id argument for set_flags
Date: Sat, 22 Jan 2022 17:00:02 +0800
Message-ID: <c008a837b1cfd578ddd689a73ce3ae0615680bb5.1642841713.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642841713.git.geliang.tang@suse.com>
References: <cover.1642841713.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0217.apcprd02.prod.outlook.com
 (2603:1096:201:20::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a947d661-08b3-413d-b571-08d9dd859c1a
X-MS-TrafficTypeDiagnostic: DU2PR04MB8854:EE_
X-Microsoft-Antispam-PRVS:
	<DU2PR04MB8854969016B859DB8B2477C2F85C9@DU2PR04MB8854.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:243;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VFcwXvAJ6+BYqiMCkz5wKcbdCvPfjITAo6MfnwNMszkb2WK4/sT9x2Xkog4xri1lkfq/p+7rUc7nTQa6HuNGkk7g2Nm4+ocl8WcU7l01g+0obmGvSvXsXXFscWjM/fuu3tiVJqWnZyXgBBTRIqDmvIGycc2pWeNCzDzR6xBxARiGdkTalXtsiSf7UD4F7eeNkdyVs8uGjexgpVYED1W1FutH4c8O3wwsWbH4gXxcdyCfUWazgNJH+4Hm5NBXC0o6OmYzyuxQjSz4eWArBOZo5hc0Ozsh8VKmJm2vup5mnNUioRuvZqYR7qcBSjJvXPDzyda1qAEyn+tV4gAtHkfZn2//z4CEG/BxnLZ4a6WeKsxralnEptCOFi7RqkiPuPeirWP1pEw0LUL9scfMF0UW6liST9al98cI1oIW1WkP58nFWOhNgw7Mol1uOAmUs/axuijIBNSM5UBRPHW1IkEFB+ZapdYzZUMd3p7JqQZ1THcUsrRCQeHNoHZ6nLJxRcGdwnsM05k7084CyPXW1VN2OhOzoSLtGaibyoSSm8oCaVLVjbOdLxRzaQaLduiGQMOE+QXZuTzh1gJQi+QymPyLZGrvafua/bf6Zu/EQ7Fy9E0+NDV5v4NoFovdLJduMT42/HQ+fLurJ4nkSkKPcY+/3GNO1q1C2Z64y13tWYrQvLzPXwj5O5jU8JBefUw4Xzry2qPCcXM1KsR1zqPRz6dnyg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2616005)(6506007)(44832011)(316002)(83380400001)(5660300002)(508600001)(186003)(6916009)(4326008)(36756003)(6666004)(26005)(6486002)(2906002)(66556008)(66476007)(8936002)(66946007)(8676002)(107886003)(38100700002)(86362001)(6512007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7U+6a47gTWx10L8ZpnrV+s6FwZom1D9LQOVpoKJagc/sUpcBJqRviEtxhj3Q?=
 =?us-ascii?Q?ixNph+aO2DqjPPWoEEOgCfcjHXeLpBk4tfIjd2sPTqL/jDR4jYLH7jQuVUI9?=
 =?us-ascii?Q?2ZXXiuLYFYFufcqC0YZmhGepEe2DPAOd+v7p7JmXRZOBREV+rg4aYb1y8ihX?=
 =?us-ascii?Q?sDdW72o3cor+oMj14KHbeDycAKnAeMeX+NK+5bASESdxiieGKODax7Xgt51m?=
 =?us-ascii?Q?JIUz9lKy3WjdrkGs4KrFMWJv+9PIZQldPdVh/nK2jTTtFftefrPefwHqW73V?=
 =?us-ascii?Q?yp6lQPkFa0vhLWuYoJT6OI40qdAxAROtO584FMteWsuhNQLP7ymPKz9qIwFW?=
 =?us-ascii?Q?i/C1brgBba5SElA2Ka/Ywusliv06SL4YwCRfG0KFIWyKmQuskLau7VHLCqO4?=
 =?us-ascii?Q?K6xz0/z8wjoFzz0ggF1cCEoslKnfxzAQA+nFu18X27PruvzCckv/ZqkL2wlI?=
 =?us-ascii?Q?8ns0OsoU1lDsf9ShT2n4tVonvyflaS+kDc7tJtqn7pLOSWMQuKE2pAu2TUQG?=
 =?us-ascii?Q?LSwKUhayrWbL/Jvbx73kcL4eBoFV2FSjcfxdncVJydNMsxvUKDhxVaGFynvl?=
 =?us-ascii?Q?XE5Pva/4wok1T6uCpLVIWZotYz6AVSCTC5Fu5c8OmaMKLo3Vw1gNTo/jQibX?=
 =?us-ascii?Q?U2L3tV9iOudSCmHhcYUayvwo/REsfGkJ/XdJzosB1Nhy4Nvcg1we4sYDLFa/?=
 =?us-ascii?Q?wUYeHLAacj2PDkSX7h3UIzi8g7XqdXhjildczzKfNlHgoP7fvsVwZYMKp1Pl?=
 =?us-ascii?Q?5H+RA9xU6OaTwwnzh5R0ZfzhIPWZn1b3/c7r1LBG8425r5Nf1paaBJWuhYTW?=
 =?us-ascii?Q?eUpCXbUu0VC7yd7mmEAUUD8FG1sRFJTMjs5DTBILEcNgaCr7/JZDDnQQ3Xg/?=
 =?us-ascii?Q?uvbP6ARVH4MlL/cxQ/xefYpqhzZoB+hjJA2H0UCMDI6lYhotA6NoL4L5Fwy2?=
 =?us-ascii?Q?5v++Ai3CO/axXnZtFifFb+ojC3WWrnTXdtdvlfG/7ZnqGzPmiru3LsGrrpWA?=
 =?us-ascii?Q?x/zzAVJDIoIJnkZI/4JvaTofpUbTi7Z72K+GhPax3twFUD9DXdlCNYgJydir?=
 =?us-ascii?Q?2SFI+eQLU9Njv3NzJ1ea4rpIhgjujoNMtqGThZDNWy/6OhR8xkx4zrqZ3RZp?=
 =?us-ascii?Q?ivfwsO2FrRSkK1qefQzpnu7GJ2DGSRwnUYJ7oQOcaznLTFBUUmJ1ZqxA+lb0?=
 =?us-ascii?Q?6n4eSHkUJXxVUffIRncLzisVxzKpbtdtKEO+hGkCHL8yE3YYx39dFlDwbOCP?=
 =?us-ascii?Q?6ZIOwSfRh0Z20hFyuDbxNn9zu+TEZ5KoxwXwi+6wrYEiyfi8sm2DApC+OCM4?=
 =?us-ascii?Q?q2ZFKlreMb5y9SasctnDrWVYZ7T4Tj1H/k5Z52F4ZKM11kNjK65R75120M8I?=
 =?us-ascii?Q?b+GsK6yUeM/Ozr1md6JieVgTeaboqvSPC4IFdOjLnYOnqikEBmUCnmwI478F?=
 =?us-ascii?Q?802YqA77XD98oE6TyxUWgBAnHEQgAWv7iDGQ/VWqsEjdYdtXCtPJEEW4KHoK?=
 =?us-ascii?Q?B+hOFVMg6HbErxJpEdKDywmEs3QqebYT0jWlks1bTQ6Z2NDEwPUhDUkjeLZD?=
 =?us-ascii?Q?QlvDg2ziKno3VM3tMKSHew2cyJteF8v1cxELs1foToPMK2NjsISgRc8kk3FH?=
 =?us-ascii?Q?pEo9jSHMBzLyA3C3Cg02kYs=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a947d661-08b3-413d-b571-08d9dd859c1a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2022 09:00:17.1676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Mdo8mpBKMRo/0aJ3u4Gctd+vbZgJVtfmmR8B4oZBYl97YA3FdItdPqMeY8M6JxuTz+hNGWw6+eo1cYmch56FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8854

This patch added the id argument for setting the address flags in
pm_nl_ctl.

Usage:

    pm_nl_ctl set id 1 flags backup

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 64 +++++++++++++------
 1 file changed, 43 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/=
selftests/net/mptcp/pm_nl_ctl.c
index 2a57462764d0..e554928487f8 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -28,7 +28,8 @@ static void syntax(char *argv[])
 	fprintf(stderr, "\tadd [flags signal|subflow|backup|fullmesh] [id <nr>] [=
dev <name>] <ip>\n");
 	fprintf(stderr, "\tdel <id> [<ip>]\n");
 	fprintf(stderr, "\tget <id>\n");
-	fprintf(stderr, "\tset <ip> [flags backup|nobackup|fullmesh|nofullmesh] [=
port <nr>]\n");
+	fprintf(stderr, "\tset [<ip>] [id <nr>] [flags backup|nobackup|fullmesh|n=
ofullmesh]\n");
+	fprintf(stderr, "\t                                                     [=
port <nr>]\n");
 	fprintf(stderr, "\tflush\n");
 	fprintf(stderr, "\tdump\n");
 	fprintf(stderr, "\tlimits [<rcv addr max> <subflow max>]\n");
@@ -657,8 +658,10 @@ int set_flags(int fd, int pm_family, int argc, char *a=
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
@@ -674,29 +677,45 @@ int set_flags(int fd, int pm_family, int argc, char *=
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
@@ -724,6 +743,9 @@ int set_flags(int fd, int pm_family, int argc, char *ar=
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

