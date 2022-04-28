Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F4B7B
	for <mptcp@lists.linux.dev>; Thu, 28 Apr 2022 05:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651123462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WnSV5a1EwgO3RknI2V5ujKmVZVa0WBBQfbw9D8tOT7g=;
	b=E5FHo/B0hauasPDMMLcjWM9r7UwQ4VzCHGL/bqG+dDCbLjZ2SYwWsW1nBYcUlusPo8q3nH
	cCPwXkz4MMOx7BBs4KHmpJwRMob4a6MeGBqoeJQxe5liv0+68LeqzuACjDt7FKsOjfJg3Q
	7xDkxMp4Nnfd3D0qG0v7Q7a9XBvU5fg=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2055.outbound.protection.outlook.com [104.47.12.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-37-qVo5oHEANt-sQyu23k1W_g-1; Thu, 28 Apr 2022 07:24:21 +0200
X-MC-Unique: qVo5oHEANt-sQyu23k1W_g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bepudcCxFit8468Rjf4byhU0E7KTg7lr7/Vx82WBbZmKF08yOSUF9vKrV0L1Trhtmi6qNpFSzyonyiZaW0GKE3wIFPkSoqjydxS+CvCFnPADqoFMsNUhIbDPKkTy9H2nKsF7SgC9xGTZx1j3nio2pgOoCbm6HUuaNh33NjwwX9qtgA/BbrhmDwojkqEU6nQbTMcm0L1FYdCcPIrlTZD0561Wlp/s5MYNecEI5ToO/z/JmHHj2pVeHxR58WrG211YhYcayhrEOBvpKBhEPCkSEnPsUcutZ5IysWjNlH6sAIb9A+6CMtan39ejzeyiZ5muVoMM0KmxOTV0wRmBqKphiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XaWAbkqCo4kB2a2vFZa9GAp/RL8+LsScjAc1pLDDwLg=;
 b=dS1KseMGBGC5wLSLJ8/wu74uSANQKSyqXLYCIFoCmCRH/Ar5iNqJjJv1yrEds42PDTHz0hPm9209Q4UWkVrmj+wt7QtlbLs9pjRSrAlbtIqDB0qaXAu9e/TBkQuOJuYttr8dLPozxWffL+tdT6Odg99BH0rAstSxZ3ML04j4ughshQwrpELO7MLPRkTZ2xUaSKoUvrYKLJhCsa8EvvQsvr8y4RB4J/mCrxow8UO5P6JxBvXR2H/m8vQnUvbncy7c3ApyyKMJLkxcAW1D7r5sYxZ5ie+BP9fL9KuDqeBeKkrzg9asRTxAvXZKMuF9l/RQsZ4jNjKQDconVHN9z6kqJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB6PR0402MB2885.eurprd04.prod.outlook.com (2603:10a6:4:a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Thu, 28 Apr
 2022 05:24:20 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.021; Thu, 28 Apr 2022
 05:24:20 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v17 8/8] selftests: bpf: add bpf_first test
Date: Thu, 28 Apr 2022 13:23:35 +0800
Message-ID: <81c493815ed6f4d50b8178323771b97d27fad1f8.1651123078.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1651123078.git.geliang.tang@suse.com>
References: <cover.1651123078.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0061.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b41d78e1-3fa7-40a4-42c6-08da28d758c0
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2885:EE_
X-Microsoft-Antispam-PRVS:
	<DB6PR0402MB28857041EB6E197127AFEC59F8FD9@DB6PR0402MB2885.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rlk/HYaN1TD9KmB8eZTa2xh0jurxTT3e6NCwktiTvrmQ/qz3aoV1iTQ2Nk8r7uoYjo7kYrJJ92aY5baqBcDkn00fv1tpO4dQ6CGFfFuJXBBEYxnYNNForiA/6+2fHhE9IIkTazbv98KOpau4H/QW0CA1fHNopBcsZIWkruIK1EVuyspadcF/dNdFt0Za26Zng4HrwQnUHu2A12K1PgOW/r8rphXLqKYVBeem9uy/vmbMczvWYT+AnisL6ZUI8GMIZAeMp44R3sVYXeXCInsi9fsr2lOvXQwcdZa4LLbj88CVyabVVVRe+gK0bJ5/q2bAdQqMpG4xjLPxjWbhSTWrI7oz0TWlw9xYW34ovkJKpRjNjElV9WpYawSfroKF08kkmt/e5bpekGTPpXO3G3ESUBvA21aw+tsa9epZcFw8JBVYcIii+ihSkp0amARaeV7U7BZAAy14GiXcTodYtqM92h8rr7XznXfZIbuewRxslSjSVVE2tgsOdlbj10s9dOfbjoYsUp4s+xol3CPDf07UwgYZbhLXnbkqqvPNSIm1VhFyJ9wCYsPEkflOhtMc2Tw92LSrfepRsAk3aBPZIwWF1yjHp4+foLtjUhRNMuqCUG8UxWVP9jKjf0ojQtANtX0lNwspFt4fXUfjYZk8ko8HBZPVPDyngsJGeAAlBsu/d61W797xXIGgOiTqOxs5S2IF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(38100700002)(6512007)(5660300002)(36756003)(2616005)(8936002)(6666004)(6506007)(66556008)(186003)(26005)(6486002)(44832011)(66476007)(8676002)(4326008)(508600001)(6916009)(83380400001)(86362001)(2906002)(66946007)(107886003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/nVUMNTituqUZCNNIfWPmeZTDXPIxypI4i9kKEHLtopu+pBpFiDXh9Mprw1b?=
 =?us-ascii?Q?rwLG3TZkfNAR2+OBuDK2SGvJ54hCahV1vRP4WQeetGp+4fKkAYSltbpWNXiY?=
 =?us-ascii?Q?p2VaZprxZOAm7X71dcRfmx806WbSNxySd51nL6rRQp8qShpMEc7w6AmUnzAF?=
 =?us-ascii?Q?NaWPfwcl1Eq6/v8EYr/3nwlADOin4huupG4Wkx/nlkKYJXQHzF26/HUIOVp+?=
 =?us-ascii?Q?XCE/MnPA17VzoacoPa7VK7EM9xW3FR8xLkPZYkciTGRL9ucd/Mm4FM8ntYSb?=
 =?us-ascii?Q?TjTr7ybQw4MgF/x1RJs4m1ivqxG4zi+WpoAP2bXisVxb1NH9PHM/hl2Mi3Zx?=
 =?us-ascii?Q?fHgxwKKbUP5BCy+d6d8TB3gTlB/rRXCSVYFFWXwkDIDeNppJkgJEnDfCXvi4?=
 =?us-ascii?Q?ZDms8T0zRRl5ZCitb7spQiL6L3He8UeRiXzWXRDtYjU7KqtU3duZ0TCs7MGn?=
 =?us-ascii?Q?paR0n38yeKhfi9K0ZnOavAhYME8/qDziDWYrCzrYPtKxpFYs6rl1RvtGGJme?=
 =?us-ascii?Q?Bu2swpPOzD4TONM5ZtDTR5+b2QruNywtB/poa5/7HAgfxuxY6158WIf5toUI?=
 =?us-ascii?Q?Kme5jj7Cvn/kFAIzDFU6k8NXWWKMoqhjdPFoAy4Q99sbHFKDfMelmIcMRe/o?=
 =?us-ascii?Q?IRNVPaI42hbhomxTbvHNu5BODy7vLs2ioTDy1U/FhKiQnYhCkDaL7oc2ZgfE?=
 =?us-ascii?Q?h66cfHWpdu5Zihdcfjf/KurNp7WV5LMhtpaspUMxxsDs3wBf64o4WNXSYddk?=
 =?us-ascii?Q?tmvIvULSwqtJNQ+5BR8BBjPqPoCchGjrtod48OI2mBWX7r490o09Nh5HqqU/?=
 =?us-ascii?Q?sZNRmnPzvQV1+tq92ICUVSW+/bByfqCFrDEAbnXr+LzYQ2qkeZtFRxsL5KIX?=
 =?us-ascii?Q?7+iDEGVUV5ILux2EJ8G6eYcbqABWKlV8S88+4C9luRLIkZgshR9g9wk/pQUp?=
 =?us-ascii?Q?K15Bqg9nVu6cxoaHNLJ0DwEybJj2C8jueRInqNPOjT4bcDYIOOhD4axoaZQU?=
 =?us-ascii?Q?sxoZrHl8LKH5eRnXhN43EVetvefEbji+/fqSPiWRhuXsSKvchK7vqFS+gYOt?=
 =?us-ascii?Q?kgbvJxdOeEIY2NvROyh+cPgPNYXLisfJwNaGTLYHWlA0R0OvfRFYo76sUt5v?=
 =?us-ascii?Q?VpbCRTIVfAs7qPkZyzGlB4MmE4Y2qP2f3ZV3umGMb+RK00CF4tistZTBWBlN?=
 =?us-ascii?Q?33qnxu7FC5r96Yeyv1zVDU/mbizBbY5L7XYFfdO/F9aaywCpoRVQMNxo0jJM?=
 =?us-ascii?Q?StLsZRMhrN8z/r/SCKoawuKZ+z+ow87rC/6/S5eK45T+nwkzgJpQb1e3H09+?=
 =?us-ascii?Q?el8kdYVcSGXXBQt0eqNecZIx97LNd4yOjFdE1G1Fry61G1S/hV98CW4y683x?=
 =?us-ascii?Q?GmsEQXJVzOZx6j4xLBJLUPwh4qUFOFo+zCVxOMZz6INXCBs8SSma+T3r5D1p?=
 =?us-ascii?Q?P8KciAlJJ5oGs/f7K4RozYCgsdUeZ0pAZq20iUO0iAziHj51S4eytgIElXl3?=
 =?us-ascii?Q?EXdPkQmkydBaIBDlbqlxbSWsQ8w2EG548/zw7lpYmaaJ36RAZKZ0VBSV9/tw?=
 =?us-ascii?Q?t4Hr8H7hmAJFMfEMi5lNZkAShUv0a/A3eOKpteaV9Tj3oCxkRQBRBEXElt8u?=
 =?us-ascii?Q?7IgNoKpB+HpwaIDWaNYqPOxd/km0PECinyOV5VWIIBa9Ol0cj5aE17owwmrY?=
 =?us-ascii?Q?rN7VF8sKp15r5RFkRhOLNDZ98eD1bElCLYFupYzJ0FoqvAZFgUMG3YJ4tyi6?=
 =?us-ascii?Q?+Tzfeg7YowYzc6V/FZ3pB/QZcj0y1oY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b41d78e1-3fa7-40a4-42c6-08da28d758c0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 05:24:20.0139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HRR3+6lYBCbORhjy/cjBVt3/jUK34+saEuOY0+Zyz0++sqURe1PPYbxUSXqC4HhjJf3ycQMIpaiDakc3FDHTEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2885

This patch expends the MPTCP test base to support MPTCP packet
scheduler tests. Add the bpf_first scheduler test in it. Use sysctl
to set net.mptcp.scheduler to use this sched.

Some code in send_data() is from prog_tests/bpf_tcp_ca.c.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 112 ++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 7e704f5aab05..44484a63e62a 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -4,6 +4,7 @@
 #include <test_progs.h>
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
+#include "mptcp_bpf_first.skel.h"
=20
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
@@ -19,6 +20,8 @@ struct mptcp_storage {
 };
=20
 static char monitor_log_path[64];
+static const unsigned int total_bytes =3D 10 * 1024 * 1024;
+static int stop, duration;
=20
 static int verify_tsk(int map_fd, int client_fd)
 {
@@ -251,8 +254,117 @@ void test_base(void)
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

