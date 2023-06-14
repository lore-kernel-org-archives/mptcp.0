Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2052.outbound.protection.outlook.com [40.107.15.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDEB7F
	for <mptcp@lists.linux.dev>; Wed, 14 Jun 2023 07:27:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JRTofwOxDXn3WmdBKNJLavjfzPc478Omi8yqPMe0/Yi2JTeqMRGaFZ9v3HTx2OW+fItbs5isIeiIPa6LAWzzwCi54dm0B7VcPpWigyl22zsFBgyfC1KzS804YG8/TlQpVtXL1haBHnKUzJ4sEqCEtU3StEJM6opoTj7e36dr1NhDxNhIIRb+zvo0Zk5R2hZn030Vm6opJecgZikEYpjtyXcm4ijGAFs2MiCbNinan3qfMV4XC7GjVszI+aji+7ILKvxEqZNaZt2+ETLTQQsgTiD2qx0ClbE50ODgJEWyarG0nDlxDh3uM5J6UNXXHOzrX85vphHrwv4TvkJHz+zLHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8nrKOq6CwfkDgwaX63akjx9o1uzBLA1DhrOrnMkkw8=;
 b=Ruzer7/uTvJqfi5lTi3xAdJKFxJiwp15miEZTt2fSJX6zFv8pvnptbVDEPF4ZYTilusD81FAY/8kaQVxL0YUxR370vfGjluMpTvofivW2hBjy0+F+VAJ8ZY7TC6qlzQQ/NekpBY6dd2puu2WGmMPHfl4KF1++OTKMlX8ZmJFQoxr5XycS/b64zKHx+MxeRCkAW4SisGgVuC2EE1Cr15S21QRkaVvxqBXJmcrzC9BmmxYKIwCM/fotjtIxC8iBVKJ8zPxUT26mGhtdUVVqRrZREtM5C1L9L12MxwsD1vheQ0doHfKsa4zJA9oBM1wdOoofIRZSr06LFqmPk6Tou55ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8nrKOq6CwfkDgwaX63akjx9o1uzBLA1DhrOrnMkkw8=;
 b=bpH4+kTFiy98MSc7Lc5mbqCW6IGujYOZDZ3kwP40Vmz7YB/3vGPDTl7sCu1s6QzxN8VUBSesYUGqvLLjleangxcI7KoRvqGfRsO0G7oG/ipkogwCyAAOOkevhGbn/f6R66i3Ro0OU+DVU7YgQDOPlZ6ppEG4X9tyz+AjK3JtHv1DQTVYEbrG5QOLymE0QdlJhErBreZ+w7lj+3V0mDn1OJFjlzHm134iGMhUvl+YDe5x2Udvo0TcIWJ1CLBVyCClkfNMmdL+C+93WvGd3vPOG1/OSQJu0pbRSjbZmSAzY3+qfa7VBz9Je6YdP1F6x7UlmXb6+QxYDSiUmTdiTBhq3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DUZPR04MB10037.eurprd04.prod.outlook.com (2603:10a6:10:4d8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.41; Wed, 14 Jun
 2023 07:27:20 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Wed, 14 Jun 2023
 07:27:19 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] selftests: bpf: Add time metrics for sched tests
Date: Wed, 14 Jun 2023 15:27:05 +0800
Message-Id: <c369b42c70b6c7a0c7d534ab3f4872af3ea8868f.1686727613.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::8)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DUZPR04MB10037:EE_
X-MS-Office365-Filtering-Correlation-Id: ae4360ee-72cf-4422-4193-08db6ca8c940
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pCoH61k0mFRUj9NB11xihAC1bb8+QNGReqYIwgxjPJmOPBdkEFEG7PxvKfbTOZlXcUQBKlyc4pz9NG0DqBAeIG8RjyiS86NP8YuX3MKkhkk37iSaEGtLy/xwhmGyTGBT7Y27zuFVVtdiXH/VVT0fdjAusjzgdNgJKcSCdWwQy5aJa/WgzCP8EH2N5LiUVvSPQdKukcE9HEvjL3X45xSFhB3uAlXFwr0IM0wF09mgQk4gRhnnRg05uPTwBy0fPgx0fZxr+l5mgylV5ILOkY8P5Hx/MlM4B48gd/36qlrmAl54AxRs/y0nMXtCGcjRv9fF4sROAZgbQ9n/hPXLnpJVubB7aQD0bPSxbiBBPgec9C0nMau23surHXzeG93b9af7K8xgLT/Og27JZJyFeJ/KESSQCD2Uuz4Ny1Sg/2hTnSFofPLx95GEInhewskSlnhfX5xdXNcHh6UtuuRhLbqjbgN+yJlHSKpK7CFNrznafwWZRxiJ+9JLmieWQ2V/9HtAPnY3JFcWFmEWwdw10S3INDbHsLfSWpH3vwKyNg0C717HZzBvb2Uz6nyTbW3GzbjE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(396003)(376002)(346002)(136003)(451199021)(6486002)(478600001)(45080400002)(6666004)(36756003)(6506007)(186003)(86362001)(2616005)(38100700002)(83380400001)(107886003)(26005)(6512007)(8936002)(8676002)(4326008)(5660300002)(41300700001)(44832011)(2906002)(6916009)(316002)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Pn0ISUBAOOEyy5q1Wccutv62bBANPjbYT1iFtNUnA3mhgIbJUlUp7c4eukQs?=
 =?us-ascii?Q?FuKfFUBj6NPFPt7g2NXrEYPNsxfAIKeXE+xBUpcFRvwW9Th7VMMhtGLb+wR8?=
 =?us-ascii?Q?UlhL5eaExB4D+bXFXxoqp9oWnkjQIZ7Fg3Fq2yeHxe2nrMigKs6YUUjqJ7xg?=
 =?us-ascii?Q?zchO2K9zeIlHUjZM+kbRRDXY+fQ+NR03tiYb7AJJ8CTgq57UJIXHvd9TKZm+?=
 =?us-ascii?Q?7RqClygbvrnbC9X1jepkvJtADZIUDGZYtsEvU5rNFaOcEiAiL3EGh2rh02Rj?=
 =?us-ascii?Q?G3NkVjd/2d7O5O5IkyPxcbQdUl/LbK0pTJ0c9OKX+jOaOdh9BEGBM0vaOKL9?=
 =?us-ascii?Q?n9jZJevPBfY+pXaWndzLS5h4LMTW9v4tGuxbVQjegwx9zaOjagdttBkno+GS?=
 =?us-ascii?Q?fiCegMbzQjd37aIbv7xd00yQ0QdjR13jmgJjRvOXsxFlo6juGJHojMuf5QZu?=
 =?us-ascii?Q?THfLnuL4T72TX6n8vpx8yzNVloLQlmAl2G2jI+hP5oNwUOXQsFY0vWkuhPbW?=
 =?us-ascii?Q?+GAI7Uo+PfUTv/PbimCbg4aWP1mNnmiCPeAsMk+1Sk93Z1NKvn1YjaZ7biI8?=
 =?us-ascii?Q?p1DDjl2c4qFUQMrwe9duDzGp0Hb/1TE9oX9NWUuvuZFWVESzAaxrqG58A+H4?=
 =?us-ascii?Q?ZppwRUI42B+5pMavrcs3ObDvFCmr63q/u4b7gFi39UvQUy0wNHGLJyHDTlv/?=
 =?us-ascii?Q?6Aun9OoqNdGFZMuLJBAF8cmhN2pcf0LY4ToRhKrNkpThyihMUmzF09gqVywa?=
 =?us-ascii?Q?B8AWRTZY69tPEcwbtv219GTJDjddrFsKdTZScvvXwAbQwsXIqS5JMpaEogw6?=
 =?us-ascii?Q?1hqlTevUv+OMu6XDb8A/i0MoGTJr+IVwKLndLHdvHgmxSisYxAv8PFpBUdp2?=
 =?us-ascii?Q?l2ebwzVcsTg/FjRLfeEWW0S3Vkqrjer9BMWchnO7rfYP0OSZ4QSade4/Ea3S?=
 =?us-ascii?Q?AYLw8VgjnZtLYpZpduabbbVD5Zjn1Omjp22VH4V5X1Y5udusRKF0hronFOlL?=
 =?us-ascii?Q?bArudnThBiVKc/k9UjOUZh5FNOhSc1pLzLF+Ow0frVrN+pM79dRkdN0F+dve?=
 =?us-ascii?Q?m4rDwFfh7+iYSCrgCE27CEL3Rh7QgsNA1bXivbvNqy9q5ZkHDm8NpH0iQNkV?=
 =?us-ascii?Q?QbIcjvuKUwY/Jvj9riEnki1iQdw3spIDj/BAZr2EhJJE7667x8QexRzWjTfk?=
 =?us-ascii?Q?TKnG7/whorp9LJxyphXGE8PspT+V2i7bGy5Hhmfx0Is1eFoKRFqR09kkFiFz?=
 =?us-ascii?Q?43c3kdVx7BKgZzuQxHgpsjV0NtkGJXXBs+8oap51zJczz+kSHhE/RWbHRwj2?=
 =?us-ascii?Q?TbhWIdkxpIRD39cSAODW9C1NSZhQNT1esBPekYDCamb4HtA7mvLM6KiJdZ30?=
 =?us-ascii?Q?ldQA1O0UNAX4SJRIV0WBzB7ovlN7nH03QqrlMre2bzSMsLKdqTO9msnKspnC?=
 =?us-ascii?Q?sj/r1JxF+4Y3MfGpD5WRr6Ied9snJF/F7ovsHJOdZARIl1wTdwh5Cj5NrFUi?=
 =?us-ascii?Q?JdaZfq1KEdH77ByH1Mn1Kx5s+X3FtxM/vNi0KJPSvvG9KaRALClwUD34BWl+?=
 =?us-ascii?Q?hUl9o9dZysfS/2SBtiReZCIQq2sfxn67NWqZFHWU?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae4360ee-72cf-4422-4193-08db6ca8c940
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 07:27:19.5119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F7rZ5iEFg1AeXLl1OubSc3zgGwtVmsNsu51hTN1SM6xfteHqItrAbdAPcMm5ZJ1NQp3gcpufxCvCyyPp0/v0jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10037

