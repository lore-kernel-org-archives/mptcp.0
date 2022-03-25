Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DF423AD
	for <mptcp@lists.linux.dev>; Fri, 25 Mar 2022 10:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648203075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ScCEfU2Kxyv0jolY4vow+/zrk7K2bGTroEeiaV10LQY=;
	b=Qq9Hb10Q+K4I6ICSxHTOkCtOHhE9FCcsMWwNI8B+UfAG3B8BkbIyrLKYPCzm/nsYBRg5vt
	D3FlaHppYH4KSbeqYuyTpsQeQLwsuf/w91dSXdXiosZ46uInQs5xKgptIVp54sbSqDXd+0
	kRAsjv89jMpD88xUJzyFx7Y8NMrNpmQ=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2113.outbound.protection.outlook.com [104.47.18.113]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-9-X1b7yEk7NF2w6wo1TIK2sA-1; Fri, 25 Mar 2022 11:11:14 +0100
X-MC-Unique: X1b7yEk7NF2w6wo1TIK2sA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fkaT+RaqNrPiBPoVGy769XOiPXOe+mNcO6okGDADjquvK82HF61m+TfCrAPEeKBjNhPka6ZyFAkoYbAzn4bWUqErw57mQGvCY8cYqurovqOx8p1vXLwEQ3G0nWgczgyP/Rl3n1vJBmEHGfT/SGhz42q20TuFg7I2HzTkezonqRWNClh5I5JBguGx6OAK5aKPnTcekfosPlk7Fv3MsDTC2zWoefTMWzzLfPS67S5ruranPKVQvR8b2zMpcwO7wdGPa/ZAIpQ/les3TFayeZRLKv0N6j43nbOdhjXZSFFp+GdrX6OftjlRf6bcLTpBYmF6yFOJQkbH9PfkVSW+5/zpSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdk0wjz9o9t+jJnCq7e9kw1RsfGJIwd3IKfW/XU95o4=;
 b=OoXmDNtSJQeqLB/pzFFxrNICNIxTJg59Hxi1zW+vuND71tI/ZqClkImndyrW6oa8xF4SFlpZh2FMEH6oQPs4vXeonXcjFouWMHq/P643RnFyPdMbHF+cT3sNCSeqM6PmyjHENKG0vsWNQlHpAFB4EZHrTVNZd67Y6BOYY/vCcGL/A1+QAeJ710hN3o8UYZ9mvHjXNjR+3qr14DC3v0k2I39sPxvbmyORiLUpTwMFj6xUDQRbFS6wVvlsH1kMY/27m6AfLS6RC+aSIaPHnidoF0aYbqto3jqef5n3VmC43xuFVyZj5uGkhO/8w/VLaIeNG3h10ts2CZ7Eoh6EF+FsHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8726.eurprd04.prod.outlook.com (2603:10a6:10:2dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Fri, 25 Mar
 2022 10:11:13 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Fri, 25 Mar 2022
 10:11:12 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Nicolas Rybowski <nicolas.rybowski@tessares.net>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v13 1/5] bpf: add bpf_skc_to_mptcp_sock_proto
Date: Fri, 25 Mar 2022 18:10:52 +0800
Message-ID: <22e7ba644f5943834b2a979de3847ec2c88e0c00.1648202310.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648202310.git.geliang.tang@suse.com>
References: <cover.1648202310.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0118.apcprd03.prod.outlook.com
 (2603:1096:203:b0::34) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32518c55-43cc-4f1e-c957-08da0e47ca5f
