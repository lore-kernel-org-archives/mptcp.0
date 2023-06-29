Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2075.outbound.protection.outlook.com [40.107.8.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12EB15A8
	for <mptcp@lists.linux.dev>; Thu, 29 Jun 2023 02:12:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ioVuaS50H8d3NOqGwTQMcSbzORBUM3Uj+9vOcv6ZlarplOrR8+4utdfFiZcwF7eVq+Lon8Z0p483PRAZ7thSFrCcaGVZxpwMeYE4Rq5f3Aep7jLjEWi0glSjLJyngANajLZ1R2AwhXlidpY7uOWfsGQjBGZmF8FVqhJbXUBRfaooi4ahMc8jDloDs8GdljxPlmikw6pQXZwR/fqscT+vCCmQdWDfi1Wbk+4fjwQ6QXFN5SsBoDw9f67vyRee32GI72s50JXF1p3pbEB3kyzPhtvkYBNUhIGd/2tGsnnp70oNbFXPmNRJxQ7MeggbLrHzIDcgZHK6v8AOD89+RMsevw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/AZWCo/UuXKr0hjg1LXBmOPEoSb0iFQlegdcbPvHTpk=;
 b=Ttx1UtSkGgHAyjmbUihVT6aaduAliEpXlVmF5uxmLpCsv/JaEgxRoCS+FjUZOld2zQR6wZoughz2avH2WmIY0n4/vTybZSHnyj7aVEB0p9MCm65X4p0BUwFhW7fUTvO4QWfTqCuP7pzlp6ZniFuYYKpLFeYvu7T85/PEzLCcdzVmsCUNSRCnoqQtgJ+wlQEhlNBfbLGlPcr2I2NT5/JTXLDpcx02WV5rSQbgKqjdG3eL6L9kEGwBHZk+ty57yY5LYs8PMlQlqi/VmPaA9NI8uho+3x7bUiYoJYS+vCu/pOjERkvIQ8CYFGhfGqj3CzBymoAOaD1+zzliBiEc/Tq/dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/AZWCo/UuXKr0hjg1LXBmOPEoSb0iFQlegdcbPvHTpk=;
 b=oHdSgGrWSLwvmMAfmfXpgTJzQWAZUooDHdSxvI7sPJ4lpOgayKvGRyCUHNFVjI2k7yIdPidkYHAwBjdAyOyg0pI3ltbdhT+3fEowSPZArb7jzuq0itNeNPJ944gZDLa+Nw6nfRJKwCLdjcULsZrE4s0167vQw2og9IR7KGo6AbJ0JdRllM5Eas4i5xhbQnR1cwq+YDzHpPXrMgleui6hgPZszQqZ/eKfoaLkH2PMCW07QcNg0OwGIvcw4Tl++Ge6buOCRUYDLFR3P6sD4g8QvYjIzUi8v0LM0IWWqybDPD/dSv7JO6/5X1VJ3SydjSenx1phEPRe8uQM3bFQI16e9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB7049.eurprd04.prod.outlook.com (2603:10a6:10:fc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Thu, 29 Jun
 2023 02:12:32 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 02:12:32 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 2/4] bpf: Add bpf_mptcpify helper
Date: Thu, 29 Jun 2023 10:12:15 +0800
Message-Id: <53359d2572fdd676206c35d29e823e9dffd5e9f6.1688004307.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1688004307.git.geliang.tang@suse.com>
References: <cover.1688004307.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0040.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::9)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB8PR04MB7049:EE_
X-MS-Office365-Filtering-Correlation-Id: eb86578c-54fd-4eed-de33-08db78464bd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vCrGaMWT56CwUWTkiPaR8F3CLolQ6EAi0khxzRlhyOpBAoje6F8qzTU3btPs1WsYreNbEwCLepcizhsTppkVMKqe9qFHB3Gp0WiBw5RSAiDO/liooRFL1m6XuGicJGcOGbAq1Vs0frVL30kkygHHzs8WQQ5JKo63DU8giMiy+ZY7RwRlouY9znQPnu3Kq2B9m8IpSCz+iJ7wk4SSRGwOAKTguNmSdPjAeYx4Y1ZdYdOGd/I4pClgg226emWtp/fOqkW3NWcli1+0gDaMxIPMekK4UbTeqKpMHx9lWHGEteN2kcm1e8CJmxYcTlLLgrI6IUAfoK7v2i6LusXXV+vgXJOtJhC+9/OVwaTTKadrapVomAY0Hq32ITWriqZTkAfSErGfMxsXPf7Ic/MM+ClCYQAT/ila2IDsH6r0KfNd7nLbLnVODV5xCB2ujNO4E6DBC/LOaGFqyEcPiQETPeHNHwtWH0oltR/B9ESeIZgKErsm1YpqNuCZWI0eZ+MdyFyJmI5mhzTZJ5Bj/E6vpKE5KKVsSWIlNSR5eqsB0K/TigjoOt1Y0/KMo6hBC+B0lyep
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(376002)(136003)(366004)(396003)(451199021)(6506007)(26005)(107886003)(6666004)(6486002)(478600001)(83380400001)(2616005)(2906002)(6512007)(186003)(66556008)(5660300002)(41300700001)(44832011)(66946007)(4326008)(316002)(38100700002)(36756003)(66476007)(8936002)(86362001)(8676002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VvMO+793oZG6gZRk+N8tAQG4bEdk2qbxQjSIsKm62W7eN1G2SpzoutSsjtlR?=
 =?us-ascii?Q?LYV55BUBWvfSiDKqWMTW0znSq/gfzH9rQiB0q1qusoFrs3ETO3jr49Rm0XXe?=
 =?us-ascii?Q?SG0LzdYE8vORfVdeQuBOpWvdIxdiuosu/2TayvU1ZHB2BES1BihqPm55D4Pw?=
 =?us-ascii?Q?+zsg8Nh2OCjnHF3PAJahbFmaOBoWgoAq/SWetmpR1b0w0wd3t9TFszz6DF8a?=
 =?us-ascii?Q?a+lbyABW288ep6QkgwyHYW9HWEtO7HLV7cNWFxsPAGxz41NRvRBwL1WsaMiQ?=
 =?us-ascii?Q?HLAOYL0b+kQAOCbetJxbn3No99pyIBjVOfYRUg8+xFtPxViSATRi0YKWouaC?=
 =?us-ascii?Q?HFw5h/upE9l8VxpSlYWD5u1ca3PM9HTF+GsvkchdWjOKrrwFj2yoeDKgSRPN?=
 =?us-ascii?Q?d4hpmpwWR5LA+yp7nD15NtxA95petErv8s4xwR6TFQ9hLaPHsz/p5cnCBXGy?=
 =?us-ascii?Q?9e1WaHXBPO4zFh98Y1mivf3eNRC05Pjok+c30uRsPQC8a2zId6fRVvQW+FLk?=
 =?us-ascii?Q?WxSIK5dyMuo77IbCPR0wqyYTmIOvvYxaKhJal8MavJvxgtUYri7CiooOgdJi?=
 =?us-ascii?Q?/MYtNUjRwm01/4/8tfVYryffK9zZ0Q0oRpw87c5GpaRZGYwpbg8fo24FRoGH?=
 =?us-ascii?Q?Leh+jwmwYDl6/JibvEwYezr5dI28C4eRUDyhmIAMHHh+FkKUvkMJuGbns/vR?=
 =?us-ascii?Q?XC1HhKSDOuQnT/9IxVkzdnpM9RagB1hsarBgWKN3rBlgFntOvBzuBm+vegsN?=
 =?us-ascii?Q?u3YL4fb98XBySTAwoLKdFoAQQAg/1pVNBNrySGEGd8O++FNR2pGqc/wiwrpe?=
 =?us-ascii?Q?SIq5ZzcFkou4gxpmVQ6NvA7tb8GvQHnNwHjRSbx5MEH5unYOUndXY1KEY59R?=
 =?us-ascii?Q?UzUNywEGIl1XAw76qOP9/JBRWaKs3TPDb2wxTQ0+zsAiKFNn4mlRUbZLXHrK?=
 =?us-ascii?Q?C7kzQg5bO/btnQV87BIkJf/RUW1QB12dHWVs6GkPnsneHuFRzGMLk3mXMxvv?=
 =?us-ascii?Q?I7Aa6QdJ+JvyaseAAs1eszQ0dUwfBQ5BNsYfG0FDEMXSu8eO35nBt2+D/vzE?=
 =?us-ascii?Q?8UI0hXko3gyrc8cM5u4GvHzEn7aMENSLs2ja8qFoOwstbk3awyEmZykdioZB?=
 =?us-ascii?Q?ouXdN6J79c2cOtlzAGUkRKPOcg/gclti4zVIgHKXRP94Jl3+DBIyPP/HUDvt?=
 =?us-ascii?Q?nfRr2ZCU1JjwpL4hcadGTX2ID0u7JPIgoiFKzCG+9AwVHCZ7Ca1F8/yqW4oV?=
 =?us-ascii?Q?5Ps1/zNDgUWaRMqG6xAmJFWT3qr4e0ojDS3FIFB1a5s3XjtQdY0z3R7DUXr2?=
 =?us-ascii?Q?DTjQDe1iZtxW3vxtVouNvtNY6w+dYdkVyHHiQ8pW/9oraugC1o4sDCCFF+Ot?=
 =?us-ascii?Q?m/AiphuoTVIM3rBr8AGt3jIaiJBJzsAOhtbPAwt0P74f5+mh4ixYHbgoeoZt?=
 =?us-ascii?Q?THWI6ooXGt7s5q/lt7Bbx28/fJnhTq3u6iA7Yw3lqBvgKlR0ppveKOczXWdU?=
 =?us-ascii?Q?crdCLMP+bXiU4WsRDv2UdDpGsTIxaefFcuPyOk0DcXPZy5SXwOgQZVkq5ykg?=
 =?us-ascii?Q?gdPb9iSAm7rY0Vs4UdMFyRsBeBq8jfAmW6ulQM+Q?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb86578c-54fd-4eed-de33-08db78464bd1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 02:12:32.0818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L95LRj+QKhIXwiwfVRAcT4IQ2liww0ROWCv51qTKwfC5z2m3/YAWZoQAhi73kgKcyrZQmpZy21cm+esanM4uPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7049

This patch implements a new struct bpf_func_proto bpf_mptcpify_proto. And
define a new helper bpf_mptcpify() to mptcpify a TCP socket dynamically as
an MPTCP one.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/linux/bpf.h            |  1 +
 include/uapi/linux/bpf.h       |  7 +++++++
 kernel/bpf/verifier.c          |  1 +
 kernel/trace/bpf_trace.c       |  2 ++
 net/core/filter.c              | 21 +++++++++++++++++++++
 scripts/bpf_doc.py             |  1 +
 tools/include/uapi/linux/bpf.h |  7 +++++++
 7 files changed, 40 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f58895830ada..424056fd5335 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2883,6 +2883,7 @@ extern const struct bpf_func_proto bpf_skc_to_tcp_request_sock_proto;
 extern const struct bpf_func_proto bpf_skc_to_udp6_sock_proto;
 extern const struct bpf_func_proto bpf_skc_to_unix_sock_proto;
 extern const struct bpf_func_proto bpf_skc_to_mptcp_sock_proto;
+extern const struct bpf_func_proto bpf_mptcpify_proto;
 extern const struct bpf_func_proto bpf_copy_from_user_proto;
 extern const struct bpf_func_proto bpf_snprintf_btf_proto;
 extern const struct bpf_func_proto bpf_snprintf_proto;
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 6961a7b70028..ef175ea8ee4a 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5569,6 +5569,12 @@ union bpf_attr {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
+ *
+ * struct sock *bpf_mptcpify(void *sk)
+ *	Description
+ *		Dynamically mptcpify a TCP socket *sk* pointer as an MPTCP one.
+ *	Return
+ *		*sk* if it's valid, or **NULL** otherwise.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -5783,6 +5789,7 @@ union bpf_attr {
 	FN(user_ringbuf_drain, 209, ##ctx)		\
 	FN(cgrp_storage_get, 210, ##ctx)		\
 	FN(cgrp_storage_delete, 211, ##ctx)		\
+	FN(mptcpify, 212, ##ctx)			\
 	/* */
 
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b54193de762b..fa8d656d25cb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -523,6 +523,7 @@ static bool is_ptr_cast_function(enum bpf_func_id func_id)
 		func_id == BPF_FUNC_skc_to_tcp6_sock ||
 		func_id == BPF_FUNC_skc_to_udp6_sock ||
 		func_id == BPF_FUNC_skc_to_mptcp_sock ||
+		func_id == BPF_FUNC_mptcpify ||
 		func_id == BPF_FUNC_skc_to_tcp_timewait_sock ||
 		func_id == BPF_FUNC_skc_to_tcp_request_sock;
 }
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 03b7f6b8e4f0..26c170a456c5 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1926,6 +1926,8 @@ tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_skc_to_unix_sock_proto;
 	case BPF_FUNC_skc_to_mptcp_sock:
 		return &bpf_skc_to_mptcp_sock_proto;
+	case BPF_FUNC_mptcpify:
+		return &bpf_mptcpify_proto;
 	case BPF_FUNC_sk_storage_get:
 		return &bpf_sk_storage_get_tracing_proto;
 	case BPF_FUNC_sk_storage_delete:
diff --git a/net/core/filter.c b/net/core/filter.c
index 968139f4a1ac..e439f8b5f203 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11587,6 +11587,24 @@ const struct bpf_func_proto bpf_skc_to_mptcp_sock_proto = {
 	.ret_btf_id	= &btf_sock_ids[BTF_SOCK_TYPE_MPTCP],
 };
 
+BPF_CALL_1(bpf_mptcpify, struct sock *, sk)
+{
+	if (sk && sk_fullsock(sk) && sk->sk_protocol == IPPROTO_TCP) {
+		sk->sk_protocol = IPPROTO_MPTCP;
+		return (unsigned long)sk;
+	}
+
+	return (unsigned long)NULL;
+}
+
+const struct bpf_func_proto bpf_mptcpify_proto = {
+	.func		= bpf_mptcpify,
+	.gpl_only	= false,
+	.ret_type	= RET_PTR_TO_BTF_ID_OR_NULL,
+	.arg1_type	= ARG_PTR_TO_BTF_ID_SOCK_COMMON,
+	.ret_btf_id	= &btf_sock_ids[BTF_SOCK_TYPE_SOCK],
+};
+
 BPF_CALL_1(bpf_sock_from_file, struct file *, file)
 {
 	return (unsigned long)sock_from_file(file);
@@ -11632,6 +11650,9 @@ bpf_sk_base_func_proto(enum bpf_func_id func_id)
 	case BPF_FUNC_skc_to_mptcp_sock:
 		func = &bpf_skc_to_mptcp_sock_proto;
 		break;
+	case BPF_FUNC_mptcpify:
+		func = &bpf_mptcpify_proto;
+		break;
 	case BPF_FUNC_ktime_get_coarse_ns:
 		return &bpf_ktime_get_coarse_ns_proto;
 	default:
diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index eaae2ce78381..7a20ab9c6513 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -751,6 +751,7 @@ class PrinterHelpers(Printer):
             'struct file',
             'struct bpf_timer',
             'struct mptcp_sock',
+            'struct sock',
             'struct bpf_dynptr',
             'const struct bpf_dynptr',
             'struct iphdr',
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 6961a7b70028..ef175ea8ee4a 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5569,6 +5569,12 @@ union bpf_attr {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
+ *
+ * struct sock *bpf_mptcpify(void *sk)
+ *	Description
+ *		Dynamically mptcpify a TCP socket *sk* pointer as an MPTCP one.
+ *	Return
+ *		*sk* if it's valid, or **NULL** otherwise.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -5783,6 +5789,7 @@ union bpf_attr {
 	FN(user_ringbuf_drain, 209, ##ctx)		\
 	FN(cgrp_storage_get, 210, ##ctx)		\
 	FN(cgrp_storage_delete, 211, ##ctx)		\
+	FN(mptcpify, 212, ##ctx)			\
 	/* */
 
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
-- 
2.35.3

