Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2045.outbound.protection.outlook.com [40.107.6.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863B52585
	for <mptcp@lists.linux.dev>; Thu,  3 Aug 2023 06:51:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7UB7EnTHsnGahnFvP4IBAwoIvC9WK5lmNAXolYPTL4u6teLdpfoQl4aluI1fgk6WnbPiL2waYAcX7e0Qjc2aIOT06d4hxmbVGTlWJtU+hvQPrjWA1rnQQrisZLYoJTx+eb43mRmbfbKR7GDMDPUK8oQ+f4Q/J284iA0sFkwkhuhQRET7NslP1zc9D5mhg3fGiUpbCha2L+J/eXtUMDkynWaNkWbbQbRRNOrtc3wr+uuu/reCqmJ5+mGtkrBlHSinfiLIbpcoE+Xx6c7zqjRQTRCn/tagfA+IGWsYwfsscPqe99Ez8R9slaM4TkAjaQzdFsikDDVRYPm3pW4qD7fBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJb7Dt3NaydSWl9V0YNebKPWr6CyfotHEVPeOmsEqec=;
 b=ihdB50EAdI0MAxnC6CfovSNnSq7+VwOrhYt4lUgD2txJg4cNN5YTcgSPxVUA9HFT3zQhkkUF3eBYWRrvwRjbGs3XVXCVvkz3Ep2pP4xGbziCdg08XfBYTbNwWoU8rAiUvc4pqtrRDvX4y0typsKfnLvWoc95/r+ZKrhIo5i0xW+Iw8EmY5zyXJtmY9IXDKLj8CNg0zK3NR9023D9SxNkdtGjsGk88GkPF/+3t62IdgVOZvLCY2Yg4QjdkngHCTgUGfbY6q92qVV72eKHFSdBYvSbkfTzL9fOGZ32nRxTWPiyc+SXOhdUL4yP19jkUZdtEIHW+BBgJnAWAqUI0hA6hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJb7Dt3NaydSWl9V0YNebKPWr6CyfotHEVPeOmsEqec=;
 b=aM1J8BRxELrOwDSca6u7OiSOoMv5HGe2ZUuoJi50GCIVo22PEGA1UcGCUaEsQs0K6xPdIYo1KID2kkqP1X7qfkHkeD1rGzu26uTHsmBNnzRTie7bCxKS2rMq4oVY0Hn3bcemZj0Sj0z+nd3mIxnbTYTgzw2WiXbHZV2/gJVZZIAvYZ1pWEhgyrXLN5hauFdKfPwZAFz2cDWPjrYOEgA0UhPfinovxS2YqJbQvuWTybD0oeD5u/eOfP6WfKA8Bdyd7sQQhVylFxs7wtK1IVEtj/cw2BXVSWkrti7o94uFLpHoDo8HoVm+LafkdbQ5yMcTo92bcBqFPLtBbBzgOtN4Wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB7014.eurprd04.prod.outlook.com (2603:10a6:20b:121::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 06:51:38 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92%2]) with mapi id 15.20.6631.045; Thu, 3 Aug 2023
 06:51:38 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 1/2] selftests/bpf: Add bpf_stale scheduler
