Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2059.outbound.protection.outlook.com [40.107.21.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4596CA23
	for <mptcp@lists.linux.dev>; Tue, 27 Jun 2023 01:39:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AxuHuXnk/T7Cx1KOTuofLluolgE4UR9KEHk48oZq2R3b8RDXdgE6gJ2XDqA+/Gn1jJ18zW+ewZybAWamLUxQu5wEhMrrynHEM/9v3a6dvP02yUy3Rw80dC6cB8vDxAFNMK4ualSQ62UDT9vs2hxOneqgNpwCsD2KOwTe9RZwARyUS0xaQXsvWgXHyrJwNso6EkNFehVKYgzKFBVskhgzgHfQeGKJvrghsuwn2zRN7yfiMpKog+QhpAMR9TcpEA6BziUQOveWyNmXPe2vIdNgh5dmDRgu9C+gZs6IksBKgstpXdvMuBjs//QlQrFvWsYQQupkR54Q0eQcW6ioJ911qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4NfrfIaKyZiKFAKhCXN2GZph29xDq3ofVgi4sQTssFg=;
 b=iG+rYxScueMjbHdq2FXvL2NQI/IS9in4+HoaW7Y6LQ2Px4NAgpWo9f1DArQ0Cqd7F6LGx2nRf4XhtDdMbrrDZwniCmcPJJAm6nmJarYV1oQ3dT5VVF92YGymAwhGIzV9weHWcBtbXuAA58FJFbs5aTy4BsbY1QNiFiSyq8YcSTlngibbqs3fWXiveLRb59ry0sOmDSLJcVe/CNNT4zP4hSawc2URcHf0e9weeVL1nB4IoVw2T8t9UjCjcirj5UMScpl93Mtgy18HJuJqa1IQDKNdRg8s4zACoM20bNTLenY1WNzXuXHfdyK9hR2vliad3pFYpTqODmWPPbSHy9w16Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NfrfIaKyZiKFAKhCXN2GZph29xDq3ofVgi4sQTssFg=;
 b=BfpVsvlDFGk4xmpLaGpN2YRtNWfiXRmrOWfybfqyhgFtQuK5ErTXfLL4pNifyY87FF0DGswIieOX71FiaIYuY/9MVrdljNHidqYkW58dbE3NbDWyNBviCAak3KovLvqF1crHqbBiokr1HvciCekbijWk202QmCK14phKYsYfT6UotWp25vqbWE0zAvjPCK1PuLSM8zMrIo3tIw9XXJ/sNS0iDBuVKxgPmc+YxuFSfs6L3WeaBz/g2fJtYtr0lTeZEzO25FPFCKqDuYSzB7SK2n/tKit7mllIJL4A/J4HKcH2lweO6GLKG27VJJwkcCWcKySA4ECAhxtJCH8AeOdLJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8277.eurprd04.prod.outlook.com (2603:10a6:20b:3fc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 01:39:53 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 01:39:53 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 01/10] Squash to "selftests/bpf: Add bpf_first test"
Date: Tue, 27 Jun 2023 09:39:22 +0800
Message-Id: <c9699387fc337c02b3135b199aaa8d90bd741eb1.1687829823.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1687829823.git.geliang.tang@suse.com>
References: <cover.1687829823.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:195::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8277:EE_
X-MS-Office365-Filtering-Correlation-Id: a2ae31c9-aa0b-4889-4e89-08db76af67a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WSlMiR0aEbZsfSLIpjOPynHu31Nhl5P151mYTgVY0we+ry9TZZTP50tKb1Zt70M0G1hpQlkDb7MCkZ03IDuyP4BCABzZrKSs7R5Ew2X1XO7e6e6CMOWfvcn2R4IMbH0F4qDNHNp4kkPLx7QiLYbnrngk7UM0HjtaoxMmohYWfy087w4vVigKVpfB9tArH2DvZRVcBK4C1FlwfCVAgAwm0Pi2wlV7Uyu3TkI89554D4G0n8Ax41tWDw94i5+fAE8ETjlRxkBLAOW35Nl21EaC7mQeY+u+2eAA2nlIxaG9xeS9lffNR5YEYTGc/jlZGohYM7+jPcRMnkhMRpMKhf9SrS3UlNmlB+PALwoyhprAN/RS/qTJAQbUVIRUSAcbDWBeyMIFkQyjspVTI0XmtLaFSbYGCbgv4cGVYXZ+u8bVwRS2gbjEeKyLLYAe83xpKq4mTtFwPLiIZtwPgywE7bk36XM7jSpDnDOrCdFf2WvBXGfzwb8wuRwIE5OA2lyobGvvp5cd4xt22TJF3hgpP6OWgZk4I6Os1i6DjeoT8vVbKs1KbfhlVRJF6BzDfz9HLq47
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199021)(6506007)(107886003)(6666004)(45080400002)(478600001)(2616005)(83380400001)(26005)(186003)(2906002)(6486002)(5660300002)(41300700001)(44832011)(86362001)(36756003)(38100700002)(66946007)(316002)(66476007)(8676002)(66556008)(6916009)(8936002)(4326008)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SIj+Iox/7LnxULRB/nZGxu9AQOeQfMIbYtc8HODj2VUrzUYMg+cY0EUCuexR?=
 =?us-ascii?Q?jE6wIB5U5+PWgPJU3BNF0iB3nJniIm3nDo+D9Bs+ptfeMY1/m+BmD5JMuc/V?=
 =?us-ascii?Q?YSOBFHbSoo+OOY1IdiSoDNiixsGod/+fXW/l+Ru5mGfoILMWO8aLlFvJoeFJ?=
 =?us-ascii?Q?DsZtAoQ3FDjeOPMEMUNigoELRf365PGcukJX4Bg25s3Q1QlnmkFdWpX8zxz6?=
 =?us-ascii?Q?iOkWBFgetMgqeai0aphdfnZcZZz3pwlhFhCXz+NWRHU9riJb+twek3b9Rga2?=
 =?us-ascii?Q?Fw6bsrW0Th7PbOiM2Sr9rfp2j9pl2CmdFd6ndp7CdHZBB81JcageuIrV8IXC?=
 =?us-ascii?Q?BL5lT32eIUo8uiEeYyggHQR/WE+DHoeahsHsnXAOpkzQPjOVSSyZbriNTaWg?=
 =?us-ascii?Q?BECkYZtr2USCxaZu0wOXZYktg1PyfNrYP9wHt08FKH1iQQekRp+TyUHXFoQf?=
 =?us-ascii?Q?5VCbR/W5I3EG+A6YKjLWUbkj+LPcz7+gQBn5UsBwDuhn2ORsyHkc6rtN9enm?=
 =?us-ascii?Q?GmXGr169l+vbT3NV5I/Bm51wQjjIi1I0R4QBISEZO0p73eW0tPh5hdOO+4gq?=
 =?us-ascii?Q?0xb8sERLD5V6qBUVi5yK1gwbE7wcUC0RuyNjx5gM1rINpJmUfyXVfDptb86t?=
 =?us-ascii?Q?6hGOK+cGwY3kcA2ZE7fA+MOHIZacVKBxyS8qTyE0VYPwEDsNSZZESjCvWOlm?=
 =?us-ascii?Q?t0d26GJQfzFreL2aThBTUqpmD0hHYS00p5Z/8rwfjg/ERHzptdCxUOGsZLyn?=
 =?us-ascii?Q?O0pDN1O4hmcsd/XcqNS7Vp6svqf4Y/tbeKIXO4rwgL+aHY035G/Xb4jZ0RNc?=
 =?us-ascii?Q?i4dln9ln8j4WrrfFzK5H9vV1NDg0shbewTQ76rXoBd88k7J4dp06J8lIfAm/?=
 =?us-ascii?Q?UaVmcvQKvOSgzN4Uugv+iYBL/4pF7mC3ncWttifwmH/ev+35fyo6nwf6blFF?=
 =?us-ascii?Q?9eKzf03tM1zO0HNVW7q2B0v/6Ek+U9p7vwUO1OkqiOeymDUXdFrwKl1TFNMv?=
 =?us-ascii?Q?+1jXQPWImkYankAKzX298MoYn9MYc1Uu1cFnmy3ETFvEBvTCeRErejjhpddt?=
 =?us-ascii?Q?XX1LcqelJpEaEuhzFfkDZwWueBsI+7VIKoXg3c9cOhkMx5FdgGQbkP0Yyuot?=
 =?us-ascii?Q?5yoqmMnMIYxuQntHEFwzNXXXsXiKmRw2BjyEcurMeY29JJ0hJjMHZSWhPlz+?=
 =?us-ascii?Q?EnBPaqtOTN+tu/7LJVD/FuxHhNtkK2a1PWPYUiVCxt5aLG5+fqNFJJH7Dq8G?=
 =?us-ascii?Q?0b4hPbUIxMR90dwOEkCjz3DqFXuEwi4yLd57nVZC5BvADUseKvZetT3Z+Bxu?=
 =?us-ascii?Q?XJi42z6ay2Yh4BRHvve8Kx6r1MrxMyz8kR62Ub5OS1OgbcvRC6G2UOklRIkm?=
 =?us-ascii?Q?zxcMIWnUIz+sa6np+dYLAhW/zf88JgT9ZNmcXJ5jvRDagZ1twoW2x6gHTw1P?=
 =?us-ascii?Q?Gr+7MUR7KwCwVKCZXE+++ITBNrprSjl0NaU/SBwbcJsWdAOYwhvJRzEt/RRG?=
 =?us-ascii?Q?53hsN3jFpmOkgKpfB9vDsVUccU3YyfQr8FfZ3KyPn09gaVz1EspTSdOxJtE3?=
 =?us-ascii?Q?I8rtZ53fEB4X+yMxYtkgc9kOvpznYWeNSyJ8ZdXH?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2ae31c9-aa0b-4889-4e89-08db76af67a6
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 01:39:53.6271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iqorm7mVMNg7Qf0q7rNwBD/0D/pz/3Wn+FYfH59YtW40KrmnLfgiGOzMGhGUbjg/78TG4bMKd4K/uuXi3cUXNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8277

