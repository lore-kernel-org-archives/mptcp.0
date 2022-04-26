Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C5A7E
	for <mptcp@lists.linux.dev>; Tue, 26 Apr 2022 14:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1650981693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rkdLTKrr6yRA4B2tHMkPjOv436b3GVPz7FQ0kIZ96Vs=;
	b=lqjuMeFZdZweeoNgRPwqv1iCQL/cSKjri09VvENTZV3AXPONsL2UWlz75TkqddzK8/3DHf
	1jTwSs9K2fAmQMM+hhfIiDhMqwBrp8Sj2oYNp4pnaTHh5FqXUwOLnty1fZsktAlUfsPFep
	lQnCgc0E9gSFN04uVGafHwBVOlxfzoA=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2059.outbound.protection.outlook.com [104.47.14.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-22-PZ1miG6pPuWyAXz_PKABXA-1; Tue, 26 Apr 2022 16:01:32 +0200
X-MC-Unique: PZ1miG6pPuWyAXz_PKABXA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eadPCv64AnK0l0uRAYb2QwFBA+ZE6XhYVFxVhTyGi7QLvbmlPSwcSXwoRy7xy1lkm4GCcFKg5z/rJa3EBZ9MejALwKtL6uEFTwLeET3wXu5wihs6gr8Ly7gKjlVUUHCQrqKguc6WZnpyJXe00v8YKfTZPVQFvUC919v+kw7JAXOO52PE231yUro8I6byllr2yFKfjo/MGyvoEdwhnUXNIde255nLVWP19MDEUZRE//RSAgcM0a3ziNJhwaF5gvz8WgOteixo4eA+ZpclXCNiXGwNsQU+rIGpi91LhsbxydkdYNq+GBM+6MAiFiv8zawwreUGDiVHaYd8sxWLpaaaCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ah1XvubJA3TAzcVhU2tOI6+18DpbBFr3VZ7d19aYouU=;
 b=USW1CuNs7RIazG5IUNKnoZFi2qBwRch775EiqWI6SEr8H+qSO+rrHDseNTHala6yyfm6hvJ3afor6SKQVCq2UucpOyLrPgYFdc8qAXowN4hJlAI/n8oHg8wY+I9yIIYj3juvA1G/kqu6dX9S5OBng6+/IdQ+2JUSzIxgNXjvX/8mta2kXmTFnXQR59z2fxFCdmdu/VXqYXt0aseUk/pyLlqsIxwIYNf2HOs8oBtQ7BJYl1sN/hWaIQV2TG2nECBED9E1L8EC9rtMc3Qa9GeWuCydNbnfWyQGOTfG4RTd3IbuyLfKmNaFsD7DheuEufLxmFWbun3bdh/gAw5cuKhLOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8816.eurprd04.prod.outlook.com (2603:10a6:102:20f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Tue, 26 Apr
 2022 14:01:31 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 14:01:31 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v15 6/8] mptcp: add bpf_mptcp_sched_ops
Date: Tue, 26 Apr 2022 22:00:57 +0800
Message-ID: <475b55fee1b3010c4f91682de154c408e65028e5.1650981078.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650981078.git.geliang.tang@suse.com>
References: <cover.1650981078.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0065.apcprd03.prod.outlook.com
 (2603:1096:202:17::35) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1fa5adb2-4129-43ff-b2c2-08da278d43f3
X-MS-TrafficTypeDiagnostic: PAXPR04MB8816:EE_
X-Microsoft-Antispam-PRVS:
	<PAXPR04MB88165A7E157E7E0CEBFBDBFAF8FB9@PAXPR04MB8816.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pUM5r2ljOgR6MScSorSHxdrhm98kf8C1KZpxepR54T8fMYoDTbkicJU0002rRAyUIvqTkW22Ro4EGXAvMOFDJul8yco5bdnI6E2/AszydO6Nh6WfwfMsHt0qdTtinsbg/h4zPeb2cShtTOyjgYSlfsNpuW/ncfMrQhsHCBQzGPAIui1imtosrPNyvC/aRResTHkDV/1BLgvQ0KxRO8fqFBN3MJ+RgjZ3vRXXSY+uz3npxoPVC9/CapjjozaD1wJc6X57b7wpM5OXdR052+2XOrZ/SSrA+UtmDQSKFuQsjpfslZbzJnLtFesLBR0SuTDH3Jua//rci7tgWl0cGUQl/GfBejqdAPqIOjEIHm0Ee+/mEXwydh0AyydfWjgoha4fyiK+2rt3/8hfXMwmnVE8xa9kWjyJLCKJBj7rwrp58d8GKtjQiFd/rJx45MTTUrXhk6c90UkTJbMNjoOyn7oiDuoUZTouPVIi6bguZdiO7cioWpQ44edrgRYnAwnUAS+5fyp1yuCTQGxU1MBS/8pL7QKYT2pz3quPYm6ShSDGDAWIRVMLW4HT5fsYYmcs1/wugeXxOYl9lHGV5F9hGl/4wPylvjTSO5Uz8aMKtieQqvSxjqc+bm38Igukb+sl+W5o6L4RfLuJAerSyln5olidfv5tg/DQ5TcWkRIV0effQOTSmQD6X/FIp24CwUVjpG5QrwiApWcBoEOrzGy+lmmEtw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(66946007)(8676002)(4326008)(83380400001)(107886003)(2616005)(316002)(6916009)(86362001)(186003)(508600001)(6486002)(6512007)(66556008)(6666004)(6506007)(26005)(38100700002)(8936002)(5660300002)(36756003)(44832011)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m70KABbTrbCi7EgWNhswrbzcQXKsMW3mfv7dFDF64BBB3xgP8lwz555kzpgY?=
 =?us-ascii?Q?n5jvTmMjD9OQ4taYdVO4PcNdzCUW9lY/jnOYXQIHoiWdBZxUSXfCyIntS78g?=
 =?us-ascii?Q?EGAySebYQCcpXedLkoHR5nxHwXghDSgtXkvlcmiJlOZY7nFda6fg7jVahlQc?=
 =?us-ascii?Q?ncFIa/wIRYnEDDCrVIvKl2qdG6q2gyQvptvFD7mv+XhsAnozdMfTIphCU8Ak?=
 =?us-ascii?Q?Uj5SGVv33+/oyCol73OYRPYcuPZ3tKRzE5TdOi3K3MSaHvYk38G5VxQxNy5E?=
 =?us-ascii?Q?9Z3OZjRhwLgrRFfTE0LuP5GcscZjVJ/9SY5LizsZ8TOlKXX5UtwCL3nSCB9b?=
 =?us-ascii?Q?L/BG+Whe8iJJpCRw3xW/t0VamvW4kGOYpH04KcKyAjeehOG9p1PpmJlBl/An?=
 =?us-ascii?Q?WEjL8A1dzxOKkKJF4W0YwPy//S7uvGgHlGHVjOEwwmLbjiefJRBw6Ydtsck7?=
 =?us-ascii?Q?H9hl7bG9ysAGK8GFu4Sj7bS8MGGLP7M791sPAJJHiO6pc86LNP7SAdoPEck4?=
 =?us-ascii?Q?ewFeSOGlr37liZHpO53vSJA6efUvl65TjJJxowlTzic3nYP1MkAUTnBeGGbV?=
 =?us-ascii?Q?nbe2aabQgBOjFAWURmGVNju5rLVOXKa/nLkF04G7dXpYHOLjjgAk/qT+ojE/?=
 =?us-ascii?Q?nqtGN710LAIiW6ZRTdthkpZxUWcn8JFJNx+bNA5UwP7QE4Wcsdh1grM4rQGu?=
 =?us-ascii?Q?5KOWTpZ/k6g0dGuI/PVe7xZBCSYe7mKweeIiCxzL/4fDTj2gt6zT4/gzPpGN?=
 =?us-ascii?Q?ecTK2HclLpZxc9OxoEwj5soGrk0lj/vqqmSIz8t+NkIuNTaoFR9NjPuRTlRf?=
 =?us-ascii?Q?qpChsHIacQ7a0ihJBvCekTw2GzGVsDBF1RCgCYKZCzh9V2tLEXHy4Sqd7hHA?=
 =?us-ascii?Q?9nwSjre8cX1lZI/5OJryO/8nDfH2dMJpzontbKC1QBR4dHUXTtvVxsQqACVg?=
 =?us-ascii?Q?Tc7AIBTI+HP6FeV6BgSuU4Qh5ECBTlI9B4hHlb4SNRlVdEAxkwsUInQemN7s?=
 =?us-ascii?Q?xyG2kOM0gx14EwKNzrW5qqe8ESNnlyBehXOAUUnxC3+ZTZ0qvKye4A1ZloxU?=
 =?us-ascii?Q?0WZW1rv85n9bMoYoIktP0T63eb5LlodSfb5H1KaL+74epKoVeZFcWbd+NqHi?=
 =?us-ascii?Q?o6tEH0UVNQ7548ZkoWfSNLTjTUDXbtTZzezwSzebIJUnUYahh/zDCqlK+Ubc?=
 =?us-ascii?Q?oDU4FTS1zhPrC6RX+sXhAZTxU9URmX4NL0GwKx8NntYI7PqljYYQo5EknTxD?=
 =?us-ascii?Q?m7bR4/uh7XUdxIJ2A76QB//aB8XokG3pPvwJR/cKT3xOh+K28npz1IAB69Lb?=
 =?us-ascii?Q?Lty9K7N/Aj/xpuTpkdsuz1CE9ymSUTM8PBQmx5lqUQAz1Ds/Lg1BCYd4OnE1?=
 =?us-ascii?Q?jVq/8onzcCkusuBYLmepLt02zeaUEfNutPmDMlYfqqUytsYZj6NP5xrF5r8i?=
 =?us-ascii?Q?J3tl4r9plldzt6xDmb3yrIyyhkUAVMZeZAFl5DI0KHHSJBgKswWhgHRe8gG5?=
 =?us-ascii?Q?s7ETgzOHTuRBZ5+584dJu03zZNCL7rDQGEcJgh4mO/5ZF6sLU69Dh72aMX0M?=
 =?us-ascii?Q?AOnMnpeDTtDZGVcKpnBJ7Kt1xanAPu+K9EF/zPSnIgYB+FHO4TdG0X50oTqm?=
 =?us-ascii?Q?IE9TetOIzU3N9riRPlE/WD0lZdY55ZqG/J606Iqv1AASq8uoeWwmO1U+Ljxz?=
 =?us-ascii?Q?kOvCAYsqH3XB0oYrPBm8dYsAkba4WGmCp+PeqnhNTmIZDBs6j312SW7IUZv0?=
 =?us-ascii?Q?mZkZRsR0yb3wQLYzsYATM6k1dg0uejg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fa5adb2-4129-43ff-b2c2-08da278d43f3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 14:01:31.3075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5nncNlMUAV4IKylngqMTbcXeNkd1xM2u3xgHtNJeCUe+PgBDxFe9h65iHjS+2x+EEs7wW0GE5zh1VB/TviQw0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8816

This patch implements a new struct bpf_struct_ops, bpf_mptcp_sched_ops.
Register and unregister the bpf scheduler in .reg and .unreg.

This MPTCP BPF scheduler implementation is similar to BPF TCP CC. And
net/ipv4/bpf_tcp_ca.c is a frame of reference for this patch.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h               |   2 +-
 kernel/bpf/bpf_struct_ops_types.h |   4 +
 net/mptcp/Makefile                |   2 +
 net/mptcp/bpf.c                   | 149 ++++++++++++++++++++++++++++++
 4 files changed, 156 insertions(+), 1 deletion(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index dd4ee7a77567..4d777db0a3de 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -303,7 +303,7 @@ static inline int mptcpv6_init(void) { return 0; }
 static inline void mptcpv6_handle_mapped(struct sock *sk, bool mapped) { }
 #endif
=20
-#if defined(CONFIG_MPTCP) && defined(CONFIG_BPF_SYSCALL)
+#if defined(CONFIG_MPTCP) && defined(CONFIG_BPF_JIT) && defined(CONFIG_BPF=
_SYSCALL)
 struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk);
 #else
 static inline struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *=
