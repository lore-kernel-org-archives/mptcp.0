Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2055.outbound.protection.outlook.com [40.107.241.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2610817C8
	for <mptcp@lists.linux.dev>; Wed, 17 May 2023 04:33:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fcTu6AaO+/Xvo97Ao0kuMqgeSnuTGTrKLqb4OZYrtXXeIMPRwj1nXgRfzZgBvkA7g45lbbDqtJTrhCz8CtXfEo+fJCZlNdA8rafLbA2CFl7vzUYQUaVaKITVpul2jrxkGzZTZruZI2uhoJF2VZ8ehB3+OE9g/LGRb8gMd9EwIYFojz1V8SduDWKuhog1t5JK4mbTff6AH9Gx1UqWpG7DWTnQytnSE9g2KCvWAyBk9PXWKqolnDKaINlYOjVNCtwD72r2eienywgeVnjiDXW8HhTa5iP9ri0ATGeseY6WY1xG5MujV+F17G4nSXcCm7/C7Ir8Ie3HoOzgmmTEp1qjXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WM7Qp3/V0jlHMNaZsd2F2kxF7tl24Z35g0SSf5rmu0k=;
 b=XqrndtPetdMkxm2d9GchsO4pM8m4zHK1cv2jQ9sbeK7aSk/FKF6vCjsZPOgcXW/duYplZ9kSiFgIJqzJcu8C9VxsSfvvXKykTb/2dvN9OhBdto2lWNM78IZNQqokwNmXfGfdJkwIGILJ2f3PPltO8lvoCK/tvZHHCE2NqWR4AEF7okKOLIa+7ZaE6f9SZ2Hw+klQmdgbARec/fu6Wx7HsyJ5cHony5lAJloBvzFq9EXUl2M5aS03CaNE2s2AyHQLdyc4TcECOglbJlVNfzaD+hf2cVGIOFGbj189HWhrolUtdHilEtJfMWn7rL7sI8w+4r+xtguQ97LGEirxrZSkIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WM7Qp3/V0jlHMNaZsd2F2kxF7tl24Z35g0SSf5rmu0k=;
 b=XrDSquI3LgZJCBt8w5/TCwoXF3CouG8fPGBbgyXuf1eYxmaxEpYaqzDzd4F5RL4fwwa7cxjQDNeD25IqLwbNoJ8wlxDq1TO2yvLYX5k+Eqv8RU/BztFif/BntNXcmKzvw5EAHcswZwyNXqbGfYOo6UUYhqwKsxJvbXTepF7YZFEdfzLxjd0PCeCo4StZwbEMyukgDDHDKB96MlFEJXGrXKFAqhabykLA3r9MlROiF8IJiliq5r+XLg8a/+lSmVyMqrb4uA8m/nKGvIRtuT368AiQHBmnBk+6ucUXBRWC8bkPZP5hA/tO2e/0ctmFMvCXKZaDIwv1cHyPUnyIiBZvXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7657.eurprd04.prod.outlook.com (2603:10a6:10:1f5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 04:33:10 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6387.027; Wed, 17 May 2023
 04:33:10 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 1/4] Squash to "selftests/bpf: Add bpf_first test"
Date: Wed, 17 May 2023 12:32:47 +0800
Message-Id: <5ddd82f8a26cd37805ad9fdc23d16d936ab71813.1684297911.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1684297911.git.geliang.tang@suse.com>
References: <cover.1684297911.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0191.apcprd06.prod.outlook.com (2603:1096:4:1::23)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7657:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a242e20-03e2-4b79-537c-08db568fd1a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CxSIMA9EbXe+AueIZ4y8/dvjrsxdC2E3YFR1nfC/1yLTd5j9JZ0kTaWtAJ4V3xZGcieeeEgXPLUBw1BbTbejZv7enYi5lOYgpdrXx05chm7xhea+6wwKuZ42DBHSxR8F0fSIZhRW2pNdwbmpazvAxwDvAO5TFiY1s3PK+B2/EQWQKqMfJoXp9YG5Whp9p6/NemRvuDovwV34Z4ecqGmmLEF7Dcz95JCu7n5VFGhC8JoO+0dvciGZE6Iq1Udmt/Q/nJWI9Z077cUU71neU530etGSiy63GI5DsNvRPDme35N8voqJ1/q3wJyvv4mEPriE4CQZMzUSu+JUMNhezz4h8U0NyVODWBpzoL7HNvu6dcFQC/KLy0Wi8BCQXKwjyQQNNBcLYKBQHINr9mWZ/rDozaWVYuVSsAxIWN1D+onu2oXVaCvN995nnNJGCJa7rw2wJCAeREI+aYrbuFPZ1AegGir9KzYrESK6nmHOAHmpEcDu9H0I6X2NZpK1dzTJK8g96InB/xqkv67mc5n1vYii1XRubQw2N2oAUiEQ+A1iW5wvWCVXZBnGMPEMGuxnR6lf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199021)(5660300002)(66476007)(41300700001)(66946007)(6916009)(36756003)(316002)(6666004)(6486002)(4326008)(66556008)(86362001)(38100700002)(107886003)(83380400001)(6512007)(6506007)(2906002)(478600001)(2616005)(8676002)(44832011)(186003)(26005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eLsr6cQkQrg5LYZblmfbbH4juzKc4qeg0NBh7EJdO1/WZ7f5RuJFPZ1QXSSl?=
 =?us-ascii?Q?H2jOhcAnaMsPn0qZrRlf+jsDQnZLihkT5LzMVE7aHLuA8sV5+cpdVHyMSQN9?=
 =?us-ascii?Q?NTvSS4lw5cUbuAg+wOsBoTVFZbrUcMuT4uW3QWyNAb4LBHXb2JI5FQ2Bo3a0?=
 =?us-ascii?Q?sLKJslKkSJWyfc1KVamt+HgLIj2Eb0I2jK1kJkTQlw+P00t6AzFjItx9rZRa?=
 =?us-ascii?Q?UcqapleJIRHf8UCHGCMR7hiZJNdWj2vJx5Uqp6E3DPKhc/maC+FDWUmnOWs/?=
 =?us-ascii?Q?KgpXpZEQ4n88CJ0SPrw+N0iqQRHXdr+gN8yN62k12OhPxQ+qWW9BUTju2Sey?=
 =?us-ascii?Q?wu7lAQRtTQ7dljQiy/80YAnN+yjotpWs3SfyORTh8MK5AyuXe+YOMgQElgFJ?=
 =?us-ascii?Q?9AtNt9nSIiwp8/6faeMh+Ci0s8je1mKreEyISUNG2s7IJHkIhHdW7b1QTGsS?=
 =?us-ascii?Q?0WUJFHZo3QdcO0WkqXnZAo0upUhFqxe6L/WmxTGWkkDARE3TqzzgD6FbWaT8?=
 =?us-ascii?Q?5JCzLGO3cDTzQV+NVid2IRj+J6NDObcmLdOvzmWD2n57uH0Tzv2tsZlfBQyX?=
 =?us-ascii?Q?1StG2B807HkH0Q+bkQbOEOfAYjOVtCgU2QdFY/Gxm1+HL7x7gDB+EfKrI5eM?=
 =?us-ascii?Q?gq6u8VDx25QI2jMTBw0NTFbgYvn+0hUUhrhOJT24ud8QVcCfD65pC3T1dq39?=
 =?us-ascii?Q?/xdV0GNTzBCzFbtrEqxzwb2uNwkJNI/I41xsGxVUYoDQvRWKQdvcciipq/lV?=
 =?us-ascii?Q?jM6Hi8xPau8xd6ngnzPDD8EPehckaYsaNFgkrLX1G/jZRUExbcazBNmYOVb1?=
 =?us-ascii?Q?gzHNen/IBxkcgkmU/QwirkSu+mydXx/7W7ig77tRNOiqeNrKU4J3RbRu3jhd?=
 =?us-ascii?Q?kpl9lVDDCA33AtEy7sJ6Q/BNOQ0cLujOhkDiEX5jbYwvYqe1d6+rWsA3U6yE?=
 =?us-ascii?Q?oAVlFq7/VgoMDW0wF4SEmr6O6vTI1HiGNO8IZM08vIxbgK12xcJFv9rMvNXo?=
 =?us-ascii?Q?G0HOlMVNL3u4dwQKXWeqVmqJ8wy2wMrfDf/IQdemAuBmChQmRmbpvSLxJVAd?=
 =?us-ascii?Q?TrnsUbXpC3ZtcNlyeUqH9+Q3QTUUwJaAZWl5MVIbrKGYDwm/qPbvGmZ7d4ao?=
 =?us-ascii?Q?rQB5Sj1kOVDRuke6kXJqU4gTICVcBFNcaJA/YPODNInPHtTRlUdg350+cip0?=
 =?us-ascii?Q?eFVPMbhFFDi97qe7HavKcefxbKjkHdnsLS4NOyEkibEVFMiXsDGKM/qKHcEs?=
 =?us-ascii?Q?uKzH9BacdAh4F7LNYN4LaEftiv2IxnWDi3o2NBzJ/jM43FsV8U0OE1uhHxKA?=
 =?us-ascii?Q?FgIXO2yySo5TgxX5xCtZ+ykDjkrQqOdM1Kl9dPJwnqdxFUo1IFUpNSCshCCR?=
 =?us-ascii?Q?Djp9QqoSo7r3UIeNaykNUy3PPZtnDH7jaDwL3gubdSnvfrol7SexKP6vUbmj?=
 =?us-ascii?Q?ibojVS7pG3LDfZDfRBJJzF7MU+TZztWxAoU3T0a80AkInxbNe1FH1BR6oW94?=
 =?us-ascii?Q?gRGZLrgdUJQGFhOm9uZREf3Ia47LuLiZfW9FzYmDy0X4LyHWw9GT+8aMe7u6?=
 =?us-ascii?Q?jSNXVgO2vUgpjY6xjkEBAUHI/eD1LhY0Ea5BTcd3?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a242e20-03e2-4b79-537c-08db568fd1a8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 04:33:10.4801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E4Fa9WVPT6i1ePl6KOKnd+tOVtdork/KpEYpYzopF3Gozslf9mq/WnirfFb9AgJv9bAzgNVm+X+o6Wpomy1J5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7657

Run mptcp sched test in a dedicated netns.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 61 ++++++++++++++-----
 1 file changed, 46 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index de8b6c68fc30..c6fd5c2449f3 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -271,42 +271,69 @@ static void send_data(int lfd, int fd)
 #define ADDR_1	"10.0.1.1"
 #define ADDR_2	"10.0.1.2"
 
-static void sched_init(char *flags, char *sched)
+static struct nstoken *sched_init(char *flags, char *sched)
 {
+	struct nstoken *nstoken = NULL;
 	char cmd[64];
 
-	system("ip link add veth1 type veth peer name veth2");
-	snprintf(cmd, sizeof(cmd), "ip addr add %s/24 dev veth1", ADDR_1);
+	SYS(fail, "ip netns add %s", NS_TEST);
+	SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
+
+	nstoken = open_netns(NS_TEST);
+	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
+		goto fail;
+
+	snprintf(cmd, sizeof(cmd), "ip -net %s link add veth1 type veth peer name veth2", NS_TEST);
+	system(cmd);
+	snprintf(cmd, sizeof(cmd), "ip -net %s addr add %s/24 dev veth1", NS_TEST, ADDR_1);
+	system(cmd);
+	snprintf(cmd, sizeof(cmd), "ip -net %s link set veth1 up", NS_TEST);
+	system(cmd);
+	snprintf(cmd, sizeof(cmd), "ip -net %s addr add %s/24 dev veth2", NS_TEST, ADDR_2);
 	system(cmd);
-	system("ip link set veth1 up");
-	snprintf(cmd, sizeof(cmd), "ip addr add %s/24 dev veth2", ADDR_2);
+	snprintf(cmd, sizeof(cmd), "ip -net %s link set veth2 up", NS_TEST);
 	system(cmd);
-	system("ip link set veth2 up");
 
-	snprintf(cmd, sizeof(cmd), "ip mptcp endpoint add %s %s", ADDR_2, flags);
+	snprintf(cmd, sizeof(cmd), "ip -net %s mptcp endpoint add %s %s", NS_TEST, ADDR_2, flags);
 	system(cmd);
-	snprintf(cmd, sizeof(cmd), "sysctl -qw net.mptcp.scheduler=%s", sched);
+	snprintf(cmd, sizeof(cmd), "ip netns exec %s sysctl -qw net.mptcp.scheduler=%s",
+		 NS_TEST, sched);
 	system(cmd);
+
+fail:
+	return nstoken;
 }
 
-static void sched_cleanup(void)
+static void sched_cleanup(struct nstoken *nstoken)
 {
-	system("sysctl -qw net.mptcp.scheduler=default");
-	system("ip mptcp endpoint flush");
-	system("ip link del veth1");
+	char cmd[64];
+
+	snprintf(cmd, sizeof(cmd), "ip netns exec %s sysctl -qw net.mptcp.scheduler=default",
+		 NS_TEST);
+	system(cmd);
+	snprintf(cmd, sizeof(cmd), "ip -net %s mptcp endpoint flush", NS_TEST);
+	system(cmd);
+	snprintf(cmd, sizeof(cmd), "ip -net %s link del veth1", NS_TEST);
+	system(cmd);
+
+	if (nstoken)
+		close_netns(nstoken);
+	SYS_NOFAIL("ip netns del " NS_TEST " &> /dev/null");
 }
 
 static int has_bytes_sent(char *addr)
 {
 	char cmd[64];
 
-	snprintf(cmd, sizeof(cmd), "ss -it dst %s | grep -q 'bytes_sent:'", addr);
+	snprintf(cmd, sizeof(cmd), "ip netns exec %s ss -it dst %s | grep -q bytes_sent:",
+		 NS_TEST, addr);
 	return system(cmd);
 }
 
 static void test_first(void)
 {
 	struct mptcp_bpf_first *first_skel;
+	struct nstoken *nstoken = NULL;
 	int server_fd, client_fd;
 	struct bpf_link *link;
 
@@ -320,7 +347,10 @@ static void test_first(void)
 		return;
 	}
 
-	sched_init("subflow", "bpf_first");
+	nstoken = sched_init("subflow", "bpf_first");
+	if (!ASSERT_OK_PTR(nstoken, "sched_init"))
+		goto fail;
+
 	server_fd = start_mptcp_server(AF_INET, ADDR_1, 0, 0);
 	client_fd = connect_to_fd(server_fd, 0);
 
@@ -330,7 +360,8 @@ static void test_first(void)
 
 	close(client_fd);
 	close(server_fd);
-	sched_cleanup();
+fail:
+	sched_cleanup(nstoken);
 	bpf_link__destroy(link);
 	mptcp_bpf_first__destroy(first_skel);
 }
-- 
2.35.3