'''
selftests/bpf: Add bpf scheduler test

This patch expends the MPTCP test base to support MPTCP packet scheduler
tests. Add a new test to use the default in-kernel scheduler.

In the new helper sched_init(), add two veth net devices to simulate the
multiple addresses case. Use 'ip mptcp endpoint' command to add the new
endpoint ADDR_2 to PM netlink. Use sysctl to set net.mptcp.scheduler to
use the given sched.

Invoke start_mptcp_server() to start the server on ADDR_1, and invoke
connect_to_fd() to connect with the server from the client. Then invoke
send_data() to send data.

Some code in send_data() is from prog_tests/bpf_tcp_ca.c.

Add time metrics for BPF tests to compare the performance of each
schedulers. Run prog_tests with '-v' option can print out the running
time of each test.

Use the new helper has_bytes_sent() to check the bytes_sent filed of 'ss'
output after send_data() to make sure no data has been sent on ADDR_2.
All data has been sent on the first subflow.

Invoke the new helper sched_cleanup() to set back net.mptcp.scheduler to
default, flush all mptcp endpoints, and delete the veth net devices.
'''

Note: This commit should be inserted beteen "selftests/bpf: add two mptcp
netns helpers" and "selftests/bpf: Add bpf_first scheduler":

 selftests/bpf: add two mptcp netns helpers
 selftests/bpf: Add bpf scheduler test
 selftests/bpf: Add bpf_first scheduler
 selftests/bpf: Add bpf_first test

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 43 +++++++++----------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index a968641cc94a..39d95c6a18e3 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -3,10 +3,10 @@
 /* Copyright (c) 2022, SUSE. */
 
 #include <test_progs.h>
