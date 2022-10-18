Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20046.outbound.protection.outlook.com [40.107.2.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A854A24
	for <mptcp@lists.linux.dev>; Tue, 18 Oct 2022 11:44:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VwPCo4d643uAkSJ4+Wv0tZEfjCeVhLw9XxaY77Gq4+Wc3qvsLWgqQclnj6ibd8XXO/0DzDDA6ZIv/lP8ypHi2dlCRL+w/kzrM8YsL2O0CiHM2sADNqhHyOPc7T+rPL7mGX9VksnS+MOLieHRWxyEUq09QNZ5CZxNsji4vGVtgWuBPpRzgZjhSaMvvjcxa61TfjMHl37OrsIJejfHly84ZuANiRgGlvebMLZ83ZZSEzKJ3MZBcY7OryVBO2wEzgD5MqnUvLX28pPvoIEaSkwpG66Jvr5nbQv01lCoTzT8YR3CRgbg3D1u9XPa8nTEZQz3hclYqqKrPk1I6mju03jgkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1wOkWwfSWqD441BoPgl1bbwBkTnvH9YLbUx5Hqk5aY=;
 b=E0efhqYnXyJgytwburNsGk76ksArV8vvuBCEqUWA39EyodjBLjtTXaXPvHwAiILSwuvg5Zl4decZsF+qBB1zk4ruKMCBTDWEOFJde23VSynJ2SaP9eSZy5kxrafElJZ+lY1bvcMmAhjx07EKNjp/01oLQy5tzlqig0SMBAEJ/YweV0hNtkTHbM7II2jrOIBSeOG2oVDrPkuAoqMKIKNaex19WB4JBRugboozoZqR4erbmyIHqakSLx4GvEzWnoZVr5wzFtG6rWA4avqq+dxC/DL+4TkpTFuPd9/Upklk4sUdMJcAaOro//kmmTpnlgjdLRyPPQ5HWZUK/Rf6GBh/Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1wOkWwfSWqD441BoPgl1bbwBkTnvH9YLbUx5Hqk5aY=;
 b=TzEPGapXV5z9/c62lWdQtVDfovwZZztwZYN4Met42ri+3FJtEH+UVuPLfCCsDi/29FRG7adJS4XeVubOsU/HcT9zxhUP03k5QyqfBeS77/i3MLi1Ll6Qbk9Q9xgeuKcKkhVgcYa6gb/h6lbxMOAu7c+if1ZNbUY9a8kfWN9NwygtVQxzktUBNJEv2ysK0do8zkt/FQcx3NjLnSZL2WrwenCoB7QJphmU4cEG6yfmdwmOrwEbB6Z/Yj4nhWzLCi/j9fhUNn/fi0hKk/IMXIz5XINKPaE5D/IJ4XaN+fDjTeQNNwMlQPbKzZ1RqBKPxBS2FhdqI6wJWykqEH9SoRYPfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB6919.eurprd04.prod.outlook.com (2603:10a6:20b:10e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Tue, 18 Oct
 2022 11:44:17 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45%7]) with mapi id 15.20.5723.032; Tue, 18 Oct 2022
 11:44:17 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 5/6] selftests/bpf: Add bpf_red scheduler
