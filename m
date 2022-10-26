Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70042.outbound.protection.outlook.com [40.107.7.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C597B
	for <mptcp@lists.linux.dev>; Wed, 26 Oct 2022 08:06:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NV4K2iUsmzFeqklJUNDU796Yz0a8iD8uh0UXefIQrFIYyfm0LpsaqY8UJhspn/7CJQmn23uK+OdJQwpF7ceELMe28xvu/gpSII7/lOfgQ/kFrUaWLDTL2du54enn3TrnS9lHqHmqtvPRWZIk1r+LMtcwH439lcX/y+cxPA4kcP37o+kLyxE1VZCS0YW8kk0GxGgyRWToSKk1cO4prXzo9jSu9bEzfpPoEs9ZL9Mu3y+VkfTR8nBrgz+SOE67LRAbqTep6x3R6DNQWIHIkjAnYkoGNQlfP5nuaoxB+8uTIZ1Jmk3wNLerNm+JpWHum9rH0lDSmYJ5n1KKBUhKSHsOzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5VgHOKGiA2QU4SHX+fkno94QBSUGbqMBV+Qv9K8cJ4=;
 b=A4am3kW3jL3VMTh4Xl/MmcJ22O8e6pDeW+MBKIhOiTXKo8mNyUPtb7oU+okOUj/QfIlXDhJr9DQR8j6k7N7iqLvrG9HZ2Bi7g7m2HDo9d+Q4OtH47VjqvFk600gXMH6fgTjuKMr+R7lON1w4zGV6PggxdxX2ugXClyV1Lo9H70xvyZLerUUEV1hmqKwFzgiLtU18xpo/Zx9lPa+zKg0qNv+gMmpjtpnh5p7239TumKvHlg2MbclD7hBvheGlWiDyQ/L2ICi0EIUZ2rr12GuKrbnlOJ4jl/z5+jfhsqN/BssqBTtmDLz7Ty3pQCzY3s87Ss3TKRotl9rIyMp3NY0YWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5VgHOKGiA2QU4SHX+fkno94QBSUGbqMBV+Qv9K8cJ4=;
 b=oW4B5CzuwzsfBnlISR/xiU8U3PZu4eldm1GB70rnGBEn0PqiNA9D6u9Hy7T/+AFOKc6lOjDm3jwfMUcH0fGoS02Tl2tdehhX5REnqnbfrHPDblokR9v/2NBk0Wgvvr7xJiDcfbcQ7aeWC9wSmf1gWv5sIxccIoRPePfxVArhupE728jEiFG9GWryxPuYipsJ+yVpgB7zqe/AkOfWPpPqYAQOqbHdDBNAugYHIu+KMbzmxLcYIyeQ3w4lUmszN0dAec3QeB/y6FyniJG1R3Ip6OkMg1ElwLDPkeEXkM6mx89ezQuuzwCD59nR551Z9osqPW3pA9to/1XIUIs+QQiK8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB7617.eurprd04.prod.outlook.com (2603:10a6:20b:286::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Wed, 26 Oct
 2022 08:06:49 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::84de:d6d2:6710:556a]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::84de:d6d2:6710:556a%5]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 08:06:49 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v16 15/15] selftests/bpf: Add bpf_red test
