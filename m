Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2078.outbound.protection.outlook.com [40.107.15.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615FA257A
	for <mptcp@lists.linux.dev>; Fri,  2 Dec 2022 13:31:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BzhZVsU5ZtuKDqFaQAN7/XyKWXn6yMUQLCxAvqwqisSDnmt0c4M+z/ubpi4VA72DbQqnzFoUHNgCGzYs1apUz2PZJlp9eQkyL41rVYPJaMnJyTf2jFP98Q3CR/XYdOeDOCJWPxYJeuqNGTL9neOEeqCTAql5Vo6gTPgxcP5t8Tbq8nAYqm3Qp/m+SXbHB73qLyfl9SpdSpT3e0onbhPWWzaG2n5EjSQkfzk6tk64Gvq/I86zul5tqgKGFGFt8QdlLeUV84lLvHZjqQrX6liquv3UPP0YM4jS6Ak6z00d0mSoV53YdV3NsAzX6eH6fFbokCCuy9OB2NrmVME/NI+Wrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5VgHOKGiA2QU4SHX+fkno94QBSUGbqMBV+Qv9K8cJ4=;
 b=LLoUoUd4wqvG4goJlssGzQLNI8bJ4jEy9EMgoEhNoEeT9+WhnMd+RccmfFOMYKjay+pHQUUyVn6HeDlxJVzVtkeo/Puq/cDc1xFez5B2y+yzxGojb4bGNbcUuPeSCDTc53d9PGGJMbiRF/I2zqdZpMxSkbgRFrvdf0K1gQXaO/dU31l6MNtcQgniy7/IhfX1QLB9lX2npPaM7+H1w9iatYem6ijgopDctboH65iZa5lWwas7ZbK1L62NeTk95cu8UPdeaaIwUL585qBv68z6UPTN2kk87DVQFHb6DJX8swwTSeP4qhFjGkemBxLvR88O3i2FSv108L0jA/twbAglZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5VgHOKGiA2QU4SHX+fkno94QBSUGbqMBV+Qv9K8cJ4=;
 b=mThMqSO8UtYOFPBVeCDjB9IJPDdbOcCALSmX4QJr6I3jI7dlAMkE2DfAvdP8c9FC8W23K1ZcsgYeMgnIbYDQ00NWHxu4ICtfKhFcRzUPJjl86a538KywNIzGctICwlruqM+WTnqe3MUpjaw4TJ4rHuhB+aUtdefJ+RjgZL3dbw2vbvComHGjTtLuI/8jsUjo344T03HKT++yu8lAN7yfWV/p58lzzDe55/3OP6eMA+oTvRwVLr1quxqEJeLT8KbC3Fn/bOSN2jTYARUngf83j0Qz84PJmwBh9G/bDTfM9D0kSmtRUub52Y/jaVmBAvGaxlwXeSbi+h9Y8P70usi2OA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7509.eurprd04.prod.outlook.com (2603:10a6:20b:23e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Fri, 2 Dec
 2022 13:30:59 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f933:8754:731f:f6ac]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f933:8754:731f:f6ac%3]) with mapi id 15.20.5857.023; Fri, 2 Dec 2022
 13:30:59 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v22 5/5] selftests/bpf: Add bpf_red test