Date: Tue, 18 Oct 2022 19:43:17 +0800
Message-Id: <20221018114318.23627-6-geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221018114318.23627-1-geliang.tang@suse.com>
References: <20221018114318.23627-1-geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0072.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB6919:EE_
X-MS-Office365-Filtering-Correlation-Id: be7babac-a29b-4e47-f1bc-08dab0fe1667
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GEbXrELVQMMsT6bP0m3mQ6yj9igli3rDoUkBTM7f3V72UcQA7z5563+KheBEgkg6+otXV9Va3w4qAGLA4QYIkF2oMlGqaPqSuoWzix2CYOrCswxLKGuAzt8xWdX3CCwhOy1c0eYmOt31QI/Bs59TXxY074/rYKZbS1mMFverCfjnYFZFqToPqi6r+jEkKHx27IhneP+39Afor81Z+NDz16sF2j5+m31HyY2WIu7D4cLrXSaJzIxsYD2a35ZfZ23GfFwUDhChSZ01ZYPatVV/5AvELL1ajLztwXEF/n7slgqIfQJKXIv99XPvNPCHH/YOso4Y3k70KSHCMLR+oVuErO0PbZofHyUI41KcqZ4Z2ogMLhWkMXb/9zgE6Josotk7oWePdaD8c1MwhZ6CXkKunknnbUAIXMEApPRtid4QUwnuZ3cOYTJ19M00LIKLr9NdcpEq1tOPxr+4KjolThyYlu59mcewPPujMtOzQ8qJMdPBoa3ZpbCUHtBS9gww9MAMd4JVQ3zZJDLii0AQd3Jgdhf5gJ9MvwpnPD0XPz1r7xpvfj5gXEBAbFnluAD+8BY3cd8njsvuo7CgwoYAOEUtmoh8WKt90h5px/9CP0KyBRUHqGUcvmMD3xjD+NyQKjKYtmdSvkZSzH+jt8dIfo36pGZmc47jWLfIwQCdY3dfUIdqi4SZjrpQcEzj/353h4MZxD0H9WRnzHJyaGm5asvO4FJafmKYZ9yWiokZ3XEZrX09UQHu9yDF9PRUTA2yuFsq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(136003)(366004)(396003)(39860400002)(451199015)(6916009)(6486002)(2616005)(186003)(1076003)(86362001)(38100700002)(2906002)(5660300002)(44832011)(4326008)(41300700001)(107886003)(8676002)(8936002)(6512007)(478600001)(6506007)(26005)(316002)(66476007)(66946007)(66556008)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pGbJoRoQZjl3GG8sKjUkxyYXpLXatr9gZUpgDXszxtgLqPVRgGArlLLNmaFQ?=
 =?us-ascii?Q?6Nw2jXesRXVgmGkZKLc9VX//7IQ1VZ7ANmTjFB1TeP7DoorzqyGDuutgFLYS?=
 =?us-ascii?Q?SS40RIoRdsYAue8z1lp9wDiQhbL8iptxTythaJns4fD6jSPPwyE8ayNsQfmv?=
 =?us-ascii?Q?6w4do1Qn2NXqiq777N2lDcDnZqb2LjTKW/OmBlCjtCmCLVh5+3y9AAtNGqud?=
 =?us-ascii?Q?JQnuTZ5x5c9VA+KeHtCBfYKkOk6SOOLWHJmEvKwQkKOPvjVUqVsgZYDT3k1E?=
 =?us-ascii?Q?rOZGoWAqfNX3tavAq4pRJR8DFQhxQP2wjrGONvVEJnknChA1uvDHxMzt/27S?=
 =?us-ascii?Q?zUlgQnfej+cxGdxBb33rL6/fxs9Rnq2Ddu69kPE0y4QmX5i2tDduLG+qqF8J?=
 =?us-ascii?Q?1cRmB7iU4D4u2c1AF3irHG8VmKPWKxaS3AazQf42a/AMfFDoBWIU1kfLihRO?=
 =?us-ascii?Q?+JzdzyZhh+daQvz+n5a9M5SiOtUDIpqMvA734br1GtgUotXbnn+Xp+Q1TomS?=
 =?us-ascii?Q?04fPCDBfMiK8aXMiEd9f6//YFSpjV/LkCBzJmKxt6U1WjUuEvILhCRztJBWI?=
 =?us-ascii?Q?fnzuLGec7DgUs2vprO6pbBXtD4mbt6IjEgpoGKo6N0SvfqInzJIPLMT9pAxL?=
 =?us-ascii?Q?0gCfrduRLK9WeJQewS8nInHV2iEatz8mkyRUFP4RTs8a8nIXkjTffTrSOvQq?=
 =?us-ascii?Q?TYIyu8ffjp13qGbtYvxBCjwZpJnbef1Jo/8m69pBuVDEBXEAi4ynmjUMrJoS?=
 =?us-ascii?Q?kz3iIUOnywu2nXxyVtME5oVZX8GfQdQqKHK+H5UMlwEnugLGhpFXeSL5frgb?=
 =?us-ascii?Q?oKAVNaILRjNss7dc+gy+FumF7jTp7NOcTwZ0ZdT2HenMS4i8uPFKPJ//LMxw?=
 =?us-ascii?Q?WBHyWa+wlNNuD6G7N2oHqX82u+QnF/PMun0RvdzeXF+crBcX9Ci2BoKVP6We?=
 =?us-ascii?Q?sLpqDqxgz3j267/3ATG65ALo4WE3g2o2gyFPtbNlOsWAakgEFFMdhhFEvFft?=
 =?us-ascii?Q?Pa6CIpK/17mDrLyQrTMr46P2Bz2wmcaL99uF4cQBS+1Vr65Yde11pMYFzydB?=
 =?us-ascii?Q?SrGErQzfpLR1+GXf7C9ESBRYeVcK9Cythml/4yg/VXKLJawIRSDtW+eVtk3I?=
 =?us-ascii?Q?YNi5CWIJNUnPifuGja1YjqG2rInt0/CU4E6ctvM8wgQbWrPrFdMWYVMMrd45?=
 =?us-ascii?Q?BxY7afl8twp2ZOyHX9PARMs99jiyKHF7qJVsY521jaE49HqGmwjIJbTa+M/+?=
 =?us-ascii?Q?cLxGaKoXz7rTdiIceZsTuN0FpBT+rbYvtJwkGPY6+PPu9dxxvqCTHEsFzvbr?=
 =?us-ascii?Q?nnGk+goPhqh+fX34KHsdKrLXwvBlklJ2nqNAJDl4GuVHm5WbG7kABZkMMxTi?=
 =?us-ascii?Q?S0K3yV9UBXsuCE1jqxP63EFEUZkt52OQNJP8Hth9bDJvkV0ITRzFe7A/ZO2k?=
 =?us-ascii?Q?tKHvUMXLugu5sS1xInQeXXV6lM5rEqNlHh6Hx+Pe7kecyVj8wWtTxQILQEct?=
 =?us-ascii?Q?tmxmxeMmGx5BHTgnW/hUMvpMH65hWyj45tawryXDb7tOYJ7VcoIRI9xLMPD5?=
 =?us-ascii?Q?IWMXImc4me/YmAIozu3ZP8nS+0QjTJtZQpxfkSBqhQ0waQVX+0pNMzE1wQi7?=
 =?us-ascii?Q?Lg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be7babac-a29b-4e47-f1bc-08dab0fe1667
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 11:44:17.4657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JrSw/yOU4QI38gGHoQCSppXcRWdetAvVgmFcOLXJJeROFkQGLu7LfB3S4G3ewb92xxNPZKhXCw7a/Ixv9UhT0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6919

