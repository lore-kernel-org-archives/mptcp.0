Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2047.outbound.protection.outlook.com [40.107.21.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7859A7F
	for <mptcp@lists.linux.dev>; Wed, 14 Jun 2023 02:25:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EjUs0KsZ4YxScFdaAqzj5ENOXLjcF4L1p0xF9TWZKc4l0Jqxz297+MFk21TjV7PCzGXIOfVrsCmnpcXd2WbFtQ9MTChsjhtj4+MWacODnbb4f4bWRv9+KMJu9qwrBazrQBFsqC8R1EBxaAqWi8tqlzDi2hmqZhEEXXBBGvS8hMN+pZbudEVZsiuFVqnmyHXC2DgLHESSHr+PAokElwzkdu0NBDd4uA+0chs2Bhfn6c/CISiZeDYRM5zaP6ICm0MAdwOjzdRJ9x8sQjHqa3x+lefLgyAJ0tQyY+aLhEgfYbRDMbuMefF5pGisGlpcBUl/ubVOoNYStY3kOAmHuldG3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4FuNGyigQsKmmaMlPQf0bYurGQ7kbhBKgBT7C+XdUz4=;
 b=Jv5e7j8chVQggNxuZZSxtPQh0B7D+TjVRtHaTVT1/1AMRiRmoW97Qjm75sfcUpi0dVpAAdaAUFgpyo97BrhmVFwYRa6Tr+BAqUgley/GyXPSIkBHzibYQthwsS7Nda4D+Q4gSpXs9Ei8OlYRiOcLvwvKKkRpHXXdeb94GZ+vs1VwKvJW3pRuhDjHuxnMzSVhBvU3Wq4XI26BkCiSD46B3b02Pd8ptvcRFrWqvl2JWmVDZD190ay/KjG+bZkqBO0i0tC8IWgObMCYy2+z9WRk+8wDllrTrjwAQHU1FlgFMaEjUZMKqpLN4RnO4H3HiWEWbWdt00dwKD4NntPLO7MpwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FuNGyigQsKmmaMlPQf0bYurGQ7kbhBKgBT7C+XdUz4=;
 b=hFeDu2RfJJ04FOqI9mlm433Z4Nwgvy8ba9wJwdnYU776g8IMCKQY7Cu06H9I4VY+gUSAJE61oFu9XUykJSLIpyqf1B6qHwf5zsk49GqPGzQL3d3aC6gzJY9zW/hzJAIzNw6Ro5b3SWiTlCopgYpg7+0MLGd5DxqbIUMd33YPmt6EcJOYWIXcJF0VdAQP/VYMcX2YlAqvNfqMZtlfhyPhSVUY0Bz6OQYPeyG+OgLG/Pb8QPzU6v0A1PUghU+7Hd8gcPaYyhPBy5YL7Brd/OS/KG0iaXgoxZEijq8O4WEYKQOuPNkZPaKT8DCoC41ty7OFyahCDLce3s9zDDDZ9eyWfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS4PR04MB9241.eurprd04.prod.outlook.com (2603:10a6:20b:4e0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 02:25:14 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Wed, 14 Jun 2023
 02:25:14 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 22/23] selftests/bpf: Add bpf_stale scheduler
Date: Wed, 14 Jun 2023 10:21:09 +0800
Message-Id: <5c5b5f2842be7756b7293cf006b4e358d7c496b3.1686709116.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686709116.git.geliang.tang@suse.com>
References: <cover.1686709116.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0050.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS4PR04MB9241:EE_
X-MS-Office365-Filtering-Correlation-Id: dd0a630f-d77c-4588-9c25-08db6c7e9619
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FzlDlpbinnF8Lka+pIY6GrZgBYHO780uruZWBnnSRy+UMxKxjqcJ8VoiDFZtqJRtfqOe0goyevOXEL1JFFeyjW3lkhBn9TbWpd+/7lvyCzz9I9qiwygaecFT1GRdEd4azK/oT100TDLbxRJS8SWwBCaO1xaFufvJqVg9szgvjzjOSS0scjyMXJqeL2BO1Q2mgTwbuOOfWYy8JoVcoRDOmdi+W5CJE3hpI1/xGLwZSuK2XNUHGrRop9VVIEtupTq1XFwcwvKnFq2Ngk1ftZLzdp8gKkGVD5ILehTYUIwz4jJ55vHAFVNDqVwzIxhTeA1VcmlCu93NY4FNUkIeT6PGejjcOUHNh9sYhu305NWijn9W1ZGIlRsRKFWvaru9tKw2vuK3FYQD4VNTZ+Jr0gMOnk6nagH8ln7eq7bCrjVKT9fQhpItNTlB40UrhvyfivnGzjbE7aLUJN/9lchscKFlU3cua+DwNDl6ynXd4mOqBDRE7BjD8IWW/B1u/tiKT2vzc6tYVTr6bEreZkNCy7aVp+oWhv4DKreQjRx0OLLKTfl8V6/syjofjaBqLP4GmhgH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199021)(478600001)(8676002)(5660300002)(8936002)(41300700001)(316002)(4326008)(66946007)(66556008)(6916009)(66476007)(38100700002)(2616005)(186003)(6486002)(83380400001)(6666004)(107886003)(6512007)(6506007)(26005)(86362001)(44832011)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p3UFzTUDbySp67+IMcy/ZEb4OMsGuSCY9MvveMmF1zIAPFFfL6vr/oTQi0tV?=
 =?us-ascii?Q?Yzpiv22+6fJ6vWBi31uYGGi5Pji9irsu3cMJYtU5nm1DHVDNiEV/eMlWSKj3?=
 =?us-ascii?Q?3hpEGLabsvpweX3dB3j8v9c68KRBiMmT93mYyFQ6PUqLPBE+KkrSfyRpbPfy?=
 =?us-ascii?Q?FobrkvJiGe8VDJkiYIIictX2dljBWCu1G1iZlFrtPWdlW7WdXiipZctlCRam?=
 =?us-ascii?Q?2rHaPfe9oKwoHh3ww115eNjOT4DxavpQ5LN0bV6mYcqk0uXmmwVVIPOhZ0fW?=
 =?us-ascii?Q?J1Z/FvSJdNovJKFXpCGmVw9O/QovnmQNoLrFRpQeHMDbyFYrP1xYx3DLTRug?=
 =?us-ascii?Q?lEgbV7ANjm2pxhpYtZyq8NXvd+lCURT99XcmiV8AjMH0Sb6A9NGJ6TXoym6+?=
 =?us-ascii?Q?VVO5ywnOGPti3Nr1i0Sk3jWgrr2eNSBTsK9H1EnWYbfKRnLQWPUc9s0zfGO1?=
 =?us-ascii?Q?HEyuKEP+GKn1kJL17rYIPht1b1Ksg6r9E7G0MrJE7pVAakyxKh65TtESKUiI?=
 =?us-ascii?Q?OfytsXtfXIw1Botaz8nCpXih4N+Wgkuq4MjEHWuy3jTbgRknz2A3G8mfdiKk?=
 =?us-ascii?Q?Mw90Mup++aEsgVYsP1iRljssy1fXFzP8oBC+GpItA5UhG3HHQRcnMZmYGTgb?=
 =?us-ascii?Q?JTJWUma+9hPKT4q5dZYhZFodwgRaac4oS1/CNIg159fXc6jNRbbpjJa9SRo0?=
 =?us-ascii?Q?mQJw1MJfGqN3DhzeU3H9Vksc/3W9V6vxkOhT74pHuDH+af0r4Pm7HWT+qHrm?=
 =?us-ascii?Q?DJHejpHK17jhLqknZsqTHDAtMJlXve0hL7cZZylA+4ZaRQNqw+A03GBC5AC+?=
 =?us-ascii?Q?i01gdrTOlLIjnHEdojTTADeFZd4Yv21ZgiP3Ip/g/BDztSzdtTsKnlOF3NLF?=
 =?us-ascii?Q?enXU/mdHYi7qq63w2hPumI1iwtTGhFXC+tYFzMevMeeYNzQCcqIuDQPJCFgJ?=
 =?us-ascii?Q?7G0WreEj32XtvWDDh97NvWyPzoxGJtg/i7SPcPC2Nt7s5BiQlLfKKuGmDxdw?=
 =?us-ascii?Q?+x3O3JnV1hahZyDs8qeK/5qf1O+kHZhkzCMmJ5Ylrvk1jrjuiiS+tNCHHsS5?=
 =?us-ascii?Q?SFU9xem9um3+DicW7t0TT/Tg2nn3RxvsIVe1ekXnFtTYMjhPZ+VuBtyDHTSG?=
 =?us-ascii?Q?oiAtWRUcA5oo6SM4BhxbTbfUtTrN/qtb7OuqWIAxny3KT915hi5WA1CE4gHv?=
 =?us-ascii?Q?dxeNMGKkM8zCNy+DL19cnSLBVyAa5Ih4+81IlakNGKCWocpvvzMAywp/SXD1?=
 =?us-ascii?Q?mM+wYKer/Neov1FSHsJYlXhq0zyjShRcroqBuG98bVB+f/NJNg8vk4ifOZ8M?=
 =?us-ascii?Q?FS/e3zVnVEYFJXjzpo9eO8ucc2dfjZ8IQrm+SW3yjT7b+YQH9VD5WXmP0WNS?=
 =?us-ascii?Q?armtMltAOnMiyBfBtrYEeTych2wMcyDGM7SQJn2zl/VTJ6gq91NTvg7HXLXF?=
 =?us-ascii?Q?Wcf0SQkivVynZFRNXRW+aaKp6kyNYGEheySmznusOui6x/BgSSfSdYdc4A/V?=
 =?us-ascii?Q?qF/s0aptDqMu6uUIMtu9C2NqhbLN9jPuYVhyeYkOy0DHKxuCE6oLMB8jdCdH?=
 =?us-ascii?Q?0Dw4Lf2oP7k5EWMFrLT9ULH3vJNBMn1HNjAyz23Z?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd0a630f-d77c-4588-9c25-08db6c7e9619
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 02:25:14.6683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pwk6Qks7Y798mFTxu3ciayAlHKnnVk3o2nuKK1z25T8Vq5N91Ecmcf3DDomWEEkuIiVf3HJHq/v8PGjO3IHSNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9241

