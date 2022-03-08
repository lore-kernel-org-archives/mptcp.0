Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDE72F33
	for <mptcp@lists.linux.dev>; Tue,  8 Mar 2022 04:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646712214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=362WZUzmVE200dFQmnEnopUwKgSMAI+IU3fj7/NionM=;
	b=V4Ld5LZ+Wkd3mFUhSBGfxAJ51rSVSfh/XT11tOz4E81eqIp5vw1+9e1qi+maMBgrfV701D
	XpOTuda6IXebfPC78+N89XMnmseU/g3OhLUz9r3JUxMocd7bUbFVyvCjPtP8Tk30r7L8k9
	BUfuezp/v8cfT/SdHYWjbiS5HD/K4Pk=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2053.outbound.protection.outlook.com [104.47.13.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-20-etML4Sf1MymPjSrur47Isw-1; Tue, 08 Mar 2022 05:03:33 +0100
X-MC-Unique: etML4Sf1MymPjSrur47Isw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPyZWQdfn0NlX9gTweqcZG458yngcPaw4h4KW3SGNVPXD/m4ROqld3bRbGqyJd9DvCy7HrDxqSTH0mbLOWzsVRmULoPoAg7TT89eKkzyvjb3N73yuk15apfTesi4yfRSeZG1DYHwHfXxdRLBbu++7YQps6vxt5LhXu8IOPXdnZBhxhkFt6jLc0BK29bvUulLyObEPSheiZE6rm1IesXDVd1kp+FQAhHPE/kZaRMav9xI1dezKNW4d/BZ1jCOHKdXC2sLcbW5hnPf6t7B+yOGHxGyxoucdVfTU03D2SY3RLJtcrjNHoxV96O9v9Zuokknuydd3LJz//Ia8BF7LrGVtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4cTG0orl1M2YPlxQmqgjFLA6PYZxQl1ZAYMHpAOFUrg=;
 b=TyJGlAxdElF9bAMKDc+qGvLT8awi2HjL73dXn20UnUe0rrqhlfh416mO4KAlE9grkV1qFmOUTk2y/7rvfmXNYERSM3BLhzJR6rxRTIRFW0KX0MV2zuNdlwPU8byqzjVi569BrLwG3M3/uniPARZ3Z19za3UcOu9FDIu2RfMo0k3icdNDCWGuRRGnyx3v2NDECnIByPB5bIOtApnEEp6KQG8OW7aQ4jIuwNPYiFXgyU4gjb7UPBW5Fcif0Ef+RVEQPByaWezzaYgcZbSWFrCr88En0wkGCZ0wPKNCxLpfEQo95mPtAAJNcZ0AjMD4sHcSNnlUX8uC6CYZOdURhEpNFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7862.eurprd04.prod.outlook.com (2603:10a6:20b:2a1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 04:03:32 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 04:03:31 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Nicolas Rybowski <nicolas.rybowski@tessares.net>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v7 3/4] bpf: add skc_to_mptcp_sock helper
Date: Tue,  8 Mar 2022 12:02:52 +0800
Message-ID: <d6d33be9899118c5f542a6ce43f868d4e9e2766b.1646711943.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1646711943.git.geliang.tang@suse.com>
References: <cover.1646711943.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0169.apcprd02.prod.outlook.com
 (2603:1096:201:1f::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cae4d249-4a92-45b5-39c2-08da00b89c00
X-MS-TrafficTypeDiagnostic: AS8PR04MB7862:EE_
X-Microsoft-Antispam-PRVS:
	<AS8PR04MB786260A237FD3587B71D9056F8099@AS8PR04MB7862.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ki6hI9qya+MtdYDzBo/iod6XU6wJ2mKqt1wAI6osFy0I4oLhw4xEh8XJagtmOt2/536j8h8hwYrz15gq/TvKYL3rXKnbafQQlKib6IqU1hHJJ0gDmU6M/h0ZgEUojKKJwggX8iONR45/k1wsCyTH+2wJt4GSSSjiqlaTfAYGCQFOVQicQ4U7keBgCSlNx/QSX+5AwlCUK6HuGUaUJ/5McCBH8ByXxd2p5/RyRhKvSyS9tpnzqvaYFc37F6YqIpFh1QuDll/HtH+5sqgyKoJ8qU2pBRkGT5o4WlwEwuWrgBFGsbyJe6APexX1aaiWqB3Wqa5xE+mSHFtQqemysIxZB3X5tN3ZhxIBq5SChtj8/V+/urN6Sg8iUGn8432d/5uT9yTYR3eQK/qplWT6oj/cf3hBYqiMLwB0bw7wo34+M4WQxURScPFpZ+eSlO6VZanj9TLGAicE6JwwwlridbcOJldb3DA4lMrmT98hMc2H4Cz+1/O06vnUmnih9RC+21CNbFx/Xi+7nDmM2vO5LuHnfwcToHcfdjVZu7Syzu8QFCyhUGmaAvc/Q9XzbnfnhVVPNzIQgyWZLKHxFBPq8c1Dfn7UbHHYkwh4cn8/asoUC9teBSxQrxlMhQa37gSGba8DANnDOo6q/OfW3Twh2+VHSIWOqgTtO1K27sLjOUfAXIe/gpjr2OniAnQYuToImYAES3cny+9+ORpoQFVrAxoKeA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(26005)(186003)(6486002)(6506007)(6666004)(6512007)(38100700002)(508600001)(4326008)(83380400001)(86362001)(2906002)(44832011)(8936002)(6916009)(5660300002)(316002)(54906003)(8676002)(66946007)(66556008)(36756003)(66476007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hkFLWH+K0mjPoXMZYPilgh14Pk6tbLsmL8NDjQHe0+Eq0KyGqswQQc5nRpje?=
 =?us-ascii?Q?CAi+y/VN96M7wIarvl2HnZou1RLOr0RFFxlr5TIlyDE1VWWf9liMMON/FxRb?=
 =?us-ascii?Q?ifId8aYEYnr+vT0peN/L80rLWW1fYc7hsgctVc0aVx9Yfq2tQoX9LnVgnwcU?=
 =?us-ascii?Q?KYtySk0571xKWP7Or3nfQUX4Zxx9MOXhjlYLlv5Jchudq9CCoiyXHXBeHoB9?=
 =?us-ascii?Q?6v0Vn9Jj4tfbRxpYeURE61WKu4k16JYqzdG85QE3NkjHRDl/gWoKMSFAaP+i?=
 =?us-ascii?Q?P19dSH5XIqeuSHA+tfbuAp7OnNkQZtlUfM9NGZtZrKFWze4auLcRSCacF/LG?=
 =?us-ascii?Q?LwFG+RRm9JzPnUX1U57UwnOV129eYF9N8CX7/LYU49rOURyCkwgDuI5m/kqr?=
 =?us-ascii?Q?hXRIX+FGmdM1qfgWdOpT5o1nPZlScjilgNAHHXdgISIPAnMZAJHt63nXDk+Y?=
 =?us-ascii?Q?AHBC3INO615xF6Ah+/aK8/ksV7iuUYrXrKcc7MbC+2AwoieUts8qK5Thji5l?=
 =?us-ascii?Q?fGM8FdVp3c5vYYRQjiNlNIzjbF85hgMuRLobljKF8ZWZG7yidDC+u3cduQYE?=
 =?us-ascii?Q?PVg2e3YHtaHMIl6Unlk7OKl4+HTBdXEYz0ITxB6Cpe8A0iRPk0jvRKy8+Ip2?=
 =?us-ascii?Q?74IGx++XZdEJevXq/Kph/JzVkRgtmePF3+8Bc/lGNUtJW5jhfqk8IFJT0kBA?=
 =?us-ascii?Q?ZsYAATN7pW4p+7F0dCFBVjMcokrFsPhQOUVQbAUYYH1FmVDpOoSgPlHVn41N?=
 =?us-ascii?Q?pgOuF2TDT3U0FrlSrpNjPyeovGlosjZ075kpiTcZ4glUR8RJwuXryc8UFi4/?=
 =?us-ascii?Q?fDZupJSb48DvFTY8Ejq426xpuIKIhzE/lhysMVcuT1NMkXPAs20M8q42COdp?=
 =?us-ascii?Q?QPgZ2LB1OmpMwXlLoIcc6iwaf21MK+epwHyDxvN5AgB3j2jBUEqYI2/6hPqb?=
 =?us-ascii?Q?/rEmQcOIITGn3ooR8R5Dr98GccMeGcPvH0z6ihUPDpPj00FMmCSdEyDteZha?=
 =?us-ascii?Q?qJfgupAgQRQ7nxNW2kpgwp2JTOKxm8FzEMxJC9eZeZJ8J62zP4KP6ji/+OjD?=
 =?us-ascii?Q?Ka0GruOpWtwEgA1Y8i+dGkgw7HEc5QWjLnCzVFfGsHKeCKfqvi1QyADDLW/C?=
 =?us-ascii?Q?UbRRPZp1tNktzAIhdIWLZmOsDeIazIj+hNrvnZ76Fcgk8H0LTrw9VSmIFWYM?=
 =?us-ascii?Q?6boxkEG9wHonACTCoXOXT7gY6c3OcB1X3CR4TyRBccg1dstFM/EsOml/QoBl?=
 =?us-ascii?Q?ZzGOCV2OfniP/JvsPfKZHHW5K9+NtDA1r+73ewJL+NBFBwXFEel7/weIjSEt?=
 =?us-ascii?Q?dYV/wtdemCuD6wmcLMwLNdpXVgzh4pyd6M2ZjFutNx3hChdS9WxqfCQuxhEl?=
 =?us-ascii?Q?e+1j3mxDPWpXElSxbonNBwKkL8T89fV6tj+yhYB0wQsT6RzIjsVjUrY6EjEp?=
 =?us-ascii?Q?K7qiefjwR1K7Psl0dqP8pNon50rUBxoeJvqkwc2I8zZ1u+RbdMlfKSf6HFNz?=
 =?us-ascii?Q?+9jzFDIXbMicPyo+oKT+3OR3yAPeJhBGcONvrAqUnseFJnwROkIFidSP5uQ8?=
 =?us-ascii?Q?2sFhILhOBNnN0YytO2UK5/qkGL01+t/B3kzim9UoZtsl9kDTsbsadwdCk0xC?=
 =?us-ascii?Q?vOcSl3vwVdeVk7mjOfYJytg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cae4d249-4a92-45b5-39c2-08da00b89c00
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 04:03:31.9308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TElYRX8iwYxJeGEOWJQt5UrvKEsiz3iP3Tt0AQTYae+OY59+GXvc24gX/4pPSPz6vp4c8pBZu7dNcuxoA63Hdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7862

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

