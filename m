Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2049.outbound.protection.outlook.com [40.107.104.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D5F110C
	for <mptcp@lists.linux.dev>; Wed,  2 Aug 2023 05:10:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bLNqy3OplQYuljbkglK40hUORbPzHRLXDg1RdpknHlvVpS0v9wC9nP9Tr+GGpyWjICTzmx2/lUjVvCv6myuhDs8FVXW/fbwcIq2wg+P721l6EUKZ8oeqfvVDJkkOoyYdVPbgW8u4OaAkeH7UbtJ4pY+ihD5yWvivOFr7ECu1Qq5rtRgTaZ1yoVFcD9whrp+HIiHHlkGuKgLsGB3+abdmftFGzn3//7pqUC7ubVgU8uCAKm9JpB3moF3gplf9QyouNIOhM36JuMKjxELULxtbG2YOtTDRRK+QjMDsCbTxGNdvm8Kb1IG6Bmwf8Q6/WIAPJo+V1n3ZP4M9HNrSd7Scqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tbGwFbCdr2mkQRdV+xI2pLX99oVkc/8Mp4SW4WwcU3Y=;
 b=XrADlCdfShCM9UKHEFUEwbfP96DOvq454dPE/Di8XM1nBNOYiaYW3DYhczxnHtkz9oBp0YBLmh8UvxdxrkNRXtgZo/pekImJcgc3xrXA5wskIZJvZM1qV8L2KakJiFeq7sz7StHaoSwpZffTUkMkCGwxGwdOvaHqmVDLw2CmJ/QpnKbrm0EHzcarvWbypzQtRMTMHOkuEwDuCdDMGruSOS0PW0+p+Bxp4g1pZ4l6OA06t22SOqpBkSwfhwwEM7L7mzlW0bQC4n9/nR8ff3FY5XARV4ctgOXxveXlGpmLR1+6TFkHJColjPvv8mIa+Mly8z6aC9aWf2rH3AFWFyA0vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbGwFbCdr2mkQRdV+xI2pLX99oVkc/8Mp4SW4WwcU3Y=;
 b=GfJraTutzlGokGVleRmViWFbUn3fpHQUQ0SUDd/PV3ZQxz8oU2GEDr52LRHuYE4jazIyKU1sU7oRrHbp9ldpo73wAaioW+i7fRdQ6CULbiMAIEOnEP1HXCU/yq6wk4IKUTGRBJez8x1pICABXf4XgfPvoiYjDKC+3nfJsMA4g4htteKEcBFFPmxKwVuXTK9c6aWGZesnU20xtRFCkWKvMwuWUK6xMZGKKHdybVzqaXVZtC1yZtk6jpz6gz+naJtSrlQ4v5b+wK7nJHK9LyBoJzh/kf8YZxSP0E+Ye4+09FqUpFCQI4eH6b7v3z22OcRRl8KAuLTlHPcYYN6Cky+VFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AS5PR04MB9826.eurprd04.prod.outlook.com (2603:10a6:20b:673::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 05:10:41 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::6480:1775:c36d:b797]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::6480:1775:c36d:b797%5]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 05:10:41 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 2/3] selftests/bpf: Add bpf_stale scheduler
