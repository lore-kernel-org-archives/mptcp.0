Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B06B3235
	for <mptcp@lists.linux.dev>; Sat, 26 Mar 2022 16:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648311879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u+bUmBMrGS448CsTMz0CjmsoKb9Rrs23jIRQj7JUA1w=;
	b=Dx5bTFiJJOnqfg744bhGEQEI2GRtvIi2bmS3Dw8aLdmAeREeqRLRp4ioNn1IBWLIyYu1AQ
	a/5ClHA0kDyo2zFURsuKlUw6VsAXW4edCsQx5Vv66LGC19FcCe6MpjSy3xEJstB8zIWbkU
	D5C+EM/p7ul70iTUaFrQ5Vn1ds174/w=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2058.outbound.protection.outlook.com [104.47.13.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-3-Eaw5U1hUOyir2iQdxWFFVw-2; Sat, 26 Mar 2022 17:24:37 +0100
X-MC-Unique: Eaw5U1hUOyir2iQdxWFFVw-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2gOOXFyJQQ7M6kSG2Udrrbbweml1JtCfEn607I4qUAnH8NceeqPY0kS2ipTqHNx4kecplTZh/jFPRkH7VWcj7dI/6UInk56Pa90H3FEiPp2jUX+WzLOAffuZrhsghH88uQezI2o0xctA+rBFI7YRIzlN2MKzbcQpmOU8E3q3yoSOqI+CF6cv746Mc8L6y8+fcyBK+7KxLe7i625W7J7r6oVYIuvNdwo+BYa9EzlLVfZNAiQYqVjqmKjGilIHQbui8B0yd8MHrcvS8h3jBYz1rNXtS52bH4KjkS7t8zMPyv5r60ncAZ3m+anmjsnh+0cAlKFpr/UHsQfYpyFP4x9wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=850N0BKeViJLUF5vjbqOu99i07ZAUBZHvrlRedRUc34=;
 b=WGzz25KN25YJ5hBOj/D79StAYRvr9QAz8tebvqSeu80M/6qMMXZ7FQG4D5fo/McC3ztoPK0t3FaqbCL291D4dy58edIQhBFEt+UE/IaZlB4q0AhcmMwMhx3N1kH0Z7Saz0500JMiG0bPei/kDcTyqkBMha2RpD5XIqeki8HO6iZQMp4YYyz4wrPqoNdWTGNsL/w6OfEaeJa71JaXIU3aL5nUI3PRmhebhLq37jwdQru0J8eiKcmY3BL1AI6uB04eRNfOJUaG7l7YL6QQiNGNdRFyNKhkqcU1HEa4LpVlKKnTsXtNGiO/tPw9JGhQYp8VA6SCjbQN1tPOSOxRm0ygmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR04MB3067.eurprd04.prod.outlook.com (2603:10a6:7:18::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Sat, 26 Mar
 2022 16:24:34 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.022; Sat, 26 Mar 2022
 16:24:34 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Nicolas Rybowski <nicolas.rybowski@tessares.net>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v14 1/6] bpf: add bpf_skc_to_mptcp_sock_proto
Date: Sun, 27 Mar 2022 00:24:28 +0800
Message-ID: <fe6b85aa1fe550ad677accc9f7ead05f08d45f27.1648311457.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648311457.git.geliang.tang@suse.com>
References: <cover.1648311457.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0176.apcprd02.prod.outlook.com
 (2603:1096:201:21::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06903aab-9935-409c-e0ae-08da0f451d28
X-MS-TrafficTypeDiagnostic: HE1PR04MB3067:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR04MB3067DCF389AC212D918C067EF81B9@HE1PR04MB3067.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jO3zVJ6VvU/OsRFHKrlr4YtO4DskZpsYIjwcrguXtTeB9mhBocJ0EChuJTHTONjEwP/C2soD2kTSPJj7csoxO6S/nFz31bA0MZcF08JUzSj/68MX1EQvWJWQp9kvhaMs7nz/q5lbzih43/ikyHx1t08DSZ+vdBwH+MsU1aPBlHh2/OfenZyyN7eL4rXIDYKNl7pdjGnfs+h4neBNWjNROnO17kaRPFHByb43syIsMOrO0pvHMKX6UeaeCu7w8/jXIe98mYC9+ygp/qZm5pzXi6BOVIiXobWa20xXn5Z1pvPkXt3j4AioROiJ/nUaeQjvXgLjhbeprh4t/KDSH+14mdh0qyNjHMvu63t17N1l46RIQ7PW2RudiZVRxfdC+4HFL0NewWyBmA0Q9uMwN9LrDF2xR25leOSjO27d1eTqLGjRGJ9/AM43kIhX4/rC3JtzTDJ9JEv9/f+wI9kAh/VJWMVtkyOecUuDvTtfrDmpSwUcToe7IUIrwpH+jODeNIES4jJj/V/yCPs4jbdCPA9HtFkkBfwSOPoWDErc6W/h8R0nRLqrQNoobYm7CYho8Y6ypLPqA0SY2oHsdfDk4oUggMc8fttKyjlujcJG3/BzgS1wPZKJ263h6YRsf2EM4C9aOtNTUtPcaRAIHlBOmJj/yFCMmPa+iBritkz3dyrC+lWlILtRBh1xBrX4q2n2xR9XgtdWLcO31ZBDerRDrUETMA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(5660300002)(66476007)(186003)(6512007)(4326008)(8676002)(38100700002)(86362001)(26005)(6506007)(66556008)(8936002)(6916009)(54906003)(44832011)(36756003)(508600001)(6486002)(83380400001)(6666004)(2616005)(2906002)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3W0eh73ac5Ck9fOPoCRLK8M4VA4hOpTk9TBIqYHv7IPRfWQR95Q24DjDxBiE?=
 =?us-ascii?Q?5D4kMMQInHkKUeD6OEhyKRXqIpzqKLeO9JWXWhV0S3jk0IE2LR7uetU0MLv8?=
 =?us-ascii?Q?J9bSPv8tX+41LeE2C7r2ZQHxiri0QNYQ4zVdk3+njLybT4rg4Rw63ZgPhXhz?=
 =?us-ascii?Q?Yg9M+ay0+hO/gUUEUfSVqradWLEYksh587Vs+j7dTg15XMa+hhIH066uVH9P?=
 =?us-ascii?Q?GChwIJHA5e/d+Qc6vH/ve/f5A5uZM/6N7m3Q74auk53R5/YzN5MaiIlx4C50?=
 =?us-ascii?Q?tGFX6riIk9npSmSBoKeXZKUqay4TMdjTP5r4su3DStScZ0sdIrdwL58DtTvT?=
 =?us-ascii?Q?Yzb7VDJ2n4blF90eVVG8M2llo13nzzfzdJcmUEp3mImtLdkD8HvQqyFnZ0M8?=
 =?us-ascii?Q?o1kG8aNdjEtXaZ2dWDuYIBOjEt8rL28VssBaQLox5u1RaAaqR4p39W44c7r7?=
 =?us-ascii?Q?zhXgPfBl7xdaoFcVGusR6Wb2aP5TmFHwKIuEegkqAJd0o8iu9EHw7h8ho8Vo?=
 =?us-ascii?Q?OaWthrzLGjLfT1dmQGDr0UaVHrYIuj2H5lM8yb7IvqA0ws/qxz48YMw/IY7H?=
 =?us-ascii?Q?G0CJ6xDvtTHipw4Aqzhr4KNqNa6CbDfXk5LKI77ktRlj/5j7LZ852banY5p/?=
 =?us-ascii?Q?as55NWUEpU+ED5W98GV0af0IjbSFEEsBtQeY9SVAK849zZWVjdZlKUbUPP3J?=
 =?us-ascii?Q?bB6pLkn+SsXBm7kLFeJD+Lyv7XqTnj57by8w7phzHnLSd80NzYyX2/uvZA98?=
 =?us-ascii?Q?s/+AAlliRT5WzHZWnfWkLH3prTQL9MglcholTYT9FYrJuCbNF2p7FN5So5dN?=
 =?us-ascii?Q?p9YEtRjoWTDOTjBd33AUiAxreZUjcFekj1L74dkMdKJALJMeeOsarhJqGZs6?=
 =?us-ascii?Q?A0ClaH5w6scLhNCr41oC0K/KJYAi/au/nqVMedyp/b2EWJDUArHRlwAE2wdm?=
 =?us-ascii?Q?ScRkIih0Qnn3g0Ytf8mfzjmCGdWj2Kt3IIm9mYL8qO9xZ7a9mozQEXmcVQ8v?=
 =?us-ascii?Q?IcBOKls/I13ZjzYAS4uov3lUhhfgWhtVXUIIqslQzx7JN8kPXkMwYR8JfD+/?=
 =?us-ascii?Q?3LF/Q+09NsgzZDDbhSsUsdPOFOXrrsVUCVoHXgd0Adu0DNVKCkcp2DHCbXLK?=
 =?us-ascii?Q?lHvDqYvFbjCtUaLZCvwdBHgpoDw0mQ4si4OhzuW4uR9dfe9dyNfwPPzYOQuq?=
 =?us-ascii?Q?bzBXKZ0YuC1HpBxGdy3Ej0CTP6GPmhGJMox8U4iHwkrAZKDcXc0wBfP5hWIV?=
 =?us-ascii?Q?GfG2QHLEu4QQWtRTzcCElEWeDD5iM/GRLR/MiyUnpbTocn0xT/8GaC8EeszP?=
 =?us-ascii?Q?hM46AO7jGxeO7LJx1QOkob0BWDus1yTia0uty2Huv4eevSf5NTKYPUED8pAE?=
 =?us-ascii?Q?tLnAmUtwa8PvIAFDJuUSq9m0kz2zx1NJX6KzJRbrQHqAZEO2y5wD9GEYsCQF?=
 =?us-ascii?Q?uOoIKkO42vuu2vel9qAL6WOqLjQBcEkECrONu8xOAZExRPhCCBAIRA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06903aab-9935-409c-e0ae-08da0f451d28
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2022 16:24:34.5693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QwY4h3q88rJjX4rBxyLeqfsGtX9hQ2OCaH1wj+L9kCrVsD/YEjsRfGKryVuxDkz8HtpKnEc5xIm8dDX0EhobMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3067

This patch implements a new struct bpf_func_proto, named
bpf_skc_to_mptcp_sock_proto. Define a new bpf_id BTF_SOCK_TYPE_MPTCP,
and a new helper bpf_skc_to_mptcp_sock(), which invokes another new
helper bpf_mptcp_sock_from_subflow() in net/mptcp/bpf.c to get struct
mptcp_sock from a given subflow socket.

Co-developed-by: Nicolas Rybowski <nicolas.rybowski@tessares.net>
Signed-off-by: Nicolas Rybowski <nicolas.rybowski@tessares.net>
Co-developed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/linux/bpf.h            |  9 +++++++++
 include/linux/btf_ids.h        |  3 ++-
 include/uapi/linux/bpf.h       |  7 +++++++
 net/core/filter.c              | 16 ++++++++++++++++
 net/mptcp/Makefile             |  4 ++++
 net/mptcp/bpf.c                | 22 ++++++++++++++++++++++
 scripts/bpf_doc.py             |  2 ++
 tools/include/uapi/linux/bpf.h |  7 +++++++
 8 files changed, 69 insertions(+), 1 deletion(-)
 create mode 100644 net/mptcp/bpf.c

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index bdb5298735ce..117ae3f9451e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2372,6 +2372,15 @@ static inline u32 bpf_xdp_sock_convert_ctx_access(en=
um bpf_access_type type,
 }
 #endif /* CONFIG_INET */
=20
+#if defined(CONFIG_MPTCP) && defined(CONFIG_BPF_SYSCALL)
+struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk);
+#else
+static inline struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *=
sk)
+{
+	return NULL;
+}
+#endif /* defined(CONFIG_MPTCP) && defined(CONFIG_BPF_SYSCALL) */
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
index 258821e58ec6..53f353b81a1f 100644
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
@@ -11312,6 +11325,9 @@ bpf_sk_base_func_proto(enum bpf_func_id func_id)
 	case BPF_FUNC_skc_to_unix_sock:
 		func =3D &bpf_skc_to_unix_sock_proto;
 		break;
+	case BPF_FUNC_skc_to_mptcp_sock:
+		func =3D &bpf_skc_to_mptcp_sock_proto;
+		break;
 	case BPF_FUNC_ktime_get_coarse_ns:
 		return &bpf_ktime_get_coarse_ns_proto;
 	default:
diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
index e54daceac58b..168c55d1c917 100644
--- a/net/mptcp/Makefile
+++ b/net/mptcp/Makefile
@@ -10,3 +10,7 @@ obj-$(CONFIG_INET_MPTCP_DIAG) +=3D mptcp_diag.o
 mptcp_crypto_test-objs :=3D crypto_test.o
 mptcp_token_test-objs :=3D token_test.o
 obj-$(CONFIG_MPTCP_KUNIT_TEST) +=3D mptcp_crypto_test.o mptcp_token_test.o
+
+ifeq ($(CONFIG_BPF_JIT),y)
+obj-$(CONFIG_BPF_SYSCALL) +=3D bpf.o
+endif
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
index 096625242475..d5452f7eb996 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -633,6 +633,7 @@ class PrinterHelpers(Printer):
             'struct socket',
             'struct file',
             'struct bpf_timer',
+            'struct mptcp_sock',
     ]
     known_types =3D {
             '...',
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