X-MS-TrafficTypeDiagnostic: DU2PR04MB8726:EE_
X-Microsoft-Antispam-PRVS:
	<DU2PR04MB8726C026F3482C88C2EB70B4F81A9@DU2PR04MB8726.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	i6wn6tfd9z835N3/l9U8qgJN9q6RReLo+OcFcBxfWBuDyj3G1kU6KJ/1hG3tRS/ZCQaCKG8a+mKGSrAdCD/3f5iD13fkMUXAXzw0u1wSFCJzpzuU3MiET0qCeZjGa5vTdSdvaDhLJzNe4degkAX1hSwQ5omTJmN6CJt5443ubhv2TXBO9xnNrBoYye6NZkDGrW13VKykGPb1rQ05HPIaRuvw8NaIsIVmKOkG38dL0KCNwl8AB2AYjmbQymNYFzxPWv01G07/xhqQ5s0UYv8qRofek0gCsFT6uWRsBn/ockpLUQqWUkUX4y+wB3kzz+Lmii4B6KG2fupykBWl1jN1EkdWat8kMU5JN/V4k1ZjGQBZeJojUO6vECvKcIxob3UOFCpu0wgwQOi2O2cPudyshmKV5eX98+SlWoXXO0b8UbyzQnwaM1PZzxllcwXpkeKb8JSEsk9kVpWrfy2v6M/TDyFVgsWrHfYWgkpYgHyVDAKNsJfPPzXl+p2eUcU2l9ShTf4mNoJhA+myTb/7JkEBEdtVbLJMvN0mq4navhwIgAvu6tsQsRTNk47BpeSGo9sk0HWGuxZrOIFPGZ/PZZvQNvCb0kjErwba3CbZDYvpcpTEWDZUONZRppSnbKBg9BDUTdOgUvTWmEdBuWStmrWZnhJv6uE+FYQhw2k7o7fuw6epGU/AVEH14/Mq3GsFDTOYDgSf9F2/b2/p8km17RQCMA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(6506007)(6666004)(8936002)(316002)(6916009)(36756003)(54906003)(66556008)(8676002)(83380400001)(186003)(2906002)(2616005)(44832011)(66476007)(38100700002)(66946007)(508600001)(4326008)(26005)(5660300002)(86362001)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rGGqmGFkUgmAi8rQm6qSXutGaPD9J/Lgpx17Xt2uK5TDF0tlHo5og7B1gsXv?=
 =?us-ascii?Q?0CZ+lEg2hivdRnHr0wlN9Q/YU5B4gtS4pfzC6XocYOOYRPD314TK6S6LAQCq?=
 =?us-ascii?Q?JgFa7yuiH/9n/QwFIpuqMHCn6gfxoA8WuqwSqjTKWDppzuuVAq0kcrGN1BSe?=
 =?us-ascii?Q?bs2qJSTvQDl8rNpWy5mDRC0zKZ8Vw7yBfzYg7i/7Ju3Iea3mVtBvYdCmru1k?=
 =?us-ascii?Q?n1g1YWEmOiq82zWpNPTco8zcRmmCqJ/rltkGQpw9Qokb6Pn9ghEIhFWpnZnk?=
 =?us-ascii?Q?ZyVH9E6oQL0L9QRMnPViu8+vpku0mDsgwWHZaE7p+4BFU3rRsF32koPEaoD5?=
 =?us-ascii?Q?Do4bTbceXVx3e6PbYjajlS2NxehZ4DeLyfeNVUBuTvswy5FDQPMPqNuo09QG?=
 =?us-ascii?Q?dO3B2BcohPe9R1m6nRyux+QG/EbJJpS3bEcPM9WmDIqRFVoqf45gj0/kUjaw?=
 =?us-ascii?Q?KlBONI5Av4HhDRkPJm0ksB9ngQwoHmNGG9VaL/hGptcTXPfxKGBApfii7CuM?=
 =?us-ascii?Q?HXuxXPrQu2ok4z3K0xdSzP02pcvMghB3dcwPA+th7b3M18SH9aOHt0/kfk1T?=
 =?us-ascii?Q?zCsfianDGrj/ztCkGbHwkalv1cDXu8WUbL/eMaGmTQqPzk8NrU1Ysj4BDNHg?=
 =?us-ascii?Q?OJi9/BLN4FrmqIOSN2Qk5tCoKnUD1IwzYvLbq4uCHctGdBPoBWBSazpy8Ebs?=
 =?us-ascii?Q?IipH2zILE9YuytWixJcdEGoSGKLiIf8+TK57JVTW6v95K2BaNzEYPyl2cwvI?=
 =?us-ascii?Q?DVMRIyOTiblZx+UslbjzooqreZJlUX89jFCLiY+QLlv8Hkm3Xns5+rhxJ3FV?=
 =?us-ascii?Q?Nd5e2r7N032C10ErEj+1gRSsEfyB7GyB0gMsaV6F+u/X8NMIQsmVqzNUbPNE?=
 =?us-ascii?Q?o+gDJhmA//0ROlJ0qUtJhoBrebtFsBnbK4T8CiHIVqLkv6Moh4ILWU/Zt49/?=
 =?us-ascii?Q?qzPpqIlrKMqOqN2cZrCJseHJypOT4fmHwAN1nKy1AfIqwIsakrK8I/m3uEsa?=
 =?us-ascii?Q?Rf0kkzWoMvB396CIAgrsYWucb9Xgr8zNG757gHdy9CdjowuqwUquX0b34nRZ?=
 =?us-ascii?Q?11dSszDZMzfg8VLLzp2JSHWYcP6A48O3NOTwv+gsNpOyy3oRlAmGT7NBaJjG?=
 =?us-ascii?Q?DMi6tq6aHnn0vkd/DRWmvfxcolEckn4ua6gYDCpjdwpMM8Ej0nREG4hhFwG0?=
 =?us-ascii?Q?GmN+hIIE/8P1ifrWYP6LFQ4Qe8IRiKw7X3lqYz92XBtoqzyiRzMEdVxji5zH?=
 =?us-ascii?Q?2I/bjJRS+VgrnCdQwarlQntFnq73BNqVaYJ5x8Lumrp7l76qD2yVoXA1rKlF?=
 =?us-ascii?Q?qLCc60G6VlkcYfKrRV0VSPYKSBS8IRCQ+sBeVKjy+zPiuvEVfIbZV737J1jU?=
 =?us-ascii?Q?qXYnLxA6g9pvcilv5A2/Gj4jYNyy06xYRJmV3H5+6/YbegvGc0zK3ViYCmab?=
 =?us-ascii?Q?I63AUqwtITRclNLZREbSaKoRzrE8E+jL9+CbtomZYFrozhNaNR9o79LfbJHH?=
 =?us-ascii?Q?d6k6jQOQqLgm/7aydL4H+bIAFT2cTfsY/XVarhs7iMKpEgIF30kSUHfoSYFV?=
 =?us-ascii?Q?331483Kej5K0l+u9dbSap8+Fh8GwBqGVm56zTfSoG36XyxRBFuhgxJZ/KyiB?=
 =?us-ascii?Q?tAz8jQM30QGAWIoWRdRUNAi7rwr2reEZu7Q/M5SZYc9PyywUBZesFJlVOFBy?=
 =?us-ascii?Q?TRht38068VCSX6CqkvQ6eFPoDkmokUov01JPqoPCd6dwjOfPIHnZxEen1zsp?=
 =?us-ascii?Q?TBPeo1bPdayE9ll++WloQpkUiwn8qtQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32518c55-43cc-4f1e-c957-08da0e47ca5f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 10:11:12.8807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aD0wLYgUZPeInmqy12TIlqVVR49gvNw/m4YDWIYoW4gy/daHbam6/e+w81UmYL5o5j+Kup10724xYihSDYCTyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8726

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
 net/core/filter.c              | 16 ++++++++++++++++
 net/mptcp/Makefile             |  2 ++
 net/mptcp/bpf.c                | 22 ++++++++++++++++++++++
 scripts/bpf_doc.py             |  2 ++
 tools/include/uapi/linux/bpf.h |  7 +++++++
 8 files changed, 67 insertions(+), 1 deletion(-)
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
index e54daceac58b..99dddf08ca73 100644
--- a/net/mptcp/Makefile
+++ b/net/mptcp/Makefile
@@ -10,3 +10,5 @@ obj-$(CONFIG_INET_MPTCP_DIAG) +=3D mptcp_diag.o
 mptcp_crypto_test-objs :=3D crypto_test.o
 mptcp_token_test-objs :=3D token_test.o
 obj-$(CONFIG_MPTCP_KUNIT_TEST) +=3D mptcp_crypto_test.o mptcp_token_test.o
+
+obj-$(CONFIG_BPF_SYSCALL) +=3D bpf.o
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