Date: Wed, 26 Oct 2022 16:04:24 +0800
Message-Id: <e022569f28a10100ab409d73c5c326b4736f1417.1666771065.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1666771065.git.geliang.tang@suse.com>
References: <cover.1666771065.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0042.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB7617:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f5a02fd-acd2-4403-5f47-08dab72908af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	I0AsxL3CCKbkIPjGPg0NlUjv/GogTFFkdEyGL43Z9dGVu3PSySqnjNmRgvvHw9OKYScTbiSYBP44xmq8qgQYxwQkVIS5KmlJtkYBSLwXnSBvaAPbXiY6m6Bl/55yEw6uvY4mFSpoq6RdJHqXJ+rJ5lwjEEgpIHRKO37JXW0EFzcCMaUu0C7B/BS1+IdnIon8HnmRyO3tAozQVUo4cm8wfAjIMyFY3gl/BFfvD3cV0X8LfZtUXKLVAi+cjci6D8VNOELyH91FKRLzk+iLCipBb5l39yd4TjlWF7XANd6qE5o1yB9JsfYi0QlhFaIAbhfb0VFotz4Md4O2SfOd+k9I6LowPwQbYk1kSU5M9sEjPn2tfrQoS88Fh818KppWJwnx8pj4VMsalYfcrSTxwctTu0EmN/gLLDrf4+a7DLqm5AdjyW/WuOYtigTMNxPHM2c2QcpyeET/ejQ3Q8qdYayROn3H+d5Q04V6YMdY/zfzYwyJdDlXTgpyLcXxNMeRp4fAHX2V9Ai1wPvwfRLgpYXk+Q1lMsgcTEGwLD3CFVDy1f4UglM399bvCqY6/zQKipG7hJwON97jfb0+AVxCiVHsVemKIHz6EPMafe/eahL+prfyAcZGQk2G+xkWhtbtpXUzbNKNH+sWtU/FEDn4Au0ndyi2zYNZQgnNmVyAduL3qQNsNNi9Gi/HGRdFDR9j/jTCMtQkQy+mOKxilkDZVJg0gL5QH93FyLEEIhDKkXmCllGX4Bx+VoArg4npf1pmCpGB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(136003)(376002)(346002)(39860400002)(451199015)(36756003)(186003)(83380400001)(2616005)(86362001)(38100700002)(5660300002)(41300700001)(2906002)(66946007)(66556008)(8936002)(66476007)(44832011)(4326008)(107886003)(8676002)(478600001)(6666004)(316002)(26005)(6512007)(6916009)(6506007)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jg+F4/Ri+FlHYs9uEsU4TlQEQDNT0KeztxCGdGUuHYA4i1awzFcx0qpv7IUR?=
 =?us-ascii?Q?pZWeS4o8g9i0BvEijwNi3nkWqGx0D+pezn9QaOGLjr+EcALkpJ3IVr6LKHDZ?=
 =?us-ascii?Q?aKfNtb6ClrfDIDl+nY6Cxcf10oi6aBUK5OEW2UULLfZavhH0+4NbohMjku1x?=
 =?us-ascii?Q?Bq7NxOwT1Oc4cJdvJ2chDsLOJldwZ0G/SSEjVI08Yc9Nss5cdcIDc0hzHtPH?=
 =?us-ascii?Q?eyXgELDywpTDbJNvJ4jzy0rgi6YVuZQSzFMK0YvJ0kqtiwl1xWNAJZ4Z2oG5?=
 =?us-ascii?Q?BWMFeQdvbXNRaMk3G5JimExZLLMCKT9zKcADaNW22Bc3kUStO38B43Z2RGkJ?=
 =?us-ascii?Q?Kr+4YlCPtbDHzt9ybGihdPRWc+4qB2GRe1I90uo3MQsutx6K1Tflr1JT1A9z?=
 =?us-ascii?Q?/kYuWj7lIurPgU5kbZiJsJdzWHC2GnlzBnFb6cIJXCy5GVTQFeQF3hsTXx53?=
 =?us-ascii?Q?eYIuAxMdvtOWCbsU3OSLNebGE0393q31trGpY8CLC+51VIHwhuBDUp41v31s?=
 =?us-ascii?Q?EMRXnHyUSu9dWL36Hr8Fd2zlUcRLSaFpHy/kUGNh0eYbcJX/DQUZgCQ9tiiq?=
 =?us-ascii?Q?yddjrwhHseUYbQVS9yfkYRL3GAYiGFk/ibm8/iDYMjLFhrCc1YD/N4IwWcVS?=
 =?us-ascii?Q?spu1zGUOMQxKZpzuFFh0SGp7UDlVO46F2D+qFJM0qgh7LxpPjeyLAJxriXCB?=
 =?us-ascii?Q?p4NBS6e6/2i/LkPfnz+HA/qePrlwXmMuHAa5QRX4xS7MyZh3cAtfnTi5Ujh9?=
 =?us-ascii?Q?Ylb3PuSBGPbKe//QBWjWgCSiDwUCJh8gaO5bzuTayJPsp5tpRNooxev243DX?=
 =?us-ascii?Q?zjt0q4hYNG6YJ2sKP40zSdG1ZkQJ9gCmbfPslm0sQTJ1brLyEEn41BdTzkVc?=
 =?us-ascii?Q?DEf27OtSOz9oxsXVc1lg69Fk3YSvsp2CTsdkncY7kSUUE8mxK2ZnksxxggLk?=
 =?us-ascii?Q?4AF8sVKfos4wMW83DecbOcsPjucJlX2JmrtnqHhi+XV4QVB+YS6cMjkmfKRI?=
 =?us-ascii?Q?2jXaS8Qt71xMZJXrJpdeWJBhcHMFWLXkplwB/gJAeUVnpmkxIxTGJV9eINBi?=
 =?us-ascii?Q?qnkxRRXuSWuDQlJsWp175KdYv4b/9bnt+Bn2Af1EKsZXudZ73qnIHZ+JtWtM?=
 =?us-ascii?Q?d/WUtqp1/TalsX0q3b6qwrbmzd/k6qNw5ecL1ALyS+d/zEKA40sMgoagCifI?=
 =?us-ascii?Q?vvhm6N+lE5n8+M7d/s+kg2sNPDdEP72sl+/PPlJfO3Va5yn71Akd0Tr1H8M5?=
 =?us-ascii?Q?m+NLr1JsN0USWkKS8HDm1h7mA9oUp1DRmtwrXrELmsYBEqiV78yiWeKSJ7Na?=
 =?us-ascii?Q?9m6RaGMDnFHFy/1dx6VQ7B7JysmD47wNpSNwCcAMhgQKPouuFPSiLnKSIxrt?=
 =?us-ascii?Q?REOr/26uEoPDaP0IQjBFtYKSik0w9hqmZ1s3snUE/B098utXL7k2D4d746cb?=
 =?us-ascii?Q?nIAmv5qSz3B1ZJtMGEjrGTtZPE117RSFZvmkfijMptRlyrG6KffBBGbijaWi?=
 =?us-ascii?Q?Xiw7RPnJ/fBVQVPxd30QBysecBjTMAPMODZ73uJSkPLOkefLVFCCri4UvD5H?=
 =?us-ascii?Q?SSSlJCycB/yoSDvG1kTS1z3a0LpIacIQ8wykg705GQSTcEbo0zMz9eD8l4wj?=
 =?us-ascii?Q?pg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f5a02fd-acd2-4403-5f47-08dab72908af
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 08:06:49.4693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1DRrmTwA3tS1EkdX5SkNBhqHxDpA1o4Sxg5FlYmTLvDsdBWleJMgOA6lHE8Qna2fV3mhEmsrd91QltHEHs1n2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7617

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

