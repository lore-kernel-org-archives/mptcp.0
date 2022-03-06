Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF69C10EE
	for <mptcp@lists.linux.dev>; Sun,  6 Mar 2022 01:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646528535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DIRFswwjsk7XTkrix4FmPXHWCL2XoOBpsQLXRVgQCI0=;
	b=WCl2AX3lvf7KmoVmCqM90zv+czIoEqKj86rOZROyVw60UY80LWfLeTOJe7juF2D1shqgq2
	6bt5uKzAVWDzJVxML+CQYb4HIACZNlDG9BpRsd1tKCHnXRC70RsmhwAPYyro/+GGFyjKpb
	srcLQvFrdsfrnkEzOZm9A2M1pyM2JSk=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2059.outbound.protection.outlook.com [104.47.13.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-28-RxTiuvCHM1mv_vEou57S2Q-1; Sun, 06 Mar 2022 02:02:13 +0100
X-MC-Unique: RxTiuvCHM1mv_vEou57S2Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0+PHf1LYB6HnPnv8o0XJs7pxL3Z0RhzVqynyR7wh7nevvMBDOIKvrsY9KeGnFRgvUANveTh2ayv1Ax5jFTwxaz6iEij6N/5D9ZPR17Wc5vpqmONWiOL8nCq/Se8L7ykK1VOfeoBHKKyLDP4laG+l370HtPBiylB46/RArPOg6UbISeQWAEgdLK4zMBww8E1OhGqYOpYjXm7BTPpJ0bfC/p3bc8JGtGYFI8ohk83f88HbviiGnM+Xl0dtZzxd0kojhFQZaxJ+ha7jWQHWAYlSGnMXMidG/ko4ti37WE6MQOILfWiVGJhdv4TdEmrPghD2+PoLRtGOwdzhZOHtLesXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+IqIzCOygSIQmLBey3D5KWkDPlGv7EsKNSEgncru1k=;
 b=bH+oFI23wS8O3wEp2CJbzugn0XtTztsv+oVD1v/QcGJlUAejnGm3O9cKvU3B3DxyUaYnZZvtKUnQBXgzzhllINUNmtp3wZVLX0tbq41u7CGM4cS3RdWqXM3N/QEyEWrEpOvFR0U2G1dVeqDV0MP+ZhanFU2JX1mAti4SZPwf/CgoVPzMnyD+rg8TdNTOAfX4ukUmE2Jw9je1xKk15YecoElpN2KufEmJPio8mkZNuJC5W8l8YjJ/CD9P9R189RVgor89h6CjdTnWP/XpJFP7F1RWWWLA5j/+hJJKf8ArDDY3+b9zc5bgn2TLRrAxRx0rQ2umx542291clRD37KgplQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB5724.eurprd04.prod.outlook.com (2603:10a6:10:a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Sun, 6 Mar
 2022 01:02:12 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5038.020; Sun, 6 Mar 2022
 01:02:12 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 3/4] bpf: add skc_to_mptcp_sock helper
Date: Sun,  6 Mar 2022 09:01:36 +0800
Message-ID: <c5594343d3100143e8f24974d893e57a645942e3.1646528337.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1646528337.git.geliang.tang@suse.com>
References: <cover.1646528337.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0206.apcprd02.prod.outlook.com
 (2603:1096:201:20::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1d02340-33ea-4b47-1f37-08d9ff0cf232
X-MS-TrafficTypeDiagnostic: DB8PR04MB5724:EE_
X-Microsoft-Antispam-PRVS:
	<DB8PR04MB57240EA5528547E1993C0045F8079@DB8PR04MB5724.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Qc7k/LsKXba9ZFo6D354JbGJ86lsfLleC6UJUC+xYV226yhAXW9im8YPaEdcCoSPZOeeR4aIo5Jo6ZFxtTiIT2Bh/MFni6Rl+fQgJHeVOnRUE0P8ClSXVST1N8i1BiaAvuEluGdJc9YKTHRULwauhSJd3pjlnGyRGzTrd6T1wJoq0uXe7SSgmlcYcWPrYVrTCeltykEgU80nCgkv6k/iq5vX9t+nxxseCIClnAAXsA+prmNj+4sHta0YH0QSo/+IfpXHJ3PyWdq59cQ5RkA2I8YgfJ9laWkCksDKueEJAHDcSPwUw6y5O2NiJocvWy6gNbRiShCLxixJSOw6x+XClpxRBIPEU8PHp3HYYwUazBS1PrIZqPMehsNPegxVOokw6CXxzOw6mcH2UE/+3DgkIVRCc38mV9v4Q/X513WECmUV18Q7v/rsr2qrPBkXhXhVTNr1Lhlv6cD2Ag2bwNTBuW90qehW97aX+aqd+LGb6BS18c1mtCasGOGwb1uG0r7Dc66dpnt5I2Qo0nJdJ3fqntNKe7j4N8Mfe/AHnmeHV4E0qONCEC8KzkB3LAwQ2FluejWObOzuMkc/JofuoTUvrlWladCnGf3a0If70QglavQ68hkAwhkwlaFGs1hCWlgSv83cvaDn/DT6QNWHl9X2imvj7vuGwdvzPGk/IteXtnGy64j+GXpOHgTHHawKj81vZfH33Ce4wLfMGdewOCHFeA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(86362001)(8676002)(4326008)(6512007)(66556008)(66476007)(66946007)(44832011)(38100700002)(6666004)(2906002)(8936002)(6506007)(83380400001)(316002)(26005)(186003)(107886003)(6916009)(508600001)(36756003)(6486002)(2616005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lRNHPdtxhP0eAPzXlfdJEqzdtdQKUmYTqy8FT4En+wuye2KjGRyRv0OhL1cE?=
 =?us-ascii?Q?bG/Q3YcT+k1OT9hI8b5/tMvsb7igZg1ZeenL49N0J1FoxyJ/RTbnug9aipqY?=
 =?us-ascii?Q?X7fUwaA86ha4xfXp39nCbu1qzCt4ygMWsDmEaNfY3wwpvTK0kWp60a+SyeG9?=
 =?us-ascii?Q?+4LuqFT6p/7QXfXtZ8CoZJoII5YHdNiBAdLnGj+bQYnBGxVlxZEg/TWVUeW3?=
 =?us-ascii?Q?pieWpAfyPQ3KcYvrpPek1j7tkhCsOXIGke2psUvw+mXfKjt0eHyskiUh2/wQ?=
 =?us-ascii?Q?VWoMIt0KQFdNv3EBYYIoSCNiEsGDqxC99y6LOVQlV8eei1saSr+sw5N51w34?=
 =?us-ascii?Q?/VU16yCWBxpLyGBZzIeEkPMoaRaWZvkwqt57TQ0mXJ0fLQYfpPzVZpgrocc9?=
 =?us-ascii?Q?cRtzNuRb+6VSL8SrT/F06PCjtP398jcPt4+gWg/7lmzNmfZNZHbHc4N/hKzQ?=
 =?us-ascii?Q?2ZllhGwr2v2PTPCEHXwBsalMmdDfy5a+zIb855ZZbKpkG0Wv0V3jlP/WuURj?=
 =?us-ascii?Q?b2SDCRIY8RG1tYiYXJovyPyNUGSw+tNawPTbCQlJ3C9roBeJXbHIxr3nXOp6?=
 =?us-ascii?Q?CycOPWh+fD/LtKfEVUr8emJwhbcs+GPpfsAT+lctr02Bnr5052KrraMcZY+D?=
 =?us-ascii?Q?tu+OSq3LExWFJX5YM9NDcavScxFL/9WS9UODNkisl/o8o5d1j+xdMp9wYAUS?=
 =?us-ascii?Q?N8T1cyRryertOKnoX+qRjzjx23jEN8ir9Hi1kABihAPUcVez+ywwLR/n8ba3?=
 =?us-ascii?Q?6qxsG15PRxWcV0eKT1X7jv9943ZhUXpoK88UKLVVpS0j1NZtzAUhjIjD2kf3?=
 =?us-ascii?Q?v4sT9+euXNcfjLaYcBl+omEG4jfNntDVjBnIYRhkFF5o9cGDPkzAGSIbN6FA?=
 =?us-ascii?Q?oixI7GO/noPS1osOgstrDVW06rqBJPZqkeL6H+1a/Wh40vKOsZHlQGIOsbFt?=
 =?us-ascii?Q?iTJTyxyoBP1BRDHaYN9s5rWs086KzctQRxBfmCaNBB6w7/gAfBhLTNREPbiR?=
 =?us-ascii?Q?geT0WzRHUV4PBFMVYw+qPnzfC4OBdgxj3P2UiGmBGinFOlFAtRxPNM21/VIW?=
 =?us-ascii?Q?qXHHpMgODAV8fGqd+Qnua+KRq7rmauBfjk4gAD3iT/fwMaJkFSUCKwzL2MyB?=
 =?us-ascii?Q?hZa+ZylCOMngapiIScsu4FDB7z+tjRNuqPgpvmKp5ZJEc+THkLR0/TiS7DNb?=
 =?us-ascii?Q?FkFihe1tZPnQyp5KNDecwX3qU4v/V0jLssMH2M/8c8zjftjG54U1e/H4NqQs?=
 =?us-ascii?Q?a//xCGYaKzIN0GS6NKA5sxc5vpLJkFLk+vAVawZfOJq7gz+kSduLUKHlJhMv?=
 =?us-ascii?Q?Sf5bp49jiN/DdtRJvlZ56rW0sAUaGhupUCqFg5uD8XYsrzGG2oPuxaNXLAlE?=
 =?us-ascii?Q?f2ga/lnpQ2qjzwj8xvyGd9XmS0HBem97ck1aILJ+mtYZTvnsTrMLCjEcaVlJ?=
 =?us-ascii?Q?rYKlbAgQgVPRtOfhK0GoHrfe2bixBidkCqjfgPvsnos8ovdlgVCMM8QQdvIn?=
 =?us-ascii?Q?LS+kzxJF8aS45KxA9yPtCX1FHl4pwUlTp6b/fpMso4aBlrhnNAlHUpmzIs1N?=
 =?us-ascii?Q?wC/Ql3cMZ483+tcU82lPDsbzxizVoE+0wV26HSKfar9WLqQuXUgSN+HQ3qsI?=
 =?us-ascii?Q?kQi0L2KXDHt6rCP6OqULFkM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d02340-33ea-4b47-1f37-08d9ff0cf232
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2022 01:02:12.0353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8VyfQcE8myihP7q9vveUT7azHmfHqDvX9RBXBlmYM48H8FRzmdsys2Beiu1+phMa80UMI+Jxcgm8NKDkaTt+PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5724

This patch implemented bpf_skc_to_mptcp_sock helper. Defined a new bpf_id
BTF_SOCK_TYPE_MPTCP, and added a new helper bpf_mptcp_sock_from_subflow()
to get struct bpf_mptcp_sock from a given subflow socket.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/linux/bpf.h            |  9 +++++++++
 include/linux/btf_ids.h        |  3 ++-
 include/uapi/linux/bpf.h       |  7 +++++++
 net/core/filter.c              | 17 +++++++++++++++++
 net/mptcp/Makefile             |  2 ++
 net/mptcp/bpf.c                | 17 +++++++++++++++++
 scripts/bpf_doc.py             |  2 ++
 tools/include/uapi/linux/bpf.h |  7 +++++++
 8 files changed, 63 insertions(+), 1 deletion(-)
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
index 000000000000..d140979181f9
--- /dev/null
+++ b/net/mptcp/bpf.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Multipath TCP
+ *
+ * Copyright (c) 2022, SUSE.
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

