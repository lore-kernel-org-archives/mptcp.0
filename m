Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F322CA8
	for <mptcp@lists.linux.dev>; Wed, 26 Jan 2022 02:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1643165785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V6PAebVxWBUFu0iAB/WuF6CNG8KOs6LKJFvEaBiaiKQ=;
	b=e8dsadtIJbOPkJvyumMMFaKn2D0vGkASVFIHhX2T/yixAwP+k6rB0ffZG0dqSY0k3Rg3Se
	KCdPX6zRhQzJam8vllCcJqdJ05K7VehXe6Kc6HcLAHnGzhnQO1FadzC0vGI6ZRH9EeVfpK
	BmytayRoiXL/rsSSR2GYSP7VHEnH100=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2112.outbound.protection.outlook.com [104.47.17.112]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-8-IH0Y23n1MdeoAO9AXQkskQ-1; Wed, 26 Jan 2022 03:56:24 +0100
X-MC-Unique: IH0Y23n1MdeoAO9AXQkskQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y577n9nC8UzpMiwgVJjkKMy9GdP/MLq1FskRvym+1MP9b5R+EHW+PSvC3fzMnqeqz2ujenQEC/f+LIi7NavsA1V120n3wIwU4JQcAHrYRIkzSlcJWZBt3kn5pp5riBXixsGSbemRqfqomaA7bzPEhT2BipOgh/31o/PHfsNTVAmccTh5VtqeXcB/a6CV58ph3jkbl5SDnAc8KdxWqoPGLnsO3hT74ctVLFRil2mppbo5qspIuLwx6BKwWn1PY7DTe05Es8ElgnT7/XwK74ZK2hKziQcohLXK7JNk8ereHdFGYjN0a/m0ey1aOnAhJJWbetelKQ8AzJ288UTImuYW9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KDtS1CArsZMPRIfXbNbfDHSREI4sJariI4I2gwK03A0=;
 b=WX//F9Me7VjeRbhzEBnkm3HYMDB+fwGCWTY03rXC3CCSYQpKK6E8ZAbc9AAboMo4TwNcJZG9ZEyQU5GzpqNkHqBgcBTwANvGy6mXGWz5wiTDLjN4AqkzwPIq4DDyHwysjTcS+MOhBpnNaspaHUm576m0q+lypJJb3gZCvxDr16xcFrmN9fPvElabl+eQJoPjYoxsUlo/U11qn7KI9MaAqWT13MZ8wWDZ5hjgpehMnxqKL9EEIUJPBozvqqXIBDKjGU33Z8TFXBPb1PCJWFJeySEL6v42ywpQPH74Nvf/qbspe86Sv9+dUGDEgLm2eHaCJaNrP2kKYxPVMfd+28fLnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB6PR0401MB2391.eurprd04.prod.outlook.com (2603:10a6:4:4c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 26 Jan
 2022 02:56:23 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c%7]) with mapi id 15.20.4930.015; Wed, 26 Jan 2022
 02:56:23 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 1/2] selftests: mptcp: add the id argument for set_flags
