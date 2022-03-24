Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7AA1FC0
	for <mptcp@lists.linux.dev>; Thu, 24 Mar 2022 13:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648128518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h4U6oLE7Vb/RNofjwKSYhcXqAYsVcSOsZFUN15CBcBQ=;
	b=bOL+V2YClZuxRRQeA0+jKjyFl5jyfFhmkq4hJ6pcUhf3JBY2SRuJkuWApYsKG+8rOK95Vv
	gAMCyKwSiBKXYj4A9Z4DGr3xjctf/pwoOWTIgbZp7q/qdfAhppuKty3fuoKbV8RGP61mnI
	C8eTYPODQ8WBEMr90RhY6e+6lOtOMTc=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2053.outbound.protection.outlook.com [104.47.1.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-31-cKYnCTHgMCyczfRK59neeg-1; Thu, 24 Mar 2022 14:28:37 +0100
X-MC-Unique: cKYnCTHgMCyczfRK59neeg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MHs1e3hR+BcVh3UvOpWmem8fMu+nJstMxsjcSdN1GNXxyhK+JAWYxcLR/Ags61tAo2MXeKhIbz27uWH5mgQy/jJObVlEzU+M+T8FaCTqYiQEnNmHOEtDhoufLHyJDSinzBlzVQaMRoPsB7bRmsoYHNZ8hRs9IgPiNJ+SyEQf5qfPYfwLuiTeUwi8EtHFpdyDcD1KZSf+JZjIYosO1qm88Ssi9XZPveWUpWWR28BZK8+GL70lNyZSMVPMgg6KDCosKEuMsn1ID8rN52dKH1q3tIEUAdRaVH99syXUSrMZ+QKLawKhz2sCQbxcLns/SPj1Jy7IaYd/qbw+gp2gMKIsYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PpiTjAbWGd/bjBFWG5BSLENmZL86ej0t+eyXFjK6+yE=;
 b=BCM6QFdXxqUcthoXwQJnFL6QMX7ble4tSF4smyfqGtnPCEPrinatN+aV1BQoguMuEXKZmfIbq4pJcopwL321gFUukP0cENiSAx2M51NVEQUYmuGJPw+Db7lfGPI/ai8pzIhOqE6JHz1mHl2/HnFE6chy/YQywWDYtHaKyP+E2ZIt6iNwQJ4iD675AQauxyCZwBIxEVlVjBIVPQ9gpgilPszZe1uUyr4+yJumaNAmGDWDMO7Am/K980Ga0aTZSvJFXdMYwny70yl+2+9S1VXra+AtrZ9NerzU7EhfLE5qenmZOjPmkenou5W2+BTRjnKmsO4Jrzkl4uN0YOk9h5Oo9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7754.eurprd04.prod.outlook.com (2603:10a6:10:1ee::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Thu, 24 Mar
 2022 13:28:36 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Thu, 24 Mar 2022
 13:28:36 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Nicolas Rybowski <nicolas.rybowski@tessares.net>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v12 1/5] bpf: add bpf_skc_to_mptcp_sock_proto
Date: Thu, 24 Mar 2022 21:28:28 +0800
Message-ID: <2faed80c68d4170a206bd8cea88c95a2038a747e.1648128255.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648128255.git.geliang.tang@suse.com>
References: <cover.1648128255.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0002.apcprd04.prod.outlook.com
 (2603:1096:203:d0::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2c36866-3a4c-43fc-f178-08da0d9a3329
X-MS-TrafficTypeDiagnostic: DBBPR04MB7754:EE_
X-Microsoft-Antispam-PRVS:
	<DBBPR04MB7754860C0FCA205443AD28F2F8199@DBBPR04MB7754.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ep/irnKmo6z+1A6XMH5jndlHYR4JJ2aUw7Num3TYdak1vxS9ibM4nWqX0VoJNEXUmMx/STisp5XxAnXSOqa/EtnxMu+DB9PaZ04zmgS2to6k7VKuELlZUi4ubNOeWxNGYFV62lC45FTWFe//Dz3g+ytnBav7gkeVPtefn3iOp7zd1lcNmA1XAfwHdfNhlWOTo0qJNgXkdPxlidvcj8VGkoLdeCXA/wlD6hNX0pRhSsA+1RgekfXuaVI4QE/1CYfEG+q7+oTJjxIEhe7fxK/seN0Y6YsBYBk1fnrUyg69YNiGdFV3fIM8zpDbvA0Q/taCb47KLqP9v37WKSY96ihRTfj2fuJ8wE62QEPRoJkQlwyz6gPVy5xCfwcESURjtXD/SCj21DnBwlUeulCBlYYmxrl3lq0M0YhKdrIRznjQtpRTMyuLn2AsA10GtnEVs5Yo3RM7JxhbUCI7+S5aJSjJlWtagT6siiZTBSZhuqpKaUBihniBUfFn6cu+h2MeSiIEOzirIF20/ZSMix7Kj8aapT9YS0lYgwDvG2iB9EyKwu5tez60i5sUDn51/xwyvhkaJK+eX9uz3YuZG2YAGZ4FDzndodq75Ej145UD8s5J4vCj0s+kU54Z0V8TuP7b+mFazKjV6ZB7yooQR4yknMu9X1WTKKcWC3HDGLG31wEg/ei1388rtRnNPs7zLRHaBhGHwLy3X1FA9bKvmO/uLeZtAw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(8676002)(508600001)(4326008)(66946007)(6486002)(6506007)(6512007)(54906003)(8936002)(6666004)(6916009)(316002)(5660300002)(26005)(186003)(66476007)(66556008)(2616005)(83380400001)(38100700002)(44832011)(36756003)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DCLCZZrPcM3kK9fD80HI9Dfrt+d1hsxI4K3tGLkRcmpExLSrHPjcQM9Q8kW6?=
 =?us-ascii?Q?354cBqHl/+u4YlfScyTDdu7VSJ09LnJBoHRSN37MIO0nmXZb6Pe5kSAypHQs?=
 =?us-ascii?Q?1RQrtT74+uh/KFW6IEO5t+HjJnTsrxs0kSazzGa+/qsR+5LNq33ftHDgOOdq?=
 =?us-ascii?Q?aVdW1ttiQlr+TpjD3fr0FoE8bGwr5TfPHC4t6vHCijT5QikutJxEwxVj7wuX?=
 =?us-ascii?Q?BtfkByF9fLOSydYUw7pngB4hTH1NgHe8fEs4w4ORJnQ4A4d5IwtyDagqVDb7?=
 =?us-ascii?Q?wicI9PtSJo2Y6zO44zd+AbjBCVeV7RldDZzeBhFLM9IKEirBISszFoApf7oM?=
 =?us-ascii?Q?dH7r7bwRRcMR2SX7OL8jgoP+PfnXQy3Rs8e32bCQ1hlx1sYu288Hfqb79KnN?=
 =?us-ascii?Q?wsRG5EG2xY9jxjHPzA3FYZggBZa0J7LYnR5VO14dVGjjklwNm1nGbY56HLlW?=
 =?us-ascii?Q?UOZJCwqki5g8XhMpLh9RK9aZ+ei56zwr/GdrdDBMjOYhVsb+7B01KeYaSH0n?=
 =?us-ascii?Q?YzmAEFpxMn9nNa6dx/LQ7qCWjcsRpVcpuiRaXhYxf1vdEGklNEujiHJbVVNO?=
 =?us-ascii?Q?FmO8T0DkQ8uTjbtwtsJEIi9e6Nqfx47XLUcmX3e9z0QmY515FMjsfwLJHCUU?=
 =?us-ascii?Q?WY37LB1/0UlZgiFSwtYBE4zK4cCXHdi8QKm9N5NM5TvPgNxCfGeDXz9B8uOB?=
 =?us-ascii?Q?9PIyHuvIhBLMIl0iXsazsp0SA47YnYmnNcqMcMmxQP1tXvB2UmdEZ6KO2iel?=
 =?us-ascii?Q?ca91+6kWz8Fe1POC8OfLhhBBzryrCVUSf1arWom3zc57IGi+4SeREhBJfiMn?=
 =?us-ascii?Q?TDBCW5CgwIHXf35EPMDyaSLb3BgJ2195Jf1RqOBW0pQtKDzlOW0W4QVTaA5m?=
 =?us-ascii?Q?tkipmgH9DCbpA1JuXggfJ6Gnn2RoyJHxHMt0pDK5wVDVZ1KDxSfhD1+3WIRp?=
 =?us-ascii?Q?y92HYUbF00YeNXW0+EXRhY6OXqevtLtqYoGoEzFeFXsE0mrQ5qVFOEd3NWWh?=
 =?us-ascii?Q?TPHHIOfCAanosqv8Mc91L0ytPvjW8aIK+jNSefYpBQz6mLFgQGqxFr9/cvk2?=
 =?us-ascii?Q?GnpB7xqil374f8IGcQqnsUfkuAHtabl/PIp8NOZT7YrmQ4T14Jlu8Tvq31Px?=
 =?us-ascii?Q?gf2NND21FP1k8Ctl0+G+GgPMxe5jUzys9TWwCR8D5f/njUV4l4xZ5M+VmHqo?=
 =?us-ascii?Q?ChLb/zF1dxcZc4yxxpqA6IEWz6hUYu3hKwxPYFJw0yNunSd65ozXS5/XKcvK?=
 =?us-ascii?Q?WDRx4vZRfe9vRxsBZAnrxGb8P87BR3GZQhkMZqyHm7Qy9wczUV5aAmGoWNH+?=
 =?us-ascii?Q?HgoaW2ObWNg7j7v7g+xPuXwViWFPp1uQym7gU2TOKVTHWQBAKaWKHcQv2yGr?=
 =?us-ascii?Q?UiCm9zr4rxe+hRB/NKkyhvqJh1SWcGwliYF/l3M1bLP3zrq7wmMlO47HUSgs?=
 =?us-ascii?Q?NuGqbijhRnlp9wRPfuENrdVhUxb3IwkR2rMNRKW96iizzYpSFEBUtg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2c36866-3a4c-43fc-f178-08da0d9a3329
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 13:28:36.2576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +LAW3nvRaVb0iRB7K1ojjxEmaAn9gSWADFpPtF6tomyX+j625N8Ha+Gl+1NfGfSlYUxObeIKSDhpuJW/3U5cLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7754

This patch implemented a new bpf_func_proto bpf_skc_to_mptcp_sock_proto.
Defined a new bpf_id BTF_SOCK_TYPE_MPTCP, implemented the helper
bpf_skc_to_mptcp_sock, and added a new helper bpf_mptcp_sock_from_subflow
to get struct mptcp_sock from a given subflow socket.

Co-developed-by: Nicolas Rybowski <nicolas.rybowski@tessares.net>
Signed-off-by: Nicolas Rybowski <nicolas.rybowski@tessares.net>
Co-developed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/linux/bpf.h            |  9 +++++++++
 include/linux/btf_ids.h        |  3 ++-
 include/uapi/linux/bpf.h       |  7 +++++++
 net/core/filter.c              | 18 ++++++++++++++++++
 net/mptcp/Makefile             |  2 ++
 net/mptcp/bpf.c                | 22 ++++++++++++++++++++++
 scripts/bpf_doc.py             |  2 ++
 tools/include/uapi/linux/bpf.h |  7 +++++++
 8 files changed, 69 insertions(+), 1 deletion(-)
 create mode 100644 net/mptcp/bpf.c

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index bdb5298735ce..9752445aa266 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2372,6 +2372,15 @@ static inline u32 bpf_xdp_sock_convert_ctx_access(en=
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
index 9ef1f3e1c22f..785f2cb15495 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5143,6 +5143,12 @@ union bpf_attr {
  *		The **hash_algo** is returned on success,
  *		**-EOPNOTSUP** if the hash calculation failed or **-EINVAL** if
  *		invalid arguments are passed.
+ *
+ * struct mptcp_sock *bpf_skc_to_mptcp_sock(void *sk)
+ *	Description
+ *		Dynamically cast a *sk* pointer to a *mptcp_sock* pointer.
+ *	Return
+ *		*sk* if casting is valid, or **NULL** otherwise.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5339,6 +5345,7 @@ union bpf_attr {
 	FN(copy_from_user_task),	\
 	FN(skb_set_tstamp),		\
 	FN(ima_file_hash),		\
+	FN(skc_to_mptcp_sock),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which help=
er
diff --git a/net/core/filter.c b/net/core/filter.c
index 258821e58ec6..171941772a2e 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11270,6 +11270,19 @@ const struct bpf_func_proto bpf_skc_to_unix_sock_p=
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
@@ -11312,6 +11325,11 @@ bpf_sk_base_func_proto(enum bpf_func_id func_id)
 	case BPF_FUNC_skc_to_unix_sock:
 		func =3D &bpf_skc_to_unix_sock_proto;
 		break;
+#ifdef CONFIG_MPTCP
+	case BPF_FUNC_skc_to_mptcp_sock:
+		func =3D &bpf_skc_to_mptcp_sock_proto;
+		break;
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
index 000000000000..535602ba2582
--- /dev/null
+++ b/net/mptcp/bpf.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Multipath TCP
+ *
+ * Copyright (c) 2020, Tessares SA.
+ * Copyright (c) 2022, SUSE.
+ *
+ * Author: Nicolas Rybowski <nicolas.rybowski@tessares.net>
+ */
+
+#define pr_fmt(fmt) "MPTCP: " fmt
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
index 9ef1f3e1c22f..785f2cb15495 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5143,6 +5143,12 @@ union bpf_attr {
  *		The **hash_algo** is returned on success,
  *		**-EOPNOTSUP** if the hash calculation failed or **-EINVAL** if
  *		invalid arguments are passed.
+ *
+ * struct mptcp_sock *bpf_skc_to_mptcp_sock(void *sk)
+ *	Description
+ *		Dynamically cast a *sk* pointer to a *mptcp_sock* pointer.
+ *	Return
+ *		*sk* if casting is valid, or **NULL** otherwise.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5339,6 +5345,7 @@ union bpf_attr {
 	FN(copy_from_user_task),	\
 	FN(skb_set_tstamp),		\
 	FN(ima_file_hash),		\
+	FN(skc_to_mptcp_sock),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which help=
er
--=20
2.34.1

