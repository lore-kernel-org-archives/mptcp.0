Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2081.outbound.protection.outlook.com [40.107.22.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AD48821
	for <mptcp@lists.linux.dev>; Wed,  7 Jun 2023 08:41:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jyRzH8vjaXQ7nlzwgy4pKDlLKRr0crL9aiysYPUIcThebVRTFqvrc+Rmc4Ow2r5/tit/3i5M3bybn9jxfMILV0vWar+qd6W6cxXRM+VBPNXnSW/lP80bFQFTbBQKbsmaDMaIopHCsJ208i9pdfzSrsB8MIo9egTLDLhkjN9fbBkoih7c1LVOVSoalxpAVO7LMafUpi7JUETH7AEHQdQRIpgrme2z7F4G2mtU7a3wGwWrSgNP0aVD3ospDq/wQRkqpbSg58kkc3eoU+9XUsEZVM6bMNWdu7mSH/StQwq98R/Xkf7R+Jo21qKnTCwu81Azd2gpGh/HkdPdj8sZ6Kc5FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgsDyY0vTYB2o0sK/fDUXM19faPWLKks0hj83Xoq6Zw=;
 b=Hi8EmGFX7o8OMQb3txtUU2cqnd1vV4gvu9AI819irpWDG9qqRY3NX0cgySWLh6ouMQkt+Sdx3pBToUJRV7DB1zRz6gqcLV4pWOOl/GJOO2VGrFxLLhv5xPH3DIvPwXQxy/7MQj4v7+b3CsRF9hs1kpve0ibxC1vUSOs0ZDbjxIzq19SCt2prTy36vI0WeTGql85GiqgPf/IqJUrbGx4i3KoM/12whQjUoZKWg7xIuPhZf6A+W23i+IbKA4xG51Jn7OpXE98aXoZqOI0oAMHOryfJAOyYOTJYcKPeaSKK7UJXJqgHJvRQhj7WqdFiLMIwL3ptbulkmYqr6tvC+uG/EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgsDyY0vTYB2o0sK/fDUXM19faPWLKks0hj83Xoq6Zw=;
 b=d2DS3WUPWXL+p4t7Ys8DcUKvqbHBrngFpmqJEego11wgS5sAmeDmaJMHkuIf6DYaukSNtpeMPUdRnhNipMI9aATMGUpuZVMFN+Lbtj5iY4AZCbF39jEQLuJD46Vn1/K2faQTxD5IX17Ej1TgGAZVCghI/ulepEGp0FKMQHft1JZYWsGRpcI+H7TefMAgRueBJinoUyFMqEtSx2lqWUY3AciuEXDd39PWuieFL1y7oanliSWgNX9AamCtsAXV9WJYMe5FFseLYeKUoLDAqg93Ay5SEg57YFtKb+oDy2kiH+btNmfCznGf5szHCzskS5UMBOWkOafh37pyIJJmIjDikw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU0PR04MB9467.eurprd04.prod.outlook.com (2603:10a6:10:35b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Wed, 7 Jun
 2023 08:41:46 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 08:41:46 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 19/19] selftests/bpf: Add bpf_stale test
Date: Wed,  7 Jun 2023 16:38:34 +0800
Message-Id: <c999814651073121c97f2e5c5f273d6674a6832f.1686127032.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686127032.git.geliang.tang@suse.com>
References: <cover.1686127032.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0202.apcprd04.prod.outlook.com
 (2603:1096:4:187::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU0PR04MB9467:EE_
X-MS-Office365-Filtering-Correlation-Id: ccf5e032-e02c-49de-1bc5-08db673306f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UqenbEdzLxUIWSTVUo6GvaV4JrVTrujg0aqlB6M9wuqCCYm/K6SnfdbBy+CSnq5YA85Vm/Tv9xOs1j7NqxLWNdE2RPmttDuEdt8WRyGb62IJYbJHREN2Pi2E3zRhDaRwNXdjo+AdcZaBp16KyIBarCXSTZO+vrpjuDLJZkBQ4WZV1FBWhmwETPv1AAgDZCh03IBJ7a8kl1zcx/8hXJQ5GXp0PzIprYvmS8hCMnsb5lYW9OPidMJcyJwsJrWg6m85J7j3EluW6l+hovK3SagXX8+vmCiRaJRFrLDkvH2DZuvR/zCzTpLCNmiKP3yW10t0G0KrWc8I22fIqCadXS0/Jz9ig40+ZdmuHuVWDLU+4fX8Hq7gIsv2L0CRaf395hfXQxyOhtycYBQRiholTgHGPynXggwHy63Xd4kuiiBSHas5esjbbfAtpQWYqILTX1DXDLUbX++M/7wD0ukkAgWcV0gFMm0hFtqzg0O21wjwr5q04cbCJHmUvhoQq51tTSUjx6O7wnl0MxkvA+3wYIVqHmUwQj6ghQ/JMyyeMJHssTNx9jq7HXUEqAm4nmO0TM1v
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199021)(107886003)(6512007)(26005)(6506007)(2616005)(83380400001)(186003)(6666004)(6486002)(66556008)(66476007)(2906002)(66946007)(38100700002)(44832011)(8936002)(8676002)(5660300002)(36756003)(478600001)(86362001)(41300700001)(316002)(4326008)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cIZGyddhn6qnSpRQYRdb8SIE3O4WnZ0f729vIIZeqnQq5BtcbwdIYvqolXEV?=
 =?us-ascii?Q?MUZrw3OszP+JITKaAeD7nbMeC5U+0BAC4pup21tHl1FHQeWChJXugc1snyu+?=
 =?us-ascii?Q?70pTqS6uw3JckiXOwkx6+jjhPtgXZ7ZJFyQ2s7kz0T+vapKvzy9b7lRT1CEP?=
 =?us-ascii?Q?QOT1oizcM1HoG3Dx0wrLuXCPtS40xPRt+yp6TtJjSxdc/3e+1nX2Ek8CLNQ1?=
 =?us-ascii?Q?sv7Fb4V5hkgkZHNJRDvQ6FL2+gd6JNaaI2a0UJcap0KokRrIja1Cudfdv1Ky?=
 =?us-ascii?Q?Z6qyOW6RFcOo42WGNrj20oXuQ8BPDNGXliBfiTbFAhkZoWoKStbRzd3t0wmw?=
 =?us-ascii?Q?5jDpCu9XIvpdbNaJL0JUzdrsZgbwF8gClxqdgCT9BXMQB+ZsUBM2xyQpTjnM?=
 =?us-ascii?Q?APq57J3Liw9FSJxhdN1ZG/OLzcRVJrmNJwUeR8qDb9at/UsLAtyj9nPKy7Jj?=
 =?us-ascii?Q?inQHLLOPTRcSxpsb6XV3ILHXSfGjWKPZ11fj/ZSU0CG9er1fVSD0kEWQIK46?=
 =?us-ascii?Q?kBBdB7OjefaYiZGoKtipOtfCE8OHBwXhC1+bLCZK0azv48GlUrKS7upBEEUo?=
 =?us-ascii?Q?yWNFExuSYjQ/H8zK3T6BVpQDyAy3p8Dl9gDYZKUO77heHEzDkf3nSsX1vgWi?=
 =?us-ascii?Q?yXWiUsvOKrqrszzYZeIdpJTfmOQfVTdhfyfZC36Snyq42ITv2Nvluwqh8owh?=
 =?us-ascii?Q?x4hid+9IAXaYykMRKjPk1IXBsDYcZu22SXzBtsKOSXKLS9/4gXe6JNPFG/l+?=
 =?us-ascii?Q?/ZIDVij0lohdVUBmHnRb1u6pfUKoZKWUTBTeIG5Judfh0zrDmep3VcRsaF3c?=
 =?us-ascii?Q?MIcbhyuMz1vCor7Yj6m6Cr70XTovE5oIFbJ0orz0WoByikRSCDedDGebaAL1?=
 =?us-ascii?Q?3FZQ4bthwTvyX+fSH2eFqWXAxUVSI23NUufBTnqhuR/vyNY2yTJ7D8w5iUCm?=
 =?us-ascii?Q?S1dntykwHdgElzHoo4AMZcZ8+6zxQkR6G+g/pNaDDHkiC8AfPp11gy//l0x9?=
 =?us-ascii?Q?WZZkODDFOGunAP19d3POsP5c+mMmOpGOD44EbHfCjUw0iLRbZF+gCDeKgOS0?=
 =?us-ascii?Q?Nhohd0xpyNvMyLL48B4i1jfEtI87urLBAJ2I9MF1iV9c3RrDAHw0u7MPt6V0?=
 =?us-ascii?Q?9ybq1iDzuR47cPWATB84f6OltpVaEn8R7+V0h8ZElvdcb+9QS3ybwE07lwmm?=
 =?us-ascii?Q?PiBdaIBg5XeRm+MTgIUET6JpTY7ZA8kFKkx2JPrWuifv3WKHUB91c+pMaC+s?=
 =?us-ascii?Q?7npO+CqnkWz4KqKwk2lngkpT5LtpE6qobP4PFpkphIJget5TCYG4T+j1yxki?=
 =?us-ascii?Q?LSKJ2Oe/ISJCmOpvQVzX/zvk0s8+uX6FdsLA8EiTsyvZGKCbfC0sTldpiEmF?=
 =?us-ascii?Q?G1zXC6x7pnQ40oxtdfkPWoTwWHgFnEWGKLxH3v+2lLL7dMqjNIQMvi4yxhyK?=
 =?us-ascii?Q?j25BGXEI72uHP5hovrEiGAfMP4WwbLutNw1tmDQiTP8vWPAlxtTE3lwlAR8m?=
 =?us-ascii?Q?Qd5HnhtHcoTJ0z8+m/XGR8eLe6N63NlojwUA6mq2OpMeamk7VTcjx9zczl4j?=
 =?us-ascii?Q?wsoZBW2jFQZgSQ1PyFfzljq6eSiuKYHyoAJH2gNr?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf5e032-e02c-49de-1bc5-08db673306f8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 08:41:46.4014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wv0YeUljns7fRE+s8KZ7K901z7ZaE/gy4SRHLiUIXLxX3INKW0Um3jZ7mW5nv/afvjA4wovWPrmufD/gkY5VwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9467

This patch adds the bpf_stale scheduler test: test_stale(). Use sysctl to
set net.mptcp.scheduler to use this sched. Add two veth net devices to
simulate the multiple addresses case. Use 'ip mptcp endpoint' command to
add the new endpoint ADDR_2 to PM netlink. Send data and check bytes_sent
of 'ss' output after it to make sure the data has been only sent on ADDR_1
since ADDR_2 is set as stale.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index b9f6dcf995fd..94b7624bdfef 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -11,6 +11,7 @@
 #include "mptcp_bpf_rr.skel.h"
 #include "mptcp_bpf_red.skel.h"
 #include "mptcp_bpf_burst.skel.h"
+#include "mptcp_bpf_stale.skel.h"
 
 char NS_TEST[32];
 
@@ -491,6 +492,41 @@ static void test_burst(void)
 	mptcp_bpf_burst__destroy(burst_skel);
 }
 
