Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2049.outbound.protection.outlook.com [40.107.247.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A3415A8
	for <mptcp@lists.linux.dev>; Thu, 29 Jun 2023 02:12:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F79/ehdakJ1S4HFZEhtxRoosCO2qIQ9CrT2sqxRFpbyja7dKDrQpLtmo9P8OTkdD3LGCuM6nYKP15FLG9wsS7l5UnLYaoQ4VCJeoJt3MEhpqmdgY+nofZmjQzSc3EC0EVNtg8Z9IpnIGjeTAwZV9nVPv5j5ulWiqOuNHFWkqjoCFuOs4xzAbZpocHinz84x6v1wY559EeEM4Hknl+noy1LAXpYyxLdxlBI1OxdQpgZUPMVyEOoIpZuN8X3yGF8Ti3IvnhfNtuOC+oGgugkrtQhYKJHQkHeKBiI8xWTWsHKKpo/ZEsFMwZwAEy2oSkdeM1e2UonBUAS0d5J271h6pcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aj8Khvm2MFLUPALt6R/mkZVAmoZZ8mRJ8n/jSKaIfi4=;
 b=TwDH+MGf+3SJyeODpLvvgh6YRS57kSYE55vAcIW6PPScwW6HY+b73+2pjoh6rDnVOUNSmniKVVlQUTBYpRzBXPSrWn+q7hi7b5K9ARBA+ikle8tAub+NirrdkaBfcd4e32O0CgqV2wqurI5h1/YTimrtmKP2NVrns+h449qmxHG7z6K8AG0bJ9sOGI90bWhUYf17iz1N6IGULiQyB4NqWpYDsewxPYiwq8KMhPQCsdkWDPrhHe/V3EWBrDDQPgrLtmXbeNWs4YJMLjyavM/Qv3BkN625+KmHfLoKt61n37xPUAGo2CYwmJaZE41ypzdRQXxNPa60E07GTPajlxujcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aj8Khvm2MFLUPALt6R/mkZVAmoZZ8mRJ8n/jSKaIfi4=;
 b=QKhqBIFNcl2DOK21485sJ3iy1cP2HhvCNkGhUhMrv7pc3rGRQmRhJlazWoggupbnkmGX9zTVjirLdoQdvYYpiGWrwzIDKMylrUGU3E9EO29y/g2EFZTzw1GhJJWNTN/nSOmlmQMWFrd0QHXqjNE8JLtjJq8NXmWk3fOWOqwJ+Es064VC2/hFNKKgF/gtA/cXqyq7y8Hhbh9dwj23IF+++xidJOE8z5iKZSEvtK5AFTGDyWJqQ4qFDRZqw/RPdOSYZDCbkcbsC9BVzol62frgPxczyckcTD28+gB2/aPWA5a5H6NHlQSxwFn0stdp5hsKGaPjWKbUdm+1fNYa3M84nA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB7049.eurprd04.prod.outlook.com (2603:10a6:10:fc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Thu, 29 Jun
 2023 02:12:48 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 02:12:48 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 4/4] selftests/bpf: Add mptcpify selftest
Date: Thu, 29 Jun 2023 10:12:17 +0800
Message-Id: <5276902ce9c5492bd2029fc3b46bfcb927afb18f.1688004307.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1688004307.git.geliang.tang@suse.com>
References: <cover.1688004307.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:404:15::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB8PR04MB7049:EE_
X-MS-Office365-Filtering-Correlation-Id: dd7d33a3-d9a7-42b9-8dbf-08db78465532
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vqDBxDGYBMTBarVEDXQJdiJOHkU2drDtKvaL/+7KWimEKTb0yveL65EyjISDChaixAmLTJS9irIK39sVp34JnBVh/9INeGi+iM8igrv7DiHu3wxlgGlm2fBFjKQa9KJ9GA7wW0adeQ+EKq+yr+RyPubk8hyqUElOrGpEJbh51oRtD949lUGFtsXS7nedX8HukAhjrx3mwKX4l+x2uQO82ymeTInn8VSmq5nIgtFv7XfgwZygKs+L87ufjff3UZP/A+0ODb0H+4S+YUdyyzQg3F8fDMatABb5Hj8BB2DkHs6KtXfOg0oZ3gvTUSauemiKpx3zLPfksK6nHB8DBQIKiVH9jfND+LM/o0tb7RANfALQzwQaUhzopqoqVrfRVceeC0UR3FLgws12p7Dix29wznbggkGfudmZ+zZS+1CtXkOQGmuDgTaML8NEMNBlANmMCRv5mUFuLTnAPVunjSZ9x6jRBF7alXLg4e5M0aTasMCTJbMINFfP8tGPxgCxRfbHUreEAMmpsls9xV457ZSe/qA4O+n3iDzuUfUSXLGzlG5bPBCY8j2kgerqkhnqc20Y
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(376002)(136003)(366004)(396003)(451199021)(6506007)(26005)(107886003)(6666004)(6486002)(478600001)(83380400001)(2616005)(2906002)(6512007)(186003)(66556008)(5660300002)(41300700001)(44832011)(66946007)(4326008)(316002)(38100700002)(36756003)(66476007)(8936002)(86362001)(8676002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?or2T8Bp04DCQtluUPkTm8dj2PcvJdBj6EfpdLDjF8ixzKBmLxW1/eSz/oMpz?=
 =?us-ascii?Q?N4hdHkJQSw6F1OaIra1KfWZ7FTCzTmkJzYmgLm3bbKKGJAJvqlihYMVumVYC?=
 =?us-ascii?Q?v8btQY5cfxlsNiME1DCOCX4vhGG+fh6xy7jBvBaKnyrHqQUK6cmmTMre+n3d?=
 =?us-ascii?Q?gEuF8tDWAmpjbr+ALdJgNyHEiYUUFlD1kqEXDP10i75OL3kApASSpkVr5pF+?=
 =?us-ascii?Q?uZ5Zmoap88VjRzUy+hV4PCkTWiSdFLIhfG0XNxY+hqXa9RYxPkYKxFzXg+4n?=
 =?us-ascii?Q?KHuO4rPNSWMhNBWVvdlCLiuDgu145pC+WOiZ7wSLqHLsn+RsH3E3X+WwUUSF?=
 =?us-ascii?Q?hQyPIT5R13bqhS3SrHc+FyPEYDrHrsml1WNwuCqVj7Sq/Cd3JtMuGz6/WUTK?=
 =?us-ascii?Q?c7kUya5TzDMLZUJhTcnggkNNwVzJFVgiQlFWfHyci5iejRFCTGKqtCqAHSGG?=
 =?us-ascii?Q?ZwPHufwRW89rUz9CN1jkFzN0mEOBs+TdUr1uQ84eI/tL6zwLDzpAAfMDrNve?=
 =?us-ascii?Q?Is0FvwcNcQyWp68uJUWIP63MIdXw4pf/ROtjk5LshMtTY64NvdNAdXEh9JDy?=
 =?us-ascii?Q?POCJqnJexb7mNcS3NOO9nyhzh9oZFSCFRS3Wa1eC5AUMa0Lf16IZ97DxftQE?=
 =?us-ascii?Q?fOeL86yVh47QRLiraFR4NlZHXnEujixQ3FbdG/vpNqvXjdUh9wLuU4HiLmjI?=
 =?us-ascii?Q?1NygUj33cVEtznQh1lsZo8mz7Suf0LMjFvJrYxyN4QwHjDwuo7phk9+86WT7?=
 =?us-ascii?Q?NCm1UEs0fc2+DwELL9cVzWxgQE3lb31tqdALXNXEHAyfuwFShxoyb+lyBP/V?=
 =?us-ascii?Q?Z4FirK1QsC1ZugZi4XyKNqrPEvzkAr5BPk0dwgIJradpMNE4I3oiUZ5X9fVP?=
 =?us-ascii?Q?zkA6v4OyrMluD2orDyiJMJaleKLK+O/Gyh+WtWFY8bznoMeQGGzm85MO4z0w?=
 =?us-ascii?Q?jY+XSIyWt5r+MCA+C1Gez5ssoxzYE+5CtmRWDCWloRYiqiOZsRfI6q+5smId?=
 =?us-ascii?Q?GRVn1omS98qRFQ4mADXce2I2WTJZs8PJC5Dqtnj+hSeDDevwIgc3jUs9WeyD?=
 =?us-ascii?Q?BimA3Sm+E76zlvmEqzZEEOYs2yeVcdZk7BBdDvKUGock8xO7MXy3DoY73o1Q?=
 =?us-ascii?Q?aFqSoYfQ4UwKwp25Ipf7lt/s5McKGwlHwItxq04qDTzGPCUDv7om7nYwaI9Q?=
 =?us-ascii?Q?YuRLeV1ujnLmB7O/9m7rSNeijmVdXrKLGDkyzQyKN7gAHDPjwpRG7lRSiXYL?=
 =?us-ascii?Q?Bx6OTEJAKJWDXzoenNYcdFk1Y39BNHnoG+Xi2HKyzU6ZfwOceiMnWTXRzDKh?=
 =?us-ascii?Q?5JrWvDnyKfJyEUf3rZQ8ss7HXoQuL6W0/mi/Si2Ek7OmFyyVpSuLpV6g72Qa?=
 =?us-ascii?Q?MOZg32mT3BA6C3yjUIFNLb/T529G8gMPL5vZhHGbsdxodPwcQRLpLi9VEP5z?=
 =?us-ascii?Q?O2ZGMBCEP3KgP7Elv87a+cnIbdYlj9EobYhCxN/EriSi16/K6Vd76q9WiHtj?=
 =?us-ascii?Q?Y78SeGco6qSnem74AQjKxr04Qg7Psxy9hfUGC1ZuqijetJpo8dXyg17rMhJ1?=
 =?us-ascii?Q?UsnfzSdFiKZDoq2mnRTYEXnvULUnHCcy14LPtL+g?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd7d33a3-d9a7-42b9-8dbf-08db78465532
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 02:12:47.9405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /PuQ+ue+3iParIhxCR1lKpUVYBJJTs6XbUpNp3CPGB8eKCIU4psLMnKuwf5Bu6xnDwohFVovjMm1ZJ5wF3kVyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7049

This patch extends the MPTCP test base, add a selftest test_mptcpify()
for the mptcpify case.

Open and load the mptcpify test prog to mptcpify the TCP sockets
dynamically, then use start_server() and connect_to_fd() to create a
TCP socket, but actually what's created is an MPTCP socket, which can
be verified through the stored local BSS variable.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 83 +++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index e430bebebcf0..4057ff07572d 100644
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
@@ -13,6 +14,9 @@
 
 char NS_TEST[32];
 
+#ifndef IPPROTO_MPTCP
+#define IPPROTO_MPTCP 262
+#endif
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
 #endif
@@ -200,6 +204,83 @@ static void test_base(void)
 	close(cgroup_fd);
 }
 
+static void send_byte(int fd)
+{
+	char b = 0x55;
+
+	ASSERT_EQ(write(fd, &b, sizeof(b)), 1, "send single byte");
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
+	prog_fd = bpf_program__fd(mptcpify_skel->progs._sockops);
+	if (!ASSERT_GE(prog_fd, 0, "bpf_program__fd")) {
+		err = -EIO;
+		goto out;
+	}
+
+	err = bpf_prog_attach(prog_fd, cgroup_fd, BPF_CGROUP_SOCK_OPS,
+			      BPF_CGROUP_INET_SOCK_CREATE);
+	if (!ASSERT_OK(err, "bpf_prog_attach"))
+		goto out;
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
+	if (!ASSERT_EQ(mptcpify_skel->bss->protocol,
+		       IPPROTO_MPTCP, "unexpected protocol"))
+		err++;
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
 
@@ -459,6 +540,8 @@ void test_mptcp(void)
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

