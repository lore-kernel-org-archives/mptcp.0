Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71982564
	for <mptcp@lists.linux.dev>; Fri,  8 Apr 2022 15:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1649432358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GNG8iEtpzdkuvq6LDqfwpmKo3DfQ3gomG42xVqw+Nco=;
	b=QDOMULj/zfhwTjabyxL1ccwrPbB+OGYhLv+s+u5cZnx9cHJnaEIo0uoDYi6B/xz3LTv/ue
	DHEyBlhLzjk4Q1OQJqQeRgUE2CfCIEKmeT9+noE49Qt+60Un+JLjHaRVJs0yZUUFhhJ2w4
	a+e/gXHeeCACQVgiR17ybBqe/m9hreg=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2174.outbound.protection.outlook.com [104.47.17.174]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-38-HY-ec6tAPqa74ZDrrPh_Fg-1; Fri, 08 Apr 2022 17:39:17 +0200
X-MC-Unique: HY-ec6tAPqa74ZDrrPh_Fg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HnpnFugJxq5Y3R+ar5IPHbMK/jS7zt8YOqYgyHVdxnqKcg7bfZgqSVZzOCjyeBKSyXpVlHS66QELte5N8jHS9R8x6rEn6WAecuErgPOF4dGuxw+rQ0vYl/Jfo9730S2jcN/GFzGXJjjpp4VBsVXB9htojHQEZmAZwctQXMXEjbxkMpszzTK4fNfizCd4arAHFxBOZmFZPfLgeJQ8TfRUc6Zw3oamIMiqktLy9IKyZ0vJ27yTjyaFTnIJaPr/e8zYX9zyE8+px8jWrXCOKMDGNCO5yM2i8WgnhWUpylErbIZOgDdvkCfSR3+sCQE9GH9wRFp2KRAd+vFifYpo4PJ37A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZK0VfxUK4qsR2ROUjpij6j46M5w2ZGToJAXYcwSeKA=;
 b=La+4WwRWqdTCmpMOsSSFmsDRQB1OfYTI5nhFW+lFIKf5v6NbmWkLlEp0x9aGCvBeyI3UmldnBkiygmzxwWAPJ9udyfYRsNi5crhhoBUTbVFqqrd5vCfTNlMcLp7D5+qE8YRSwMd8jyTQhD49XhvtUClm+vYErVm4ilbEFKNGj0qWEeLv+T9Fenoj0lRgq4cPARwvi1Kh+2dDF+7gH90GzmL+URjRHynQno/bsSmjX5RoUVbcDfkKfawoUOi9DQjjtPVItwIUfxh0kxmsDqcy/XjId7tHTuxiwVUi31O6/iK7ZkVig/YIl4UqGfiQgpTtRoI2+7i89NfTNVf9orzdxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM5PR04MB2995.eurprd04.prod.outlook.com (2603:10a6:206:9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Fri, 8 Apr
 2022 15:39:16 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5123.031; Fri, 8 Apr 2022
 15:39:16 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 8/8] selftests: bpf: add bpf_first test