This patch implements the setting of stale flag in BPF MPTCP scheduler,
named bpf_stale. The stale flag will be set in bpf_stale_data_init() and
will be checked in bpf_stale_get_subflow().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  3 +-
 .../selftests/bpf/progs/mptcp_bpf_stale.c     | 65 +++++++++++++++++++
 2 files changed, 67 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index a0d4d05c0642..e52dd795cfdd 100644
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
index 000000000000..4f21211b3931
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c
@@ -0,0 +1,65 @@
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
+	struct mptcp_subflow_context *subflow;
+
+	mptcp_sched_data_set_contexts(msk, data);
+	subflow = mptcp_subflow_ctx_by_pos(msk, 1);
+	if (subflow)
+		mptcp_subflow_set_stale(subflow, 1);
+}
+
+int BPF_STRUCT_OPS(bpf_stale_get_subflow, const struct mptcp_sock *msk,
+		   struct mptcp_sched_data *data)
+{
+	int nr = 0;
+
+	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
+		struct mptcp_subflow_context *subflow;
+
+		subflow = mptcp_subflow_ctx_by_pos(msk, i);
+		if (!subflow)
+			break;
+
+		if (!BPF_CORE_READ_BITFIELD_PROBED(subflow, stale))
+			break;
+
+		nr = i;
+	}
+
+	mptcp_subflow_set_scheduled(mptcp_subflow_ctx_by_pos(msk, nr), true);
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

