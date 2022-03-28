Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125B87C
	for <mptcp@lists.linux.dev>; Mon, 28 Mar 2022 09:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648460327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=syfExDS5vYYs20MW6KE2HpDJqbWLuqde2PWvs9BHibY=;
	b=ATvdHAWPtGKixha2PPRiBqHqdDebFqnvBPeQZlhTS3wC/hXW5ILyxLYcfh2F6/VmiFbC3j
	XdsjzWMArmAZobssGdIKD8O/WVgStCll6RgImcj/WzHpQ4/vfpn/e+h7zN/Oknss9ky0vX
	4GORSqNElb4zapKw/qSg7hGX1cwPdvI=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2057.outbound.protection.outlook.com [104.47.9.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-34-SwOZCNoIP1Wh6Z7JZ6eYyw-1; Mon, 28 Mar 2022 11:38:46 +0200
X-MC-Unique: SwOZCNoIP1Wh6Z7JZ6eYyw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jMT4NMHPPGJPomJ2VMGe2g1PKiBAUz5w92dxWYlUMYkwxDi4CVv4xepci+clMqTXbdDjKhStYggax9FO/QtvltB/SRF172dtMPDJxvf1y0x8qGUXeC1r0fKVBCoHi+fb4tiIuc0w0LVMJiuM9oFWrMwijxA9MakhO1RtFfsClro91VE/p1xHz9dxPS+3gXd+61SlrQvtEMlWbZhvWPjQVx33QfSm3mxxpZ0RP+0PqJ1NfKR9agJCIGv9BOm0JELBT8DqJSLQ+f7X5UoUp50cAD8OZLgkuMHBvuY5tWv/6Miyp2QZ2dSJprtZzrogNunAzG0dkaxVHcGY7VnEF9Gp0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2r2ti1IOhF4bKfidtHssnFOlzOyeT4Gj7f2kCmZJEco=;
 b=I1Oih28CnWdcZktUoEXDjI6DP0/w8El584/LqFHqbmJloYAaWeTMA5E3XLl+jaIiH0kTU7kGUqKJve7zOL1Xh5vdXJ3D83LE6L+x9duZWhczHbgJuU0mVN/Zui56KlNXN8XejwHs4xmHuC41MindYEJaX1i+Ze5ytKFCI/5Oz/mAMrUPnPO78Xt+hcHzj/PoWlQ4KtDFTebjme3oVnTCSPENnuQo3WjDOR1DQSv40WXRH98YCCtUmh9yLinZRqOvfN2fMRUs9iifpFKFJVWaDiGqTRlHM+dw2z2bWSM8IuE133x4+oKQhm/M7iKP3gi96OWwKwKp8OA6yGR7wy8wQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB7PR04MB5067.eurprd04.prod.outlook.com (2603:10a6:10:1a::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Mon, 28 Mar
 2022 09:38:45 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 09:38:45 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 6/8] mptcp: add bpf_mptcp_sched_ops
Date: Mon, 28 Mar 2022 17:38:00 +0800
Message-ID: <0b8f587de5c7f9a2bac48792414433c99ec9dca1.1648459865.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648459865.git.geliang.tang@suse.com>
References: <cover.1648459865.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0056.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b45446eb-87d1-4bcd-4daf-08da109ec089
X-MS-TrafficTypeDiagnostic: DB7PR04MB5067:EE_
X-Microsoft-Antispam-PRVS:
	<DB7PR04MB50674B015637F44D30E32FD8F81D9@DB7PR04MB5067.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yeuznD7tgOCNz19+WeU/H3TMHsfqSe6f677G8bSxD6flJhXcPgK+ETxGqJQs4M74944ITIY+K8g4cCJCXMrsJMFkVvy1LqylSp9wEMY7cacRc84oT6p9QMQ3qZ7Yxl8cLwoTzK/tx6h03Cc0OPjTrn4n8d9niqQWZ6GUrHMAsJfyQ8SUT20hWSjsSwrE23spC2VHjTUPmbc7bLIoXL9DNcgFtXKOepozf7jGM/8sK3Elcv2kOdGp4CSfWImYDh3QwI4gBlyeR9xG7LDfisMOgbEZIIKaJywyIN8m6Hgqx5PB7r00rIb/8MYteeVoqShIqQhNIy1CSCaVbTl6hI6iXOLV2lRFD75UMs50iXlVlkHkBJzW2hvx9vYA2QE+wACe5AqWrJFWC/mz7uCY1VRRZ8TcArw8i4QZi4nf/LuV1P0LQXSZGXTS6bGt6R5cACgHuKX5Ze9WprlOdB1FnedeNZ6NqslJyGQKH9GmQ0798kdkfxgCDSbuTx17/lJDZRU/gFLuplFFjtN/ffFxOx0OfLmbiYrxgkxSEee+S0gDzI+WL8ybwhjl0pKFy0TJd9B56mSub6skR0cEXZ6msOY1RwC3yfaKFeRuTc08X/HZeT5qx1HWE1fEZ6bU9QKa/S6KsyTgFpiF6aMRIMOeej6DMyJWaBW4E2TnmJFO6nZ6qVoCuORT3sUo6wSi2wsvvoduPyBNCvQQ+c7N5KqFZIqcSw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(66476007)(66556008)(38100700002)(66946007)(2906002)(8936002)(86362001)(316002)(44832011)(5660300002)(6486002)(83380400001)(8676002)(4326008)(6506007)(6512007)(508600001)(107886003)(2616005)(186003)(26005)(6666004)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SZ6AsGiynN/5mkawS0nrSh29ukDEXkkUWCXOZlami2mQZqsM2+SVZGJFCPFA?=
 =?us-ascii?Q?mcHsevSu1h30gO77NIbRI3EH6UMYOE8uw93QF6darpChuJTabacBcqKhyIV6?=
 =?us-ascii?Q?Eqvz2BBd/5wMyWqCJpgGjvFWAXKjvk8rZLi9F+dywu5q/yrUMirzWafn/6Hp?=
 =?us-ascii?Q?2+jUltLFSX/TJhCQwQsUkJzDJfKGI1nDyOwtmIpd/M56zKfBKHdqMZxnl3Or?=
 =?us-ascii?Q?U8V6TsSdAQXeflg28o3c1Cq4Z8KDYeGduNlJJR5UdFR8oxZO5FVb2mVTlJXH?=
 =?us-ascii?Q?q/KYzv6O4SZVaMgkekaWoMQaora1i4KRazi23rzPLZrJSIy4KvbzCNhDIUJX?=
 =?us-ascii?Q?bMW1ZEkyXoBGlZlO8mcjJqwK1VPLjfLimlZgVYPIOLAQK6okfr/QvzZ8KXQJ?=
 =?us-ascii?Q?N50gYjEb5yH3MO9JmGGLQlw8Yd6LcIXMwEnvFq8HpmZWtkX+tWARQiOXD1+A?=
 =?us-ascii?Q?Kdxmr/LEFHX0jpp61v9fBWf6p2W1KUqTWoAacIcXrU8SNx8UqsbS2CH/Zzcv?=
 =?us-ascii?Q?UfWucKvQPXs19QqiqYaL9rIYtlXISPymkVvnRsXYWbhW6U6skosVPvTOp4WL?=
 =?us-ascii?Q?SmS06eout+tmvhQaZs3Kme87nlB55doHZN2KYX9CqT9rypiiKgcSRTo1AALX?=
 =?us-ascii?Q?8cDUJcRuYuzcA/5YgKnsxrESxDjlY7eitgBr8eCAd9skJNENERSBkkutl1EV?=
 =?us-ascii?Q?vn7zv/Vg06DWcvcmAJMVFNG2EkdfiaqZuhA/c4y3klDcTU4jQmD8CALyZw6q?=
 =?us-ascii?Q?zw0YlNKpMrsIFnXuHK4Z/hxrn98ssglKWGu8pSXYA1re7u4t9k0uNBbWic2l?=
 =?us-ascii?Q?pNx9hXH9ew3Utrsm9xjyjR3AEQdh0lYNcJVKoUYGi4yjGPsKoz/QtEn7RSCn?=
 =?us-ascii?Q?y4aswtysfP+KRgbHcYuAL3bEHdPs2DWGVvHJcr3fjLJHpVLpx5hAmQYee1Fr?=
 =?us-ascii?Q?+fIAD9hI+NGmHPirQNbOm02e4XCAivxIZcc1sLqEx4YpnclEzYe5hKFVnP0M?=
 =?us-ascii?Q?a3jmIAyymmiWWPGF1klIG04GDy5fS/wXRKprbBivcs/a/ZJ+svxFY77hpvpS?=
 =?us-ascii?Q?OVLeBzXveAodzxgZHDnqGHiefFz3AKlGdeJMyN2aUnHkvnDHznQHK3+/7GjT?=
 =?us-ascii?Q?+SE4l2pWRF/b99J3Gr+cTScCqeaA1Y7+AISCi9rC+/v0f0133yIg21MzIN91?=
 =?us-ascii?Q?YZopd2iwZ8v3WCOacTPs32xhiF9Ewhy7k9tMh3cFYSQNWgak85K/1f4d+Gx7?=
 =?us-ascii?Q?HzVrn6Ihd2YO1NApWWsrwERQW7QGEGPAixIIXJ6HypGnLszeTToIANqLuRsG?=
 =?us-ascii?Q?7Wks950IdilKlyaFwfcjXvMfwLVXvvbufbyUcGqRCa+bknvsB8KzrDH7OgoL?=
 =?us-ascii?Q?uVBFX8zYCwMbyf0AicJ/zZPATqOAAQRpZVuhiOos4qb5L1OkpezUI+/HWVPl?=
 =?us-ascii?Q?sVJcDEMv2r7Mxag9idc1UIMoNq3be29krpkDMhY7/AvXKusxOHWVPJ2px9c5?=
 =?us-ascii?Q?7jL6rElx8nx/Cm6dQh9eoSfodGLz3gQXk7+W7VsGnvbICMiFOMRNX91Xqk8/?=
 =?us-ascii?Q?DxdZDPWlb1JujyjqPNWXZcLjrx2Xsu4Tn1VSZiFRK6APn5p+Qv+olhRmtYDy?=
 =?us-ascii?Q?5vz7cOjayp6iDDnArft6L3uDsSZy//kB52PPQh206/MxuFMiwiXPDFAPBmlS?=
 =?us-ascii?Q?Jw6Pi16i5/J7fd2fymjW4Uxhj3G3D2acUCLk9iQDebYUAZmzvrRMtMnb68ax?=
 =?us-ascii?Q?/W1QgkTtzFz5QMeZEYLCdvsa1OJQzTg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b45446eb-87d1-4bcd-4daf-08da109ec089
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 09:38:45.0416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6EHvwpyHaGdP16IG4Lyl604Td5xkjVEcysmTngIZkFUnfysPOG+WoNxy1Uu/hVvUAD1sHyjuo10GG4uRESYJzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5067

This patch implements a new struct bpf_struct_ops, bpf_mptcp_sched_ops.
Register and unregister the bpf scheduler in .reg and .unreg.

This implementation is similar to BPF TCP CC. And some code in this patch
is from bpf_tcp_ca.c

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 kernel/bpf/bpf_struct_ops_types.h |   4 ++
 net/mptcp/bpf.c                   | 103 ++++++++++++++++++++++++++++++
 2 files changed, 107 insertions(+)

diff --git a/kernel/bpf/bpf_struct_ops_types.h b/kernel/bpf/bpf_struct_ops_=
types.h
index 5678a9ddf817..5a6b0c0d8d3d 100644
--- a/kernel/bpf/bpf_struct_ops_types.h
+++ b/kernel/bpf/bpf_struct_ops_types.h
@@ -8,5 +8,9 @@ BPF_STRUCT_OPS_TYPE(bpf_dummy_ops)
 #ifdef CONFIG_INET
 #include <net/tcp.h>
 BPF_STRUCT_OPS_TYPE(tcp_congestion_ops)
+#ifdef CONFIG_MPTCP
+#include <net/mptcp.h>
+BPF_STRUCT_OPS_TYPE(mptcp_sched_ops)
+#endif
 #endif
 #endif
diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 535602ba2582..be809438c5d2 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -10,8 +10,111 @@
 #define pr_fmt(fmt) "MPTCP: " fmt
=20
 #include <linux/bpf.h>
+#include <linux/bpf_verifier.h>
+#include <linux/btf.h>
+#include <linux/btf_ids.h>
 #include "protocol.h"
=20
+extern struct bpf_struct_ops bpf_mptcp_sched_ops;
+extern struct btf *btf_vmlinux;
+
+static u32 optional_ops[] =3D {
+	offsetof(struct mptcp_sched_ops, init),
+	offsetof(struct mptcp_sched_ops, release),
+	offsetof(struct mptcp_sched_ops, get_subflow),
+};
+
+static const struct bpf_func_proto *
+bpf_mptcp_sched_get_func_proto(enum bpf_func_id func_id,
+			       const struct bpf_prog *prog)
+{
+	return bpf_base_func_proto(func_id);
+}
+
+static const struct bpf_verifier_ops bpf_mptcp_sched_verifier_ops =3D {
+	.get_func_proto		=3D bpf_mptcp_sched_get_func_proto,
+	.is_valid_access	=3D btf_ctx_access,
+	.btf_struct_access	=3D btf_struct_access,
+};
+
+static int bpf_mptcp_sched_reg(void *kdata)
+{
+	return mptcp_register_scheduler(current->nsproxy->net_ns, kdata);
+}
+
+static void bpf_mptcp_sched_unreg(void *kdata)
+{
+	mptcp_unregister_scheduler(current->nsproxy->net_ns, kdata);
+}
+
+static int bpf_mptcp_sched_check_member(const struct btf_type *t,
+					const struct btf_member *member)
+{
+	return 0;
+}
+
+static bool is_optional(u32 member_offset)
+{
+	unsigned int i;
+
+	for (i =3D 0; i < ARRAY_SIZE(optional_ops); i++) {
+		if (member_offset =3D=3D optional_ops[i])
+			return true;
+	}
+
+	return false;
+}
+
+static int bpf_mptcp_sched_init_member(const struct btf_type *t,
+				       const struct btf_member *member,
+				       void *kdata, const void *udata)
+{
+	const struct mptcp_sched_ops *usched;
+	struct mptcp_sched_ops *sched;
+	int prog_fd;
+	u32 moff;
+
+	usched =3D (const struct mptcp_sched_ops *)udata;
+	sched =3D (struct mptcp_sched_ops *)kdata;
+
+	moff =3D __btf_member_bit_offset(t, member) / 8;
+	switch (moff) {
+	case offsetof(struct mptcp_sched_ops, name):
+		if (bpf_obj_name_cpy(sched->name, usched->name,
+				     sizeof(sched->name)) <=3D 0)
+			return -EINVAL;
+		if (mptcp_sched_find(current->nsproxy->net_ns,
+				     usched->name))
+			return -EEXIST;
+		return 1;
+	}
+
+	if (!btf_type_resolve_func_ptr(btf_vmlinux, member->type, NULL))
+		return 0;
+
+	/* Ensure bpf_prog is provided for compulsory func ptr */
+	prog_fd =3D (int)(*(unsigned long *)(udata + moff));
+	if (!prog_fd && !is_optional(moff))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int bpf_mptcp_sched_init(struct btf *btf)
+{
+	return 0;
+}
+
+struct bpf_struct_ops bpf_mptcp_sched_ops =3D {
+	.verifier_ops	=3D &bpf_mptcp_sched_verifier_ops,
+	.reg		=3D bpf_mptcp_sched_reg,
+	.unreg		=3D bpf_mptcp_sched_unreg,
+	.check_member	=3D bpf_mptcp_sched_check_member,
+	.init_member	=3D bpf_mptcp_sched_init_member,
+	.init		=3D bpf_mptcp_sched_init,
+	.name		=3D "mptcp_sched_ops",
+};
+
 struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
 {
 	if (sk && sk_fullsock(sk) && sk->sk_protocol =3D=3D IPPROTO_TCP && sk_is_=
mptcp(sk))
--=20
2.34.1

