Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2082.outbound.protection.outlook.com [40.107.6.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A56803
	for <mptcp@lists.linux.dev>; Mon,  3 Jul 2023 06:40:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2BygcxQbVsUUE18sYi3rTHmAnPEcN7rH7fvCtCIuiHzBW670YLnK0SeyooKScSY7LxDNFjohMVnzpb4uHmcEDpIQMi0PZGq72pNgt+Fu3oCW+s7njctHL8UStwGdGBiDr8JFBwjUrUKDJ6GbyllwPx91XXTaUoGyW6Nz6L4u2xBkhg3jk6OzyExHpLNW5gd/u/InQu6nQGRpzZ7nGI7nWf7si0tce4tY4kV7UVw3rxQhHvo3M1WTmzyN6W6e/lrlxGIfd0sMLhr/DDIXuLQ8ajEHH0Zl4pvHBwiHnGZJeP9BDhpBKI3t4Z+Zj/Cd4agRwCu71m3pL0/Zx7QqK4iWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9UEtpas2l98HCoZRgueIDtGoULD5dRKZzMUnJUl3z/Y=;
 b=KZ5N3WnhYQskHOPkUWIuBvUtG2awuwdvSyVKg853ER3IWg+9MPEb1JugyKprrBcLxyBoS0TvejBa5tz8OjHERqlM/gDpJ/9Lur5wvELLsIcnrG4IlgeWcFz6sfhV7pFayVue8s0XoOtuWOfLYPz/RSZXLP8gnFDCQWaz397zPIJYUjbsfj8bAU94LyYAARuC50PDgn1Spl+8kM/MXQU2XDYFnj1IkXFHRKZDdoTbFanQaRGiVC7sy4c+vfs4n4xju/8HJ1PZQkOqXvsWfge15NEZqxcl6E/GAaurP3HEWafJBBXZYiFy0Lz9miLTR99Y0ERVC4yOx3ABOfuRgkGyuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UEtpas2l98HCoZRgueIDtGoULD5dRKZzMUnJUl3z/Y=;
 b=L3grCImAPs3yDYlEKRs4MLZxYqIg0IAKJCdbE5A6i540w1+WZTfDVVPeb2HNHidyA9R/kYVRnCutzpyL+VG4qECg0PfyJn9XPdXOPM89RTf2lvnzoOrSM9FsXcjt36l9fQJT4m3aYQopKUN59fic39/SLejg7iXsn2F4jpjYTBr1ZuGM9VzBbL5b8wM3QiazMLN2ZX506NsBvEO45I8pXM7U2hox/7iPH1fV2PoCoadC59Q+7+495eGKJTgIn5G+n7WwOzJtoUV0h1oe8R5+u2JWpTnmx2ngUix10QvVtlPjMcu7TdqtF96jco5hkkkcooFb/Hs57co/52GnZdVnWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB9524.eurprd04.prod.outlook.com (2603:10a6:10:2f7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 06:40:40 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 06:40:40 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 5/5] selftests/bpf: Add mptcpify selftest
Date: Mon,  3 Jul 2023 14:40:00 +0800
Message-Id: <e8796c911cf43d2d27c7d29d152bdda8de3dd284.1688366249.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1688366249.git.geliang.tang@suse.com>
References: <cover.1688366249.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0011.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB9524:EE_
X-MS-Office365-Filtering-Correlation-Id: d8f6aaab-e093-4a25-81b0-08db7b906ace
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RyQuedZRFlFJDkYKPGbtLfmD4AO8yRxdJzVr4orZxFOgb9cXgVhq0ikjPbv+Y0hHV86G8hX8s3fdeNdXYrxKsTfqnPc3aAb23Al9lxGTokjvGzjvDk/rrrsl3aVT/lLO1e6ZHWj8U19EH2EYcY6iAxhMo/cZ/GOACXKKzYmyiSGIidzGp1oLIBynenv3ktv7o7Ufig7A/1QBLfipz43b24xTaPpjQiTgZwJ5At6lJ+Gb8unNixVXvBCRYTYCa4V2vZlUKFlDsnMJyXUWQ59WlFRxKV+UkTqlNJx8ZdcT0WnDbgeZccLM/hHKaWUJdy0M7vAve8jLzJDBjuGlz4KVkbu1eX3poBybmdbNoHTdZC+72G6S4DmHGekjvQft1NvKFW8AIysTBc2kYXYjKXTxDQIVhqlnmtBzI8EdSs9pbkVxDxm07VivVcmvz6MSyvwlGmsR1UdkAdHIknWTR6uNRvqmCH4R7OahE65wP1vj2aiu7ajP3O8H8qsQGeb7b5qWn7pomSPbLfpwM/zoDeXCjOFNID0wkzfqqnA30tyaEqpanasnySbP0KsdPf8Uze82
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(346002)(396003)(376002)(39850400004)(451199021)(6506007)(6512007)(316002)(66556008)(66476007)(38100700002)(66946007)(6916009)(4326008)(107886003)(2616005)(83380400001)(186003)(26005)(478600001)(2906002)(8676002)(8936002)(36756003)(44832011)(5660300002)(86362001)(6486002)(41300700001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rlPoI0rchI4z2+98KUNg6CciSgS/blwvYJODCDxxru0W1hbltyWNyWq+lx0B?=
 =?us-ascii?Q?vJbwJai1Mn9+AQ8O2+oKp7g0F8s5RsTyAzTp3PR3akKXOH3iNMbvxLfG3+PK?=
 =?us-ascii?Q?/ZLPvxGTlUlGfmAg9K1CMOHEI6d5Q0iKGqp28/B31f9+WKN2DdhW+bjd8x6T?=
 =?us-ascii?Q?GxOptCjkfaERinJmYpvTZL1LFLBkeUNjkZg3PyvcNJ51hdOxdr2m09oRsg0+?=
 =?us-ascii?Q?VBiK15jRSfkgk7FvntBYYz0oez100EHDnWtGoXcobql51taIUA4iwzwfY/ix?=
 =?us-ascii?Q?nmjfVt+/0kz06IzqpUGzRIEzaGUZ4JFFW/3RG9owunbG3Sc0hq0T5tkbBjm2?=
 =?us-ascii?Q?7Z/z5qm3SCXllD1xxfXisd67ShrbGy8KFx7OXnY6or/RPjphfJzM4yH8aN3f?=
 =?us-ascii?Q?0a7KfhQX1uvH1r5HppqztoPMK9SLxkz29qDOPzqE/VaU/QE2zPnovB5TRvBM?=
 =?us-ascii?Q?SGokfX9UAS+76uLeNzU0wAVZt0ihkUmk4Y1P9ijuy1CQLk3sJEHM8+syDCCH?=
 =?us-ascii?Q?ARVmzf+Tj11zD0WxjecgH0yixo6/EU3L/3k/497T42ghrgjKumYZ3DupN7vl?=
 =?us-ascii?Q?C1LeU4W7F36Js0OKsZ6xU9vs5v3XFqIUp26HrUJilfvFmlOsH8EjvLjDJ2Ry?=
 =?us-ascii?Q?yaX8JDvk/5lElReldmchjEC3ePwueTS9uRqmrF2L35G7TZFgFn4rt9j5mmQF?=
 =?us-ascii?Q?h7s2S56DuRHog3/G6CJ8ZTMA8LOWKHFNaF6FoYxAsXOXf5cISaT7ux8CQ1EM?=
 =?us-ascii?Q?taJwbsbBAhtzfJokZ5DJX7pv7Pyq+jPCqNCqS1omuUiQUqBhZ075KyT2dlgq?=
 =?us-ascii?Q?xEuRZAGTRQuUkGyKE+rghY0vlmag0Pk/4FAKwy1U4HPxOAgI9szHqDYzc62Y?=
 =?us-ascii?Q?z9m0taaFNYxavzcMXHXfari8/Dk8H/LuLFg+VvFYyEK0jFEpyem8bpHLBZ/c?=
 =?us-ascii?Q?pj9R6OnkLAP3Oa/jBDnIX7niaWKsuVCKdfom95SRkircVisIDMWfkrv6Sypq?=
 =?us-ascii?Q?R83UDz04UIZTZcm6WSofRkBQkEIwriVx7toyMFsrTF5NaPtQYp4VNm5qC8Xs?=
 =?us-ascii?Q?JFc6+CFqSEj12YEBPcYg854ns8EotI7XeJUEByL+kMMhjty9YEFsAnc4GtLD?=
 =?us-ascii?Q?eMCFxc7CcM6wYogeg7EHzot0r9oBkNCSekCBl2gtJTgyVwPhYYD/hM55kTNv?=
 =?us-ascii?Q?JHiK/O+LAh18gAIfM92tCmiLk51X4GaW9KtBw+yH0CcASaVD0koom9ce/Aq9?=
 =?us-ascii?Q?P6n25Ijvm7aVPTr2bUebZ2tM3vRmDRcSCrcrB5MY66LX6wP+XvUrGO69IbTj?=
 =?us-ascii?Q?+cgL1hIdzS5kgdDEHpv6els0kNfJI2b+uSzuC/N16CU1E9ji0AJyvHOg7emz?=
 =?us-ascii?Q?QikEypRSfBogT/6O3JcQuvNk6It93kKLdF7z88D3FAXLMVfinch4m/+c40vZ?=
 =?us-ascii?Q?AmRyKMcwor78s7ZaM9+s7pgebFJQhwrpua4FtnbuXpt2fLC7zsoWOVBy4IvO?=
 =?us-ascii?Q?s9gpzBisx5geiojrpCZsdhrePbspvwWcVf/cLlXVPvdmeRC7nFZTELKKIqIb?=
 =?us-ascii?Q?eo//uCGUiitlZpM/+Wc4tkuwZ2dbfz6zCaKHCE2G?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f6aaab-e093-4a25-81b0-08db7b906ace
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 06:40:40.3624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZlsBuW/ouKudQQAxjyrEYr4/ZiIUYJs4vL5FNrWIwu1CixHGzrNJObgU1ZnNqPURP0G0vZeW4cAZSEpm8iLpPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9524

This patch extends the MPTCP test base, add a selftest test_mptcpify()
for the mptcpify case.

Open and load the mptcpify test prog to mptcpify the TCP sockets
dynamically, then use start_server() and connect_to_fd() to create a
TCP socket, but actually what's created is an MPTCP socket, which can
be verified through the output of 'ss' command.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index e430bebebcf0..ac38d473329d 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -6,6 +6,7 @@
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
 #include "mptcp_sock.skel.h"
+#include "mptcpify.skel.h"
 #include "mptcp_bpf_first.skel.h"
 #include "mptcp_bpf_bkup.skel.h"
 #include "mptcp_bpf_rr.skel.h"
@@ -200,6 +201,90 @@ static void test_base(void)
 	close(cgroup_fd);
 }
 
+static void send_byte(int fd)
+{
+	char b = 0x55;
+
+	ASSERT_EQ(write(fd, &b, sizeof(b)), 1, "send single byte");
+}
+
+static int verify_mptcpify(void)
+{
+	char cmd[128];
+	int err = 0;
+
+	snprintf(cmd, sizeof(cmd),
+		 "ip netns exec %s ss -tOni | grep -q tcp-ulp-mptcp",
+		 NS_TEST);
+	if (!ASSERT_OK(system(cmd), "No tcp-ulp-mptcp found!"))
+		err++;
+
+	return err;
+}
+
+static int run_mptcpify(int cgroup_fd)
+{
+	int server_fd, client_fd, prog_fd, err = 0;
+	struct mptcpify *mptcpify_skel;
+
+	mptcpify_skel = mptcpify__open_and_load();
+	if (!ASSERT_OK_PTR(mptcpify_skel, "skel_open_load"))
+		return -EIO;
+
+	err = mptcpify__attach(mptcpify_skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		goto out;
+
+	prog_fd = bpf_program__fd(mptcpify_skel->progs.trace_socket_create);
+	if (!ASSERT_GE(prog_fd, 0, "bpf_program__fd")) {
+		err = -EIO;
+		goto out;
+	}
+
+	/* without MPTCP */
+	server_fd = start_server(AF_INET, SOCK_STREAM, NULL, 0, 0);
+	if (!ASSERT_GE(server_fd, 0, "start_server")) {
+		err = -EIO;
+		goto out;
+	}
+
+	client_fd = connect_to_fd(server_fd, 0);
+	if (!ASSERT_GE(client_fd, 0, "connect to fd")) {
+		err = -EIO;
+		goto close_server;
+	}
+
+	send_byte(client_fd);
+	err += verify_mptcpify();
+
+	close(client_fd);
+close_server:
+	close(server_fd);
+out:
+	mptcpify__destroy(mptcpify_skel);
+	return err;
+}
+
+static void test_mptcpify(void)
+{
+	struct nstoken *nstoken = NULL;
+	int cgroup_fd;
+
+	cgroup_fd = test__join_cgroup("/mptcpify");
+	if (!ASSERT_GE(cgroup_fd, 0, "test__join_cgroup"))
+		return;
+
+	nstoken = create_netns();
+	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
+		goto fail;
+
+	ASSERT_OK(run_mptcpify(cgroup_fd), "run_mptcpify");
+
+fail:
+	cleanup_netns(nstoken);
+	close(cgroup_fd);
+}
+
 static const unsigned int total_bytes = 10 * 1024 * 1024;
 static int stop, duration;
 
@@ -459,6 +544,8 @@ void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
 		test_base();
+	if (test__start_subtest("mptcpify"))
+		test_mptcpify();
 	if (test__start_subtest("first"))
 		test_first();
 	if (test__start_subtest("bkup"))
-- 
2.35.3

