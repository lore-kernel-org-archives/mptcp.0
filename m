Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2082.outbound.protection.outlook.com [40.107.13.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCFC5664
	for <mptcp@lists.linux.dev>; Wed,  7 Jun 2023 08:41:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPG9nccrpK8H0eqczTzPPt/Y2mp6YDWd5j9xFjwCIAEdJTu0o5qrJOYK7zAYsaEolb9R7UDz9B+uOAC6f8/mzvkOXJND13gqB8Eev2+s8ssGA2I0+onCLV+xIzd6VNan6S33p6u5gJxwtDEYK/hdBKcg8iJMRKkogx0bFaDImxWJMUI6DoSqD21uk+JPZPmNTGAUW4i/SycGYBjNCE6sDfsSscH6P1W/js+puu6ndnxcxamOLKMRrevvN0JOSpST19P1EhHh1kjYYbK0SB3W3AEMEmD6lJzXc8pBWCB+YcG89L8Kcca7+5LS9+rN2vf4NtIm3+rsvCFmMTyJcloQ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nfF2ymQTs98wwzrYJcSpzuGafFUO/uHJDM6q+Oopptc=;
 b=X3r7+Sqlo+5dKXTTQ4F0+3to7RBLT/8W5wN7dP+8c07TuN/OD6rbXxsKRjM5BX2quSfy3qZp9L2wgulGwMH18BQiH6u4VTQ9KDrVWRkHWBB8t9Qp/awlp+lNsSK8gC0L452Cq87b2ahi46OkRDR6Hc004B4oD+EOcr6pDZOugj91BQAlVLO2CWgKkaWKOeIyahXeCMmwOCYz+QOnt8OpKf5TNK8eGgYVJK5mVE8vQHq98T7BwU7x7T/CPWZxrX9Mnw9X+KaUz/ZfsrajW8klGGl8c23aJPybTow0AT7rzZ0LFV+ehh2j+SjPgPq/oSKJZU/YRRvEfiMXKOMcXg2dgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfF2ymQTs98wwzrYJcSpzuGafFUO/uHJDM6q+Oopptc=;
 b=rlA+V702q3XhTwHXN2YBfO2KeMxPhwRmYI1kpbkr63YciJrJYSuNnXOX3HTWcJQhx2YKph1BzjV+PHqUEHQEzzBNiOkJcFLvcIN0EX976IkQrT7tz/7TjCg4+mAAG8AduD8ZLAjHpmX2XA1NAwk2AYqbTlBbiGU3dTw6QQY+IdWBICY3wNe9/oiKusnEerMkiz7+EkG+9ArXY8gxDzOJgbQII7fZbCjKOZiuEZufRa9MYQ6VtvADiVvr0BF/qy7JEgyJgEllPjMkUaXT+OJ3z2r/GYdSzPKM6PKnKlxcPyOZCTZKg5f+EqFjWaVIddecTQo5xKcgqjCIMs0e0+rzQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU0PR04MB9467.eurprd04.prod.outlook.com (2603:10a6:10:35b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Wed, 7 Jun
 2023 08:41:24 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 08:41:24 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 16/19] selftests/bpf: Add bpf_burst test
Date: Wed,  7 Jun 2023 16:38:31 +0800
Message-Id: <2dfff62f24fc147fd736d452b72977c90406dca9.1686127032.git.geliang.tang@suse.com>
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
X-MS-Office365-Filtering-Correlation-Id: 86d05c63-480a-44b0-4c6a-08db6732f9b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hciLiQHWJgm319F83LgnSaU7a1Q47U94pnpZliGGeK8jTLxjszGbtxr62Aw6YZke89JJpS7ox38oSX8XimsWcbqESL+7mCM4yOlIHLWD/Go/qjVmEuSOsWp57k1Sg1g6SwRqL1fb2FxcXZjgV6W+EUF/Czcp/r4baJgCwoc4oM/ttyuPvw4iG/m4Azi+JMQdgQ4hON3L+A5bJJ76BB2C0slMfTlKX4B16EgSBeayvN2rf14NVNT+mfJbQ2PdJdXshX6LjDeKpLHGtWCJlL8zyGzWeGslv/53XIoKLuV2K/VX630alfuYtdVdzrHe3+xek+TaxbrOx26x4OwD/hIHkxGppFlGZgiW49NY1ixOF+ln1FTC+JjT4476xXjdGYG8Sa1/5jqpPqdDJ/QdDhXuHM41Aal5GeXr65SdmlNWxZwjE84JogsCIrSjhR04Hjl8t+EWLNBoNEtr2elkh4ASMaEWBr6jYubPDCsHgrkea76AibmLunkGEj+krZikUXVtjcj/eD8tavk8zOiP1VwbPU7odwEN83TSZYeye554bkovDAU9SXIP6GIGF2OgfgBk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199021)(107886003)(6512007)(26005)(6506007)(2616005)(83380400001)(186003)(6666004)(6486002)(66556008)(66476007)(2906002)(66946007)(38100700002)(44832011)(8936002)(8676002)(5660300002)(36756003)(478600001)(86362001)(41300700001)(316002)(4326008)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/fNVQglkzcsa0D2nNgv35Z3FNbbc/5qs+uE4niTAhp6g56JHJTGFTrZqXfl6?=
 =?us-ascii?Q?X9eM3S9P/g3Pn5KtvuAF79cUJqXAXDKwYJV3lF3mmEi8vPWP6amVn2nwqnfI?=
 =?us-ascii?Q?v5fkOdWmErCl6FvTylKLQDBwfC2b6HfsTUs67F6FZwkQAFf5YWq9V7WCjYfM?=
 =?us-ascii?Q?fPgJtl+wL/swjpZ3FoSv/cguV4zopXDsRkPLE2DC8xoNE8Zp7vBCm9Pp49A/?=
 =?us-ascii?Q?Bpm1lr6Cp8v2lmRPblAtk0xyhSiluyfhHMR5ham8/7kz1CNz+fXQ6QF2c+qq?=
 =?us-ascii?Q?c8kxTePKoSWWLt/gH5hRHX0o53cVyfXCbxnGTGQZ7vFt84JimdUGYLygByWY?=
 =?us-ascii?Q?38ZR06N/iEqUQAMzeHb1ygI6Uklm39XpQv1u+WBODFXEpPRBSBQU1HJDqYvB?=
 =?us-ascii?Q?IohlJAqGolLWS8QknOBBpKy0M+KkfMU8QNtYlBW6fYTxnGpTfqduNGIwdUfE?=
 =?us-ascii?Q?CD0fGvfeuMWiFDl1O5G0+5gicR/siiw6cpA/UI20OAbcidtszFTMjiEwphyG?=
 =?us-ascii?Q?q1Syxqq+KrQ3PE6Qqv3JDE7umT1ltx7EFRtcxPXWgiydFkeNuy77lXc2co+d?=
 =?us-ascii?Q?76+USRB2ww7MfiyHIJN/HjcRH5LvYwtm+P26CuK0Y1pUClOxDgilLrFmuZwR?=
 =?us-ascii?Q?Qo2EEwGmUC4A8P7O6yAuwdo+nekene4apvYg1nM65BqZtHuH30Wj2pZ66xYI?=
 =?us-ascii?Q?e5Ow5SlZyDL0vI36bW1xJXXe1qPFjGl3Tpp4c/fD2/b4yrQIVu9YZRWCArOc?=
 =?us-ascii?Q?m0/Pjjo5p4h6RHvfOffsDIymD5guSzgtUMqoyRKf1Fj46V6IJwsAO/9nU1Li?=
 =?us-ascii?Q?Iuj9bqII7CTKIxk0shAMyiOTmeFtnfhwux9HmzSc0TdEeuVIuVkHpV3Q1opD?=
 =?us-ascii?Q?CqySlpVWJzp/zPiehzG5ww3wbe+ruo87JIWgBDhCpsV0sXZB75W6JgA+TEM+?=
 =?us-ascii?Q?B565Jg3mQ2izNW8spUOWxlLXt6NMqvGRSunAKOiYXnIM1mS2KjCol6xG8FSw?=
 =?us-ascii?Q?1tWxjmQabXCfPNUHL62btHeqO4VyHj6+BBGaswQqVG1pDFF3hOzbAuK3bSLC?=
 =?us-ascii?Q?OKorDK+ME+QRVGMLR3CAX3e+35uQqCM8Zpb/ugaKHjzr5exr4O4d5gUYh83S?=
 =?us-ascii?Q?xUVSDVnMrmXSpbtCIJ1+z/z6aSmH97ceG5oCcTDBJU8zNLXVXY34DsncSir/?=
 =?us-ascii?Q?3qwGeJacn9wIOoY5Ip8fi4BM3iNFeludwJMdJkU6vkDvC68LWDOe4RSzz3Nd?=
 =?us-ascii?Q?to9AhAIEFzM2Kq9CJzfIDBLFKg/cpNqfkDcWQOQdUocBnCPXrrGNuAYJo3qw?=
 =?us-ascii?Q?giQQcAxigOZQqP5cBKrE+2xTaMP0b1DWdJgzDux3EZzN5uJBGXz9mP+mVSuR?=
 =?us-ascii?Q?5wwaNfhQu7V+Upw/vhQfGn/GuZf6uijcB4ruc1IDtMfIvyTcn62xIBONUMlt?=
 =?us-ascii?Q?5xkxWkr+tVeLAxrXD6hzpn4i7202wU7soJDp3wGdolTnwAsPijSaiRwibIQd?=
 =?us-ascii?Q?M6ZWcz5bj+Zm+zMsW3Y23mpwtWlo6X10fRmcEJd6rkNeRRRQ1bfuKJJ619/d?=
 =?us-ascii?Q?eEu7mJBUl2uVLUcZiBnPdWFk/LS68zallpNnR0Dr?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86d05c63-480a-44b0-4c6a-08db6732f9b5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 08:41:23.9532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r8nbKhryKSgRpxqTAuhUQdIOWSFN5t9alcBsi9tkDviIZUxo2rnr5WXGLFrvZjypSE71AsGsmm5qSYi19nT7iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9467

