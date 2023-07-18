Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2089.outbound.protection.outlook.com [40.107.7.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612A317CE
	for <mptcp@lists.linux.dev>; Tue, 18 Jul 2023 03:38:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CgNbBKlMHCRprPSWmsChK6yqnGZwHnisDVfq3SObrpxsRsf0VBFATNvj/GgczE3qDJdNPixUqCV4OkH6kavf+gQpH7n1JXi//zerkZaQd7gM508Dwlz5FcNa+l8/2JYOVIMa2jt/XfTi9E6H/Bt07pR3xplUE/wEVRgzj9uR6pIqoy3mRNpRXTr/OFi5KXECzqv+zrtW1kEA5emNZIytU0HmumMWFuFwrvAOP2jQB83CAPMKD56ZLtyOuciJTXVLHgudmU0uMe12V8UAtDNNESV8e2/+I0EaBtYGQzibw+O0SX/f4iRQdW69qUw85Dn4NzoD4N1KvCYiNppFS8x4Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UsE+Oxtj6e8rWWNHJZytg8QhUswiBWKdTffnS4C5ER0=;
 b=JHFGfxuJI7y1oO3V2AYibU+6t3VyTE6qlt8elJyxITW9OR0CpUFQuamgKt5+JKW/zxsAT9QAdhol6AD9wUJO86RTVSIrHMi1ZIDyM2Nce90IyFmXZKP3Pw4gkfjeBkJtMYisTYzbIJc7r77ahgtHoPuSmoZZfmM4kAAw2Q43dPlG7PRZhDbNtrKCFn27wAXmvM9jCL9HvZER3Wo1Z7ZCANfPziftBE7t58vz+CnKGFiFsZhgDSnq6O2noRWxzXhUDVCFnMrmKdHCfopXlcAR5stktPWQZ6RbpTG4qkryr9Xm8FPUN/f8+XTZupLkMJiXXVpLNimm7fpboBhAKJYztg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsE+Oxtj6e8rWWNHJZytg8QhUswiBWKdTffnS4C5ER0=;
 b=JjXDrFQEBd6zp6hs9Pu+3+kbk/jqTj6i1/R4fH+E5SNTQauP0+NJkiHaiLJwucwSwhBLd2BqM70vn5sopxPXvzhQBzUuKf3zIDVPqrwDFY/DtEhdC+N4xIcScfWMpbrGGNk+57WrJ9a1b5gazsOuVCLZLcXG/F3p5NqK8QtlGro4Qlm78MoW2kyQuu6KT7G686Ef4xNEyTHP5nQo6LK+iM/adHewVt8Om75FoLhC33dxhbo2NSRkB9tO5B42hYyDFP3PGJX12EYApbbNfeawlIR1Q0LKsQZtYYj1VbRdUOOArB4QsjlLXYMyTU14/V5Lya2pRfJuwSdSLGYbGL1n7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9105.eurprd04.prod.outlook.com (2603:10a6:102:225::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Tue, 18 Jul
 2023 03:38:21 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f397:e53b:9707:1266]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f397:e53b:9707:1266%4]) with mapi id 15.20.6588.028; Tue, 18 Jul 2023
 03:38:21 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 10/13] selftests/bpf: Add bpf_stale test
