Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E81A1391
	for <mptcp@lists.linux.dev>; Wed, 23 Mar 2022 09:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648026600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2DrvO5rip/hgUotrahdyxlwfws1Y0zx4omMtVPiwjto=;
	b=hCP+aaPdrL7avFU97ER+rU49yKc/s3cj/wXt7l+r281IX7Zz0MynJ1nP5aRtXICkYc/WPz
	h754hQUx/Du1LbsyPbnY6OQgHyM7gbvgxsxeaDV+RPFzAEHJR4jPsWIxB+UYJVN+K2H3gq
	jfhE4K0vzkXd8OURlwG7G7iHAOANC/o=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2056.outbound.protection.outlook.com [104.47.8.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-31-xrca57glNOKPhswlafIlmQ-1; Wed, 23 Mar 2022 10:09:59 +0100
X-MC-Unique: xrca57glNOKPhswlafIlmQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XDeCJ0o7JgKWkuq6/EjdC7cRiHNl1aZtFe7pmllCpkfG94f38x4Np/FJwyjEhI7bBdd0DkOOmpB17Q8NmcVEgqVOSQ9Yinc0GJ+Y5wBtExWDIOBeQKffbBjTO4xt1ecYNT3EQUGsfDrJ4q7iURDIqSmi7PtJz6Co2AInJ/Q5VsPlugb0XTRoaKvk/gsZicMm6vDkRqNQ4uA/veec7cbpOA0RE0pZorg2I2p1FAKf1N/lWfRWyIGEfALDEU2G6ZHjQ32TrHNWZ1FPQN8sdBef1MKksg6WOLyiPexrQoFs/n0g0Q+K/KTJT6ox0WZCdOQgbbUwhUuAamJdSqsUolAKOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ilCdS1i9TAx1QsDfZ2ZkaMsndyzSVf2mCIk2dBWFCIw=;
 b=TrovhPJXNG2bXD9iCG6vWfdSbnFSG7tdQeEtHhJN7Zt78DU6wwE7yEwMFP/whrMLEc3Ui9hsIoKGOsIn1mPzGeXixT9ZAZ6XVXtDjEuJEEgp5OX4rm+PEjAoUDLn6brfzBOTiqTueP8WpJ6xSwDMw7DGsj4xvPTfDs2ONezDcS8Cz+ZJfZui73IhNzEwn4YtYfikOr7t7WEUJkbwFzJ7jQGzvvhFu0wT+kIpBDIMDVpCZhNawmAlTfkyjsRQWGxuD4ggeCdy8iDZDFXUXZ5mAJpl0yXcUi8WPDhBSHl84k3MCPdt/4i+M57ySMgg0wtuTJ739lpxDM1XLVn75ZeGIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB5988.eurprd04.prod.outlook.com (2603:10a6:208:11b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Wed, 23 Mar
 2022 09:09:58 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 09:09:58 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Nicolas Rybowski <nicolas.rybowski@tessares.net>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next v11 3/7] bpf: add bpf_skc_to_mptcp_sock_proto
Date: Wed, 23 Mar 2022 17:09:32 +0800
Message-ID: <8083614a3a2b867f5838f8cbee2106d1169f3fca.1648025308.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648025307.git.geliang.tang@suse.com>
References: <cover.1648025307.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0198.apcprd02.prod.outlook.com
 (2603:1096:201:21::34) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58dacd19-c90d-414e-9b07-08da0cace73a
X-MS-TrafficTypeDiagnostic: AM0PR04MB5988:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB5988F0F56FC56ED9A3F5C3EBF8189@AM0PR04MB5988.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6eWVT1KtBA2ya10qbelLgYxRyCQsoitYZdUYUIbDLNJlUziPThI/UB8a9Xyn/2fUrZQGiE3Yg2r5erV/47U1FBMClFHlL35IwGI0uqI+2khWmWw3inTuMKl8gmt/sZV1ac05FgGDWMNxqD/xLXquPfheZKzb1jYv8S5CTVGTAXHw8WWEtSa5lUnb8xImJchDA8UzJjItuy7BOixRqqkG8DSPV8cyqNYOGQYE4L9S8g1/oo6HmFVXF8gSWnpcXDEqd0uwzLEIgzUP8+9ibSqOEEAntbKYIVC1SoLMqAKRrQJysxCOzF1Sm7Ig5AUKDkl32cBVoF6nwzWVQ162XkpBguNUCH7FU8ggLJ+v1oBJYBIUPBM0wRUr+modIWVEvSuueeQWa9K9/mkuaIFrCCzARBLPDSngAQh7ve73nlhHem0Svkgy0y7dzgbWHkLaXUGlWve8m3JVG92udtbZE05j58ri/3t0Q94nvkRm1Dql7TWdWHBgIUEHgmmn+OqHuALWIwItH5Aez2jRAmRid2Sl3MqHsY1xRqqZ+p4SSCpMiK7O695/2wTQRWgHavNWoaY8QrenICsbvGJ9aAxHzjgVj5eayRstavNTuK6NCHrM4lKuPzf0j2SavfHvxZmeuVRftQRHYjSk3uRnXWV2L2XyaCWEulT1lv3StWt8ujjdBOhnky+dgCHyFp07KCEh4pcFevCNIIfDEwavHqMtEokU7Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(2906002)(66476007)(8676002)(66946007)(186003)(26005)(2616005)(5660300002)(44832011)(66556008)(8936002)(83380400001)(86362001)(6916009)(6486002)(316002)(54906003)(6666004)(36756003)(38100700002)(508600001)(6512007)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dg1PEbppnVt2xEMnu5HtTMZikxRMsEu24z+kkVQB8fRNNigOYMfZzVoiuu9e?=
 =?us-ascii?Q?9CGpOXYAlEYYG4o3iZNbaTClClFU0OvxbQsU8kuubB3A7yYevD2iu0293TKh?=
 =?us-ascii?Q?/J2RL2rw6KBA22fqn/+oLgJdf2Tumh5cZ84ePROQMzxsXfPwGO9EvCu9xSF/?=
 =?us-ascii?Q?UZ6xrPMrwHisS+FZA4WvryuzWLD09ZwD8LHWw7C91VRZjxatxkxsZtOdgBXY?=
 =?us-ascii?Q?bmQhU7M8tw0kElzUc5rXAcDvYujL2ZS9jMYqx9eRGnOAdrFH6Z2ksGsBzMYe?=
 =?us-ascii?Q?wczo3foxpmFVBByk8vgBNi/NP6S5eLVdSxY4wbib1WnPIbIoNeybNklGNrZJ?=
 =?us-ascii?Q?C+0axHJzcRFy70YjhSARTT8OxpqxxPTe88/BlGAA7pWWaL/AuEqCMbKj3kOk?=
 =?us-ascii?Q?3la4eNz1qWLpY0rFY8e1j+Bdr4nJSJjWyewXr3taNCLyQh9xeeIKnF0+17BE?=
 =?us-ascii?Q?F21vcn5QmwqBb8YA05ylWMQiBAaLCyHk1NLYmhNStdG2raj2O0ZD4ycBi5ol?=
 =?us-ascii?Q?+ps51Cdcw+N1S3cYMWqLktswPquGGvm4Pph86wbhKFZ+X9W7GOPAaUxvsQte?=
 =?us-ascii?Q?ugYEPZX+StfytJxvo5NyPiUw7gpf0fmo+aj6E0/6rev9wJh9ExprJ2Td74yu?=
 =?us-ascii?Q?NXQuLOe+QvE/4qxgtaffFvQp+jb49yW6hBnvgPShH6vxeX0q0t6jCXRBVnsI?=
 =?us-ascii?Q?nFeq8JU/15ssPJtLp3e286/Z2xevbLIosSNJva4DywKgepyxU0le8T36dkYd?=
 =?us-ascii?Q?L4Bnp6OqWzwrsmPYESBFRoNZDddtP5r89UjQQwIcFVAXBwW2XGuBhCRSdboM?=
 =?us-ascii?Q?kjsmGCVPHcjpaFJQFzA9ZwBnhyAAoZ6TYIi3kJIVJCwpn9g29XX1U1zrnzxa?=
 =?us-ascii?Q?S6tEyE4E4lNOY2yuWMczBqGVXMawh8uDuSbCIDCpb+okhVNlpV42+nBPiiuY?=
 =?us-ascii?Q?8d3i7hLvxSEgTKQ5ogtvIiXztxq2V365eY+ZNZy4Fm7JJR+ZTY7PpFO280dX?=
 =?us-ascii?Q?k9VQb6Z79t7yGEKC4HB9Cn42wc6+lduBsb8JkXLjQDqRTMKW2CIWkGKcZ9ZF?=
 =?us-ascii?Q?QMpT0rJpOhOnj6rmFUEa9YmRy7MQGa/pPURG2rsGojEyitfusok20cyeg1xL?=
 =?us-ascii?Q?PQdDpd9oc9dTaL+zEPZrqUR5s6Z/f0X6KEJ7gXLmggA/zLpvpse/VVbSvHNq?=
 =?us-ascii?Q?gL8/KyTJ2utrzaSa4xIaK/ENOV87TmZbKt6aLRxEggH4jdP+QT8ngi80XlGE?=
 =?us-ascii?Q?57mIrwGRpFf7Ugv+uBzUaY8JhV8LIN4gQByIt1RSFoBMnvDalGXovjjAdwou?=
 =?us-ascii?Q?J03Lh86edG1qKAoK0qPIqJewTjo1QAYgEjOrDp5NJnEVAN5zMCLbnV+/HmUK?=
 =?us-ascii?Q?phfze+NJnKVWMZeQ8WZH5+68b3UBnxNtl8uJJfgg1+DjhhHeJ9Ni1wFQPRC7?=
 =?us-ascii?Q?Fy23S+XCs8xI8WvS7tCsQPREFS+g9n6CCyRQc1DFGeNsl2mUEoHD7w=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58dacd19-c90d-414e-9b07-08da0cace73a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 09:09:58.0882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VenpMTxiqXi8b9yPsF6o04kPkqucj9ObV95qK92Pu1IN741GLD7NJauXjwjpLwv7Qe06M6ttHmkObpKZkQO0vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5988

This patch implemented a new bpf_func_proto bpf_skc_to_mptcp_sock_proto.
Defined a new bpf_id BTF_SOCK_TYPE_MPTCP, implemented the helper
bpf_skc_to_mptcp_sock, and added a new helper bpf_mptcp_sock_from_subflow
to get struct mptcp_sock from a given subflow socket.

Co-developed-by: Nicolas Rybowski <nicolas.rybowski@tessares.net>
Signed-off-by: Nicolas Rybowski <nicolas.rybowski@tessares.net>
Co-developed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Acked-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
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
index 57cb6af3177a..fdf4d2285588 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2365,6 +2365,15 @@ static inline u32 bpf_xdp_sock_convert_ctx_access(en=
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
index 4ae3cac94fb2..f02357cbdcbe 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5117,6 +5117,12 @@ union bpf_attr {
  *		0 on success.
  *		**-EINVAL** for invalid input
  *		**-EOPNOTSUPP** for unsupported delivery_time_type and protocol
+ *
+ * struct mptcp_sock *bpf_skc_to_mptcp_sock(void *sk)
+ *	Description
+ *		Dynamically cast a *sk* pointer to a *mptcp_sock* pointer.
+ *	Return
+ *		*sk* if casting is valid, or **NULL** otherwise.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5312,6 +5318,7 @@ union bpf_attr {
 	FN(xdp_store_bytes),		\
 	FN(copy_from_user_task),	\
 	FN(skb_set_delivery_time),      \
+	FN(skc_to_mptcp_sock),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which help=
er
diff --git a/net/core/filter.c b/net/core/filter.c
index f195cf034e43..b87370e77926 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11271,6 +11271,19 @@ const struct bpf_func_proto bpf_skc_to_unix_sock_p=
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
@@ -11313,6 +11326,11 @@ bpf_sk_base_func_proto(enum bpf_func_id func_id)
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
index 000000000000..c3b6f94f033f
--- /dev/null
+++ b/net/mptcp/bpf.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Multipath TCP
+ *
+ * Copyright (c) 2020, Tessares SA.
+ * Copyright (c) 2022, SUSE.
+ *
+ * Author: Nicolas Rybowski <nicolas.rybowski@tessares.net>
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
index 4ae3cac94fb2..f02357cbdcbe 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5117,6 +5117,12 @@ union bpf_attr {
  *		0 on success.
  *		**-EINVAL** for invalid input
  *		**-EOPNOTSUPP** for unsupported delivery_time_type and protocol
+ *
+ * struct mptcp_sock *bpf_skc_to_mptcp_sock(void *sk)
+ *	Description
+ *		Dynamically cast a *sk* pointer to a *mptcp_sock* pointer.
+ *	Return
+ *		*sk* if casting is valid, or **NULL** otherwise.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5312,6 +5318,7 @@ union bpf_attr {
 	FN(xdp_store_bytes),		\
 	FN(copy_from_user_task),	\
 	FN(skb_set_delivery_time),      \
+	FN(skc_to_mptcp_sock),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which help=
er
--=20
2.34.1