+#include <time.h>
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
 #include "mptcp_sock.skel.h"
-#include "mptcp_bpf_first.skel.h"
 #include "mptcp_bpf_bkup.skel.h"
 #include "mptcp_bpf_rr.skel.h"
 #include "mptcp_bpf_red.skel.h"
@@ -247,15 +247,19 @@ static void *server(void *arg)
 	return NULL;
 }
 
-static void send_data(int lfd, int fd)
+static void send_data(int lfd, int fd, char *msg)
 {
 	ssize_t nr_recv = 0, bytes = 0;
+	struct timespec start, end;
+	unsigned int delta_ms;
 	pthread_t srv_thread;
 	void *thread_ret;
 	char batch[1500];
 	int err;
 
 	WRITE_ONCE(stop, 0);
+	if (clock_gettime(CLOCK_MONOTONIC, &start) < 0)
+		return;
 
 	err = pthread_create(&srv_thread, NULL, server, (void *)(long)lfd);
 	if (CHECK(err != 0, "pthread_create", "err:%d errno:%d\n", err, errno))
@@ -272,9 +276,16 @@ static void send_data(int lfd, int fd)
 		bytes += nr_recv;
 	}
 
+	if (clock_gettime(CLOCK_MONOTONIC, &end) < 0)
+		return;
+
+	delta_ms = (end.tv_sec - start.tv_sec) * 1000 + (end.tv_nsec - start.tv_nsec) / 1000000;
+
 	CHECK(bytes != total_bytes, "recv", "%zd != %u nr_recv:%zd errno:%d\n",
 	      bytes, total_bytes, nr_recv, errno);
 