Date: Tue, 18 Jul 2023 11:36:47 +0800
Message-Id: <690119e110637a386056ced8848355521610ffcd.1689650435.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1689650435.git.geliang.tang@suse.com>
References: <cover.1689650435.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::26)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9105:EE_
X-MS-Office365-Filtering-Correlation-Id: 39db83b5-dff7-48c5-4bb0-08db87406f27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1lWF+k5MsriaxGAktbgtSnCNXiPnj/Bi8W8kg2fE2sbMzea8Qh1692h70+cA+x9clQHpLnXGMK/XRKm5ZNcO4gcFtUJ15ebv2Ca7HCbOEojZUPL/HlcVBm9R6H7dH91YtaIt0RqVtTmiIukU4TsDUfvujJBHTrAGzOq/Pg+m0MMAoQgxfJdlTt+JD0IRV8zUkZZotOd0+ITLtrnCowKcnF4BMrzp2OSr1R23/mpDMsJYlfWr6pgK1P+QGBrvXfVX8EZR4IjYoD5L9hCjVJjFNsV372L3uaNWdc+HcQ/cUw2mfpvT1OYa7l1EvhQijWxoYwuzDS7Tr2uD3lSJhsPzWtPtSh7k6qJqXANBUJL0P6rPm7aBR1jTjuNX1M0rk4KYMMU+0BHGxhwgKGeL3I5UhG0x8X2PyjBa+7fsVlhdVLQiWz/KG2HwtAbsYDm08wO1qGkpZciUYKhejeBAnGBgRift6iNHe8KQ7t1XhMnYFrcK/IMFV2P+DZwKicuQevDmj4nApP6v7671Z8AWuA3dsXBXE9xqE3JHh7eLV7yxFX6lmSNp+XEtQdYTP8Q3xHVZVCBYz0vL8CZiw+0LifK+Q3C/Y0yYBUPLMqctOSc+pmE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(39860400002)(376002)(396003)(366004)(451199021)(107886003)(38100700002)(8936002)(8676002)(83380400001)(36756003)(2616005)(2906002)(6506007)(26005)(5660300002)(186003)(86362001)(44832011)(316002)(6486002)(6666004)(4326008)(6916009)(66946007)(66556008)(66476007)(478600001)(6512007)(41300700001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HicpgKnhAJidFYSjiezOFcxR2jmgXuiXyv/TJT7dbSSFvKPjABtzruOs0LGq?=
 =?us-ascii?Q?K1xBLWCZORqB4ABm81d5RbDHLX+OA9YLLaquckLDywtQHuYYvxnT6gAOn4Wi?=
 =?us-ascii?Q?D90IL7eThHcUxOwC3NTsaCEPHaV3wdr4cGbYHIdser73URL01PT359KHGkX8?=
 =?us-ascii?Q?VMll5SVbE5Y4ypKuvqkKPU1SwG1s/yaqQSkKfwF8Tu0x+FglM8PZOsabdtPe?=
 =?us-ascii?Q?KuaQEQ2c4xDNpg2XMMus8u3YdHp146zHfi662OAZVXXyTNXDds7cX/EiU3ma?=
 =?us-ascii?Q?cGExQAgRb8rkogFBt7rxWPHzJ8y4WM2XpnlV7TDO5DONv1aUir7EbCjlNFdB?=
 =?us-ascii?Q?29/K6pPi1oQA7vuDwuIFrTbUJAfUFQLoBqJ3l+v1MPycHUe5DjAIxq3lBFor?=
 =?us-ascii?Q?UTLOltXS1SJgD62iztIEYlbYAeZyWuSVZEAwTLjjof59Xs86V3Cb8UxNKOCh?=
 =?us-ascii?Q?exaKT46xW2eCd9taYICOHIb+9Z8yu3oZkrtOnvHt7W7F/qIQXUh++mZvEZ/m?=
 =?us-ascii?Q?IanFFyp6Z4aPuL8t+r7lU/FC+P9wzU9qNE4j9VD78LO72gYlSJNSOBMH2ffw?=
 =?us-ascii?Q?Kkc9/Jxce1ZsLjWYjW+2WkIg64CzxGK/mTty2hEPgoVZMuuvqGDmpZKgw741?=
 =?us-ascii?Q?wG+TlAAqkx3rMLfKiByubIEyC8Sg9ShvN2ljRLI8yern+uPNAUYmkQVKibMY?=
 =?us-ascii?Q?cQWQMlERBtsKPM9hRlgKhmK2DjUYpkaOcRbvqwMQYFx3lwvQK+ythvT+jNmO?=
 =?us-ascii?Q?o3wGiK5sCV/UemoM7RT26eFks14TwNLD/4Pf8BLCTaGI0yQCaKzK5bmtfMsO?=
 =?us-ascii?Q?FvTH0gTWqQtFC/JXtyTOSgrC28AVqJOZMfzElbD+gwo+pAfeiVmA6ok/0xxx?=
 =?us-ascii?Q?nm8HBrYwKjM89CxS6R7Ein/R/xqnoGwI+XFXyioMVUcZs0EpwBs49yyaSC6c?=
 =?us-ascii?Q?Z+U9IzGMwijPXzO6qjyu70wrSZeNE+L310KlncAYksSXvheC+I/hkfDp6F70?=
 =?us-ascii?Q?a0rnYVDjfuzveZt8gcn0m0rF7ubKLi+rckFyjnVkZWhJ5hNADo0C/wLS46v4?=
 =?us-ascii?Q?hu+G4oeTTo5hnQ7HUj3zfZ9whOgvxI+P4UEOIDZxfmpuTDzdJrrTbXBZHZW4?=
 =?us-ascii?Q?/WAKTERwNSTaFGfsR/9tzAt9ZBTVu1DbAwRtg1NeoCZqdRMlkQvOlWveweVq?=
 =?us-ascii?Q?NNxJqY3TNPHL7kX4THpQCZhLO53l1vZcvnI8pef6An7bweTybkwcJhSexD2I?=
 =?us-ascii?Q?Wrkg9zWSYATGfHXF3jilzo8NHzdMjHu5XCuUgRXSDUIcCFjSlwbha7sM9vf6?=
 =?us-ascii?Q?RElymPqOft5ouKf+r2NN906RAw4zElSkkTU+6ndbJVVOnaGBIgtpXM1MiT/B?=
 =?us-ascii?Q?l4M5M0Up8jxgQiHgBDOnmlsE8OyybouTrXjQiMdmPvIwprnPayRIY8Kxb6nw?=
 =?us-ascii?Q?UyMOLysR85D7nI6M5NsbhEJ9oFzJntHbdC01aGC0MsRFXk07zn+OoFy+3WGD?=
 =?us-ascii?Q?VGsVWrTteO6u44B26aWTg3vkZ7nPJflopGr6RWX8FzlolFLBmezJzPGnaZHs?=
 =?us-ascii?Q?T8ESOKdLGljGX4NNfwIVgpeqw0eyk19XSijnT1iG?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39db83b5-dff7-48c5-4bb0-08db87406f27
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 03:38:21.7366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Ykftp0YxgoopZ3QhtaxyFN9BxbVrgTcjuvCfN7FtWk2/jD9iz/0xmw5g4QNfAt+WI7+XH1FIQ2CXwLphcQWuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9105

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
index 30fcc82b10ed..c6aa34f3a0d7 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -11,6 +11,7 @@
 #include "mptcp_bpf_bkup.skel.h"
 #include "mptcp_bpf_rr.skel.h"
 #include "mptcp_bpf_red.skel.h"
+#include "mptcp_bpf_stale.skel.h"
 
 char NS_TEST[32];
 
@@ -489,6 +490,41 @@ static void test_red(void)
 	mptcp_bpf_red__destroy(red_skel);
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
+	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
+	client_fd = connect_to_fd(server_fd, 0);
+
+	send_data(server_fd, client_fd, "bpf_stale");
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
@@ -503,4 +539,6 @@ void test_mptcp(void)
 		test_rr();
 	if (test__start_subtest("red"))
 		test_red();
+	if (test__start_subtest("stale"))
+		test_stale();
 }
-- 
2.35.3