Add time metrics for BPF tests to compare the performance of each
schedulers. Add a new test to use the default in-kernel scheduler.
Run prog_tests with '-v' option can print out the running time of
each test.

This patch should be squashed into the existing code.

Depends on:
 - BPF packet scheduler updates v9
 - Squash to "mptcp: add mptcp_subflow_ctx_by_pos helper".

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 49 ++++++++++++++++---
 1 file changed, 42 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 94b7624bdfef..1ef74b9ee141 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -3,6 +3,7 @@
 /* Copyright (c) 2022, SUSE. */
 
 #include <test_progs.h>
+#include <time.h>
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
 #include "mptcp_sock.skel.h"
@@ -249,15 +250,19 @@ static void *server(void *arg)
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
@@ -274,9 +279,16 @@ static void send_data(int lfd, int fd)
 		bytes += nr_recv;
 	}
 
+	if (clock_gettime(CLOCK_MONOTONIC, &end) < 0)
+		return;
+
+	delta_ms = (end.tv_sec - start.tv_sec) * 1000 + (end.tv_nsec - start.tv_nsec) / 1000000;
+
 	CHECK(bytes != total_bytes, "recv", "%zd != %u nr_recv:%zd errno:%d\n",
 	      bytes, total_bytes, nr_recv, errno);
 
