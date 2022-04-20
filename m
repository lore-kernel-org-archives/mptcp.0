Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3607A
	for <mptcp@lists.linux.dev>; Wed, 20 Apr 2022 04:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1650430692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GNG8iEtpzdkuvq6LDqfwpmKo3DfQ3gomG42xVqw+Nco=;
	b=bz0BngBxN0IASFR/5wNnS5HPRgOJ5mr4Pc/a1ABH0zmSXQVGLHCIm5rK3vUtzJC8QOisnJ
	4aaV8g0qgoo6K+QbSLcwBaSbnmgx+HfSaKmGCidjKDf3J9EjWioqjZuIttHCiPnaV8b5YV
	dvz5xev85l4c4TyR3+y/D+ih7rrfrzM=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2050.outbound.protection.outlook.com [104.47.2.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-8-qC9yNgesMxugBZUpF_OsrA-1; Wed, 20 Apr 2022 06:58:11 +0200
X-MC-Unique: qC9yNgesMxugBZUpF_OsrA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HcyXGBRNbPATgRBWhNE6IRSfscJ/PYgzTRfn3DwGiupniizzlupqYqNjDBy7YFukKmrt2yC0AqBI8vT0ph5KVce2VN0fHoUxeHS6/S8ckBAN+fYqvQ/hxlvTbq0xarNMpZ9i2jcb37M+G5Ut8nwqSZVM50djmF/yA4bFAItrk3/+KFPuwmVs0/cTh1e3E2P10D2+ZKAI+W72W0Rn/rjNqQeE1kWHnxBPizFDJ7dKLuYghlXuwlvHiCe0e7dJ7KYBo95RG2VeMLi13ofTsHreClIz/XSReOH0A/65a+jC5Cr9LsQDOxJ5X6S3uIt39PZBTFK2i1d9D2pV0PLHR13tew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZK0VfxUK4qsR2ROUjpij6j46M5w2ZGToJAXYcwSeKA=;
 b=WXNPnyWEhq6T+E8Hv6B73GMPjXofk4bg7XFKM8vb8LM+06cq9QIoqnsKpIZ70RnimCG7dpW8CqJFHrpSREFY9zWgpqiTRuwMeMtiFJm8PZ6K10ZxukE2eggGV7QFkn7tbRGWs3UFOWlXIYTLnko+wr8B5QUGnJqF53HiajBUyBAYi5xysy2r18oPMOnZVqoCJFrRKPXnD5G/MC2r+u6jXMdi/uf0/PecybPEGARjgrdrZZ3KUc39wsKg4pEg0yWTGXvv2wtlZMNYOlZgode5kXY4ZegWoUW530id3S+If9sNzEXXC4igFqF0ukiJm77dhv0IqpXX/iwk6Lt9z1PtWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB6504.eurprd04.prod.outlook.com (2603:10a6:20b:f9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 04:58:10 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.013; Wed, 20 Apr 2022
 04:58:10 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 10/10] selftests: bpf: add bpf_first test
Date: Wed, 20 Apr 2022 12:57:09 +0800
Message-ID: <7072b5ca4b8e6d710506a789c4e962c9e33cc54d.1650430389.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650430388.git.geliang.tang@suse.com>
References: <cover.1650430388.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0049.apcprd03.prod.outlook.com
 (2603:1096:202:17::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de13e5a4-f64a-4d12-fb85-08da228a5db9
X-MS-TrafficTypeDiagnostic: AM6PR04MB6504:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB6504A303ED21BA3E6CE01220F8F59@AM6PR04MB6504.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1XfwratK9Up6FtM8ej4jFfcWk9rwWHKQP63ypZiadye2aK8v2vD3B3djriGb4ud0PgVDo/g61G0UmO3zDWkBow1k5opo0UhCfx/j6znhmFPMY8YNiq/yQBt9AIZn4FlRW6aSz4f7rzSr32lVpDuRJfgqKw9qhXSmMIpjOo/ejG3hX94De6707hMZH8m7XgMOJQmOpkevQ6jAhVNJE3miT89Yr8c8xYkE6W7Y9ORmQQBNQKI8D16M3DWqLd4iBOVnTGyK8iUK1vD/PdvZ8xKy5rDivViKq9UeCsDzBkr6zGCzv8n83c68LI2wibSPFTktzgjVGWwu7W47CMVxMhNAftqCeS81KOIdM4IXY50z7xvTXNHyNuiPtAqcHbxpsUaMJMrCzauYJZKsvX0q+lorPdPpdN6gAp3KoSo6FMBmkPIruZqj4xrn46CSbLoOjE0QAb/mjHqk7EU3zOWZj4hhPg8u6gUk28Di2J8/7GyNqiOiFe2KqcEbCJ9+Q/EHEQS/H7TQ8kXPSBWik6v8I83i5kVvIfoLQBz25Sq27pLRSoouIF0+sHdScCEukjs+O9KDOsPcoR7ohh26Dl2XUnSntXeV1G/Gotq4D/3qdmwYCkTAZyVYSKObPeaHk0NKiCIVfC1koYPkViK9vRPI1LhMx9VHyfzvYSWy0PGxjOyV52uvqf6s/RiPD0Vdlx5ZQd60
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(44832011)(2616005)(6512007)(26005)(186003)(38100700002)(83380400001)(6916009)(107886003)(508600001)(66556008)(66946007)(66476007)(316002)(2906002)(8936002)(86362001)(8676002)(4326008)(5660300002)(6486002)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Hk/9NHHbwLj28FjxujZ55LGPSAu/D6GDACIX8AHukuYb8eDsvRB/T78zrrzH?=
 =?us-ascii?Q?D6vxV9v1KEg5qW5hImIJQgSxf8sadxrc7ZVIDsqjvx8k00VgvtLgAtPijZE0?=
 =?us-ascii?Q?lo3E6h0+CEsWtH6X1cKrpSjMCWi4J15u/fARAYIDWZtEX9Lc+piaCs6oCeyh?=
 =?us-ascii?Q?2r1mQlV9VtVBD8Q1N/t0zD1fNkotbbNu2T4MildrUi0Mna5yxenkRAckZW0F?=
 =?us-ascii?Q?O+Op5krDdOsZDJcz1yXjlLVdvHL4faZzhm0TXvOv4tfRwqePqnCUnsJT2jrL?=
 =?us-ascii?Q?56g3jlI7WxIYvTSGSfbHa0y/guP2kQ0xNb1p6Ute2IXGM5LTQijc8Xwwqn5E?=
 =?us-ascii?Q?a/S1gM6asYJPJc0QFJ5nTKTEawfut9xqIL9tXwZxV98H4XncGpBsFHGQXOJL?=
 =?us-ascii?Q?9/2hK3y0s2Eogm5w1hMV6sX0cr7VArblfPPZJk/bo18ySGmTsRTzIUn1aQ3S?=
 =?us-ascii?Q?1Rk9Mz2cj0qTm6evGsNDWEyugaFMvRr2J4sexfdHJqa0XJUyZC2tTHY/WK+z?=
 =?us-ascii?Q?MauQgMTLEwgCXqOUWxcxz+C4KapPRXJTYX+QjmglK/SinhhJ6Wq/rsLXgULP?=
 =?us-ascii?Q?pS72sQdJDi6Sc5w3/N7IUn+N+93fU3l/xSKgjgktFe4h1yhrpMAQ5nD/W6UX?=
 =?us-ascii?Q?Pf6TctH/UYuOIPQbukvA7seCAkCrDO494pl+HJCTMBf0OXqrgpvLS0lZrWR2?=
 =?us-ascii?Q?OLo+zuXfgsm5rNviV7HBzE0/suVkdw7u7Bw5uW39qOKe0LcAgFs7CpTbPSW8?=
 =?us-ascii?Q?LGlzyZtr8yxxECYc6s40jtAZgCJv3+DIOTc4fgMqIxZ5m6y73PYfTrbWwvIk?=
 =?us-ascii?Q?zUldQhdZ9Aqwt7Y6LVoN92C3CmtZW6rw5o2cqs1pB6krQptqTeh9hL9VPdeh?=
 =?us-ascii?Q?e75SgdhDOfKTIdjHX4AszRAtV+LgobYtSd5Ise7QxeJoe+xPx/l/S2h73I50?=
 =?us-ascii?Q?WV1gzhjArKSq59zYUPf2bctknR2SlDE9J8MjXG6yV0r5gYUYGAdxeq6o9vFC?=
 =?us-ascii?Q?zH4zFvJCQyEglX2qyH6ZyLAWJsssIsWuXQbGo5XL0JXpBD9v0lBLiNzyMk0Y?=
 =?us-ascii?Q?ngoi3sB3mBC/y7d/iXZy4St56eDrMboSObz7opS3SJhvMNDs5Q1sg4tcNPt0?=
 =?us-ascii?Q?guzqIuhC2rMDuiypcgsvjksBPjOuy/N92QeNdJTEBCRIQ6YiZZFemlrLcidd?=
 =?us-ascii?Q?qCMl6dbXcR7/R2OZN3MZZTxPTDCOKH08QdcT/Hbxs1EXGzTbFScdyF2/CMy4?=
 =?us-ascii?Q?OFrSzkMim8JMdd76JnXgRCuZJmC1/aMaK8qTCUyYyktkLv1U++ZHbJB6X12d?=
 =?us-ascii?Q?/7D4dIG13oh/1TIu86gZheKfaKcnmJWOFy/fjYcO1aNC3JQHN9tMRVfcG/21?=
 =?us-ascii?Q?QEpVI4jV49K1Nc+00R9MsqOISWS7htWIpmBCQqaDbt0bT5CeExxwLkPQFuoW?=
 =?us-ascii?Q?dyFMJSYC2VcLsimf5l/kR066wQoC0y+hZco+i5YfJnFWtErb04LsuuLHzsQC?=
 =?us-ascii?Q?MwOvn7/r6TVmAIM7cQzToHBewITGpg1Rs7oXPtZlRBxGilIytiDac8NejZ9I?=
 =?us-ascii?Q?CaEwY+Rfd6W70cKELrYy1qULRjMc1T8+SY3JY7SrCHksijhfJiJ0tnVj2Sc9?=
 =?us-ascii?Q?4ZqQWsqKw5vA8M3TYw3OPpSBfaBs1575+b0llmEifMYE0uxtdThB+NYr5dcD?=
 =?us-ascii?Q?EsTV9AsSyUAiGNEhYDo8Hrd8+t8fTOfNTVQMSbXj8Ay/w7zE+5AASESE4PlQ?=
 =?us-ascii?Q?A52zkI7DSGT7CSwMJNePS2p0fbrSQ3I=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de13e5a4-f64a-4d12-fb85-08da228a5db9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 04:58:10.2459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ppb5iCXptvTvZBFlU3YNIcavs3W50KLWKQ8soi/LBXQjzef+Jz/0uGSfLiWVzGplS8BqB6M5+rQ7Q1nOTe3u1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6504

This patch expends the MPTCP test base to support MPTCP packet
scheduler tests. Add the bpf_first scheduler test in it. Use sysctl
to set net.mptcp.scheduler to use this sched.

Some code in send_data() is from prog_tests/bpf_tcp_ca.c.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 113 ++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 7e704f5aab05..377ebc0fbcbe 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -1,9 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020, Tessares SA. */
=20
+#include <sys/param.h>
 #include <test_progs.h>
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
+#include "mptcp_bpf_first.skel.h"
=20
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
@@ -19,6 +21,8 @@ struct mptcp_storage {
 };
=20
 static char monitor_log_path[64];
+static const unsigned int total_bytes =3D 10 * 1024 * 1024;
+static int stop, duration;
=20
 static int verify_tsk(int map_fd, int client_fd)
 {
@@ -251,8 +255,117 @@ void test_base(void)
 	close(cgroup_fd);
 }
=20
+static void *server(void *arg)
+{
+	int lfd =3D (int)(long)arg, err =3D 0, fd;
+	ssize_t nr_sent =3D 0, bytes =3D 0;
+	char batch[1500];
+
+	fd =3D accept(lfd, NULL, NULL);
+	while (fd =3D=3D -1) {
+		if (errno =3D=3D EINTR)
+			continue;
+		err =3D -errno;
+		goto done;
+	}
+
+	if (settimeo(fd, 0)) {
+		err =3D -errno;
+		goto done;
+	}
+
+	while (bytes < total_bytes && !READ_ONCE(stop)) {
+		nr_sent =3D send(fd, &batch,
+			       MIN(total_bytes - bytes, sizeof(batch)), 0);
+		if (nr_sent =3D=3D -1 && errno =3D=3D EINTR)
+			continue;
+		if (nr_sent =3D=3D -1) {
+			err =3D -errno;
+			break;
+		}
+		bytes +=3D nr_sent;
+	}
+
+	CHECK(bytes !=3D total_bytes, "send", "%zd !=3D %u nr_sent:%zd errno:%d\n=
",
+	      bytes, total_bytes, nr_sent, errno);
+
+done:
+	if (fd >=3D 0)
+		close(fd);
+	if (err) {
+		WRITE_ONCE(stop, 1);
+		return ERR_PTR(err);
+	}
+	return NULL;
+}
+
+static void send_data(int lfd, int fd)
+{
+	ssize_t nr_recv =3D 0, bytes =3D 0;
+	pthread_t srv_thread;
+	void *thread_ret;
+	char batch[1500];
+	int err;
+
+	WRITE_ONCE(stop, 0);
+
+	err =3D pthread_create(&srv_thread, NULL, server, (void *)(long)lfd);
+	if (CHECK(err !=3D 0, "pthread_create", "err:%d errno:%d\n", err, errno))
+		return;
+
+	/* recv total_bytes */
+	while (bytes < total_bytes && !READ_ONCE(stop)) {
+		nr_recv =3D recv(fd, &batch,
+			       MIN(total_bytes - bytes, sizeof(batch)), 0);
+		if (nr_recv =3D=3D -1 && errno =3D=3D EINTR)
+			continue;
+		if (nr_recv =3D=3D -1)
+			break;
+		bytes +=3D nr_recv;
+	}
+
+	CHECK(bytes !=3D total_bytes, "recv", "%zd !=3D %u nr_recv:%zd errno:%d\n=
",
+	      bytes, total_bytes, nr_recv, errno);
+
+	WRITE_ONCE(stop, 1);
+
+	pthread_join(srv_thread, &thread_ret);
+	CHECK(IS_ERR(thread_ret), "pthread_join", "thread_ret:%ld",
+	      PTR_ERR(thread_ret));
+}
+
+static void test_first(void)
+{
+	struct mptcp_bpf_first *first_skel;
+	int server_fd, client_fd;
+	struct bpf_link *link;
+
+	first_skel =3D mptcp_bpf_first__open_and_load();
+	if (CHECK(!first_skel, "bpf_first__open_and_load", "failed\n"))
+		return;
+
+	link =3D bpf_map__attach_struct_ops(first_skel->maps.first);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
+		mptcp_bpf_first__destroy(first_skel);
+		return;
+	}
+
+	system("sysctl -q net.mptcp.scheduler=3Dbpf_first");
+	server_fd =3D start_mptcp_server(AF_INET, NULL, 0, 0);
+	client_fd =3D connect_to_mptcp_fd(server_fd, 0);
+
+	send_data(server_fd, client_fd);
+
+	close(client_fd);
+	close(server_fd);
+	bpf_link__destroy(link);
+	mptcp_bpf_first__destroy(first_skel);
+}
+
 void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
 		test_base();
+	if (test__start_subtest("first"))
+		test_first();
 }
--=20
2.34.1

