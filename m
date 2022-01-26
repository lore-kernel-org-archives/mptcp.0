Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B83E2CA8
	for <mptcp@lists.linux.dev>; Wed, 26 Jan 2022 02:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1643164533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V6PAebVxWBUFu0iAB/WuF6CNG8KOs6LKJFvEaBiaiKQ=;
	b=LUvWblketqqVtxWmp1o0SqRpxy+i319LqBJeh2ffReOKcPgoMuR1oj1Yaekww+WP41K0AC
	YUvZMz76dossMd/Tzb+fZDlG7p8z+ZnhQExywOifezCHKFs7lLOmPnzCrymqHEpDKHP4pe
	EXQkG0aui8E59TicnmVChCCbN121lnA=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2109.outbound.protection.outlook.com [104.47.17.109]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-20-ltNuCvjLMKeujMyv7vMBXQ-1; Wed, 26 Jan 2022 03:35:32 +0100
X-MC-Unique: ltNuCvjLMKeujMyv7vMBXQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S76hfIxk3m5K708tSqsppNo2n+vdeJMTB2s/jrnEzXF8WEZ/VkXCMrrVvkHa0oVeQ40aXXwEgqOV2fnvFQf53WBouhSlhwd99jA5wLVHxwGCyexDKD9ZU2cP7xemSFrS4KV76FiMN1Ad9jn2MakkamqwKZxtgWfQL/azVsGfGOebXk8KumyaBqPr6XZ2x48rm8JflJpN2d258FByIeXBHFuQgoad1iKkuHtHNr977S5/wO9EYjbRTS8PVbNhu/PyRC6EcI22DT2LalS3tKgvj2N2zpnEi/SrNpMo/jMnV+ZXbVLrSbR2FX84BxBpbG/ir4Ypx3IEtkNJEK5B+21iNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KDtS1CArsZMPRIfXbNbfDHSREI4sJariI4I2gwK03A0=;
 b=hzJX5urQHP5hzbX70XQB/ax+IV0nNbz3H4XlSXuEfNa4YpJa6z1C6PzCgbkvFk3UKOXSszrEcysUJUvLhBX0sKcva3+RcB6KS2UIQLDvZabxip+XsbISBoKUg/S3yOHY8jr9ubdEXbRszFuQCiGmBBlhcuceCHuIgjI2I3ez+6SyCkwq2gefDwvJw9DUbRTsvWVLBfskuBVuf0CP8TZcdKSp5e8RIHqXJVEXfnvrnKswjCVAVi6IcIQxmUaB9uu/RYQoUNsHDKW5XMagjHDbgeVImjns8WZ+qyVQ84TNRZQQncHH/mMIC8BzhXSu8qr7fqI5rB61eHAYsxpixLNt5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB4942.eurprd04.prod.outlook.com (2603:10a6:803:59::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 26 Jan
 2022 02:35:31 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c%7]) with mapi id 15.20.4930.015; Wed, 26 Jan 2022
 02:35:30 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 1/2] selftests: mptcp: add the id argument for set_flags