Date: Wed, 26 Jan 2022 10:56:22 +0800
Message-ID: <784120a28466006bd4f62f4b119f10cf7e4ccde7.1643165468.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1643165468.git.geliang.tang@suse.com>
References: <cover.1643165468.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0176.apcprd02.prod.outlook.com
 (2603:1096:201:21::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5c08a67-24a1-43cc-4085-08d9e0776fa6
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2391:EE_
X-Microsoft-Antispam-PRVS:
	<DB6PR0401MB23913B24426D7052278634D3F8209@DB6PR0401MB2391.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:243;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2FyyEr1/GUw/qiig+KjcVoEQ6mx05DX+FVCVKgKvNXTGM0G8tX5sEPxXL8SNdSLcYVfDjAsgEGVRA7vJIE4+TDl5VwzS5bTf5geJFPXgDbnrgf+JzqxMNzZVl2j50+fISBgfC6aKa18ISlvftJlOyAzLM/g+sStRVXZeKWO8tMX6BwZPAO7SfUZvX6GVOIwQm9Ps1Mf6NQYRdZYeQaIjhYP5XD1XpiutJNSOvEZRDe5uUjFaB+INatSwgwKw7VcfIwxteh7aFcXK5qD1ETBGuwJLfpqx5tupLgR/gOaBk/c8iLfv648EpvLJIqzVSIO/83Tqe/2+oC/nkBni3/V9yiHlyc6JeE/3uJ/h/XHUX5KI8H/hRa1pruupwJGfe4LArKVGQ64BU0DfS/1AV3Hj2Zm12Pfj1bYyan0Ey1omzyk2uGsqKWtC72CQWHLaT0nxQOhtKx/p9b1IVqR7/MBLcH/BzSAnpi4t1Xh8BJoo+N6jWxrqk80gmhBRRQiqa0ogc1axuhKjke+25xSOivO7SiuaHq62jQLF2MhL3Kbc34h1l/nXhfviCq6xBla7A7JCkIxZ0k3A8/gbMMExpHVH/un4iW6ESK5FoUHf8z63lBKGQsjjznufIPH6Mp43k5GeCTPj79fjOWXU7DNTDJ2AgQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(508600001)(2616005)(36756003)(316002)(186003)(6916009)(26005)(6486002)(66946007)(66476007)(66556008)(8676002)(5660300002)(4326008)(86362001)(55236004)(6506007)(6512007)(44832011)(8936002)(38100700002)(2906002)(107886003)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RxwH3B3hZjuVfyFv6e+AMX2xzDAKil1jsRVGNDvIswRtweBuMDklm3lHeKtF?=
 =?us-ascii?Q?ALBlZoBhGHqyR+Ppvdt95ziniOUzAYuBmZY2JGxQWGZ1l8QkqDDuKnxC/ZQz?=
 =?us-ascii?Q?ng4XbZUD1iu777AZs3cs7P3RHTQaYTjnMnbOQ0cZeFJgpWWhDMRFdK076drD?=
 =?us-ascii?Q?/ONiHMWYkH6GuBHuveLIqYG8vMWGHsePRgcfelVnWnTQZKrXDqVSooR/LpQT?=
 =?us-ascii?Q?GwQLAz4d3QkiRVvVtM587ESMN1L8NCaAb1SFPh1Nq5tRJ65a/9aWXiygdj46?=
 =?us-ascii?Q?8YEcgbTQJwxE0/sMcInPP7kcklAWwhmt3v/FgHm/oi7BGwO/b+1FvDrLHgU8?=
 =?us-ascii?Q?8LX80VD7okx8oqu5iLPfhm2KldUrZTGDXfREaTjywFju9p7rnAgzsWpANEG+?=
 =?us-ascii?Q?GVEG/j0Bp00vanDi9fMFEyI/ZxKhkhhGQ2Bi3801uR70sY26P9xtuk/r7u6+?=
 =?us-ascii?Q?de4I+PvMhh6M5ZPQ6gnc5EOmeeAqvvfOQJ+/d6M7T2Civ5QPoyPTc+Y0pkRM?=
 =?us-ascii?Q?EQowQFhzh2ELEmcw0V2coN1RrNbvDmtdoyBQ/u1Lkd7zIWrNyBIQh7mXF4CX?=
 =?us-ascii?Q?He6+gudCY+ebnxtxtdidhpmBHUrLxKuC7c5rwF1eRIAZ10ADTr4HP1E8TzFN?=
 =?us-ascii?Q?h6Mak9YVNEWo8xHlC/l53LOeDFixLSb8jrJNBst33wfLCgrGnux+rrdeFjnM?=
 =?us-ascii?Q?/Orbg3LoMjhl18AIzGFlNBCfO8/TnlzuQuYasnRjsH2kw7+oXONjb4mAPGcO?=
 =?us-ascii?Q?IR87yOPKlDdVlr7VMN1ZOOzyKkcoLulWHo43d2aUgjIl85cgF9rwEMHAmnF5?=
 =?us-ascii?Q?+6zH04YNZyPwVkl0gWVp4aKcwVR2krGBdcPzy8vjXyMQzNpyJUPkEPjC9AlB?=
 =?us-ascii?Q?plDFHHTrip5uy/y9wj7MC25QzZ5runms6LbUROoenXBroFKFSPxFr/S+wPm3?=
 =?us-ascii?Q?F8zeirDC7FW+RxjJNnQg4cNkosWcDJWhDwr4wlWWCR6L3QgIxvs+gMzkH9GV?=
 =?us-ascii?Q?1zF0eEug9TNvVrp4aSZD2c72I9SqYM3+eFRbdiceYLE4VqSq4qVadVBMpLzT?=
 =?us-ascii?Q?L8EEC8Te8UTJM1IYrKQdaxPtwIkOz/jRYykb2tgNIWD47egCHZ+e9XRDBOQc?=
 =?us-ascii?Q?Cw0Ki3NCwYKdshF6E4QKMqtaSM8XGe7VL60D8uZtQ7BdkCpaZnd/cB7v+YLz?=
 =?us-ascii?Q?D5XD16jXUoILL5gm7BOcydomNhmsQeE3uCt1k1weAiFqTdJ55phEJJMFCogg?=
 =?us-ascii?Q?3dj8IEbwKpyRNJr6KNMFWPtm7sk4Bx0JAa/sY7T3HTOqLRnbd8fiIzBnTkub?=
 =?us-ascii?Q?sL5y4eageqzLEgVlu4KuzHdkw4l2ihe8ZmxAGMrow3K62ipL7+5dEtb2CMW+?=
 =?us-ascii?Q?kd1zTXuiddpQGdD98i008c+hhMGIdMk7dNIMwh11/ZqvQzGUbmvNMzbIjhuZ?=
 =?us-ascii?Q?I8DgOGO4x1i7fNlDJPc3h4wAf74aDMyQi9YojVAyo1ZoFjN4rYO0zG+N8NF7?=
 =?us-ascii?Q?lV83FZRsonuKC33vq4mgGti+baceOb3QtnoFjSLxfDUXHg7r3rG94qtWGhsZ?=
 =?us-ascii?Q?7+SyTi+wSzZ/HPhMBNzE0he0iOwb3SKXDIvdMx2hpcBW2ZC66WblvJTytCiq?=
 =?us-ascii?Q?C5xTHUyxY9Ex8sbUHJcDhqU=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c08a67-24a1-43cc-4085-08d9e0776fa6
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 02:56:23.1344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jOeWzts53RNFlxj+M3zUhYeVa/VpW8cap5mLjS/9CTz40C7SgEZ6OPCAwUSerHT4yCzsPsd0ae4Ejr3benn+eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2391

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