This patch implements the redundant BPF MPTCP scheduler, named bpf_red,
which sends all packets redundantly on all available subflows.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../selftests/bpf/progs/mptcp_bpf_red.c       | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
new file mode 100644
index 000000000000..f8a9b4d1630d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022, SUSE. */
+
+#include <linux/bpf.h>
+#include "bpf_tcp_helpers.h"
+
+char _license[] SEC("license") = "GPL";
+
+SEC("struct_ops/mptcp_sched_red_init")
+void BPF_PROG(mptcp_sched_red_init, const struct mptcp_sock *msk)
+{
+}
+
+SEC("struct_ops/mptcp_sched_red_release")
+void BPF_PROG(mptcp_sched_red_release, const struct mptcp_sock *msk)
+{
+}
+
+void BPF_STRUCT_OPS(bpf_red_get_subflow, const struct mptcp_sock *msk,
+		   struct mptcp_sched_data *data)
+{
+	for (int i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (!data->contexts[i])
+			break;
+
+		mptcp_subflow_set_scheduled(data->contexts[i], true);
+	}
+}
+
+SEC(".struct_ops")
+struct mptcp_sched_ops red = {
+	.init		= (void *)mptcp_sched_red_init,
+	.release	= (void *)mptcp_sched_red_release,
+	.data_init	= (void *)bpf_red_data_init,
+	.get_subflow	= (void *)bpf_red_get_subflow,
+	.name		= "bpf_red",
+};
-- 
2.35.3