Date: Thu,  3 Aug 2023 14:51:38 +0800
Message-Id: <342e6005353b786a63b821787cb1edefee4ac530.1691045340.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1691045340.git.geliang.tang@suse.com>
References: <cover.1691045340.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0131.apcprd02.prod.outlook.com
 (2603:1096:4:188::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB7014:EE_
X-MS-Office365-Filtering-Correlation-Id: cef31119-d28b-4c40-26bb-08db93ee1599
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RxZT2R9Q1Pv3KZd07KoUZhP9RsTq20MSZPB0gzjg+A44VGpKlmzZmu1YUBSB1T8sWNsqhIvf1Y8Vq4TY9awwFhhsUaxOaZiaBP/I1wsMHDXdU9Z6eKyLDzksK7POctDbnqABPR6jvbLkns34rN0Bb8mr5NZAz2+NLPtfxNgJMkfUC5lTFJpAttQAXV+D4e4/FgDiZ9PN2EKUhz8/4O9fu7zL4MhYRqfAHf64g9pYv5G7RpH34P4+q9cWjN715qYa/+5oygzfwZbY0PT9IDi1XtW12QShgeyTeaOIhPksEeeITSMnxWKE3omWRm6z7wNIi/xj+uROn1x/UWM3oogpoB+GsQePvpTO2cg+R/oOBS3yB4hJbf/ttRVIqOX7rvPAaTy0H6qZh3rybUWpyQDp+vdac91ZwiNjj2PG3Ve5WoxMfuZJ+M/kRewwZq8jZl9spZe0y5j3eJnpJF/RJxmvFuLbC+K7TrXFP+Mz8IKg5Qi6/s6JPSeqZZfbb4X3Lfmy45didPyVHVWSzoyEEgc//R6zYPA9EfftH6Hcvz3N40C/sWDzINFxBtCcgXDweSKFzDY3/AQLI6aVi4BlPBaBTg/y6nglaYwbyFgitl3rirs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(39860400002)(136003)(376002)(366004)(451199021)(2616005)(107886003)(6506007)(26005)(186003)(83380400001)(316002)(2906002)(66946007)(4326008)(6916009)(66476007)(66556008)(5660300002)(44832011)(41300700001)(8676002)(8936002)(6486002)(6512007)(478600001)(38100700002)(86362001)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?juJNS/DYutRoEkBAXgEHb3R7ApSeshDo6auCOauOylGBu4dfrs+uYzPCy5YW?=
 =?us-ascii?Q?mz+kQsaLCOgevrt+zPpqwv6yybAM4MGUehhfM7yxbM9vOC8AJGYCF+SqDqYu?=
 =?us-ascii?Q?EwATv4cZS3wlgsXC8ABO1Ya5DcPMWgy7ukbJ8vQ3HWMpQXQpT/Eqgw3jUbbO?=
 =?us-ascii?Q?ARAo2rOMOVSOE1tM5zXaTz5qX8lDiEkjaChIX4+ItyMe+ng5tWyVIn/1OcOR?=
 =?us-ascii?Q?AF+Ole7SGwXH+4oxkc6aI7GZCO9HgVO7SYyLjp1HZoqhcoE2Xm9yPO/m+n7G?=
 =?us-ascii?Q?oZs5a2Xxt+AJskhkpEVG32/Pmky0Nxs9cOO/GAGSPWmKmWMcHkwT+aQ7ttNs?=
 =?us-ascii?Q?zwf+ZYmCsqvl6drJatujDgIK0tOwSCMLG2biuiEMTexntdRv59irzj3uLE1m?=
 =?us-ascii?Q?3AB+/eA/5aM9yaKgvJg0+T+WxhUqDCLv5TN4LbAXHUH2gC+JOBG5lptMP9lM?=
 =?us-ascii?Q?Gk0/3DcePTWk6LlFXL7Kqcnw5fH/nXcOnfHSUNTGSp33adJgKRrqa1ivk0J2?=
 =?us-ascii?Q?UM8F+e69UUyKeV21so7OQy99wP9mHa1SV9JJaTs50kdnrTRzvyIDIGsCEdAL?=
 =?us-ascii?Q?3henFWAbA8iCz6vxEmr4cSQM1ExV+hd5Rc2O8BSPOK6Ep1q7iOvM7qBuLpes?=
 =?us-ascii?Q?GXQ7H6Cg4bliGzIfeFjLko3hMNLjwM+/k952JNNDRquv8E7RYc8EdocMovSh?=
 =?us-ascii?Q?Qv6OycLOzrpHpsvz4ZH/RZ8+ZAdHehH1dk7tpgssLdd4E6eVRm24TspDS4o1?=
 =?us-ascii?Q?NnoHpWKx65YobEErvA1KX27l5Y1Om8/FZJh/QhI7qRkzIP44HOPWaeAe4c/G?=
 =?us-ascii?Q?dhGRvvnwmitXu4IIOiMg0dngVIpLR/2Uzp9vj2RoBUBJGrDG5pPEMuUAB7vS?=
 =?us-ascii?Q?71/ggnHU4m29Mfg5yEQv5iSp63qbegdnCWAqYIYW2LbcCD6cgCyW28VMlo0I?=
 =?us-ascii?Q?JWyc17iIfGJ6CN949BuZcdvcyhg21Hlcx7nlNDpH+ofK5Q+Iv1XY9AEO/7Hf?=
 =?us-ascii?Q?KKSYYX0i/0ZqQI/Fs8xNOxstJw+7nwjGbk/z62/PZQMCQdRDb5rOGXh0CagA?=
 =?us-ascii?Q?0Tt4Io0TJ9agYN5zlHUXjhK1/wbtI8wFRxKih0gOf2ee1Rg6+2TH3x5xpKNr?=
 =?us-ascii?Q?TZPWrfNAa2ZPN8ektVjDZifHeRm9FMKU4AvORBgI6kjxW3d1gcQnlHxkd1jm?=
 =?us-ascii?Q?2i/LzIEBOo1+T77qcVaTAYeWjFh9EzIpEmcgloaFezHQuzaKe2UaPyg6/cgF?=
 =?us-ascii?Q?31i7tX/jLdX4lDqfrzjAdfVO1i7JCDMkqBBSK+TlPZaXX8XjOdMuppw/Aog9?=
 =?us-ascii?Q?k/iBOJbtTwFcMDRG/ByiOQ+ktFYEzSBp3Hpx3toL77HmMi+NcGyED3rAQdvw?=
 =?us-ascii?Q?lcIdnlWNtuk742eaK6p6XHasdRwL5mFEmqtl7nbMu+1pMqoEerrx07XVDOv0?=
 =?us-ascii?Q?fHlPeQNhrdbS09i96dZ9CoWEkq0QVaCUrL8bogvx31OvjJZKlxv1qnCgitY1?=
 =?us-ascii?Q?kpX+REDyAGcTYWNacEaXAZXe3Id50JaBXEeDXSs+CJGSJiiPzqNHwlBt16Ms?=
 =?us-ascii?Q?D3WAE8/qeRVaqBWBUSr9NlqYuymHdveIr9vZaZFWMUxGoigDsh+WXby9DlSt?=
 =?us-ascii?Q?+g=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cef31119-d28b-4c40-26bb-08db93ee1599
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 06:51:38.1371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mxfwK4oRqhBQ25I6+00bxwuE+DTlCCwaTeISkyrDOw/3HjYfk4DZom/uLc8H3mRCJ7knLFHbX1tpJSEk6zpusw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7014

This patch implements the setting a subflow as stale/unstale in BPF MPTCP
scheduler, named bpf_stale. The staled subflow id will be added into a
map in sk_storage.

Two helper mptcp_subflow_set_stale() and mptcp_subflow_clear_stale() are
added.

In this test, subflow 1 is set as stale in bpf_stale_data_init(). Each
subflow is checked whether it's a stale one in bpf_stale_get_subflow() to
select a unstale subflow to send data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |   1 +
 .../selftests/bpf/progs/mptcp_bpf_stale.c     | 161 ++++++++++++++++++
 2 files changed, 162 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index 776c54948a4a..0a7c9fca6a07 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -239,6 +239,7 @@ struct mptcp_subflow_context {
 	unsigned long avg_pacing_rate;
 	__u32	backup : 1;
 	__u8	stale_count;
+	__u32	subflow_id;
 	struct	sock *tcp_sock;	    /* tcp sk backpointer */
 } __attribute__((preserve_access_index));
 
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c
new file mode 100644
index 000000000000..995c7448c394
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c
@@ -0,0 +1,161 @@
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
+	__u32 ids[MPTCP_SUBFLOWS_MAX];
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
+				    __u32 subflow_id)
+{
+	if (!subflow_id)
+		return;
+
+	for (int i = 0; i < storage->nr && i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (storage->ids[i] == subflow_id)
+			return;
+	}
+
+	if (storage->nr < MPTCP_SUBFLOWS_MAX - 1)
+		storage->ids[storage->nr++] = subflow_id;
+}
+
+static void mptcp_subflow_clear_stale(struct mptcp_stale_storage *storage,
+				      __u32 subflow_id)
+{
+	if (!subflow_id)
+		return;
+
+	for (int i = 0; i < storage->nr && i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (storage->ids[i] == subflow_id) {
+			for (int j = i; j < MPTCP_SUBFLOWS_MAX - 1; j++) {
+				if (!storage->ids[j + 1])
+					break;
+				storage->ids[j] = storage->ids[j + 1];
+				storage->ids[j + 1] = 0;
+			}
+			storage->nr--;
+			return;
+		}
+	}
+}
+
+static bool mptcp_subflow_is_stale(struct mptcp_stale_storage *storage,
+				   __u32 subflow_id)
+{
+	for (int i = 0; i < storage->nr && i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (storage->ids[i] == subflow_id)
+			return true;
+	}
+
+	return false;
+}
+
+static bool mptcp_subflow_is_active(struct mptcp_sched_data *data,
+				    __u32 subflow_id)
+{
+	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
+		struct mptcp_subflow_context *subflow;
+
+		subflow = mptcp_subflow_ctx_by_pos(data, i);
+		if (!subflow)
+			break;
+		if (subflow->subflow_id == subflow_id)
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
+		if (!mptcp_subflow_is_active(data, storage->ids[i]))
+			mptcp_subflow_clear_stale(storage, storage->ids[i]);
+	}
+
+	subflow = mptcp_subflow_ctx_by_pos(data, 0);
+	if (subflow) {
+		mptcp_subflow_set_stale(storage, subflow->subflow_id);
+		mptcp_subflow_clear_stale(storage, subflow->subflow_id);
+	}
+
+	subflow = mptcp_subflow_ctx_by_pos(data, 1);
+	if (subflow) {
+		mptcp_subflow_set_stale(storage, subflow->subflow_id);
+		mptcp_subflow_clear_stale(storage, subflow->subflow_id);
+		mptcp_subflow_set_stale(storage, subflow->subflow_id);
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
+		if (mptcp_subflow_is_stale(storage, subflow->subflow_id))
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