+	printf("%s: %u ms\n", msg, delta_ms);
+
 	WRITE_ONCE(stop, 1);
 
 	pthread_join(srv_thread, &thread_ret);
@@ -315,39 +326,25 @@ static int has_bytes_sent(char *addr)
 	return system(cmd);
 }
 
-static void test_first(void)
+static void test_default(void)
 {
-	struct mptcp_bpf_first *first_skel;
 	int server_fd, client_fd;
 	struct nstoken *nstoken;
-	struct bpf_link *link;
-
-	first_skel = mptcp_bpf_first__open_and_load();
-	if (!ASSERT_OK_PTR(first_skel, "bpf_first__open_and_load"))
-		return;
 
-	link = bpf_map__attach_struct_ops(first_skel->maps.first);
-	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
-		mptcp_bpf_first__destroy(first_skel);
-		return;
-	}
-
-	nstoken = sched_init("subflow", "bpf_first");
-	if (!ASSERT_OK_PTR(nstoken, "sched_init:bpf_first"))
+	nstoken = sched_init("subflow", "default");
+	if (!ASSERT_OK_PTR(nstoken, "sched_init:default"))
 		goto fail;
 	server_fd = start_mptcp_server(AF_INET, ADDR_1, 0, 0);
 	client_fd = connect_to_fd(server_fd, 0);
 
-	send_data(server_fd, client_fd);
+	send_data(server_fd, client_fd, "default");
 	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr_1");
-	ASSERT_GT(has_bytes_sent(ADDR_2), 0, "has_bytes_sent addr_2");
+	ASSERT_OK(has_bytes_sent(ADDR_2), "has_bytes_sent addr_2");
 
 	close(client_fd);
 	close(server_fd);
 fail:
 	cleanup_netns(nstoken);
-	bpf_link__destroy(link);
-	mptcp_bpf_first__destroy(first_skel);
 }
 
 static void test_bkup(void)
@@ -459,8 +456,8 @@ void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
 		test_base();
-	if (test__start_subtest("first"))
-		test_first();
+	if (test__start_subtest("default"))
+		test_default();
 	if (test__start_subtest("bkup"))
 		test_bkup();
 	if (test__start_subtest("rr"))
-- 
2.35.3