This patch adds the burst BPF MPTCP scheduler test: test_burst(). Use
sysctl to set net.mptcp.scheduler to use this sched. Add two veth net
devices to simulate the multiple addresses case. Use 'ip mptcp endpoint'
command to add the new endpoint ADDR_2 to PM netlink. Send data and check
bytes_sent of 'ss' output after it to make sure the data has been sent
on both net devices.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index a968641cc94a..b9f6dcf995fd 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -10,6 +10,7 @@
 #include "mptcp_bpf_bkup.skel.h"
 #include "mptcp_bpf_rr.skel.h"
 #include "mptcp_bpf_red.skel.h"
+#include "mptcp_bpf_burst.skel.h"
 
 char NS_TEST[32];
 
@@ -455,6 +456,41 @@ static void test_red(void)
 	mptcp_bpf_red__destroy(red_skel);
 }
 
+static void test_burst(void)
+{
+	struct mptcp_bpf_burst *burst_skel;
+	int server_fd, client_fd;
+	struct nstoken *nstoken;
+	struct bpf_link *link;
+
+	burst_skel = mptcp_bpf_burst__open_and_load();
+	if (!ASSERT_OK_PTR(burst_skel, "bpf_burst__open_and_load"))
+		return;
+
+	link = bpf_map__attach_struct_ops(burst_skel->maps.burst);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
+		mptcp_bpf_burst__destroy(burst_skel);
+		return;
+	}
+
+	nstoken = sched_init("subflow", "bpf_burst");
+	if (!ASSERT_OK_PTR(nstoken, "sched_init:bpf_burst"))
+		goto fail;
+	server_fd = start_mptcp_server(AF_INET, ADDR_1, 0, 0);
+	client_fd = connect_to_fd(server_fd, 0);
+
+	send_data(server_fd, client_fd);
+	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr 1");
+	ASSERT_OK(has_bytes_sent(ADDR_2), "has_bytes_sent addr 2");
+
+	close(client_fd);
+	close(server_fd);
+fail:
+	cleanup_netns(nstoken);
+	bpf_link__destroy(link);
+	mptcp_bpf_burst__destroy(burst_skel);
+}
+
 void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
@@ -467,4 +503,6 @@ void test_mptcp(void)
 		test_rr();
 	if (test__start_subtest("red"))
 		test_red();
+	if (test__start_subtest("burst"))
+		test_burst();
 }
-- 
2.35.3