sk) { return NULL; }
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
diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
index 8a7f68efa35f..702b86e8ecb0 100644
--- a/net/mptcp/Makefile
+++ b/net/mptcp/Makefile
@@ -11,4 +11,6 @@ mptcp_crypto_test-objs :=3D crypto_test.o
 mptcp_token_test-objs :=3D token_test.o
 obj-$(CONFIG_MPTCP_KUNIT_TEST) +=3D mptcp_crypto_test.o mptcp_token_test.o
=20
+ifeq ($(CONFIG_BPF_JIT),y)
 obj-$(CONFIG_BPF_SYSCALL) +=3D bpf.o
+endif
diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 535602ba2582..dff1ab26a608 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -10,8 +10,157 @@
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
+static const struct btf_type *mptcp_sched_type __read_mostly;
+static u32 mptcp_sched_id;
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
+static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
+					     const struct btf *btf,
+					     const struct btf_type *t, int off,
+					     int size, enum bpf_access_type atype,
+					     u32 *next_btf_id,
+					     enum bpf_type_flag *flag)
+{
+	size_t end;
+
+	if (atype =3D=3D BPF_READ)
+		return btf_struct_access(log, btf, t, off, size, atype,
+					 next_btf_id, flag);
+
+	if (t !=3D mptcp_sched_type) {
+		bpf_log(log, "only access to mptcp_sched_data is supported\n");
+		return -EACCES;
+	}
+
+	switch (off) {
+	case offsetof(struct mptcp_sched_data, sock):
+		end =3D offsetofend(struct mptcp_sched_data, sock);
+		break;
+	case offsetof(struct mptcp_sched_data, call_again):
+		end =3D offsetofend(struct mptcp_sched_data, call_again);
+		break;
+	default:
+		bpf_log(log, "no write support to mptcp_sched_data at off %d\n", off);
+		return -EACCES;
+	}
+
+	if (off + size > end) {
+		bpf_log(log, "access beyond mptcp_sched_data at off %u size %u ended at =
%zu",
+			off, size, end);
+		return -EACCES;
+	}
+
+	return NOT_INIT;
+}
+
+static const struct bpf_verifier_ops bpf_mptcp_sched_verifier_ops =3D {
+	.get_func_proto		=3D bpf_mptcp_sched_get_func_proto,
+	.is_valid_access	=3D bpf_tracing_btf_ctx_access,
+	.btf_struct_access	=3D bpf_mptcp_sched_btf_struct_access,
+};
+
+static int bpf_mptcp_sched_reg(void *kdata)
+{
+	return mptcp_register_scheduler(kdata);
+}
+
+static void bpf_mptcp_sched_unreg(void *kdata)
+{
+	mptcp_unregister_scheduler(kdata);
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
+		if (mptcp_sched_find(usched->name))
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
+	mptcp_sched_id =3D btf_find_by_name_kind(btf, "mptcp_sched_data",
+					       BTF_KIND_STRUCT);
+	if (mptcp_sched_id < 0)
+		return -EINVAL;
+	mptcp_sched_type =3D btf_type_by_id(btf, mptcp_sched_id);
+
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

