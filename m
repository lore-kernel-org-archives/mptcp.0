Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2083.outbound.protection.outlook.com [40.107.20.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E917214F9D
	for <mptcp@lists.linux.dev>; Fri, 18 Aug 2023 07:58:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DyHjHDhncqssgrckFoARV4kxKAw6ZdpyXSvAoRw8NNTavzBMYWIX9mVlqLx9768uzBZoe7EwO6kXsTN6Dbs+x5aZZmM3m6m3qLiBMzIUOkOAfLv2ATvp0VYIUvXD9Ev5GNc/v8LL/bNsA4b47mnDVTx1gvFcuiWl0xJT7muhAfh/XI8iLjh/O6LKRy3IT8d5COmZgJkEEtUQiCJKbazH0LWoKAtliA4oT6WV22XvqMjByV75PE3K/Wz9fy0ixpkZefRn0qYzf59kaqMyYgDZjL74Ku89TptcqXPGZUob/eK4/Thamo7V1Ky95BMclKYGQBu10FiPMXuEePlaZso0cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQ/SZqDReEze96s501RVxXraNlWh0t3947hHsyGP+EQ=;
 b=TAG9C4ExFi9f0p8wlo3wntBXenvkswweOav571a8c+4raiPvAGcqT2zyOK/FY1WIU65C7/4C42CugHq5Nf0vbNzF2ee/lPS4bnxGi9VoFC8i19QRGMG+gL5J9EUTBqCbAe5nTWd4s+iMPPKoYVn+2jF49O4SIIrC3AnuDThulQkq+pBnp1JLybJJV6XAQYx/885H1ehG77gXJmUP6mTP39HX3aqzx1yojdbrmnPOmW9xFEGEdUSGekWuFHpHZb90vP/q6OdG4k32xZoL5eYlLyRIyZjb7p5SWpVzwTkRckw6YB+I4n+/vQyYxH9GwpLq39CJVFzEfwnReWvaxAv6Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQ/SZqDReEze96s501RVxXraNlWh0t3947hHsyGP+EQ=;
 b=sJZwIzxydPt7WR4L391T/GouvL6f6IERh7A64SZnXO5gy9ueFEfjq+uRIQ8a4W3BtviJECxrjbxHPMe2I7b91YjLc7ceNwtEBxhps8GBRoBCoLvMPSRb5L1yCqFjetFg97yaV/MGJ7S1+DjZ7LpeyMIpyp1yE6iaHHL25tUi+bbnZ9Q9ZrxUxA9uqn+KfCjyYJJCCd3eODASWyH83ZPzePbh/L4taXH+0tr+i1qfhqZ+IRitHhF1sHWZL2f6Eo17RJAO+bv9AY6Igf5U7NnN5o5WLnIDqeoFx0xE0xXMjwfLxnbqWQxcA+UDRnlInip3Tawycex6ruLL4cutDuB4Zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB9212.eurprd04.prod.outlook.com (2603:10a6:10:2fb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Fri, 18 Aug
 2023 07:58:43 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 07:58:43 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 4/5] selftests/bpf: Add bpf_stale scheduler
Date: Fri, 18 Aug 2023 15:58:32 +0800
Message-Id: <51abe0fba5f509bbabf7f400831c6a2a1a0413d1.1692344463.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1692344463.git.geliang.tang@suse.com>
References: <cover.1692344463.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0005.apcprd04.prod.outlook.com
 (2603:1096:4:197::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB9212:EE_
X-MS-Office365-Filtering-Correlation-Id: e7c33ca4-f512-44cb-6e68-08db9fc0f13e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+gjJzKNITHvdmjRiqM2tLWXSPri6n3Z+Xeu4HxCotjUh/7dqcVbVFq1qDGnHEiifrX8Ghkv4vaxM8JmzOgfkwIw3ntWC3GNkZCRXbKZv+sKNp2eaZoxpgjiMNGHX3auoUy8kEwE2dEYFyaOvCPa9UHjiZSDPtbfZnwh5bItjtTip06wt3EI0FVWoybu2gcatWZMgLXw3V+D2Js+BuHkLAxJMcCe3o3khp51LA1lrVpNGeK98Cq0vTKjLBcnsMnBk7DoJlMvik/QM+NlqlkuD3tDo3HPR9T0UHeGkne2sj6IEfm5GHJb5u2kkMUnHtCtv9Gh9iaaDZm2M9lK5ZsJ2OGWRC3rZmOSFdJfOvfr8MxNHAQ7PRnppd4yJnhMrkAhugK8hyq9VKT4MMOl/DPytofvgXjZ/3viUtokNVabq0JcuzAUSxvNRC45WgHaxbGr3kcyDCS92S7Amc+GZHbPR2qsSmDlvVx4fZcKH+1uLwLBzbltH7S1nsQ854c3cPvoyPH554BoCs5apoo0hj3DKRUMwa/XS8RJT6CQ3eXcMS/v/9IkgDJTjWZRpZUVqi5PGNDSlTRY537bWUFezOVqjSsU4Ux59AyNMO114AUu8WgM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(39850400004)(346002)(396003)(186009)(451199024)(1800799009)(2906002)(83380400001)(26005)(86362001)(478600001)(6506007)(6666004)(107886003)(6486002)(2616005)(6512007)(36756003)(44832011)(5660300002)(41300700001)(66476007)(66946007)(66556008)(316002)(6916009)(4326008)(8936002)(8676002)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J/nmGgsW0219a0FW6kQkLRKRKM2U/OFnhvmHsmjJNbuUyvoQ3oJI9SpInZv+?=
 =?us-ascii?Q?Jqoy+SwWbBWWtqI3irDHGYirwF0d58E11hi8m15OfiIWHK0Q83wrfc0c65uO?=
 =?us-ascii?Q?X1x0IZGXYmQsvdh9HWcJMhNC2vW6+8qsThMzAOWfgIAPNv075ft3otYSJm56?=
 =?us-ascii?Q?NP01k5vuYr6m/dFKMW9KtZ8Qw7UpET0YGlK0KYffCdBnltCfSK1A9tJkCcSi?=
 =?us-ascii?Q?ewE3ijx9I1CLjgQSEfH4i9jl9pD34mHGYOv0tdiIms/T+Uqt8wIrg8y2U59W?=
 =?us-ascii?Q?Vp4tmolA33jM1MOwe0w4Omoe3q1tpefPHslFvGY6Q6sS00qdCpj25AA0PCfr?=
 =?us-ascii?Q?4TwvlIdxPkC+UUr8eskDHweglHg4Ja8hPPbUmThnVVTsbtF0zd1itGD3uFhJ?=
 =?us-ascii?Q?t4+PPX9eyY/V/BLTUjv83f6YC+JbJjwNSU6d9ZBPasx3ODJwpfUIeHLy+cEg?=
 =?us-ascii?Q?D1jvjvSMGLkGSEtC6eHexA1aRDttrxrjELolE0z1MnMakLNKMyzvU87r7Prx?=
 =?us-ascii?Q?xF2h1nkpdmHY4z7U4q2HMqIe9APoNFpv+lbFIX5iaAjhHsIOgNa6+oYuZLkf?=
 =?us-ascii?Q?vrvdnq3/d+RdWC6nDJyHTGipAc/iNXH1Hhpo0goVEBIaIwXqAYnfF0vgwZAS?=
 =?us-ascii?Q?7EeoUAojhMd5G8Wd3IwzfLqV7RO3/sAUq8f381kvQgkIvqXHcuS3NJDDppMj?=
 =?us-ascii?Q?JUT2VifW8mRrsO7+UVvBcObhZzn2+aMYZx7Stmzw81UYMu2XowRKsSmG/nbj?=
 =?us-ascii?Q?Z9G9iWchdT+LoN6gMFdkjVBlejA6AFC2KqvG8/+ZRkxujHTgCd8bN89qrWe5?=
 =?us-ascii?Q?Xl/Pk7tcx0tRlKdTfdl+fdcyqgTqTix/upltXssny9CwbKkyCgYA14VA2V0s?=
 =?us-ascii?Q?VX170pD7Q6Wsin1sAMmLDIoGYV8UlXC7r5pm1fvuoteanukXEjfetEGFJ1MK?=
 =?us-ascii?Q?Zw2QQqbN3sfiILdtfmNQu5HaRF5A7ESHVrldTIdwY2SJlUVOG7tluET3ZFx7?=
 =?us-ascii?Q?RMSAU2PVemz1a6KsewXRvzhIkSVnxulaDkM4xNbgqDtAlE70DeU9XXLCtWJk?=
 =?us-ascii?Q?BBb577oFvNnw8BNt+OofSahEPBDkWNjD43Ucp1f8HYAtSmoOlxQ4s0+sVuue?=
 =?us-ascii?Q?sWBl/GOVgbxTGaWANDNLJvayO5tSSDkgJWKvgqpt0qaqGUUU6qF7qz0vdlFp?=
 =?us-ascii?Q?9RAgnEBfdJ6E2KVrpeBcmiDI3zQVm8UCxQ/zIOvX2LTLuAu1K/ie8FAaWWvQ?=
 =?us-ascii?Q?VOR5Fs3J8bsLB09hMypd56cr1zpNutyDVcgpJ+PbNVO96vXKEewBgDQCjrxi?=
 =?us-ascii?Q?7K3k4zstjQfA/WstqIe4eHVRNw0YGD0R9geDW0kf6PQUHAMSL0OFrTemAjp/?=
 =?us-ascii?Q?PFSvkoqpBGktLpQnheKmh7eRuKVUylrBBtWwju3g8NBXRYnlK6d+N0cBitOu?=
 =?us-ascii?Q?4wWRa/g3FijeJ+zmhF3E/oVQBWwM4NdYCSSinML5GRG94JeGusGcsrCR7DLW?=
 =?us-ascii?Q?yY8nOAUjavdC/6XRlv2+VE/IV3U4j3s0nz4fGh9/xlPZQst2tJo4wIcAGHxJ?=
 =?us-ascii?Q?X8GTuLVn8wOcp2dVYVwmUwzbW9iy0YRbOu7+QSinH2RB/zn2oS46DZJDG0ti?=
 =?us-ascii?Q?Ag=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7c33ca4-f512-44cb-6e68-08db9fc0f13e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 07:58:43.5841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jPT2ZMnm+wX/ScR2JlHH86gcnVKLIL+dJzlsFTw1Uwsq4Iy6TG3lDkgm9K1gasyFqoVd2Iu4C8RMR9vdxmnRaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9212

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
 .../selftests/bpf/progs/mptcp_bpf_stale.c     | 152 ++++++++++++++++++
 2 files changed, 153 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index b687f91f2da8..33246629fa36 100644
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
index 000000000000..08c857f79221
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c
@@ -0,0 +1,152 @@
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
+int BPF_STRUCT_OPS(bpf_stale_get_subflow, struct mptcp_sock *msk,
+		   struct mptcp_sched_data *data)
+{
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_stale_storage *storage;
+	int nr = -1;
+
+	storage = bpf_sk_storage_get(&mptcp_stale_map, msk, 0,
+				     BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!storage)
+		return -1;
+
+	mptcp_sched_data_set_contexts(msk, data);
+
+	/* Handle invalid subflow ids for subflows that have been closed */
+	for (int i = 0; i < storage->nr && i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (!mptcp_subflow_is_active(data, storage->ids[i]))
+			mptcp_subflow_clear_stale(storage, storage->ids[i]);
+	}
+
+	subflow = mptcp_subflow_ctx_by_pos(data, 1);
+	if (subflow)
+		mptcp_subflow_set_stale(storage, subflow->subflow_id);
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
+	.get_subflow	= (void *)bpf_stale_get_subflow,
+	.name		= "bpf_stale",
+};
-- 
2.35.3