Date: Wed,  2 Aug 2023 13:10:19 +0800
Message-Id: <61900b09a590bdfce5f744e3ee87283e087553c0.1690952908.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1690952908.git.geliang.tang@suse.com>
References: <cover.1690952908.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0180.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::20) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|AS5PR04MB9826:EE_
X-MS-Office365-Filtering-Correlation-Id: 62031079-27a9-4d16-5e70-08db9316d0e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZIS/s9zNiw1bN5uaApyUtw+mPXRxXnCTPJecpNij6tm71AR+zJLX3rtgIkN4sCCWuEleSXreVuvuv8YDXhjJf8w8LVQVw3WHt0NCg/snAFhJW/Y5nDibBhvKuF02Pq20L/HbSDTtEwqDKJYQlbokGDte7xSXfZfvENYX+zjIao0NkhCADCQN83q+wXSkgYWtns2FgfJO+zlmJa4rlcP94W2HWWjy+c7uxS8p7kIHLB+jtd/eBuCBK1sa3HZ1Ldsw5qf/zurlSktF15EvdcYue60Ex5gRy+61VVcSTYPFEQdq+rxpQAQ+xmpsWu7+0zvVajCMRqjQH9UO2IbGEjh9elNPJGdo9dWIt2MaCR3ShlBa/0pQt/VzsbbnMKXhTLW5epU0HXEzsL4JRP5R9asCSKkkXXh8OmnNv7uFSzdURGfuJ11jibtgEmf27NR3+5BodbSfPSEWPoIig+C+CyPEhVLyd7RBTbXr4AfLIiwPxetzFRqq6bN7d2tkAaZR9VtRlZtVJ9c5qPCZQHj/L0portb6HXiEqF/daMTuZZu93YveDez0vM8oeF90oYpvO4LA3BEkB6nmabeWCpQy4Ev5Re0S1zXVQa3asUd2qOs/KLE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(39860400002)(376002)(366004)(451199021)(44832011)(66556008)(66476007)(6916009)(4326008)(66946007)(2906002)(38100700002)(2616005)(186003)(6506007)(26005)(86362001)(107886003)(36756003)(478600001)(6512007)(6666004)(6486002)(41300700001)(8936002)(8676002)(5660300002)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qIHo8Kc7dC/lQ4bZt6ZLDFH7TRu9lFE3uAfWxB8g293ZflCr2IgCBFu+wMaZ?=
 =?us-ascii?Q?XuUOMS+CzhSKAnJnjXL2AGUeWLHxtE3vDW4TIZi3qLjADBKUnZJipZey2FV6?=
 =?us-ascii?Q?7/K/qmMb3UyU2rZ1dxWsCoYKrDArYRtUAeKtBN5bJwU6mUVP3G8P0Tpq2aqK?=
 =?us-ascii?Q?DgTJlcv4Uzxo6WFhf9a0R1sGoilXztqTdFeCjiZIQAU847i/Ohnh0j/SB5+c?=
 =?us-ascii?Q?kzcjE13mLdzwe0u5bA+sBcCJIryEZ715PpJE3bz3udBeFeEMphlHn2uYaw3H?=
 =?us-ascii?Q?d9X0JDiPPTRGUf+tLlcdV8uf7+ldR1LN4jpMy1yQPmYO9fycSxvggDsGrN2e?=
 =?us-ascii?Q?jiJfxo4AhS88X6pO4EI+CNAEeMtbYHJtoVeIiZ2UdPoRi6TsTUlyoRmwFZPs?=
 =?us-ascii?Q?gUbu70EWaNbsQVwL4LtbrtjF2sIex7JGCxKDuzZY75wN7c5MMCebDWKFWVuG?=
 =?us-ascii?Q?J8emqRfx5MtQs2IJDHA59vNyXdQfUbr4eSdB5bURgH/EXvaCBYMBIL0AWtPq?=
 =?us-ascii?Q?/pEcvtVi/xEzaB+mZv+TONEyDtXCaRkI+X2gn5eujWusJFIEdWC2OgEm85/J?=
 =?us-ascii?Q?obY/nfW7TaXzgqq2UNzSwbKd8iLl0tMTdo9YRc0Wy6/Ax3r4wap0xF40zmyn?=
 =?us-ascii?Q?t7zTZ2Z/wETH7XAheQBzDE5NlfnkMbTlBHHDtCY4nbU3DI8l4uwTmGDLC/fW?=
 =?us-ascii?Q?coawdu3XtGp1cV4dnmcWD6ukbRVET0eJQMLADevK6/9DiNxUUL8zS01XTKZw?=
 =?us-ascii?Q?mMYdsJoO7yoErG8ALj+htJ8tnImn6fFcQIVlCLfNjNcYzErGLP7miiILOosy?=
 =?us-ascii?Q?CFnhIl6P+APX+u5A+JAjr+u/dGvdPu6TUTEIxmunRqH3j/r2KiFTSBFVblmU?=
 =?us-ascii?Q?lfW0qFU3XWpL2ZT5KcGJ3HgSMjJLZ27V1ScwUzLktOKhu8v/T1/zVhlIlbHB?=
 =?us-ascii?Q?V2GxxXph+aiTZNNgBpwmWY9H64y1w0JBDx//ddzerzCAuaCfVfdTZStUBt4q?=
 =?us-ascii?Q?WzLaSYC6XlRrzRslBiw7RsNnRu6qUfqsLMxUUYC6PblJFxZueOLHYETjhAe7?=
 =?us-ascii?Q?KDLhzLaIVJKVbgQP8bj8S7+0iNnq/EHGCGkypKo8mr0lhqMuNJCzfRUmZI8g?=
 =?us-ascii?Q?WdKP3Rx4A37Rm/8WAvBHsgX04VmIVTsQSZZq0SChfmjnm44ftv6V82kj8lvP?=
 =?us-ascii?Q?SsxBL2gJseXcIOahYPgvywVlpQ2Z8TvsIBIBk3JFW+pwIeyiwStvdj8gWbuK?=
 =?us-ascii?Q?ulu0FC3dhG3lFx1cWoOMM1pLEi6btlhmiaLMklwmGzZmjInIE3MJRFLB6Viz?=
 =?us-ascii?Q?gBnHSUDKu+1I99z5UNoew6TYBY3tB5Dxn78NFOQKso9asS5lHzRSFH9BJWB1?=
 =?us-ascii?Q?5oZCrbu5MJVkodOoOz56g8hI0o1tA4WC7+mIarE3z44uMzB43zU2lH37BIeb?=
 =?us-ascii?Q?K+SnkMikNMZ46BWiqcZGqVhh43gRyDvhZfruKjNLYvDmfDH3xu6SvUjHD2hY?=
 =?us-ascii?Q?MFQDeNL1vvo3riIy9yLL3yKberAAGhVlhYzFfSorSTzFFtqQY+X9mVQnUgZ8?=
 =?us-ascii?Q?KZjzMw9n7hO36hysKTmRaELgt2HLVDadzMC+m5kn?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62031079-27a9-4d16-5e70-08db9316d0e4
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 05:10:41.0659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ps7PbFhcpNlgGfAxl4ygzCJ4vVCYJ4XNuLtZReJBc3yj95Ur6WJJ90xczJjEf9dO/6NffwWkH6Ps08fWmTPzww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9826

