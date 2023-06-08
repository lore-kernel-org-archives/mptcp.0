Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2053.outbound.protection.outlook.com [40.107.105.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01E6628
	for <mptcp@lists.linux.dev>; Thu,  8 Jun 2023 05:49:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XY2JgAosgdWiC6gvLSmzaCq5lKV//m8jMkG4hAU2spXKwP3Y1yAj9UDdLqpvAn5nisMckCbG3x+1Jr++Us/nvteNaDEBrPoTtJPu10mLaq80wGP+iz7UXsyjUrk4D0nOe+y+hsWR3BJWDIFsr5RNLoA0ddpWXSBC8NDtHZA/z4gK/JMZwEMeW6HdWoliOVv4FMjyvOl2tfPsDlbJUcj3jUmVhP7dWM0gXt9VVuP1avyfiXetGl6QkruO6WVOoXXK8mPwhR3cGFOB1rfr6NjAUjg/g4K7QJaKBrdCudOnuAhSYo6zEXh2uHiMkiVUJf/cwkGQEgDOgPvJSr+lWtowBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3kLsDJO92GB5KeMcQJCS0EC1zZJZe4nOr4bxzZ1uHU=;
 b=Z7Bx/TFVNKqMIc/2pG9DkmipwkB7QAFmQxkFhNyyO7ex+V3LL/S8XvnGtXhaFDwLVu47IPZCWH3sxczfnv1HX5xTMbmo/Rc3l7HtoJ+xmriFht29SMdGI9XxIYaTHDx/CDZExbCoAspMU+f+eauwn3vVUUaV+Q2GjrsmBi0djrGMLFVk600Cepilb0Mvi22X+ayALnjd17qVW/Pn2gkKWqoORmzRq56aGm3im6C5FOq/gJo9P6bid9+x2Oh8KajwYrTfdukpxRShPI9y28KuMq0oo+1GSKE9rxbo74UV60hplCzVcdI1Xko4kFnkcvca+DtyiWFe/xBmHmXanHV+VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3kLsDJO92GB5KeMcQJCS0EC1zZJZe4nOr4bxzZ1uHU=;
 b=ftCpz8gLViYADnDS9o6yh+S+BYW51FQS4lMdY8YguFWFMrjyFpuMP4xsi2NzVSbHdHYRWF4JGGXX/MRTtJ02YrQjIw45Zzy634v9hFkrLtsQvtlfaJJk6wgREaHHOPGgSqSFJbWjzE6yU2Sz6sDHseRSXOpCNJdfCDoM0X81FtXIHj1BrC2yTL06VCy/RY+3eLLmBOnx4Q5+zppzH9i1uBZIYR4GtXli2R0K7K9PkDX8yONAV88M+WMLaeqkNEFjpAInHdUkQQQbkxJPjo6saZdtT+JY0LqpzeBoRlYiPcKWUQdeOG/LTBQhx6Y4jkfwCH4aDzxWfgfD8yslQGNGcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7600.eurprd04.prod.outlook.com (2603:10a6:102:f2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Thu, 8 Jun
 2023 05:49:39 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 05:49:39 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 16/17] selftests/bpf: Add bpf_stale scheduler
Date: Thu,  8 Jun 2023 13:46:54 +0800
Message-Id: <38342dacf7b55620db244a09a55ad7485ea0a13c.1686202841.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686202841.git.geliang.tang@suse.com>
References: <cover.1686202841.git.geliang.tang@suse.com>
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
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB7600:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fb5e9f5-460f-46ad-f907-08db67e425bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hBVoCX+VDn7IqwhKqTYzdbiUmKwRJG6OPgRJNfQ5FOAtKJYBjWgUhO5rHgF7tY1qRhjPSCSIZj1EECIVmmlmvy51TX58k9Pe8/AoQPgMs++d0ixYjewG4D98+RLeXZX27RV/F62PKuCuCuqF7CiszUZzofP14IA9GAAlchYL9AkoJXy0A61Toq1kc5mKAdwsRFAXFQzwwoJYSB4fNE0pj7ORxCAs/NJUmb+lJodJriUr1okyr7gX9A7CDBahmy0DwXZmjM3RnxbNnmLqqDZZsx/YqbbXIpjja2zuFnVnfuUxs487pcKjk2ilXqlhpVLYc7V4CMjunUMnFv2UteomM1IsJvEszJvScuAWqxHLua68IsCf/C5nvjIy2pmwDhmfNfQZenc98MfzYXGbVJVS/0/IQo7gvkRlpgjiCRQm+jHlOQDMtzPE6CBnYb7gNGEcXby5dcpxcqWzNywLT+tH2OciCrFQ4V9FHoV47cMxu8VKmAlqNorJffb3MK50ZbNG4gz+I3rPmDlElqG1QdKExRx0JuAjboAg/AYQ4Ocd9swCDMyBi08968OZyGvrVIQp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199021)(6506007)(6512007)(26005)(107886003)(36756003)(83380400001)(86362001)(38100700002)(2616005)(186003)(41300700001)(44832011)(6916009)(478600001)(66946007)(66476007)(4326008)(2906002)(8936002)(8676002)(316002)(5660300002)(6486002)(66556008)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x6TSnh9p1mJDclMeDmLxP2xBuhNpv7y3WKg7U51QsWM+S/JW4T0qQUTxENeb?=
 =?us-ascii?Q?Yo3MB+FzPGifOCvey7sratEYmEILWSXec+NjwpO2QJuqIoOHDnEHXDpsxFhe?=
 =?us-ascii?Q?LF6jutFJL3NJRf0EBVNxkc7XD59BH6NyUuYv9kz1ZtpdrvIj9rKbp612tqVw?=
 =?us-ascii?Q?z/JszBVPPpMr7jrYavev8QL/RRCcfT4hcIFlxCOpp3L9TsFbsFjnIbf/5P41?=
 =?us-ascii?Q?3Te8gwebK+ereybvlZv5O1DdlgCDKibOd+7AiY3RJ6CU+spFyL7KG3u8za8O?=
 =?us-ascii?Q?7xg2zSe0yqiiqI82H1JoTqaOlh3hTe4X25dnJHTNdQDUMGLnpOgU1VoWQ7iu?=
 =?us-ascii?Q?vt6LGMxDwCB952hwepNqXguOb+L6X2Nl/cHdR4uXG9zKtymKh5x9Fnb3SAgt?=
 =?us-ascii?Q?GgtYcTaVuzyrnJv7yZiSOpUSsoPDIZUjrzKGLAlvJaXi/PChOs2DuMH6d5l9?=
 =?us-ascii?Q?sb2d+3SC/p9XUGcQhphEZrU9N84iqbkEp/zD3kzPvZG3H/eMxAN/y12qtNeM?=
 =?us-ascii?Q?FwW/4UfPaESTroOmapap9gDsK76QTFeMRSASl2LyB5TG5dUTZNdapg1BBY5U?=
 =?us-ascii?Q?SwOayWU9PC17I14Tdb+RhhDeFWAY9WxyCNDLrfCnTv+TXZbNhgWZq6xHNMmC?=
 =?us-ascii?Q?eUxPMJ2/6cpzMlfd8hheckIcoWjXSiQFahMBqPX5/QzakftM1vJc3yAZjsSH?=
 =?us-ascii?Q?O5GyjU7lIfLUymNd708bBWRPNcCxbnmPowuUz9ruq3cdQwetDl1Ym+25WWZB?=
 =?us-ascii?Q?Mzx7QLau0NXq9OdBu7G6Fp5HEzKvf7nq/j9F7eZxAYPfnHQ2GXsy9qJlvoMz?=
 =?us-ascii?Q?2A/kT43P8i1BS2xxZEg5rkdKv3AfstwHX3tb1O7RQE1dRKTBybfYUAj4qzXk?=
 =?us-ascii?Q?LcgZzGh0x6JWqMymO+XUdyCpQ6jAZmlaVysOdREGqnw9eWNManBHOe/hdgFe?=
 =?us-ascii?Q?hKYTRc62RIXNlSl6z7wmEY0g4peKc2cAd6V+LdYVgVDd8MJmXmqkokFAix8o?=
 =?us-ascii?Q?eXwKOtACOLloIoDAzberEnJlnbDbZLPCPIlaFFzYIyffF3iOoMlPIdg1PiCg?=
 =?us-ascii?Q?crwhYh9lsPDEmsr/tdGR/RP9698KBcQ3egTKKf6Riqdf7PnQl6lUwz7vgW0J?=
 =?us-ascii?Q?SZNqhRLYoNFj66NyGpr2rRhBj+/Lag8BWUT/9U7yyIN0wOH/kf04kT1tmRMC?=
 =?us-ascii?Q?vDcR5nV5oZUT1ojxuGaw6+CoRLzllt+DPGGhml3I0p8+/XyYd9Pt3mSJP9Xz?=
 =?us-ascii?Q?Vv6Q4AizfW0uae/K8r7oHZQ5moH7EN6FNksGFl7DSEdJ2VqQb7H8h29f2m1c?=
 =?us-ascii?Q?R7u7dtQn9dLDOchVz4yAXxu64dEfNoGvMy6DOrwlGK1UChAVM3ZL0+P68wxq?=
 =?us-ascii?Q?5pPwGAkmDh5Ci7Ujp4+F4J9tpfRKAdVz7jlDOKRlhKC/XXtXuRlAFAj4AqSf?=
 =?us-ascii?Q?k8Is9nrqUwUtn0or5FiTWlWn5eh1fdFDhwmUmXLz5Z50XuqK9y7kYe0QfC7X?=
 =?us-ascii?Q?uFm/8PiOrgZgmktqYWLPhAlkllrsyzUxo6Dh0/hGTkWmFPTri5S1qjcc383w?=
 =?us-ascii?Q?Eej/AuFd4og38GjrIGtpQsuth70/Le7YrGORO7Pu?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb5e9f5-460f-46ad-f907-08db67e425bc
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 05:49:38.9350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EM2JafBzwpv2eJY9K0kdHbjuAXeClETti1x+3eTNlCs9+lkq/nyxH6yPWmQFvJTMyRaZwoFRYnpdBU9s6pBJEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7600