+	printf("%s: %d ms\n", msg, delta_ms);
+
 	WRITE_ONCE(stop, 1);
 
 	pthread_join(srv_thread, &thread_ret);
@@ -317,6 +329,27 @@ static int has_bytes_sent(char *addr)
 	return system(cmd);
 }
 
+static void test_default(void)
+{
+	int server_fd, client_fd;
+	struct nstoken *nstoken;
+
+	nstoken = sched_init("subflow", "default");
+	if (!ASSERT_OK_PTR(nstoken, "sched_init:default"))
+		goto fail;
+	server_fd = start_mptcp_server(AF_INET, ADDR_1, 0, 0);
+	client_fd = connect_to_fd(server_fd, 0);
+
+	send_data(server_fd, client_fd, "default");
+	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr_1");
+	ASSERT_OK(has_bytes_sent(ADDR_2), "has_bytes_sent addr_2");
+
+	close(client_fd);
+	close(server_fd);
+fail:
+	cleanup_netns(nstoken);
+}
+
 static void test_first(void)
 {
 	struct mptcp_bpf_first *first_skel;
@@ -340,7 +373,7 @@ static void test_first(void)
 	server_fd = start_mptcp_server(AF_INET, ADDR_1, 0, 0);
 	client_fd = connect_to_fd(server_fd, 0);
 
-	send_data(server_fd, client_fd);
+	send_data(server_fd, client_fd, "bpf_first");
 	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr_1");
 	ASSERT_GT(has_bytes_sent(ADDR_2), 0, "has_bytes_sent addr_2");
 
@@ -375,7 +408,7 @@ static void test_bkup(void)
 	server_fd = start_mptcp_server(AF_INET, ADDR_1, 0, 0);
 	client_fd = connect_to_fd(server_fd, 0);
 
-	send_data(server_fd, client_fd);
+	send_data(server_fd, client_fd, "bpf_bkup");
 	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr_1");
 	ASSERT_GT(has_bytes_sent(ADDR_2), 0, "has_bytes_sent addr_2");
 
@@ -410,7 +443,7 @@ static void test_rr(void)
 	server_fd = start_mptcp_server(AF_INET, ADDR_1, 0, 0);
 	client_fd = connect_to_fd(server_fd, 0);
 
-	send_data(server_fd, client_fd);
+	send_data(server_fd, client_fd, "bpf_rr");
 	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr 1");
 	ASSERT_OK(has_bytes_sent(ADDR_2), "has_bytes_sent addr 2");
 
@@ -445,7 +478,7 @@ static void test_red(void)
 	server_fd = start_mptcp_server(AF_INET, ADDR_1, 0, 0);
 	client_fd = connect_to_fd(server_fd, 0);
 
-	send_data(server_fd, client_fd);
+	send_data(server_fd, client_fd, "bpf_red");
 	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr 1");
 	ASSERT_OK(has_bytes_sent(ADDR_2), "has_bytes_sent addr 2");
 
@@ -480,7 +513,7 @@ static void test_burst(void)
 	server_fd = start_mptcp_server(AF_INET, ADDR_1, 0, 0);
 	client_fd = connect_to_fd(server_fd, 0);
 
-	send_data(server_fd, client_fd);
+	send_data(server_fd, client_fd, "bpf_burst");
 	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr 1");
 	ASSERT_OK(has_bytes_sent(ADDR_2), "has_bytes_sent addr 2");
 
@@ -515,7 +548,7 @@ static void test_stale(void)
 	server_fd = start_mptcp_server(AF_INET, ADDR_1, 0, 0);
 	client_fd = connect_to_fd(server_fd, 0);
 
-	send_data(server_fd, client_fd);
+	send_data(server_fd, client_fd, "bpf_stale");
 	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr_1");
 	ASSERT_GT(has_bytes_sent(ADDR_2), 0, "has_bytes_sent addr_2");
 
@@ -531,6 +564,8 @@ void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
 		test_base();
+	if (test__start_subtest("default"))
+		test_default();
 	if (test__start_subtest("first"))
 		test_first();
 	if (test__start_subtest("bkup"))
-- 
2.35.3

