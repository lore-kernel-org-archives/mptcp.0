Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2054.outbound.protection.outlook.com [40.107.247.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6221E1C4
	for <mptcp@lists.linux.dev>; Thu, 10 Aug 2023 14:11:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g43FewfRTRXXZtWAg9WAjZyIPCncPyxl4nKLsNc5r9eUswr86MWa4f0kINQ1FKcNev4c1h2lyS5FoJg/WZL25ymNSFl4KdYX+vXOIU4legsu905GfRHn+waTNWSqXIqqQRJoMdgOWhZjhVt+7D5EFceY47AB6f/hRXsKAv6iEnKJZLXCpo5lG4THEwna0blVvLzNs1qWTv+/B7RCVXA2r7JVJeCujlSpqGXNX5Vk5CeRXOR1dft3f/l0yVLyHVCa9RhUjtp+YCa0ufmrb866poytDN0UWG8Hl6B/EZKIsFX/gcrDo5ofOUdfKC7TbLU+5CSMWBV6EZp+5ikBHkyh9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PtOdyOPNW+f4A3qZ04MMDEIGw7uGts1plZPnyNyWC18=;
 b=k+NiTzLUJqgOnsV6yhyVZUZaUjDeWOn6d3i4cTbXVD/zTX+JyhnRazV6V9Yv/5o6IUzqqGIW/8cn5m0KbEwpwxbnVkVBpqi+eW1tapZYP+MMWRHDjJmMTkEpnL/cQmxBWrQ4w0BLxuPd1NcH5cVgSWVqbOcwrGFe/fcTP614Ry+SdalmazRl7j7yi0h+WqhWc02Px42CesLcrPKPq4fatl70VDKkzpWi1HkSouzERGpWs26qLpcPQMY65F95nmPwXj56tttCAIus4b6FyG8KHJjXs5fUtiFlp/sH55PVpTgUw0glSWSqBW7ayl1O8Su2CXAkniKu4J/ntOTZSq6amg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PtOdyOPNW+f4A3qZ04MMDEIGw7uGts1plZPnyNyWC18=;
 b=ures8fH5v5O04ZxKMaeUb43QKu/aLP4ISUj1aJ5rqg43G9pkvvhVgPiJPJ3OcUnTIbR/JFFb60/Hn98v22CR4TJk64bES+ZGgFTQRIo0x/hizXRo1IQ255YQRNmjTohtm6lH5K1fRGK9CoNfSMa/SRKK231VakwSPUx0YFmzGUHtLxi242LMScH5HP29OvA0wsxwGqBya7VEDArBvO9hTTdYrGw5dLXlI1DTuo++V254WhhrP4WZvBy5HI5iaEaVTI3io452MwvDbzjIGJYPYzC3eYX2ljsquKOzM8pm6xZObFrGygcpls3XbND2CUapxV7J0BMBvKN8hSCquXFe7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8314.eurprd04.prod.outlook.com (2603:10a6:10:249::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 14:11:23 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 14:11:23 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [RFC mptcp-next 10/11] selftests/bpf: Add bpf_stale scheduler
Date: Thu, 10 Aug 2023 22:10:02 +0800
Message-Id: <b72850caf8edeb0e8368442d8a9ebcbd2d4b24c5.1691676509.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1691676509.git.geliang.tang@suse.com>
References: <cover.1691676509.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0037.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::9) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB8314:EE_
X-MS-Office365-Filtering-Correlation-Id: 09b846d0-ba9c-4d5a-7ce7-08db99abacd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tduWG/R+IQZCcqZ6PRiTZvflQdPHGDVm0uj+eXvx7oIbSCXEI5jix8gKLOTRMRbCgGnfYkYrCBC+iRVgXQg3BV7qf9szGczloOJGGnnktbLDLL4PC/5liYfPzDo3ttImEajQ/Pd27S/mDGej7XnpnApLKjw/stTxAoXTYpLKAsQzOM3xrQ2rRhxCn27Wdrw2CNbxGda3wqhJwzpKD6r2Fl82Aa8QwLqCeMqzxd1P4rNiEHPLd40o0wM1M2UM9+M9LcPD4rncpWQFPuKBGDoBCfz1KjcM2KmPryJZIJqCEp+HTsJ+OJhXW+g5L5680DtOSeu1RuL3OzPGQCvQ/0A31IQR8bRZp+IKKYFE1jCDIwITLVtPMYFqrbaYYOov/eS1H5PewMqWaPi019nHaKF9oCKHUAw10GNAiZFO4g1IZY+3Zy44lxIO54ZANXsVp4AnOGpRpaWxjE5d1KRfH1C787HnFq38bBxqQzDaSUcIv2kejq7c1y4YwVqvqwoGSMNoKYZRFhy91NByvNFVMKsePgSWrwwaQ/TWLBp/LnJYxb7ytG4rfhc5DbOAXdv5uUweb3qh3yrcBd7ewys+QdnSJj83Prx+kSbY01QIdVNp9gg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(376002)(366004)(346002)(39860400002)(1800799006)(186006)(451199021)(36756003)(478600001)(6666004)(66946007)(107886003)(6916009)(26005)(66476007)(6506007)(66556008)(6512007)(6486002)(4326008)(2906002)(41300700001)(316002)(44832011)(5660300002)(8936002)(8676002)(38100700002)(86362001)(83380400001)(2616005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LWJsKesJk8F/wcgdejelZ6B13OMQcpobYq1jWYTQbUyo3js6pUfSt3WAa02+?=
 =?us-ascii?Q?fKG+UolT6EjQUrJbc9i1UqBM04Pi0F90Qsxi4RiYHjGqr4Lw+Vy3GcPIDTI+?=
 =?us-ascii?Q?vt8ZuvXO/usaXla8l2KJ4XoSvd0igUn+1950zDMfxlifng2fCP+KI7WNV/r0?=
 =?us-ascii?Q?EmUEGwqEL2u5rNPgjWGh6ceGyEI+cLQ4BnM5DpGqMvYT7H+61Fia4y0bov//?=
 =?us-ascii?Q?DZyQoECeEyLjFvU0V86iHzd2l5M9nqICaOMZk7ZKTRzq+EG9xuyfLfBtuyjG?=
 =?us-ascii?Q?tgt9NFzOcYTIZgPxwwDXju0FlXtq4rwrb+zD1Kb5sDzshtxKZRhFs3lDfhsX?=
 =?us-ascii?Q?B71ybJFy/mJtsk+pH3rQrjIwyU02cL3303iBcltJWTdgYC185SW8LGvMFt7G?=
 =?us-ascii?Q?cw93qlGWAXo5jP3PMq3dniQDSwNNDX0/PxBIU1zpo3C9pQnw7XGVCpQVi+EZ?=
 =?us-ascii?Q?N8cMb8+6v99oCYPwBjOHVbpgk/YHFR3XBVgY/+slnGDnTXp3tm1oSIL0l2Bb?=
 =?us-ascii?Q?Jl13FdpLIZAb42wjh8zivXr9B/Rumoy/EYTnBSr0ZmZjQguVPMLCyiVSjaly?=
 =?us-ascii?Q?waDfGZsnMnQho1fsiec4CIwNbWh44iPXDhQlSdLfAqMZINF0yTPul+yjAvRP?=
 =?us-ascii?Q?0PH4M1nFE5o+hyuGdTnX7BBzYu6Qbp+1BDYZA+ty+qeSnW16ay8FEroN9+rI?=
 =?us-ascii?Q?4JfUDGJEnR7ppjHtPVv3k20OTeD4tNNjgDNgvDw4U3xnx14qKf4Vs7Ioh3OE?=
 =?us-ascii?Q?YliVd6Og0ZI8fL2OFbXuxzyw/eHWiFstxRx5yMD6ddUl45j0VOop8xn15T6W?=
 =?us-ascii?Q?XaojbsOSwsTqNz6qw9rWq0+kbUC0orvC1ml73gh6D79+PsBcpHp3q8HWHeZA?=
 =?us-ascii?Q?Xx1l8/Nv36+ybX2Ye1YzdT660oS35iNqtAC6+9xnhriIPzX2NzSejfSV8ujD?=
 =?us-ascii?Q?L/XcAsQCCCy6fxh7DtScnEGTc1134wbQdofl5IW2vSRsAXkvgAsVKkYTaad/?=
 =?us-ascii?Q?Lzq2ysYnQRK0EYB+YpmKE63WH2+7S587IzU5VRdPqQcuOucGjRydC09YGMGh?=
 =?us-ascii?Q?61nJh4DLmbOwj0vjmN6p1+Cd3HsUdCtREyDEAQfUKHVciKO7XQypw1fxIwVS?=
 =?us-ascii?Q?1C8yxjMfCmapU3hicjOZqhddurxV4D7ha+ipD6yzqUES32hpgbbBSYS+HLDq?=
 =?us-ascii?Q?LxANZO8936KRMyxe1qvYeN3JJUrqqVMTXionAj6rhpvgyrLuO2WRYM86Ypxb?=
 =?us-ascii?Q?uLM+oQTlgpB4Lgf3WDJ5R5/ABm/EY6tYNeJza7mTgIt1bqKDA367zU225db+?=
 =?us-ascii?Q?XnpTt740i8wgKtWEPPRWvwqkTUrY4QwyTc3bXnrvJ97Ax9HR7GNkSzdgWh7A?=
 =?us-ascii?Q?sd8928O+IvyXVwoX7EmsiHXwq8hWtgbCQTM3Xju30TlvdtX65101GIQ1RqWO?=
 =?us-ascii?Q?Utvadnd7Ezc5VLNC32E7P4ovwGYz5TiNJXAU4zeIxZWf4Qnnw+EmalS68/lB?=
 =?us-ascii?Q?H5b3fvbcQOJPVRXlz6zWQEIks6JXV96PtXU7TkYIFBHplALQC+Aju0VjGUyo?=
 =?us-ascii?Q?HzE+NAVlLru1gpiA6WweK2rrFWz/DD9pcbe604ckux9MYjpV1yl3X0NnXwrE?=
 =?us-ascii?Q?eQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b846d0-ba9c-4d5a-7ce7-08db99abacd6
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 14:11:23.3023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5nYKby58Ztz1D/+esXswdjFg8PJgfKtEYaKeYQ9QTXzEEGVIUxhCAxUICQHCXBqrgM+5GXk6z/gsL2NZmrGTfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8314

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
 .../selftests/bpf/progs/mptcp_bpf_stale.c     | 163 ++++++++++++++++++
 2 files changed, 164 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index 6360593f64a4..4f7a41c8a47a 100644
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
index 000000000000..10e56fa07818
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c
@@ -0,0 +1,163 @@
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
+	struct mptcp_stale_storage *storage;
+
+	storage = bpf_sk_storage_get(&mptcp_stale_map, msk, 0,
+				     BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!storage)
+		return;
+
+	storage->nr = 0;
+}
+
+SEC("struct_ops/mptcp_sched_stale_release")
+void BPF_PROG(mptcp_sched_stale_release, struct mptcp_sock *msk)
+{
+	bpf_sk_storage_delete(&mptcp_stale_map, msk);
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
+	subflow = mptcp_subflow_ctx_by_pos(data, 1);
+	if (subflow)
+		mptcp_subflow_set_stale(storage, subflow->subflow_id);
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
+	if (nr != -1) {
+		mptcp_subflow_set_scheduled(mptcp_subflow_ctx_by_pos(data, nr), true);
+		return -1;
+	}
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

