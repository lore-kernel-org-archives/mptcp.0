Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA597A
	for <mptcp@lists.linux.dev>; Thu,  9 Jun 2022 05:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654752241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YXHYQUL+33idFTYO5EonxwfW84PQC8dxn7xldzJca5I=;
	b=UIaU3ISA7R9NskQXNH82qv/zwpf3Qdep39AT6A7UYCNsDZCbQTK+MaYOUuhyN54CEJfXO9
	s8ao9Yk1nSoorp/p87wvoS6zk41L5KpHNDKMBy/eqKUEL6XCqaUTsQ4FUQAQwEsRNvEBBH
	fYLiY9ChR8TAzhhUQwZIyQmqW+8TVlE=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2106.outbound.protection.outlook.com [104.47.17.106]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-25-w_ndZu6bOUucs8vtUvgxPQ-1; Thu, 09 Jun 2022 07:24:00 +0200
X-MC-Unique: w_ndZu6bOUucs8vtUvgxPQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDZeaIZ5VV8XoIzWkv7QYlusfDD7cBM9o7j8GDEnBckXyVQkM24cVO1Fjees19UmfoTMuKd7yH+PIpFJAFOxq1sysrKFAcO9li6eScMG0/QUPWiTDtslK0DhBXcXQMUwUsMZ9O8PLA6s/kwHQhKBPIEazmUT4a2kxfbmXQHnt/u25FdyFvyWkv4vh7gt6zyRX7a7FuQx879V3+ZS/bccaaiQXS0IRaWW9yKFVW0ORzXL3H9XN9pXcAJ9hgNYTZG8oQn9KcqSYFqozmdpb6Ti7QvnsD+STShI/Cf2figoGDcr0P7BJ0JXwXF7XWnOIImcyVHhkbr6tlMUacbOwx42oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0aQuGpgX5n7xTd5GqzlSmU1K81Dhjj5tZkXSU9bBNyw=;
 b=Oa9xGh7cvE+hzkWtQXaGZZkbm7gSTepUxp1KcvY1egGOuD7IMR/wY44nHSSlRzAfZJy0RG2CHBtcGERVzgg+Ue9G5oaz/Lq78i5/rrLuKU2jPJo8FsC7PJIZlvhk+9WUUc7txcK+TNpjZdvgmvF/DajfMFKPmyC/YZTXLN/4EYluhv/5ZPurySay1jiUxvOUDFN+wuMQldQBgdSI6SRKyaaMVGBcCqlEYMQKtI+WPVz1X7Y2hN0FTb2Iy72s8Ct0bAaM91JQnI2OI0g6akzDv7L4zAY9vF5m5sgyDuxct0GNhsQyrpOag4EVdSR7IH7MRyjbvrFHfYDkmRVvVu78YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mysuse.onmicrosoft.com; s=selector1-mysuse-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0aQuGpgX5n7xTd5GqzlSmU1K81Dhjj5tZkXSU9bBNyw=;
 b=CvWrq5BBDwWZDERMgv3ZuBonkrumPD/XMWNKQFh+7cJ1+sJOk+rk9qzi9dUPo/aHu6L522B12Oe0lL7kkGrr05Tbeb7HcbfpeYAumc5Kxo+pjbyv4nW9HxtFi2PjbXYX4ARDO3v+pjHBd0e/k5Ou9jyw1CwUXhEkiOf2FVAIZmA1CGmcEIwSPKubjBZ+L1GNb5UhFOqoKc7u0T9l6Y6Paada5uNiVxr0DhVeWNTNCC42kgQ7JzkryPcrsPvgKFakVrzENsj3bTZIziPtbg2tTfVOQSU4F6Yw+JNsbgiQTR+0BlJ6bWdTSR2XmogkGgUfr3Lf2G+AMOlzFzPbJl8kWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB6789.eurprd04.prod.outlook.com (2603:10a6:20b:107::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Thu, 9 Jun
 2022 05:23:59 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5332.013; Thu, 9 Jun 2022
 05:23:59 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests/bpf: Add bpf_first test"
Date: Thu,  9 Jun 2022 13:23:47 +0800
Message-ID: <f5ce13a35164d0c81c47b807d146632795f6255c.1654752190.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0180.apcprd04.prod.outlook.com
 (2603:1096:4:14::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 841dd338-331b-4b68-1af9-08da49d841b2
X-MS-TrafficTypeDiagnostic: AM7PR04MB6789:EE_
X-Microsoft-Antispam-PRVS:
	<AM7PR04MB6789B151EF377B8B5C2AECE7F8A79@AM7PR04MB6789.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mDgWC+VueIdhgM/dbG2JEu2ReSNREiu9LldYqGaoJndb5q1NDclQQqzHIqnAWCod9AtG3zwmkSiImdgaJnzOMdiVUF4jNH500WqMgqe1BahtAymQQexAdaAaaU6g484a9U5TQNp9h3iIEhw9WrwU5E93DXRvLpTRVLoJpmXmHvtXbPkTBCmLofSrJisiD/5njrOx5sx2eoD5isIBa1ytPL4MjDByMMSmzpk+QpvABj6USZY4/Gs6zmOCI8+jC8BAYImTVU/Teh7vOPM7fc2+Q1IbaYcTQJdyZl3A0qz9xndXNiBnJn2uBKLjcLcYVaNZWtNcNoejts2miKkWW+jMfBcHpNpv96fu/Z+7f1jvVHdIjND1y7TaXKlthioSmdC+H+laeP/zcOMvVpyMCIQKl4UVJhw1JRQ3YM39lLxQC1m4RCMmmqgtc6QJHRfB5PKfMs7UH8FZeBGVyH4GiixHfeSRfCDn5bvB0qk2wKr90uMsMWjzqZrjBjpAp4+JXQilBOB543Llh6q9J1Vqg30MokrcBYKqLJcsnXwUGXSpw93/Do55NSMp+0bJULGK7eUl+4wkHK+zrZ0NNZGUSyzA4QDN9zOzY9teqMvL4P0dbbfNMCXzSu91f5QHte1B7BXhbrHuKET9yVm7ma6rNyDBuKKPTaoJqu0ufTGmyMmyMAKO8GUKG8tM4MDrbsJE2f4m
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(6486002)(44832011)(107886003)(6506007)(8676002)(4326008)(66556008)(66946007)(66476007)(6512007)(2616005)(26005)(6916009)(2906002)(36756003)(6666004)(83380400001)(8936002)(86362001)(5660300002)(38100700002)(508600001)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hne6NkI1C584shfQHzwCndsa8BVOZBVSqka2wQFub8TmDjECa/KEIv3jA1Q9?=
 =?us-ascii?Q?Myf5KSURq9FPPWsCKzeplvP9sA9i+GsuL01yDIkJSTofrLZQr4SpEsIcYbRt?=
 =?us-ascii?Q?LTyP18xZBtgJv6gPFNkLLp3RqSxSIgiAq/J2PLey5We4dpRKqQyAz+spxKBZ?=
 =?us-ascii?Q?bJEpVahjUhmSeOKIjVPtHhgPvhwUU03OPRrvu2beg2gh6hCXnQjXd/nM1iSh?=
 =?us-ascii?Q?Vr7Jz8FHPFsSX1KXacgStoFwI8oqNxgNjJ9ccxJgrg0WqqB/WaIT5Nxqg5bf?=
 =?us-ascii?Q?R9PZOU/p4H/WZeLpGwuTHILxBhYf9MZgLUPyzSuMI3W+s0cyGlxutecEzTss?=
 =?us-ascii?Q?vD/IftYNvGceKWLBVkcoR4FaKOayJTSgGOicwECuMcRUT84P+TXhK4ojKSFP?=
 =?us-ascii?Q?Rvf2+uKi9zjt1fzDh4266RbpbfgRai29EJv7DOQdk5RUHYa6U9CjIzImY3H+?=
 =?us-ascii?Q?8Tii7Bku7+CrfcDHH/5ampjT9lp/24HgL1kFzcQJy2YwkBuGIa91hC62FYPf?=
 =?us-ascii?Q?jR0hcwzUB3cWhBFdQ4DRlfngeFK1IeJpV937MvNlI+1xO7BcWLpK+48P9cD8?=
 =?us-ascii?Q?w7o0vuFcRnYMzXcLNx+Q2MrGeEjy9NiPFsiaajmeERCAnGTmA8dAP2NAlS3a?=
 =?us-ascii?Q?j+DlIWs/kkZbcFx1cy6Y1wACaUyw0RK/OyLdHG0r8rWHUnmBgPkyhywdiarq?=
 =?us-ascii?Q?hgN0ww4qZO2X7dFecoucFbxwlGBp1eAubu00lgx7uL8vBKSEUfpsAIr/2tP9?=
 =?us-ascii?Q?CgzhhV/qUqPnJC1vyBN9cRa7yKVTBr6qGc168Gwbtjih+Fjv1urTaz5dj+uB?=
 =?us-ascii?Q?bCyXr5y9a3Fz6dbsiGr2KLo+GQ8r1t2kmmM7+frikUNI51r5iRHBCJxH3Wvq?=
 =?us-ascii?Q?I/ow2XrbvJIwvfkz5dQMgCprDIYqcgShPIEYBrPAdPf8HUR71OuK4oFJo6Yp?=
 =?us-ascii?Q?0cd6nIGvMXzW8R4/6h/N6nIMSxtHUicFcya93MjBMpy2Za76d2U5mTlIJhzx?=
 =?us-ascii?Q?yNfig3xomdhqpgM5sw3sFEbK5m3jKtak+wEJQclZW61IWRgwRji6aq+gcKZa?=
 =?us-ascii?Q?1jETiAcNjSgGFdczpqkNeEpbucIfp1hoLeRZt4yqwdckeIutORWc5S1z/yhl?=
 =?us-ascii?Q?d23ilUUD3kjjM42xiY9V5KNIPxrCl5X2mdYQ63voW35JNdwyPSmkIazoEyDG?=
 =?us-ascii?Q?+vI/mvLnebymAzLK9l4NW/MWXns7Te5qRoWlYPDCmAGGqr0xUUhh1DyZfnV8?=
 =?us-ascii?Q?fIz6MTfqmp9+fFiRj2qulWcLMdR6nzWpKU1QdCG8ETBkLL/BXLB1r6feQz0c?=
 =?us-ascii?Q?uX1kpg7szyiAt8ztUqUjfp0rQAlyalezzMPEI+ul+1iZQR8RFS3a+E2FAfrX?=
 =?us-ascii?Q?rL6JS+/taPNxWKsOvKFZ2mqiv8PI33ipKo+JP8XGRcCEokeMNi2KP8zi2mHu?=
 =?us-ascii?Q?YSnlx6pf5BkGvgq3Rxsbp/n6dvxuoXIRDwgKZaymIlTYUW3XrGVlTT46lqN0?=
 =?us-ascii?Q?IRlBUrsHBXnEAkvEzWs23rgwtzetq7butkNBnGTu1w2ZblWH+KQWDxD7TxNJ?=
 =?us-ascii?Q?d8ViVmi0YZ7p56H07lksfz3TAip4D1IolEriNew0yjy/CcMYVILSYsULDtcj?=
 =?us-ascii?Q?aehYIKa3P/iPBbiXdHkSwqSdscq+Q6JwBMV4y34IQF7EE8Z/BbZ+7oSkZtUY?=
 =?us-ascii?Q?tfuWnPr556yARVvia8hWdnGF+ZafjDS/vsIf6CNXoJDgTy1jE82ksWpQpAZ+?=
 =?us-ascii?Q?g3o1dW8rx/BbBVyiqwxTai7V7exK9Hs=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 841dd338-331b-4b68-1af9-08da49d841b2
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 05:23:59.1551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ErulKbIMOQiP5UzcUYgH4M1JmFq43TaOSm/KdXMkm7zjaV3r3Vqi0Pn4NdNNkuSXlMg8QAtewqQhlLTePYpxOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6789

A small cleanup, separate the code of base subtest and sched subtest, do
not mix them together.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 9f3242c7920a..8426a5aba721 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -15,9 +15,6 @@
 #define TCP_CA_NAME_MAX	16
 #endif
=20
-#define ADDR_1	"10.0.1.1"
-#define ADDR_2	"10.0.1.2"
-
 struct mptcp_storage {
 	__u32 invoked;
 	__u32 is_mptcp;
@@ -27,9 +24,6 @@ struct mptcp_storage {
 	char ca_name[TCP_CA_NAME_MAX];
 };
=20
-static const unsigned int total_bytes =3D 10 * 1024 * 1024;
-static int stop, duration;
-
 static int verify_tsk(int map_fd, int client_fd)
 {
 	int err, cfd =3D client_fd;
@@ -177,6 +171,9 @@ static void test_base(void)
 	close(cgroup_fd);
 }
=20
+static const unsigned int total_bytes =3D 10 * 1024 * 1024;
+static int stop, duration;
+
 static void *server(void *arg)
 {
 	int lfd =3D (int)(long)arg, err =3D 0, fd;
@@ -256,6 +253,9 @@ static void send_data(int lfd, int fd)
 	      PTR_ERR(thread_ret));
 }
=20
+#define ADDR_1	"10.0.1.1"
+#define ADDR_2	"10.0.1.2"
+
 static void sched_init(char *flags, char *sched)
 {
 	char cmd[64];
--=20
2.35.3

