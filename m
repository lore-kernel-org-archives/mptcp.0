Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0379E15A3
	for <mptcp@lists.linux.dev>; Wed,  9 Mar 2022 03:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646796994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O/nlC4E3fz5ELjikySL5hoGVkfPO3SmwC/tXxDav+nE=;
	b=lBGDupq0SAYAzKIxgL2sBtklLDHjdYA4Cg/leeB+3ZHyhf6aP7cHzvY816tW3xetsQ52CP
	13T0sg3fv1CFVob3FaY+RyGKtv1RR+tZnN7XGF3lqV/R3xM5o5VBSwF4KR8d0OpAFK78Sr
	WvvUfXyooKTQdcWt2yplcGKrVGKjcq0=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2058.outbound.protection.outlook.com [104.47.2.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-40-Xzo2vKvqNfC_h10We6jS8w-2; Wed, 09 Mar 2022 04:36:33 +0100
X-MC-Unique: Xzo2vKvqNfC_h10We6jS8w-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWyj4JFaQoTNjr/B1zhX36oIhFEmj4SfgmA+A4lX/ScwMR0VVM6zI1hZSKKbgDZwgfF8rKOHSe7lTkIWQ0KcZ24wuWJqBw9KKIz/uBN/fCtJDBxnDtDlZy9jGGmHBccqQWSAHhSdka6jPYTSiBqlHbYKuaFii5qNaRf2iK/j8k2n55RgDSefjrDyiiDZNAwOAnURu4tEZkI/3/M8svqjfVHtp94RHiduAvfws5ETP2yp9dZmOg5O1S4mZWoe0n8ffPkndqVrzLOGJ9X4KV+IsZ58IVvF4aKNG7dWRg/X88VvuOcc1k9aKXf5zJHT1egIL+bFhE00eR0uQTUgedMbFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=otnwuaxxsFR4Pb1eCGuCdZoItAe+njPTU6au58ElNzI=;
 b=A9LpeS/uGVZdmvSPxCi+yoo9IuCb5w80jA6VkcYW9BZFxoJo/sMRB0j20Z/Rxi+r+MuYhaE51RoVw4Sm1EXzOYAqFYjY+rQB/D3eunM+jrsJHjuLia+Gu/RNVtRIqSqLLihW1PP2qHvR8i0axkXc0h5bScwGDsQWWiFxcg/jKrVZQtaZiNh9kdDxOg5iHH2O2cl9/zg36JTakBzkG9dRVk485G6fjn5uzuKSNYw8/jcN0NVeUSuUKaV4hXr3mhQyibEtyiaPkA7IViJPcHsYYfVzCHsNRqE2A/mi1Q/XoQtbiojhVNUf1K/jWcHhV9zZZU/aE37jx/+dshi/p7Mc4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6333.eurprd04.prod.outlook.com (2603:10a6:803:fe::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 03:36:31 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 03:36:31 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Nicolas Rybowski <nicolas.rybowski@tessares.net>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v10 3/5] bpf: add bpf_skc_to_mptcp_sock_proto
Date: Wed,  9 Mar 2022 11:35:59 +0800
Message-ID: <b657ab17bab2a45408a0bce061f6b1acc650d9e7.1646796538.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1646796538.git.geliang.tang@suse.com>
References: <cover.1646796538.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0115.apcprd03.prod.outlook.com
 (2603:1096:203:b0::31) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 319ae841-e612-4136-f2f5-08da017e008b
X-MS-TrafficTypeDiagnostic: VI1PR04MB6333:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB6333A601D2AB69A215967CBAF80A9@VI1PR04MB6333.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GYDpwZspY2ElUQRxTgSKptJH+1npnWk2pvP9kT96RRLrNNt1qQjowmVAh96jLQWkG8FrIjL5dNNc8wZMWePFxIvLcQTbyfntKKtFSVQcQrvkeisvF398Y8VvUV7CJK6i7S6+XqWnIbMKrMlIHbm3PaCizJR3H5m3JNW6NMttxz161/85VoGtPy4mdxSGsvtMQGxIkeAUFJQA7giH76U3DPhA3/0h/vy1qd+UuZe9oeS3SQ86eJMLt2Lzo2am1Vs8FXTDYsssmuwoLtTanmdlEGI+Fl8ToLWAzGutJ3VNcEZ2TzHTkZz2vGmsdLca8PRqYEyeQS5UNd8BpRO0mqIurz75i4wLONx8ePx10+QCPyN2URcoSkDinr1tG6LQPOmxp5JhNEBy7bP2UCQ4MBxsfDRVI+52oz25RKJHEQvDxrq+MHTfz2LHC4swKjl8HKvBOE4j2FUxay8QrEFAMHQG9bHbtx3NRBzWZ7OzymY45ZyfbIqbP+7gSW0Ru4MPfBiqyYkgMe9m3URn5AODnZBrEYhKxDX9HAiQnUo44EJWVK6GnNeXkJOUn/5sDhrU2siEm+pN7+PiSTS7oTkrC3Frvfhj2P5HVNJ7dPfKKVgidrMVZfkXMKDovQvjFBmc6u+0ZgNW7R9FaX9bXYt1qJD5TwEjlpmRFnBbWffr/F0unep8quD1PvQucTB96HzR94xp2N/QtJQfVR2GYoy9QefKBg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(26005)(508600001)(2616005)(316002)(83380400001)(54906003)(6916009)(66556008)(6512007)(86362001)(44832011)(66946007)(66476007)(6506007)(8676002)(4326008)(36756003)(2906002)(5660300002)(6666004)(38100700002)(6486002)(8936002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PBuAipFVuCgOjPR0b/isIEps+R6GWVHQUWJOoOWYDwDjJ0qee8rtzZOf8bw8?=
 =?us-ascii?Q?hqGQ4XeKsavMbHtM4pWWe9uN21Tuda91uZE7kEk/Fi/Wr7gZ+7RKJwQrBENZ?=
 =?us-ascii?Q?6Qj6ytJ+FHed7eRtak66OScbmFbrM5pUUY+1u2+hwbEX1oh/0xQyPU2OcQ0w?=
 =?us-ascii?Q?zja3PbJGjGT/YA6xH2ykimeiGKhXzIlPM1U3GinJTrNw5pG/WKxpZabZzqxm?=
 =?us-ascii?Q?3YwzkGRTPtETtbzwOqjqkfczvr93qmLYVecUkAHHd8bZunJm0LNBArhWpr3k?=
 =?us-ascii?Q?tB1zeSWqfSxK0BHf8THn+micXj3Dpz5ab/fWCBT8Y3+hU/bw717Qt3Sx3T0e?=
 =?us-ascii?Q?BE5Ed5v4h45N1s4aWMT08LgIvyoIXinXQmuqRjjt29bFMZ0c4xzexBWEhmRx?=
 =?us-ascii?Q?7UEV8DYjbvFqWUYnw2ip1Lc/sXVSYDpQbjPOCkNNCh1F/yOKRK/oDKLPOtL4?=
 =?us-ascii?Q?MB79YgH5bDHvHgJOsLsBa7HlphZmEunmuKAGanKfPJQIHaXxG0uueiOB3RSu?=
 =?us-ascii?Q?Eo/k8xm6TpXGNjfEM7wIfTSoKkQXipTMzRamaXiyDgHuMKzx9x82jpSEMLBK?=
 =?us-ascii?Q?xx7pYxIUsGrsXLPNqzD27mkAjHP4LFzKWtdp+UsMi7V3EiwMCseNUHSYUU12?=
 =?us-ascii?Q?t/R3k4K4oV7/ryDW+rShhCeJNno8KqqCJc9/fPkKaBLZqliT+ToFd0PdEhWQ?=
 =?us-ascii?Q?JcqccChV0FSKSCEGsv0EV2CWaDev1zXUJOqvIImCzgVCn52AjifC2hHeCnW2?=
 =?us-ascii?Q?U+KD8MkJUJEWAc2jpqfL0wGZqxcjfwJvYQhuUGsu1Bg668LhWB+faxHIaQAq?=
 =?us-ascii?Q?kaXc6u1lWAJIdNGgL2FzaVtBy0D3Z62S6rvR6QJgKFOS8fyDJkBxzigSIafB?=
 =?us-ascii?Q?x5ONPAp75FB2hmQbhANysV/36EQD6xUawWHBiSJWoIq+uhR3E2kF25XxQqNM?=
 =?us-ascii?Q?n2wwgkVnrhoV/PHf5r31YsGnuE2Kc6h4UXTJGZjljqqEom9zM4uXVsgbGsyw?=
 =?us-ascii?Q?6/XSTHCATGXzLDcR8cQKlNlxU/rC1OEWatn8eA/UWVWxZJsMhULd95iIvHtp?=
 =?us-ascii?Q?UJz5yf1EvkDxSkIAGELkEUJGJSUAasn/HuX5Z1KuSugYmNMnVCduVUGolIds?=
 =?us-ascii?Q?gyeiZlZO9+PtfTUcdwbiGLmetmYFzmZ+IPzYJBcb6GLR3RCzEAJwXlbmSUTT?=
 =?us-ascii?Q?BGssEUosuZVIWJRSG3sLjgISbgMcQtCp78ho+iZPGmTMkUQ2bv34o9rcA5u1?=
 =?us-ascii?Q?rdHZEopcsTx9osHs0Wm2ta5pXh2vYQvufOKaALFCJJmLxgcDIAn2Zy9mmR0z?=
 =?us-ascii?Q?Z5eAtmaSl47q4+96lWm439oVNj9zpfp3vFY2Wi7sFxJnHHngMRnb+1P4iNdd?=
 =?us-ascii?Q?B0M/YC0tMI0tPcia8pVKoH2XRJiE0wzvFSGqxenIcII2mQM2YooMWpFdRbwV?=
 =?us-ascii?Q?HcC1ED947Gbf90cKM60elGvx1FQ4fOMozSv9mqJ/kguOFCPd8Sog5h6KKP5q?=
 =?us-ascii?Q?5SL5Pd8TsKS4M8j/cocysTv2aK3ziSpBsRongI9HRmYIO9tVEO80oLd4Sugy?=
 =?us-ascii?Q?fK5DV3piWJX8HWG/h7Otw5OmV468Czt8ybWYdNxsrsHzGvctdmL/s/O0VGAn?=
 =?us-ascii?Q?4sqduBcxfEplYYRKQ9tSDjU=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 319ae841-e612-4136-f2f5-08da017e008b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 03:36:31.6618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SZMQRXnxe5fleJe3fCpl+RhuJO9E89g8VtH29F4POfs5p9b+ov5ThoTnt1KfPLWI+a9drVwfOvnRU6JefVH7Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6333

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
 net/mptcp/bpf.c                | 20 ++++++++++++++++++++
 scripts/bpf_doc.py             |  2 ++
 tools/include/uapi/linux/bpf.h |  7 +++++++
 8 files changed, 67 insertions(+), 1 deletion(-)
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
index f64454722a7e..b5a01d80f1f6 100644
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
@@ -11163,6 +11176,11 @@ bpf_sk_base_func_proto(enum bpf_func_id func_id)
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