Date: Fri,  8 Apr 2022 23:38:05 +0800
Message-ID: <db23dee89ef9ab4ead8a731424ac283766156528.1649432004.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649432004.git.geliang.tang@suse.com>
References: <cover.1649432004.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0056.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7346a0f-6ba4-464b-2981-08da1975f049
X-MS-TrafficTypeDiagnostic: AM5PR04MB2995:EE_
X-Microsoft-Antispam-PRVS:
	<AM5PR04MB2995CD1E0B6CC9E82E4B7EB8F8E99@AM5PR04MB2995.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nPDSPxqLn9V4dFCIAJzXFzy0JHBR8z+G3FvYbPOKJ1FrnxQZjdZUXu4bDfmWOC5AbiKBdcUjNGwlWg+Gdyx4xM9MJRH74GmLkrzFE0DLRXX2j9pQSV0HKf3NDV3vSFok5raNd50o1YfLK+MPtST4OQjZZobecVot8xKodZTOAjkkTrlEzjxSUrNfXSSNCUmAgv5MxgDGvVZB+/jbHBdZyef6/0p1G5LiIlqMxpkjRAr/ePTa6VOTZ/zcF0KG+kKcI3yv9eY9o3/LZvoO0DzkQdo6wxDEDCgIFG8CLwVy0Af8dmhhZQ/x1jaSnVSMsnRbjmO0xAc/Tc9tBCxczNBjrzxlsEVULTx3Z0vzZvR0VZeaKSKAAmM51SfL+ZV0xa9w8rFqqWYAQ/j6IfjuoxssXAFl5tG58DmbEa+gIXQUL5LmnODfvbDr+H7ntMZAJc59sJnX7j2igqEYNtf8p2yDq7xv7B+ie57IEUM4edwqASQjyIiu6/ZdHRoA5ACFZymDcUyAQQ/QWvEdn6G5pNBTCB2uj54F1lzHEckYe0jipnZwESIhghKQYcXJUPT8yG5xB5AlU/RTynEklUUE/+riOMQuHioXE/2hEMcz7SMcwakbGNS6X+PGdT1xjqCCtL2mgPEaQkWuMvafV8XNw/eHXK0J53rFNJDBbp/LSgHTM2XLbSRxrxpJvEXr1YHnPo2t
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(38100700002)(2906002)(4326008)(5660300002)(44832011)(316002)(186003)(86362001)(26005)(508600001)(8676002)(107886003)(6506007)(2616005)(66946007)(83380400001)(66476007)(6486002)(36756003)(6512007)(6666004)(6916009)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4o049XyLybYWlLdigeSOYZ69X5YJIqNGUcg3uV751QlWxzg32AzB0/SMERru?=
 =?us-ascii?Q?8UeDOEx9ua1ZCj+m9BssCipdChZ8IbDhUiPGAPTpDHQKAHgwam6C5W+EX3KV?=
 =?us-ascii?Q?1L5rZv5FB8JyarpT6t67129MJHl60W3ms5Nd72J62wlceHw/Jc0Xrj3WrAZu?=
 =?us-ascii?Q?DlwRlDv52Ht/+4XOwaQ3+p6zvHN5x6aGWcPTa2gvnfFM3Nk+TxLAYUCbqSPX?=
 =?us-ascii?Q?ZakgAsp5qUAQvUqMn+dk6B8Z1oNPzub/mKXeMyujxPhkkMjci672EFcOWeQu?=
 =?us-ascii?Q?cysZOSQz70uMulE2WAb9MFrIG45AJUqwporPdyUuiy64vCRoi5SUT4OrqJqc?=
 =?us-ascii?Q?BJou1AMCyb3/MfQmmw9sSanmu9gU2MLwag9PncjCJq01Dnawb97sBwuWBn/9?=
 =?us-ascii?Q?QOvw8ne9Io28fL2D07s5W/bs0NSAgzccfn/ASQNbMmAQZG5zCjr05xxNPmuS?=
 =?us-ascii?Q?fs2+eLE7mNQzxWzr4SB/9EEv4D864MSojyauYIR6aB/66BBdQJjF/436WApN?=
 =?us-ascii?Q?2gddBmK7LP+nzCGKoqoYEx6W79KJSPzOn/XVdcJvT3Twp5K0EPM0ruFxDt4p?=
 =?us-ascii?Q?h23YJ4t6ZylsAHcyx/dX0g2Q+Ur1D/9k+DZDDI3iy2ZIDDLLFEEnPmRjOJiw?=
 =?us-ascii?Q?tD2LM6d96LyOo5+MP9pnyTsvwOj5feq6joqYlq5RWOsnEQJXjoIj7dEDfppe?=
 =?us-ascii?Q?46VZ8w3ucScXIo8PSzgblHdK2brFBp7rH0DukBuVaRd6d9AjeaTUkvXu0rps?=
 =?us-ascii?Q?afDZtt14AnTnaeYygPSzUc+Z1K1R5t28r9UxO0qhHLMWWfWUzWn+7Jqig/ED?=
 =?us-ascii?Q?Ve5U1iBq05Jns/HkPOWKkVfjFPAG+/qc+EgdYMfEY55uscuvSz9i6dWUJjUZ?=
 =?us-ascii?Q?JAfSfESMQz6rxryHXq7zh/OE5ZlQ7M0LorAP3vBYbMVxHkLEa7uFod9t7imw?=
 =?us-ascii?Q?EAnXA1UnU5ywcfc7Z09MNJMOmX6lT60Q3mv4PgUxzHCowGQfj6fs7yU9v18z?=
 =?us-ascii?Q?ozLgv+DwCO6mAQpF5+Jg9BZSEJ11hsLt/qE0foUUSRkCTK4BNxUVGNw3agcZ?=
 =?us-ascii?Q?6y5Zde8Qs2y4W+pdQGxYjQ3/KBjSBMMYyCbnu+uftoa7POZXeRCQH7lJl60b?=
 =?us-ascii?Q?HznPDqqyd8k8MHxJaI05Ua3y01Yzafr/QGnoP3yvJ0pt3TdtT3h/tfHbMLvn?=
 =?us-ascii?Q?6ppXJJ63Cvqr+OX/sV16XShnlbPMHZ/beIHNdoL33uahCVDu+o9u7akGZx1i?=
 =?us-ascii?Q?4HsQ+Na4g2rv1V0/vbCuLQ/ATSj2lklc03Aw1sfqFEUj3ulda8rPX9DnFQRT?=
 =?us-ascii?Q?49ZxlDeapKUqV4Mc6+hKu4RYt9fqsqVG5r99srXfS1FSpAQZpacDdjbv/SZr?=
 =?us-ascii?Q?C1lXnyD2K/OF5x0BDniGsVc1YRKOmElBIyPgxjz3lU74C4FBwFzGkNe9UdJq?=
 =?us-ascii?Q?04Exn/EAEpkPrZ+WHjZOmeHWLbV2IS4Wot6AEbnjL7yNPB/rNgziBb/eHOqQ?=
 =?us-ascii?Q?OiRFsERhEVuW/h/pDqLWqgQhLLqVR9WuSf9t1plbhhX48iGUoObCrjO7SV+M?=
 =?us-ascii?Q?PG/8PNNxGLHJKvzEQUcCxj2yn7AS+YFOZNFZ/wl5ViJWa3DfwfnDZYPs0glV?=
 =?us-ascii?Q?XEWpr2eT6D+TlMSj78MQ7DRoF15a07CM0eTB+3cnJkYVbrV4hRYlsfi5sEJ+?=
 =?us-ascii?Q?8lUjQ/tCeD3hzDQQ6Sk/aYF1qeA0kNRBT0k2/5o8pjkZ7chQuDPzJlnu5ECo?=
 =?us-ascii?Q?YJZp1mxlLfrX6Doa+ifB57/4d78C9Do=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7346a0f-6ba4-464b-2981-08da1975f049
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 15:39:16.3134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cxEecCVELIqz4WzLaiGgJSrs1WlLUpqFc+GHUbqAQLk3Filt5uc6/LYdwjukjdTjruBQqpK8QXbyKDE5GG/GMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB2995

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

