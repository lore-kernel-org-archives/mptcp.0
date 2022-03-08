Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA597C
	for <mptcp@lists.linux.dev>; Tue,  8 Mar 2022 10:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646736484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=362WZUzmVE200dFQmnEnopUwKgSMAI+IU3fj7/NionM=;
	b=WRvmLobaUT25EUt1Mn+NlyXfSPWVV9cJ5nQXrB0nKVjevZqkiKOY13T7+D/zayW0Y/3fqP
	POsyfg8GxOCRuCHNKAb24KUTueEhIW22TVz/TFh/HwLoZ3FDwaJ5VhHaM2UZOYj8D/Sk7v
	P957fQxbH6ShdVGBGbgdno0eFOeaW1A=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2056.outbound.protection.outlook.com [104.47.14.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-20-AGIo2QTwNdiYHnOb7XUilQ-1; Tue, 08 Mar 2022 11:48:03 +0100
X-MC-Unique: AGIo2QTwNdiYHnOb7XUilQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hj5pNahpIEwHKAJqFC+Zz16EK6rSvogz/HOnLiVS30lIH4jdFztWSpQwhE5Cfbo850DBr9Tif87ZEZ7RhANsxmuC2ysIV5PFwac4iN/I4GHvlSdxl1FHx5wDyM935FaujZM3uZ54fp5pxRQYvcFaBSZFmPf4ePgBBh4vkBiZPcfg6JZd3ttl1afdkG4wMKas2UP5AS+1v6QLioS0VD/LJLykUKCSw0QAZPKib1i54YscmSurvoDY+RoBH1vwY3m9BmAgFtlhbapLJ78Fv7M1DuOwDq67R64U7sU8lGwDUDxVQZ6Jtde+rSumNaGmUoJFgO1MX6RNlQ72fQhvNmOQAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4cTG0orl1M2YPlxQmqgjFLA6PYZxQl1ZAYMHpAOFUrg=;
 b=QUHFN9ikgOmNCE1Q2y15WtyeLQswczxvr+auNRtqBliPlpjcKAADGEHfEyFSQsCFoFGaeXHTiOR41ySqMDqENnVdkkPLHVcPcaaq7w7P3SSxeMqHBeQd/BFvmJBtjSFuR5BcFv0l+zvgTetkFDMBX8dlddcm4MNrAXweywgs9pj7vnZGuRzEJSf7dPaIPq90+p2t4NSXfeDRmhOeF5iKEr+O3Y29ds5gZdwRytROoG3ybn1SBeLa2e5sD7Pi/IQTy/10dVTCJFcDyD4M7TWhYbkSm9xnWeCCKOYLACA7ggH79B6d7bMz/AVmTAskFul78Ad5KQcYPgy/VkvHe+AcCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7929.eurprd04.prod.outlook.com (2603:10a6:10:1ec::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 10:48:02 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 10:48:01 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Nicolas Rybowski <nicolas.rybowski@tessares.net>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v8 3/5] bpf: add skc_to_mptcp_sock helper
Date: Tue,  8 Mar 2022 18:47:30 +0800
Message-ID: <d6d33be9899118c5f542a6ce43f868d4e9e2766b.1646736285.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1646736285.git.geliang.tang@suse.com>
References: <cover.1646736285.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0052.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1cede60-9a6b-40ef-2cc1-08da00f11dee
X-MS-TrafficTypeDiagnostic: DBBPR04MB7929:EE_
X-Microsoft-Antispam-PRVS:
	<DBBPR04MB792909D0AE6DBD95C157D78AF8099@DBBPR04MB7929.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8Q0UxrDjQnhja1inx4BYIN4qsh8aZIknEE0nCsJIq4p+TiwlTIOKN4m0fxAOtH6b5L6CX98vpj8KwIVCnNPuciC9zm8oFgDCNwzf/qsd2Yq9ft761YzqQwWx7JhIA7WGHH6BAhZzvrMGwlFtoyhDqE8762ufvJQk+Lw8IC4AC25nlr4TUJkLQz1SbJIdw6XroiIOPIs7dnJF1MFid49/D41iutfwHHktuFGioeoAnx0YcAnyHvdYWaTPrDRjEBhzVWdREM+xAjjNHrRentszHWn1LExTWPAvCXSDPDhcXrZfGidHywFPKj/GVmZ87LmGskLO3tcM7gmPSYriNnXJDqKTAUDxyuY5sooF5DLz0ayx4bUjLKuYoP6ayXI8pfL8cdGQ5Vs+ZLaHqrF0EMgFkXwFLyAvZiKY44MX9hVWWYWXvjn4g7wennsKzWhFW+iztTQjTlqKUnYnFjcJsAIjWvZSgM/LOl2b6+NyvIkyGBvCg617ffZ2Xphb/GDuMGLWqiESC53Y2F1Q6D45Yh8cfoyuC4oGM1Y9HCqmabRINPi3pBrgqOUuYjNnBiFiXTaZTqTN2r8vIEDmQhKsFOXQTvPj/6zyMQvhHpM3KXwORbHoMH1vikP09vMvuvLY4V8681JZJ8yqzGoWJCK8P/P2kJFSonK+xF9l1RcrFjo45f3JvUcv/xiEscUdsdnPHPipT6KmZBSba4xRadPp7IQ5gg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(186003)(6666004)(6506007)(2616005)(38100700002)(83380400001)(4326008)(66946007)(44832011)(66476007)(8936002)(8676002)(5660300002)(6512007)(66556008)(36756003)(2906002)(508600001)(6916009)(6486002)(54906003)(316002)(86362001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DZBvNAjF9GyX6EYOlmzq/EKpsFI3JhpozuJokT//c2UAnZAyIPKMpA05cRF9?=
 =?us-ascii?Q?PN6+rREGkGE3HAYXYTFSjNPKfNBC62R5FEW64OWWb3TPd+stdsmCxCy+2pcD?=
 =?us-ascii?Q?sT7gvDBbGxCHqdt5uTD70NdMxegYRjSgoh9bBIKQrv812BDiySr+fAswln8/?=
 =?us-ascii?Q?rp2pJLcAz21rsBW1GA9100BOMf5/eXNP7LKtZAHwpylRyMI0Fr90UINBT93m?=
 =?us-ascii?Q?KDfcV/Z8cuX4vYcgb5IPhHuwume6ez4sVWfSGOBLWhAlW0ZW/JN1sxK9D4pR?=
 =?us-ascii?Q?hBq/b/dQ1Nlz6FRfZXX1nesjaF6e31+3juAYZLsWwHXpjGE+QrgWQ+x/WEEX?=
 =?us-ascii?Q?IY2K6I16Ot81vOvcHwriG1r9uJwzAi9bhKKCNmqPWRGC/SGof/EW0saXTDyL?=
 =?us-ascii?Q?aQxtCUx9JbVIA6Y/tWIrtgz3+Yh5CfGdstlb02upTQgiXhFcM4BZicymyfaq?=
 =?us-ascii?Q?0JABWLt6ARqQSUIZQstEFvBJ0xadCXvn/WAjYK85TGRysWOyd2j0SeDN7GLT?=
 =?us-ascii?Q?NSWiHc4NKGpA0xXXNeMUbMT4KuQk/ZHjQZn/H40+ND9iWiHx/fZrc/J1TW2Y?=
 =?us-ascii?Q?S3efZtHTPoRNHNnpgls64J80iQksS1FKRFDnFga32kxmB/LH7DmnPJI6HlbC?=
 =?us-ascii?Q?Ieddu+9OAmic2zHYOKYvQFJRM29JiivMv5iLe5WpEjvz1pLtCZNrbbUJNAl6?=
 =?us-ascii?Q?ohJaQDWeh2lPapTPM4YAGZM4jEPoHg6eiYc3FZQP+kAQdXY0InjLBrJNdizo?=
 =?us-ascii?Q?x1CtFZ3EQ3lwoGD/KfFv/Gd3qmwZ9vuXDwc/FyOW0BsfCYIq+Bmj7dLSwmz/?=
 =?us-ascii?Q?+AJ5kLSS294afX4GckSOoqkI5EyLcXrhtqlhM9otTy8H9tjlZ9Ywb45BYq7v?=
 =?us-ascii?Q?uuqCIqC4FrodU2H44ZxC/bp9q3AEpQY0/xTN6AE5xd5yu5P8yDaLwtlWRqoH?=
 =?us-ascii?Q?mb9rw+1ODtXVsBoJimTRGlvEWi4jTgSVG/9mQ/qvaB/vHAK6wO83fudS1ilR?=
 =?us-ascii?Q?dqGm9vScPiUqBk/18x8ynXZticAG5l/hpnYs7mgn8SQdMwbWWjXjgj2crYzf?=
 =?us-ascii?Q?+ZPEtw3GFA9P/OFHKkBrzPawaL5YV6pjIh+Q4fPSz8ePSJXghPUkFI/jLu2r?=
 =?us-ascii?Q?Ps3Jo8Jl9qCNTulfS3I/5RjflCG98xw1bUsDUm+7UvrvqbjOBb+C+PBTTUhE?=
 =?us-ascii?Q?jAjHkGMlnBu3aMvmi1MwGAbTjqedQzFMuYSsxHVLW73SAXD1OYw6sT6C2PId?=
 =?us-ascii?Q?xMNwT72wdXDt2x+Hjq50yqcK8i1sCTvyRFwtIuCyeSRryulSJDZdJtnYY7j7?=
 =?us-ascii?Q?wgOhZ3blWCUZyYiZ9/Jzj3jLUE/fZdDRab64HTfRAK8jCwZ3hI4C2T6FR89Q?=
 =?us-ascii?Q?JH6xS38eZXVp9cA02zSmZhYtMUZSONiOHjszckWQ2u3oWOYyU30rCSaBh0WZ?=
 =?us-ascii?Q?h/30uMycTgKsb1xPOU2sfyRVOU96f+ZnurwN3mNh9p8oggAkozfnB1tfHYRt?=
 =?us-ascii?Q?+MtQWcnNBlPf7pn/MPge6/Bo+1TW7Bqddmu+SxYEVgwGm8b1bjNu6wicDr9r?=
 =?us-ascii?Q?+klSg7nT6TnJTxYQo90mToXemXNqc4rpujGlZ4SR6zBSXguM5QALvxyJGygI?=
 =?us-ascii?Q?iN8Jp8yhe1YLU2npBNEGkbE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1cede60-9a6b-40ef-2cc1-08da00f11dee
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 10:48:01.8581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S40fQPNlDi18gh9uIQ+BthXtb6rOi4425aFPZhxSW3zHV0fy+qMSFCY3RfKpj2/LRM7ztopHxMzxbM8JiScDEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7929

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