This patch implements the setting a subflow as stale/unstale in BPF MPTCP
scheduler, named bpf_stale. The staled subflow will be added into a stale
map in sk_storage. Two helper mptcp_subflow_set_stale() and
mptcp_subflow_unstale() are added. The subflow will be set as stale in
bpf_stale_data_init() and will be checked in bpf_stale_get_subflow().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../selftests/bpf/progs/mptcp_bpf_stale.c     | 155 ++++++++++++++++++
 1 file changed, 155 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c
new file mode 100644
index 000000000000..44010ca83af3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023, SUSE. */
+
+#include <linux/bpf.h>
+#include "bpf_tcp_helpers.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct mptcp_stale_storage {
+	__u8 nr;
+	struct mptcp_subflow_context *stale[MPTCP_SUBFLOWS_MAX];
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct mptcp_stale_storage);
+} mptcp_stale_map SEC(".maps");
+
+static void mptcp_subflow_set_stale(struct mptcp_stale_storage *storage,
+				    struct mptcp_subflow_context *subflow)
+{
+	for (int i = 0; i < storage->nr && i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (storage->stale[i] == subflow)
+			return;
+	}
+
+	if (storage->nr < MPTCP_SUBFLOWS_MAX - 1)
+		storage->stale[storage->nr++] = subflow;
+}
+
+static void mptcp_subflow_unstale(struct mptcp_stale_storage *storage,
+				  struct mptcp_subflow_context *subflow)
+{
+	for (int i = 0; i < storage->nr && i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (storage->stale[i] == subflow) {
+			for (int j = i; j < MPTCP_SUBFLOWS_MAX - 1; j++) {
+				if (!storage->stale[j + 1])
+					break;
+				storage->stale[j] = storage->stale[j + 1];
+				storage->stale[j + 1] = NULL;
+			}
+			storage->nr--;
+			return;
+		}
+	}
+}
+
+static bool mptcp_subflow_is_stale(struct mptcp_stale_storage *storage,
+				   struct mptcp_subflow_context *subflow)
+{
+	for (int i = 0; i < storage->nr && i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (storage->stale[i] == subflow)
+			return true;
+	}
+
+	return false;
+}
+
+static bool mptcp_subflow_is_active(struct mptcp_sched_data *data,
+				    struct mptcp_subflow_context *stale)
+{
+	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
+		struct mptcp_subflow_context *subflow;
+
+		subflow = mptcp_subflow_ctx_by_pos(data, i);
+		if (!subflow)
+			break;
+		if (subflow == stale)
+			return true;
+	}
+
+	return false;
+}
+
+SEC("struct_ops/mptcp_sched_stale_init")
+void BPF_PROG(mptcp_sched_stale_init, struct mptcp_sock *msk)
+{
+}
+
+SEC("struct_ops/mptcp_sched_stale_release")
+void BPF_PROG(mptcp_sched_stale_release, struct mptcp_sock *msk)
+{
+}
+
+void BPF_STRUCT_OPS(bpf_stale_data_init, struct mptcp_sock *msk,
+		    struct mptcp_sched_data *data)
+{
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_stale_storage *storage;
+
+	mptcp_sched_data_set_contexts(msk, data);
+
+	storage = bpf_sk_storage_get(&mptcp_stale_map, msk, 0,
+				     BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!storage)
+		return;
+
+	for (int i = 0; i < storage->nr && i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (!mptcp_subflow_is_active(data, storage->stale[i]))
+			mptcp_subflow_unstale(storage, storage->stale[i]);
+	}
+
+	subflow = mptcp_subflow_ctx_by_pos(data, 0);
+	if (subflow) {
+		mptcp_subflow_set_stale(storage, subflow);
+		mptcp_subflow_unstale(storage, subflow);
+	}
+
+	subflow = mptcp_subflow_ctx_by_pos(data, 1);
+	if (subflow) {
+		mptcp_subflow_set_stale(storage, subflow);
+		mptcp_subflow_unstale(storage, subflow);
+		mptcp_subflow_set_stale(storage, subflow);
+	}
+}
+
+int BPF_STRUCT_OPS(bpf_stale_get_subflow, struct mptcp_sock *msk,
+		   const struct mptcp_sched_data *data)
+{
+	struct mptcp_stale_storage *storage;
+	int nr = -1;
+
+	storage = bpf_sk_storage_get(&mptcp_stale_map, msk, 0,
+				     BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!storage)
+		return -1;
+
+	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
+		struct mptcp_subflow_context *subflow;
+
+		subflow = mptcp_subflow_ctx_by_pos(data, i);
+		if (!subflow)
+			break;
+
+		if (mptcp_subflow_is_stale(storage, subflow))
+			continue;
+
+		nr = i;
+	}
+
+	if (nr != -1)
+		mptcp_subflow_set_scheduled(mptcp_subflow_ctx_by_pos(data, nr), true);
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