Date: Fri,  2 Dec 2022 21:30:17 +0800
Message-Id: <409d2e76d1dd4e35f99e0d38083fbc2a64406859.1669987293.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1669987293.git.geliang.tang@suse.com>
References: <cover.1669987293.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7509:EE_
X-MS-Office365-Filtering-Correlation-Id: 154bc2fc-62a3-42af-c49f-08dad4697328
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fL/xsW/aFWHYvzRxxH0ir+Kg9+KVoW9Y7NFPq81FWYtRkQBXmW6yRxkbPpMU3aSCTDXRZHKvcZ7gibilZ1d6IbSL5JhJNd3LO2O8M9UBJHKGBFqEN5wv7V+s2AjUBvGsjIO5JTv8xDtZ5MPu31IvWGa6amjwuEUzM9c9BITHF1Q2hojKJI+VUUiJ/fqMTsdvllnKXOyYrV8qdZ4PrpTYlhsGWhjtjS2YuONn0Ypp2Vb4gjI3PqvRbDx48ilacgDonK0hJGzeAp4EH4dmGFub5e52XNJZp9oCnHgT3h7t/xfOssZ3LVil5hp5I6LDv8gGqAc+knYpLfZfRhzW8NeaF1itN+TYuihuRFUrE2o/VLi8u312kPDCEjiVB24+hms6zB1+TVrVQgAUUht6Xr5bJK9TfE3gGZ4HYcCCiMPUjGrHuGKD4ZgTiCkcBYP8cEZrSxh6sqROWFWuOWbUq1+diXoqxk68rdAgQNMUVjFwC/viY6E1tOYHrM7n11lyZkOTSjyzIweqyym9uBoMEv/50a1SpOYodViarXY5QGKQvtoIUTLHNZA0aJpvTNY9gGDg1h4z1JKekXDQS0Pr1v4Qqn1OyyMg4A+tZPqi5j43quAyQWIBVIBp445ClcCD/8ZH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(396003)(346002)(39860400002)(136003)(451199015)(44832011)(2906002)(36756003)(316002)(83380400001)(6916009)(6486002)(8936002)(478600001)(6666004)(107886003)(66476007)(66946007)(5660300002)(2616005)(4326008)(41300700001)(8676002)(66556008)(6506007)(86362001)(38100700002)(26005)(186003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ByROXksYsHAdxEzReJAE5Kvqwr7mNxkjLxKO9JscSS4AhKOoWAUmkJ0+LSj/?=
 =?us-ascii?Q?Hn/bLT6a71P3MGOaKo7AwShM4o6cQrtmRlvRnYrPbQo+Da8e2pUpj5l6P38H?=
 =?us-ascii?Q?ZZNLNooHs/c4ic33K4YXWJ7rUw2j3lfGCjO2MQ6Pm3RPScV1ASmgjhMBdyW2?=
 =?us-ascii?Q?TcoJZNgXWSxskt8tb+5EhvZhzxfPbpgAnUmYCK4U6WnyFekcJYeQc5yDkKba?=
 =?us-ascii?Q?5N1LNAhvo4n6maqKVFO7WJ0rHatZ3axRYybJcZzpf3rluczIglM7HNRp/+Oz?=
 =?us-ascii?Q?XlrBfaTz2vAIARt/IYDKvnxib6IchZVHEfanc+VUfUsX8fiyjO5u8xFdF3ad?=
 =?us-ascii?Q?Fg34OjmsokwQ4E31IuQfEkuMCyecYI1Obt4c/uplklqn9x3r3U8h85CtfWAO?=
 =?us-ascii?Q?dUgXRq77bJbNOw8kfFLslc1oLsQXtGuxEw0aLf0GWJqRMCQIoPH9BIl9R7/9?=
 =?us-ascii?Q?j1mbjWhESeObsC9EG2m9dHH5hXplKLYbq1BDdCDmrPo0FOYex1KYjxvAmFwx?=
 =?us-ascii?Q?s+e1yDM9iLNwxZBRJte4yS00V5rRRgBJRdL6hqQLHBlVLAJ/fIuXENJXJQ0z?=
 =?us-ascii?Q?SYpJ0LxERpvq46dSbq709Rj/zYrtM/caORm8hVqIZQAUqJs/EUSjubXBps1F?=
 =?us-ascii?Q?ljKgVRxho8734CgcE/Inm02LSIKBATRwWtbrfSaiSemPXmv2KLreFFlFTGnj?=
 =?us-ascii?Q?b1vsZpd6DcgPI4ivZ6w1H/lxT0RRbZZyO/qybLrK7i2ygk2Esz9ZnUYKMVtX?=
 =?us-ascii?Q?d87K4JbLvBZWSz0XxQlFmO44fVcjRCMe7CajhOrGu58YBqLRLqEJHre9ewe0?=
 =?us-ascii?Q?FtW+Cjn9hlUv6ePMVe0A6tGFqpXYKlZk2y7IcOAATy99ruhUmJupApeMILZ4?=
 =?us-ascii?Q?ktIt3dxfLSUMhcZh1BaLACNw9d8QzUGubzc/Vt5yc3TwKA0mRGR3JoB9AEyr?=
 =?us-ascii?Q?hL+MwdgOxBBSzzD7qYuwiE/CC49bWbFEfFLn63AvIuf4sIXDn5hMLkFgyWQK?=
 =?us-ascii?Q?0SnrwgbvXeMNZLUGfJVY/X2lo4WKtNVtPpX+FIw+AAB6Ist5MYjrI4wvfQo0?=
 =?us-ascii?Q?B1v7d6J0v423cmFfWafZVF8jr3nJyBaykC9HjlmjniRqABMVI2yHyrczZdCu?=
 =?us-ascii?Q?Sa2goBAK4pqJHuH3dPdI+yZtn5dtIv1vtVzQthsJbTadpARIL6LPuLz+XRaG?=
 =?us-ascii?Q?UFCW0Wpm7z61FFTn2tbZqt3CX436uXMjyJs+A7uNDMcomoTBlXVnyWu9/vGS?=
 =?us-ascii?Q?gwG0aoj9I0IvEURPEAr0APKyM9ikHCiVP5txblPqgh5FTC8sjFDsDD58noCj?=
 =?us-ascii?Q?5LwlWsZ1YXRPeICbPkzoQp6Mf6cDJjXDjnwQpqumTRZehHVvhDXWd8V1vSgu?=
 =?us-ascii?Q?MOlV0LQhwOoLMl1xgH/Iga0CtABQlvG1XyXzptwC9nhYY89hsjgvBm2ltI62?=
 =?us-ascii?Q?XBCnAxpB9nxsJa7FCTBZqrTpQTuOKuqQIGbrCHyx58KW2q7pi3nFU50DwpXT?=
 =?us-ascii?Q?4fpp47jczOl7duCJD6Ns+U1ThvGAamf2mQhwnpZUhuDyDJ9/dHDrpz6m6XOf?=
 =?us-ascii?Q?Ae9Ko+q4ceL+Gnddzu+sFyTT+RjmUwr8blUO3h3ABb/NgP1BTbKljPtbx/qs?=
 =?us-ascii?Q?7A=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 154bc2fc-62a3-42af-c49f-08dad4697328
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 13:30:59.7708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IHnTQnei6TqEIjOcfatoY+WhoUX6pJTRjgzGNOdI2Lhzc4Qi2n7zWs92Ne2IDOdQ09/TnqZrAnd7hjjvJqnh2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7509

This patch adds the redundant BPF MPTCP scheduler test: test_red(). Use
sysctl to set net.mptcp.scheduler to use this sched. Add two veth net
devices to simulate the multiple addresses case. Use 'ip mptcp endpoint'
command to add the new endpoint ADDR_2 to PM netlink. Send data and check
bytes_sent of 'ss' output after it to make sure the data has been
redundantly sent on both net devices.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 647d313475bc..8426a5aba721 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -9,6 +9,7 @@
 #include "mptcp_bpf_first.skel.h"
 #include "mptcp_bpf_bkup.skel.h"
 #include "mptcp_bpf_rr.skel.h"
+#include "mptcp_bpf_red.skel.h"
 
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
@@ -381,6 +382,37 @@ static void test_rr(void)
 	mptcp_bpf_rr__destroy(rr_skel);
 }
 