Date: Wed, 26 Jan 2022 10:35:27 +0800
Message-ID: <784120a28466006bd4f62f4b119f10cf7e4ccde7.1643163993.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1643163993.git.geliang.tang@suse.com>
References: <cover.1643163993.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0068.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::32) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a946dec1-f2e5-4fd2-355c-08d9e0748537
X-MS-TrafficTypeDiagnostic: VI1PR04MB4942:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB4942A035268971676278DE2FF8209@VI1PR04MB4942.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:243;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ThynDOX2WhLKb/mGYKZzUKepto0vEWP65ZzLCeXYKScfwnNJyxuXGNPmfqah+LwTMGoKEt6IoL1Co/BoDHBy091eXYyQ1PG2JKZwMocGH664vUZC9roSlPFwaHSuvNwKEitE7gP5mdYujlXJ9fLuIBdz0GCNdA5pRUZQHvzE2wVlsJBFpYzKUkNk+4E102UzjXXFEWLv0kuu26SYsfUVs1YdFvbMlkUDgcgD4p2iCBVb5piZLEyy7JBDzlpODTTy/FM31EWOOQ4rLhOJLyZhsA9ogA2V6FvCojG+Lklk3STbSyanxtH3KQYgSTavGmOU9Cn5Xxd8kEaqyq+K4zyy6BoMU777rHdnZKVm6DS6QR5Oh1WUsdrAL7qkz8fE4NpJVC0mZQ7btpJmn/EmfN6nZ44XmiljtZg3uq2R0tLxmweZ/C7EOBKmM2kC+eGN1eDavJ6eF0A5a97IuCoDwWj7qfbng0ObJ39lhXkohNT2bWtxjgPAVHVAePxLQrGIdJ3BivIVtRtCfqDJvY+R9wmYoVxG/s4lVu3a+NPgp3oiZHcri3xeaLTn/E0i/I0b7OcmrDUzfBTAd2YcgCrdcDwY+61faJx/iKDXqEDi8E3QKEOv783j27QwMk6jhtPG/C5DUmvijFiStzzSnsBE0xRX+Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(66946007)(66556008)(66476007)(83380400001)(8936002)(8676002)(6506007)(55236004)(2616005)(2906002)(36756003)(38100700002)(86362001)(5660300002)(508600001)(316002)(6512007)(107886003)(26005)(6486002)(186003)(44832011)(6666004)(6916009)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LPm2jZmyN3Ek9hiiCaQrwRZ9h24XHayZvexzLPMqHn5AxzWmOfG+nYgfvRsM?=
 =?us-ascii?Q?US0B6LPl5OFZpSiwaTP4CaYoqliwslYgQaEXgY6brDc2ZGBc7HOMpLvIu39+?=
 =?us-ascii?Q?FPD4/LHn+2NUIcKwmM3EBvgKmN8rPxy+7BUr7QqehJYzIj+58aseBi7HLtPs?=
 =?us-ascii?Q?U5Yvb+lb7gezf9bFAGZrIgMViQ8zZPzSISN74Sc5VgI98V63lrhx2b4rgBoH?=
 =?us-ascii?Q?utvDr7Re86AvY2lU3mK2dcpv30ntVwMv1E7QGgkHRwLbs/sk4gOC0PQMNihl?=
 =?us-ascii?Q?aYhwY1R/DXum+HEBiYqyNvwY3HeEkPsdziqZv7V6dlVr3EKXoYVWHWnT5pu9?=
 =?us-ascii?Q?+4gkHAyMcFPuZXiwhuOwH9e7B+sQRQhcTHsR/ZtpyOtx3l8gdr9x0Thy38e5?=
 =?us-ascii?Q?eLnTxtqClbdH4EcNFDv2Msh6E7nP2923xYXaMy0lIuO5mWjFVCJ76OUlV36X?=
 =?us-ascii?Q?ipETYhZUgFRGomLtqvHyp4jKAeaOcxOzfTT4ExadB6E4vPXndKCwZRpVn7vz?=
 =?us-ascii?Q?jlOZ9wu9iKZpjKD/AN6oSpSvu2Jy6laHCudJkT8UZsG/7TwBPDePRanKkTqK?=
 =?us-ascii?Q?DtZ4dZciF30mZlz5il26P8OdpKCzLlHyzK5h9p8Zk8uB8DpHqvCk06VKHr/p?=
 =?us-ascii?Q?0Fp1+YRs5yBmPt8rieus/4gj0PTXsH3HnmvItFmngrfsip883bH6agMZSBzt?=
 =?us-ascii?Q?4ZPDSNPIRWBqBPRgYgDyPawTB1C5CgieHii2weQw//7ciTCSLFXhABEjhZhk?=
 =?us-ascii?Q?S0KOwLSgZnt/XqTOjQDs5rJ8SaiSYGQEyuCn1cLi5ejnARXL5POUdgYQC+8P?=
 =?us-ascii?Q?WwAy26Ajr7QGnsgyLLHJHzfqQzkDqiEVnCZH7DwUrvhSfcHgdBlI0b4gzzqS?=
 =?us-ascii?Q?mI/NFiECmOPUcuVMpDV/s5qgWMuM2dlLn+zetDhCoUc+V1VI7l1M7GKgC6EJ?=
 =?us-ascii?Q?Rhaz6ARJUk6nC4IhvJ+7/SlleGjFGUfylBuLANXBv9ZwB6SkSFyjTPOG9hL4?=
 =?us-ascii?Q?+ZH94xiyyDTW5B1DnhX9IhnVsGbeuhuEBNZZUn5oafcms5gj7p1NpGc5U6dF?=
 =?us-ascii?Q?I+byQS9BjmUTR6tTsAucGZeA5KLmDKuiskr1AmGi6wEKq66lddNgt2V/8Vef?=
 =?us-ascii?Q?XzHlTACa81IQ/rtMTh9yhbM7PWmYejoz2uZgjqTgIicSXS36V4IiAwGF8ffH?=
 =?us-ascii?Q?ZU9V52LI66W3y5c94QmJvv51haF6zxbP+3KAYOyhkCWK5zmHbpu972rk4wWC?=
 =?us-ascii?Q?KqNfZMVJEnXIcrPHTOkF6ON5QnzEFTJBfrKK7TccHT8HbRdrR+LDJcD708Lt?=
 =?us-ascii?Q?me0BfbSN7xn8Hj7RG0RahmNEjLqEOyudS8eQuVpc8t7ujK4fSLwFKXbfjKgn?=
 =?us-ascii?Q?1iWM+lKT/FL5MVb5e9/o0dHwC/OLNSnQne7WWITKGMftuFgkPCfjvZIoerE3?=
 =?us-ascii?Q?gDviMsZNrIYnQP8Pfq5yMY7h+i2vOXRV7RnEgkNvarXtK5l5YxcTEN++/0jB?=
 =?us-ascii?Q?L3XML5cjdJ3+5u8F5m6S5NMWYkXFSc4UoSEI1ievV0et8EHKhlzPdjlNdGQg?=
 =?us-ascii?Q?z7SNgy2ZD1h/iZVOlDAy2l2PyvEF0E+dkoj1PsK47mfQWy40JJdpyp8qbFN/?=
 =?us-ascii?Q?heLwG23vLtIJ2YjOwuVmor4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a946dec1-f2e5-4fd2-355c-08d9e0748537
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 02:35:30.8420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AiUm6sXWQ0Ro2HsA/P14scCYy/6nH65uz2NxcU4DUqHb00OYDsB4dXu0QmVUVucgVACPeOh7YKB4skk0c7t+kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4942

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

