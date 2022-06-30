Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30076.outbound.protection.outlook.com [40.107.3.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F32EA6
	for <mptcp@lists.linux.dev>; Thu, 30 Jun 2022 08:51:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGy5ST4VfybR7EvW5bm6VZ3e7I6koMzDMTHX1XB7jAizQJPtVyjoqiB0+sIHfgUyfDa+L5jW7q2zOO03TiAFBP6C2QVo3kOaWDFsciJ5CmVs1p2YKteWtdurTLjNTZi7M9hAWCDc+1fQ575zlGmxOHI3ZXUnkhqASGSxAQhnJHNCTwrUg7GCnDq2TXA9XMvCSVB6eyrZQFBCaq9KNQXxTBmf7B8UnN7H4Glfn4+26N6rEidZ3Y2HTaAr70/+afgUQWS0oEYDj42Y2CvgnL1d2pMm2PSH+tNU/ZOZvIsGdX8zDQbZ6yxKcc9J3T35qV3bbbdWVW/hb3iwRe3XdKyn5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5VgHOKGiA2QU4SHX+fkno94QBSUGbqMBV+Qv9K8cJ4=;
 b=I27+gcqswknus2/qmIGSRW/bnRhu4HfqtL4CuI7C7F5OTGShb1+j9cFElod5L6J8mItwVe33vVV4IIvsM7qU/0IgEU4R8yHctPKgHoKSDJ55d7LPv7WaC7UAq4YuZkbGEIpliREWGyt13kLdOG1NdVgSwa43y8eaC48dWzZEEYexGH3FRaXtwF0HI7C6CxBpkO+DMZaMZaVVVrnbjm9V93Mo/EXR1qKN4aXlogcqqFsomAMI4lAerwDOdf495NEc8OE7/NJE4GkbOATzmTpsWi4pCaAYFBYshr7+6wJbTn11YqRYbGri9GB5T/WHNbrw/2B4M8MQWkGEW6t/qL1uwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5VgHOKGiA2QU4SHX+fkno94QBSUGbqMBV+Qv9K8cJ4=;
 b=FC/D/cQYhiI6ekKHQ8tIsB/6OfV5kKEkT8tz6eIXwaZp7adBn8W3poWCo8DFmdxI6sMwE0qBFQ66ZdaoigRwATm4ZX33LhDZhJbyhV0hK4Caz5q0SntUY0qdxMkw9oveFNWhegfcQMPTM+0MghZ5S+pt3QCj0Pn+NlFLQiNS1OMQZaU/YdOWqDUxue7Xpplho41XlFtJvNloqXW7HaNV4qjSJ6iGUdiaDOBjRL6EeJaUyLKsyy+/VxyeW0/8CaRBZrTbF6gtJBp1Y1Opuf2SS1jtuh8aB/DHTrsj5DIu5CXYMfSm9vEoQkLjxU4JpsXZ1AMGVq9TbFGWYx3jB1ZnDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7778.eurprd04.prod.outlook.com (2603:10a6:20b:24a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 30 Jun
 2022 08:51:17 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e50b:e0b:7b9c:a79e]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e50b:e0b:7b9c:a79e%7]) with mapi id 15.20.5395.014; Thu, 30 Jun 2022
 08:51:17 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 5/5] selftests/bpf: Add bpf_red test