+static void test_red(void)
+{
+	struct mptcp_bpf_red *red_skel;
+	int server_fd, client_fd;
+	struct bpf_link *link;
+
+	red_skel = mptcp_bpf_red__open_and_load();
+	if (!ASSERT_OK_PTR(red_skel, "bpf_red__open_and_load"))
+		return;
+
+	link = bpf_map__attach_struct_ops(red_skel->maps.red);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
+		mptcp_bpf_red__destroy(red_skel);
+		return;
+	}
+
+	sched_init("subflow", "bpf_red");
+	server_fd = start_mptcp_server(AF_INET, ADDR_1, 0, 0);
+	client_fd = connect_to_fd(server_fd, 0);
+
+	send_data(server_fd, client_fd);
+	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr 1");
+	ASSERT_OK(has_bytes_sent(ADDR_2), "has_bytes_sent addr 2");
+
+	close(client_fd);
+	close(server_fd);
+	sched_cleanup();
+	bpf_link__destroy(link);
+	mptcp_bpf_red__destroy(red_skel);
+}
+
 void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
@@ -391,4 +423,6 @@ void test_mptcp(void)
 		test_bkup();
 	if (test__start_subtest("rr"))
 		test_rr();
+	if (test__start_subtest("red"))
+		test_red();
 }
-- 
2.35.3