+static void test_stale(void)
+{
+	struct mptcp_bpf_stale *stale_skel;
+	int server_fd, client_fd;
+	struct nstoken *nstoken;
+	struct bpf_link *link;
+
+	stale_skel = mptcp_bpf_stale__open_and_load();
+	if (!ASSERT_OK_PTR(stale_skel, "bpf_stale__open_and_load"))
+		return;
+
+	link = bpf_map__attach_struct_ops(stale_skel->maps.stale);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
+		mptcp_bpf_stale__destroy(stale_skel);
+		return;
+	}
+
+	nstoken = sched_init("subflow", "bpf_stale");
+	if (!ASSERT_OK_PTR(nstoken, "sched_init:bpf_stale"))
+		goto fail;
+	server_fd = start_mptcp_server(AF_INET, ADDR_1, 0, 0);
+	client_fd = connect_to_fd(server_fd, 0);
+
+	send_data(server_fd, client_fd);
+	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr_1");
+	ASSERT_GT(has_bytes_sent(ADDR_2), 0, "has_bytes_sent addr_2");
+
+	close(client_fd);
+	close(server_fd);
+fail:
+	cleanup_netns(nstoken);
+	bpf_link__destroy(link);
+	mptcp_bpf_stale__destroy(stale_skel);
+}
+
 void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
@@ -505,4 +541,6 @@ void test_mptcp(void)
 		test_red();
 	if (test__start_subtest("burst"))
 		test_burst();
+	if (test__start_subtest("stale"))
+		test_stale();
 }
-- 
2.35.3