Date: Thu, 30 Jun 2022 16:50:54 +0800
Message-Id: <22c84dbb74978d8062d453f6bc1857502078fc28.1656578856.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1656578856.git.geliang.tang@suse.com>
References: <cover.1656578856.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0103.apcprd02.prod.outlook.com
 (2603:1096:4:92::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e99e09fd-a7ca-40db-82ce-08da5a75b21b
X-MS-TrafficTypeDiagnostic: AM8PR04MB7778:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wVG+DEYNmcvMzz0YdxX/KTJYkvbX00+BS4EtiscnbHW7Zv3zuzgGcCs/d8u9FrKNtyBpUN5xchDtFopIGqTHOpCV6VnDtegL+l8D5a2CtcgLuFbRJoGBiQifUWOpTsNz9kB+NVGVPuBhOGYAap1W7oc6Re9Yb8TeNdGXXKJIXiFAzk9CTWAV+7H+TEFsXkdvXDES8DbEB+JSIfG0FLFLvuypc3A+y0u/LXHiym3x/7I8cq58FCkW32Guc6IUu284033SmqW9pAoct/b57/UbDZ0S0j6Vmy2IbG6ZuEJtEITVm5PoH9UcJnHJnY1q8LBEQ3wB0kTMMND9DawRyi3xC4gg8LugXCVlaYCHY9hhhg1WpcJMBHrE6rJPJoS488mnol6m94lEaQExguVlzPb19IPCpq3NX6vyGxzZy4uC86cOuCzFGvr04G0vM1n7vNwANu/lNCjseMJN/ml+AhQ+QF/l3zbqr90fM9vdk5gu5E4thQLdAYYIgHk9pZxkthsaQmVeo1gXoe0DhJSXXL1mTI8IboLap19t4mrDXV1XwJUyFY2NtxCZWiAbOJjAR8PXZXt5VcfYmndQ91yFvrKQGFOsADNX2Qtey41czY4lo1xJpA0mdKWG/ZRPpfemxAlqmks2xrwGEJrWsFoIDvHBSR8WOiaoSL3FmWLt9EafEVGekzP4hRd8JgEINIRL2Qpt/qWnyxCPvfKbKBZbAdsOqUKyAyQOPucb2xCBGdkElUeVxQL+rD6OOZXJ+LSCtS34Xgu4OjfHT3M/F0iiVeOC/rpb11CvPvILjkcl+SM252E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(366004)(396003)(136003)(39860400002)(41300700001)(186003)(107886003)(6512007)(2616005)(6506007)(478600001)(26005)(66476007)(86362001)(6666004)(83380400001)(38100700002)(5660300002)(36756003)(6916009)(66556008)(6486002)(44832011)(8936002)(66946007)(316002)(2906002)(4326008)(8676002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CPvKiRE8q2YD4aMoGk/A+xO2rQMDsvP7ezwfhOPwFsPGVKyv8bvxCztN0wgY?=
 =?us-ascii?Q?/jLj9skqyhIryCuWIh6PumtthyJ7E6zlK9n0T5uX3bnlMzx1r9wRn3CUVW9w?=
 =?us-ascii?Q?bEpsFNtmIzFGo+toQHBbUmsPr4bdyqFosqg5o3ts03tq8XD0q4VgommcAXUg?=
 =?us-ascii?Q?IQGQchTFfrRBF4ygJ9W9Wg7FbqoL4btYyNgqfac40gdxJFjOpxFBxaNzZg9e?=
 =?us-ascii?Q?5k2zsBki/jts/u7yt5I7b1x7V8/IIiqYfNk7Bol4vR5aFxqIoTkgTt/Amkxn?=
 =?us-ascii?Q?tO+WljlJF+MHZz1QCiRs4Gsjius40moBdM1t4/Vica8y58xv63OyatLN8vKK?=
 =?us-ascii?Q?ddZGeDh40GqneHzkwfg7n47u3ZqUU/gw1LTbuxLo6wGaz5pAwjpyC5d3zIzZ?=
 =?us-ascii?Q?wsUYSRSAu/s6KAWFvc0l5/cnU6wnBrJeWR+nkwkCbJfDjv7Mco6FFRDfzZ5A?=
 =?us-ascii?Q?i9NT5/5pe8CIIqkFCpzE4pcg1JZMZG2vLghxPAWQnA8lyMTeoZd5n74ebUfU?=
 =?us-ascii?Q?ev28H6YL9AvrAe/NjtgyaJTh5s/VYw08uhlqWarJ2sF2Rjmu8ZBn3GhCAj3h?=
 =?us-ascii?Q?vOQuHak411R/EHouloRdOY94xsfwbrfPH8VNvy8lQCSvx0t6FRsJqZyv3g9d?=
 =?us-ascii?Q?UBjK8zy6LZczOk82prnW8Ov8O/pXpezdD6HtOWMXMe0ZQdsGi9LNpyw4BksE?=
 =?us-ascii?Q?dw5sCS10TC7MSoHQg7vy+FQGr/nwnK0WCqBWb/AnakUFLohZpkevYACzFjEV?=
 =?us-ascii?Q?ktGOpvb/9ZgCbSgpPrmhaIm3WBerY+U9+0Uu18qQ6KDQrdGIQyGV2seHZGTd?=
 =?us-ascii?Q?3meCOj56ZR2eYRMn3TMWlHBcN3TvRWvmT2BvFlynop0frEBASmm+WdwceLMc?=
 =?us-ascii?Q?iwpVFsUYJ3Hj0ZQqmQjHZ0Ilinfh999hILxlj/1XkB3in+RyxWl+sii27FQH?=
 =?us-ascii?Q?ntoKpJ+Twzh8jEcmjJI+TQ+fztCgY/XvMU8LnIa6g/UdA1UFJ6fU31AduMie?=
 =?us-ascii?Q?s3C99DSu51+DIHFExFo7KurycGa7XNgn6TTtOcXKQKrlF6sY6WaZ7IWg5s/C?=
 =?us-ascii?Q?EmXS18fukOocB7Pv7Cbj5fGvdHm9z/FEMQgCJ0lTPZBhr455cDFaMQuQCa1z?=
 =?us-ascii?Q?Gk0Ksx7QHKoHDRD1INm+BOIA7LVHGLHyLc2BvdypUD4mjZvLWXxDlcw8LjDA?=
 =?us-ascii?Q?sSxnf8Rst4hRty0GWG7FRVvZ75tySED7GiRs8OPBsF21tiLCYiH8S0ifmJC6?=
 =?us-ascii?Q?CHlZHo7n1TDlbC+OvZXWoPquYRp4LunvtaLlkED9YvhQq77cE0XziTzHEAGp?=
 =?us-ascii?Q?rszY9H6psGCvTv5RRwHbwudocm/6XVbvIWcgZ7geKamLYPex11nj99KtNulS?=
 =?us-ascii?Q?0LJ9+baqjbpjlM+d2hlZ0Cq+/+NHKbOdEsIVasSYpjp/sWlg7+FARNFAoIJM?=
 =?us-ascii?Q?eWUxt7NFtB6Uft+lMnD+EOhZ5RKFEsmv7ioRuMuamQGkGRkPBdcdmSOnnKo/?=
 =?us-ascii?Q?x30eyJAdPIZijTpk0O4w58TSHwmq19nUw5otjkGYi5KdOs3aTnMxUjKxxnkB?=
 =?us-ascii?Q?LWu/sNrZNy1v6wgbj1IYEQKilwZ96HSiesGWA0xVcG7Q1oXykAP+5zSDmI6h?=
 =?us-ascii?Q?HA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e99e09fd-a7ca-40db-82ce-08da5a75b21b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 08:51:17.4823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mlj7b1K6M1Fes2tvYR4Maj+H1vl9fryj4GddXmnXv81wHJO6KOz5dTJQ2EJHmNsZ+/2tSMwUnnHSvFhZfReSoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7778

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