This patch implements the setting of stale flag in BPF MPTCP scheduler,
named bpf_stale. The stale flag will be set in bpf_stale_data_init() and
will be checked in bpf_stale_get_subflow().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  3 +-
 .../selftests/bpf/progs/mptcp_bpf_stale.c     | 59 +++++++++++++++++++
 2 files changed, 61 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index 927a00f663f2..3e8df90951e9 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -236,7 +236,8 @@ extern void tcp_cong_avoid_ai(struct tcp_sock *tp, __u32 w, __u32 acked) __ksym;
 
 struct mptcp_subflow_context {
 	unsigned long avg_pacing_rate;
-	__u32	backup : 1;
+	__u32	backup : 1,
+		stale : 1;
 	__u8	stale_count;
 	struct	sock *tcp_sock;	    /* tcp sk backpointer */
 } __attribute__((preserve_access_index));
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c
new file mode 100644
index 000000000000..125e84a1e49e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023, SUSE. */
+
+#include <linux/bpf.h>
+#include "bpf_tcp_helpers.h"
+
+char _license[] SEC("license") = "GPL";
+
+static void mptcp_subflow_set_stale(struct mptcp_subflow_context *subflow,
+				    int stale)
+{
+	subflow->stale = stale;
+}
+
+SEC("struct_ops/mptcp_sched_stale_init")
+void BPF_PROG(mptcp_sched_stale_init, const struct mptcp_sock *msk)
+{
+}
+
+SEC("struct_ops/mptcp_sched_stale_release")
+void BPF_PROG(mptcp_sched_stale_release, const struct mptcp_sock *msk)
+{
+}
+
+void BPF_STRUCT_OPS(bpf_stale_data_init, const struct mptcp_sock *msk,
+		    struct mptcp_sched_data *data)
+{
+	mptcp_sched_data_set_contexts(msk, data);
+	if (data->contexts[1])
+		mptcp_subflow_set_stale(data->contexts[1], 1);
+}
+
+int BPF_STRUCT_OPS(bpf_stale_get_subflow, const struct mptcp_sock *msk,
+		   struct mptcp_sched_data *data)
+{
+	int nr = 0;
+
+	for (int i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (!data->contexts[i])
+			break;
+
+		if (!BPF_CORE_READ_BITFIELD_PROBED(data->contexts[i], stale))
+			break;
+
+		nr = i;
+	}
+
+	mptcp_subflow_set_scheduled(data->contexts[nr], true);
+	return 0;
+}
+
+SEC(".struct_ops")
+struct mptcp_sched_ops stale = {
+	.init		= (void *)mptcp_sched_stale_init,
+	.release	= (void *)mptcp_sched_stale_release,
+	.data_init	= (void *)bpf_stale_data_init,
+	.get_subflow	= (void *)bpf_stale_get_subflow,
+	.name		= "bpf_stale",
+};
-- 
2.35.3

