Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3E648D0
	for <mptcp@lists.linux.dev>; Tue,  8 Mar 2022 13:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646745448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=362WZUzmVE200dFQmnEnopUwKgSMAI+IU3fj7/NionM=;
	b=Ra1JXUTwEGYDxy8OwTCXd9VdaMybfP++7hhhnrouQZKEw9Dy5EVkSb0s2M0QniDBA7fHgV
	0swrBAR4uT1mTU1k8WKH8ciVn7Cz3lwod4hNJ+rvcr/fN56fiUJIALnmjVcO14U0B8s7As
	26ePgvqEcClFmSKzTehPTttY8Dfz1h8=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2055.outbound.protection.outlook.com [104.47.9.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-2-qveuI56mN16fWg1lcJRhNw-1; Tue, 08 Mar 2022 14:17:27 +0100
X-MC-Unique: qveuI56mN16fWg1lcJRhNw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i2FRII4O7P91Bl/6C5E+cGASRVr2q8YzYYgRgJGFI04J/412lErmFSMQoApWRikkcTDRbe4OInkvZTB+Ux42UZRYAF4ZJCZBW8lOPBk++GZwBTUXqNAqLwqtLgm1Cx/bHAP0jL0qTD3VM0DzDjN2AQiiA4avlB68Kmf0yDMhshIfg/eWowXRlIJlfnZu8P0SHFklGdJhYJhH+6D8ymXuZpUniauesjMh2uWWBKBM4egw+ncQuLqSAWP/5M5/0cumERAAAKdW1iUC3j5F5rEhjSsYQCgjhiIzvJE2+pb6VqEyv4Oa4EiHXmR23/gTaAKd8uTxgnwnO65CawiMivDeeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4cTG0orl1M2YPlxQmqgjFLA6PYZxQl1ZAYMHpAOFUrg=;
 b=AhOnpDiz4UJ59hnwiGrXLMKoIp2SwabKMoDdZz374aWqucpdpFcHQx51Yuonfqm3wIs62hnVtWd1bGsugA1cChBDLn4fgyygOxGViIi5TCNH997pkZkASaeaGa4bFdgFRbgkEmYt6NN6qe9EiW8nJvXtNjdEQKL487NTm49+VPafTlrwLbkMPa7KN22AAZmVOnuulzNKPsBv49fV4w76ixc8QZdWfS1wunncolERMXDUR/HqRgOUQTOKetKt4AUWfdqIz1gVESn/nH2XL448QJijfgHs21xrfbhFIWrnophDFFlXwXJopa3lfymXegianHs8Z23sHtVUu4Tvtf1QSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8142.eurprd04.prod.outlook.com (2603:10a6:102:1ce::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Tue, 8 Mar
 2022 13:17:26 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 13:17:26 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Nicolas Rybowski <nicolas.rybowski@tessares.net>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v9 3/5] bpf: add skc_to_mptcp_sock helper
Date: Tue,  8 Mar 2022 21:16:56 +0800
Message-ID: <d6d33be9899118c5f542a6ce43f868d4e9e2766b.1646745228.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1646745228.git.geliang.tang@suse.com>
References: <cover.1646745228.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0058.apcprd04.prod.outlook.com
 (2603:1096:202:14::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba206a66-097f-4e42-3be0-08da0105fd30
X-MS-TrafficTypeDiagnostic: PAXPR04MB8142:EE_
X-Microsoft-Antispam-PRVS:
	<PAXPR04MB8142D7907179C65C6CA5A28FF8099@PAXPR04MB8142.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	J5ioqhvIiHvPPVxk7ovYkDGf121JcZVhVkTmvvW0HxhlVMGrFx4WlzT9iSPySD7O67xIsyJQlGM/3gsyHZxKk9o9F/dy5iy7oLBthEDQSqMXhxaVMkHdm5u01KjRFteXw+/YSzbfxI6DqCwUaV68yirwu10aUD+LJKeXDhIcTLu6Z+Gw+6mKsVsrYBwmtuxkCs1uWPl/WDa7wk0tqUnmcE7HRaU962S8XH7SNdkQFOHl7XYQ7JwEXwRRim3MDZ8ltEFAKI67w3V+Gnuu3eXAMDFAzKVW1I+oLrKgUeg5sdETe9deFFetUmPGZjSq7BuQvI+j1hZ5+t7ah1PIQ7LUam/KO24rvnGbgbEKKEFNQ4Hrm9/n8kxGaAiUj5drGkoC2mY2bmBHBPGG+44bFyV8NQAjwEJSP7X6RHH0w5n96bmNr2accHbyLGVyvOXteI/0MLr3P6PTpw2ocQWl0n7qfFpzCKz13qX+JvZ/CasXvGi0BBdVzSZthQ9+hSTYBN0OL9vs36rZT7A0Xxkfz+3ZHUpfEzAW6gt82FrHvOctkIgb0wSmxzEbQohVEIG64qWWKgVRfPh8p9DTLv6EO58l3HceTTZSvIFFf8Zu/syvewazsrOB7dmVxSUv+NVGaLbp7CCMqffsIFMm94QVVzuoy1pIFeeJT1KClJAeXRniRmkuP/ouplQYnV22kTtVoT/x52y3oYwOAfz9L8/+xsDUSQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(316002)(6916009)(2616005)(6512007)(44832011)(54906003)(36756003)(2906002)(8936002)(5660300002)(26005)(4326008)(66476007)(66556008)(508600001)(6666004)(66946007)(38100700002)(86362001)(6506007)(6486002)(83380400001)(8676002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kP8A40A3xkmQTSjoxh+2cmZNBT58jiEbNzWXNHbDpqh3Ur+corJHlqYEl0Bs?=
 =?us-ascii?Q?aJq+XzfCSjGCQvOMYgy3CmLDcuuPRqalnsGAQDucHo6905tlROyoJryitLYS?=
 =?us-ascii?Q?tJDtvG3mqM8x/vWPyVDzspPkbFQIM+jTa90soAD8itX59Q8Wf67UPTt4JAzL?=
 =?us-ascii?Q?1IbjXleoLRG+aNH09t0zHhdxmJSLJg1GPqpepeqXCN4R3c0Evx7tl/itsMeV?=
 =?us-ascii?Q?UYqqJKuusVbKjRJ2mVCYcYi/qWmPClLLGeYm4KIioPnKuaDsP55Jp7lVgNEo?=
 =?us-ascii?Q?b7TdpN/OmWpX71BPB2pdI6OVxCB6HbI2wf3PWtXVfzTDbMJTaxbr64GrMcoa?=
 =?us-ascii?Q?xErpXqZIEJrIjfKcbgonfUe5eqt8XfMx87hxzU61wV+qdIv4argu8VtISRp5?=
 =?us-ascii?Q?7tql7bm/ddyhyj/bwOlZs5ZNL2+SI5S+SyRDifs1owYmkX4Uy1/tvmvDM8xI?=
 =?us-ascii?Q?18deoU0w3+jA1rOcSSLmtD1aCRHn+Ky4ymaOaWNnoSPlX1XkR6MaGc+tipAE?=
 =?us-ascii?Q?gLnDHk04InoLvlZzXHPdAH6+d3f0txxs+suysG9xtIaZ+yux0214GN31n/u6?=
 =?us-ascii?Q?zT6E4IzZ3nE5i58W2vq1sJpF83/zltlI4xnTki2GdtQE3tXEBnNLE7huIGEQ?=
 =?us-ascii?Q?gvClu2eYdIdQ85PrXQKWkVs8Tqe3uZgocLVorokbPTyqZ5zn2SgIE/4AizaD?=
 =?us-ascii?Q?TI1Byoedeg15l9Apb2ZKzHxmNcHDLB5k2bkl008Oh69fStF2/DksDwitxHXz?=
 =?us-ascii?Q?tW3Zh4mm1dz5ZwCohNd9e8g7Rb6C7ZDyhxtkmDdGaQar2e91bH+SIgXVlIfN?=
 =?us-ascii?Q?q3gANgvfTy06IUdNB9qj+rngDck6MuDrEOKibf7mkMjO77DurhICEBcJNQmR?=
 =?us-ascii?Q?VRm+t95aynvvX85jkjocoQ9zPRaGf9N85IQPzWQu9dwe1VDCdX0iS/8ca0Rg?=
 =?us-ascii?Q?/j9j8Fek03j2W22NQrGYjAvYv40MZ6bPXnKfVtTMuVA6lYcJVJcpVsN7cBg8?=
 =?us-ascii?Q?tsyoawTBAGdmOlLxqSZKLKp2OdOwcfzD2i6s3isp7YL/gVO91zLaCGi/v14l?=
 =?us-ascii?Q?1tIZBvRH0wUfAqhAojZH7vrXi7DaywaVavqGNleZ0xj1glq2W8SqFahYW9Ig?=
 =?us-ascii?Q?UhSM1SEhHwuVGSnEdMjo+Wi88jF0i9c6mZMZiHqlmhowlTQdBCSjneUrYy1S?=
 =?us-ascii?Q?UePsCTWZc//WCpxCQ8pEcdHhAFDTqZ1DEMyuuI30JAVkn6B6E8NZUBtL1TFQ?=
 =?us-ascii?Q?HAKYnpBopoQzjLx6N5+8pFzbzBQ08i7HOXY9kdGkZIKNx7xnbMFmYEerbgqm?=
 =?us-ascii?Q?EY+WFEfyOTHX3F5JOnCY1+pFRrwjEj94pYbDp72nmEVY0O9K8WoBg49h8HgA?=
 =?us-ascii?Q?bZrLDla5nUacdL1aRigYRm2+2qv282hfFLC3Y9G8Du/F2vklSv4/C9AIHeGS?=
 =?us-ascii?Q?0XckDvq7qCYX8nnBZRiqvABpTpReoJJLpMIPBZVan6x7b+ENxdYOgzRRu904?=
 =?us-ascii?Q?3QeVBXuY4fpmim21am7wFVAVLnfjAp78dX5xJNfKfl2kcLkKg/3EOPhw+xAD?=
 =?us-ascii?Q?0vCp8sQOg5KOn0ieffrkk/0hJLu7mZd4HmwedraklZKbat/d65hbnzsYDn7C?=
 =?us-ascii?Q?I1arE9mhQmy/hERcxiEj/NI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba206a66-097f-4e42-3be0-08da0105fd30
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 13:17:26.2638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t0zsMhtn5yr5zFQuU9TQ7ZsDwh2wrcv+jJiTVTeGaq27lXI9fj7OPYDw6z327TL+Kdu5NialQLugW032sUDH6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8142

This patch implemented bpf_skc_to_mptcp_sock helper. Defined a new bpf_id
BTF_SOCK_TYPE_MPTCP, and added a new helper bpf_mptcp_sock_from_subflow()
to get struct bpf_mptcp_sock from a given subflow socket.

Co-developed-by: Nicolas Rybowski <nicolas.rybowski@tessares.net>
Signed-off-by: Nicolas Rybowski <nicolas.rybowski@tessares.net>
Co-developed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/linux/bpf.h            |  9 +++++++++
 include/linux/btf_ids.h        |  3 ++-
 include/uapi/linux/bpf.h       |  7 +++++++
 net/core/filter.c              | 17 +++++++++++++++++
 net/mptcp/Makefile             |  2 ++
 net/mptcp/bpf.c                | 20 ++++++++++++++++++++
 scripts/bpf_doc.py             |  2 ++
 tools/include/uapi/linux/bpf.h |  7 +++++++
 8 files changed, 66 insertions(+), 1 deletion(-)
 create mode 100644 net/mptcp/bpf.c

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f19abc59b6cd..b28b3d8c3df2 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2354,6 +2354,15 @@ static inline u32 bpf_xdp_sock_convert_ctx_access(en=
um bpf_access_type type,
 }
 #endif /* CONFIG_INET */
=20
+#ifdef CONFIG_MPTCP
+struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk);
+#else /* CONFIG_MPTCP */
+static inline struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *=
sk)
+{
+	return NULL;
+}
+#endif /* CONFIG_MPTCP */
+
 enum bpf_text_poke_type {
 	BPF_MOD_CALL,
 	BPF_MOD_JUMP,
diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index bc5d9cc34e4c..335a19092368 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -178,7 +178,8 @@ extern struct btf_id_set name;
 	BTF_SOCK_TYPE(BTF_SOCK_TYPE_TCP6, tcp6_sock)			\
 	BTF_SOCK_TYPE(BTF_SOCK_TYPE_UDP, udp_sock)			\
 	BTF_SOCK_TYPE(BTF_SOCK_TYPE_UDP6, udp6_sock)			\
-	BTF_SOCK_TYPE(BTF_SOCK_TYPE_UNIX, unix_sock)
+	BTF_SOCK_TYPE(BTF_SOCK_TYPE_UNIX, unix_sock)			\
+	BTF_SOCK_TYPE(BTF_SOCK_TYPE_MPTCP, mptcp_sock)
=20
 enum {
 #define BTF_SOCK_TYPE(name, str) name,
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 3f6dcdf4b915..a88aac4457a9 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5086,6 +5086,12 @@ union bpf_attr {
  *	Return
  *		0 on success, or a negative error in case of failure. On error
  *		*dst* buffer is zeroed out.
+ *
+ * struct mptcp_sock *bpf_skc_to_mptcp_sock(void *sk)
+ *	Description
+ *		Dynamically cast a *sk* pointer to a *mptcp_sock* pointer.
+ *	Return
+ *		*sk* if casting is valid, or **NULL** otherwise.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5280,6 +5286,7 @@ union bpf_attr {
 	FN(xdp_load_bytes),		\
 	FN(xdp_store_bytes),		\
 	FN(copy_from_user_task),	\
+	FN(skc_to_mptcp_sock),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which help=
er
diff --git a/net/core/filter.c b/net/core/filter.c
index f64454722a7e..538b6db4fd76 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11121,6 +11121,19 @@ const struct bpf_func_proto bpf_skc_to_unix_sock_p=
roto =3D {
 	.ret_btf_id		=3D &btf_sock_ids[BTF_SOCK_TYPE_UNIX],
 };
=20
+BPF_CALL_1(bpf_skc_to_mptcp_sock, struct sock *, sk)
+{
+	return (unsigned long)bpf_mptcp_sock_from_subflow(sk);
+}
+
+static const struct bpf_func_proto bpf_skc_to_mptcp_sock_proto =3D {
+	.func		=3D bpf_skc_to_mptcp_sock,
+	.gpl_only	=3D false,
+	.ret_type	=3D RET_PTR_TO_BTF_ID_OR_NULL,
+	.arg1_type	=3D ARG_PTR_TO_SOCK_COMMON,
+	.ret_btf_id	=3D &btf_sock_ids[BTF_SOCK_TYPE_MPTCP],
+};
+
 BPF_CALL_1(bpf_sock_from_file, struct file *, file)
 {
 	return (unsigned long)sock_from_file(file);
@@ -11163,6 +11176,10 @@ bpf_sk_base_func_proto(enum bpf_func_id func_id)
 	case BPF_FUNC_skc_to_unix_sock:
 		func =3D &bpf_skc_to_unix_sock_proto;
 		break;
+#ifdef CONFIG_MPTCP
+	case BPF_FUNC_skc_to_mptcp_sock:
+		return &bpf_skc_to_mptcp_sock_proto;
+#endif /* CONFIG_MPTCP */
 	case BPF_FUNC_ktime_get_coarse_ns:
 		return &bpf_ktime_get_coarse_ns_proto;
 	default:
diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
index 48a9d978aaeb..0a0608b6b4b4 100644
--- a/net/mptcp/Makefile
+++ b/net/mptcp/Makefile
@@ -11,3 +11,5 @@ obj-$(CONFIG_INET_MPTCP_DIAG) +=3D mptcp_diag.o
 mptcp_crypto_test-objs :=3D crypto_test.o
 mptcp_token_test-objs :=3D token_test.o
 obj-$(CONFIG_MPTCP_KUNIT_TEST) +=3D mptcp_crypto_test.o mptcp_token_test.o
+
+obj-$(CONFIG_BPF) +=3D bpf.o
diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
new file mode 100644
index 000000000000..da79dae559b2
--- /dev/null
+++ b/net/mptcp/bpf.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Multipath TCP
+ *
+ * Copyright (c) 2020, Tessares SA.
+ *
+ * Author: Nicolas Rybowski <nicolas.rybowski@tessares.net>
+ *
+ */
+
+#include <linux/bpf.h>
+#include "protocol.h"
+
+struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
+{
+	if (sk && sk_fullsock(sk) && sk->sk_protocol =3D=3D IPPROTO_TCP && sk_is_=
mptcp(sk))
+		return mptcp_sk(mptcp_subflow_ctx(sk)->conn);
+
+	return NULL;
+}
+EXPORT_SYMBOL(bpf_mptcp_sock_from_subflow);
diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index 096625242475..0e5a9e69ae59 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -623,6 +623,7 @@ class PrinterHelpers(Printer):
             'struct udp6_sock',
             'struct unix_sock',
             'struct task_struct',
+            'struct mptcp_sock',
=20
             'struct __sk_buff',
             'struct sk_msg_md',
@@ -682,6 +683,7 @@ class PrinterHelpers(Printer):
             'struct socket',
             'struct file',
             'struct bpf_timer',
+            'struct mptcp_sock',
     }
     mapped_types =3D {
             'u8': '__u8',
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.=
h
index 3f6dcdf4b915..a88aac4457a9 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5086,6 +5086,12 @@ union bpf_attr {
  *	Return
  *		0 on success, or a negative error in case of failure. On error
  *		*dst* buffer is zeroed out.
+ *
+ * struct mptcp_sock *bpf_skc_to_mptcp_sock(void *sk)
+ *	Description
+ *		Dynamically cast a *sk* pointer to a *mptcp_sock* pointer.
+ *	Return
+ *		*sk* if casting is valid, or **NULL** otherwise.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5280,6 +5286,7 @@ union bpf_attr {
 	FN(xdp_load_bytes),		\
 	FN(xdp_store_bytes),		\
 	FN(copy_from_user_task),	\
+	FN(skc_to_mptcp_sock),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which help=
er
--=20
2.34.1

