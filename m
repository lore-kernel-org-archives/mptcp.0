Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5841852
	for <mptcp@lists.linux.dev>; Wed, 18 May 2022 06:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652854371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cKPMaTl/W5Ts3UrJa/7FJcwJ+JZ1uGAfTNloWXwUuTo=;
	b=Nio71mffNfSR6iWQvCPzJE80lj78GjtiMeKpEYmJnXNdhMXLCdFowLMpT1a4GbKw/LxVve
	KnWvokvfak4pNIbabH5LpaTKPxDwVS+TLqOtjmgOdF4MaJOrsPToQhOoVXqeUUest6NQQc
	WjeHDzynixaMf8WhQx9ZhK+GIvoiVx0=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2059.outbound.protection.outlook.com [104.47.12.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-27-xQClH8EnMlOdBYvVyGM4Kg-1; Wed, 18 May 2022 08:12:50 +0200
X-MC-Unique: xQClH8EnMlOdBYvVyGM4Kg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ndIEd4kQ1GU6uVppXRseT3qeHjG3Ony41i9G/OTm4TrEvtr70Nzh1LhOVrrv1eO42d4t1UFydPhUvu3TjstKmuZ5Gaw/VdaanJ1kDcfn+YxHKAbanPxpJtXi7QBNyAKK11c4/SAnsltPGn6Dy9ISO8We6N9tCG5lU/kohY/pKqnL8nDdokj0RrQy2e/28qzOI3MCe0qsDQXCsQOkUX/RHUNRO5uZkC3+wqgpjjU96a8WP3jG1XwcO0rO/xeRVnA3e0SRp9uqpo1gWSvm7OKTIuYCtrjIGqu9dXJpfUQBkplJsrKCJBbR3gCnOH4sFnq0ybhX0R07pRz0ULL0gVgC2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tYUMtfMIwo/bOxmJBUN/+X8EIj+E3KHRF08GXLxOh3M=;
 b=bjrfrFU2cCDZYze9n+AfrXUT9Ms+GtelGup23ZShs3TJybfFW2KlrNxY/UoxCOQGN3n0xLG/BYwdWZ/r2WzlpL9+0uxnLmZgqUUFh76EftjeURdCclpBwWqyemXQoNxvTn5n+m+22MJ4hQ3fQU7qvut4eyjmOyhWulxskvKUNyfU1wA315x5+wezzIm7cTXbHVwTimqBIXdkwv2v4V8Oja7e7ct4U9OKWxLvHN5naSjHb77lxyLPlEjGZRkF7gzxCqa1poJJ8mxHB3sczQSZKuKyMMjrccDKFDdj2VNDRnNzjO26BtVgS5R5I3vzeGyH8HgY3I3yZvSsVRl8qSIiSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB6PR0401MB2584.eurprd04.prod.outlook.com (2603:10a6:4:38::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Wed, 18 May
 2022 06:12:49 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5250.018; Wed, 18 May 2022
 06:12:49 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next 15/17] mptcp: add bpf_mptcp_sched_ops
Date: Wed, 18 May 2022 14:10:53 +0800
Message-ID: <d86a5fb77bcda39a8978d8976a0b2905031d39f4.1652853898.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652853898.git.geliang.tang@suse.com>
References: <cover.1652853898.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0135.apcprd02.prod.outlook.com
 (2603:1096:202:16::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93be5175-cd73-4c61-e68d-08da38956f4d
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2584:EE_
X-Microsoft-Antispam-PRVS:
	<DB6PR0401MB2584133F16DF92DB7530C3DAF8D19@DB6PR0401MB2584.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WDHnWlG0+oQqHg0HovjSDlHQgMLZmR5/7VPErJCO2biXY0W6lMrmJ9+WrImLFiZuhMHBexoAo884NEhiEbIcib/MoMp2Zsd1z+lh1iPa54wVREh8zu7xAzsPblHz3NmguhfgsdeaKaFIZBjnVhAQ19jjNI3OZAEbGrqg7UpwqwBbebUbVdk6Y0N0BZFgh7tsyaSUQG+JBVSpm9smUEcRxxnu07Vn3AcsZ6tDg/iIb9uOFEmSNznTv7vvzP3NELussdyK7ACOg5JWS1DZwPYIHO5WpERtxulHtnZZ142Vai/xroOsIx9cl6L+4Y8cyUhxxuOk2l4LJiSkibJeAVjr/dhT+dYXHKoTU9cNZfakiB0NFtRmS+/8ITKTpFxT5eXz35Qz1uUtuvygO0I/7fKlzt9ip//bKnqzjRuMCaqAX4uHWCg7reSgXRJikSYTxK7iDRxjOulV/WO25vQaUp7BPidzhYp7hZS1Gx04r3OOShKF0vkBXtXcO/A5IL13j5Hd7EgUEHAOSsSajcH8R2CQHG0lgkoDn9LB7fm7SphmF1Xpqo5r/mea8WBx8C1M7rCVRbJrL/oYMSWpio1SmTai4e+23nIgBfjOZWEiGRbIgkq/rsGyQt+PVZFMT6+MY0qESiMhGuSzhpYDFcySDABzJk1gjGEaPun8/UMLRDvX1sJKlnFjVoJ4Q7NuSJglU3EqIybd1h6lw9seKbP6MY3Psg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(66476007)(36756003)(44832011)(2906002)(8676002)(4326008)(6666004)(38100700002)(86362001)(2616005)(5660300002)(6486002)(66946007)(83380400001)(186003)(6506007)(6916009)(54906003)(6512007)(508600001)(8936002)(66556008)(26005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nHkhButNY1zIyASawJvOrcl2a1zrzp7B1Y+QHGw0YgrmWqPsXAlqehmTKqv2?=
 =?us-ascii?Q?k2TzQst8s9X/iiP88TTVc1f1q+wZ9nEfXhRaTphDpZ9PuJ1dViuZIsnosSnC?=
 =?us-ascii?Q?AAMumbBNxNslFq9o7bd/peaFX+Nx0uLepumj871ia0AHiwx9aihCj+dYgxEF?=
 =?us-ascii?Q?okPhMzu0U6Hmg5bqZh/cStEvQLMDPqqXqRuE5JUZOmcR83UfHuHipRatsNtS?=
 =?us-ascii?Q?vZ/mCPm3wXp+75x1bfFC//A4Z3r0e/LCeiFpVzDHJ48DweMF3/MIwtZEQScj?=
 =?us-ascii?Q?8GXWtF7aQbAU0KaIZPsJkkXXfFRHEKtDmKIxIrOPwB2gOwDle0uE+wJLDWSn?=
 =?us-ascii?Q?ZMxhT+oExhWvAuFh2sXRQryIv4rffYAtDjh0ZWpzII6svioTU5qjy24sZ059?=
 =?us-ascii?Q?8WgX5fO3LcgpoViRlzPww4PFPSki7afcamYIOrjAJp+D8BrAFNUg2GTAxkPw?=
 =?us-ascii?Q?mj0D10IqNazdX3FrXc2gDRIOwfAZwpYWeGcikGZVEi8SLwwVjP1NlC9+pfq4?=
 =?us-ascii?Q?sP89OxY26dHEH9SGJKrDMYugRMkAUyNIpkJu7uipk6YWBURwz1ROzVD1IAH0?=
 =?us-ascii?Q?B7Vc9Twh6dyjx9TmM1twKUzQ/xLKR7ndHPCYGFVl+XLMJ8G557EROZUYjz7h?=
 =?us-ascii?Q?2c4aHyuDBo9kbdeOmjiAkI3jQDMdMhMOA3sIC2hjycPPvQpMVwSOYD2lwCB5?=
 =?us-ascii?Q?T9QgZV38sxyvDPi/DrueWOQC/AgVQhJDLOn8O7DuA8gqmyZnaf6USQhgtjco?=
 =?us-ascii?Q?LReZPvGU4h5JaXBsfmHU/z8/X7PZ9ewK+A3Q4VEveo92nwQU39VEQnE6AeMm?=
 =?us-ascii?Q?0YfIS7R5eNOwLAuFTqlxYwTf6hOENd+eMEvLadJP9KfVYygelQgCckpoYmGW?=
 =?us-ascii?Q?TIkSVx8vU1FR72bjusYEw10MG+0B/6biSrD3wWKWp9NugLHM9mH371W51fJ9?=
 =?us-ascii?Q?kEB1/G66OdZGx9bkpIqsqT44plEx0yZcmK3KddQjYF04qDw2dO9tRaEANuJy?=
 =?us-ascii?Q?o/nxeWO4d23Te5c5OOMv3Qlb1H7zAlsuk/2ta2zHqzKlPPzzopudbiy7ijWz?=
 =?us-ascii?Q?dmwSkipMdJ7apJU9NetqAT4xCr3FZW1O3cJwUjtBgj5zBTlihWG6KKjTiJnc?=
 =?us-ascii?Q?nkmm+ofw8FpnMQuzxhhvQ2t2qUWrKPYwxiubF4tyBpOM1GaWHW3K1RBUridc?=
 =?us-ascii?Q?aPuklmEJKX6LN/mFOYkSABMOEdJE4BAfu6OAij7IZl5AJhqCAQtVctdmM1p1?=
 =?us-ascii?Q?/k4Opzj2bsDi8SCmreC91LylYq4QX8dnlVVI4zFz+OW5A19blHPSSIwnHOOD?=
 =?us-ascii?Q?ZxEBmS9Sv4+DxAuEA9EyTDfVMKvj4dvm9vOrTSnVg4hhkuiILfMeT8TBV9G2?=
 =?us-ascii?Q?AkwyKQBpirlFtF03q1FGcvbejDnPuC1hUh4UdEM+RpHpJ+veFBYlVv6Ul/6S?=
 =?us-ascii?Q?T0K5aBmb/eNZZUpLWT3QOTaX54xfMaRJb6qM0PstXOvDghMnccJXVNNEnY3d?=
 =?us-ascii?Q?LQnL3yp8GimWhf4eABEvFXjRo9WSe2Rgvp0qREIhXtqDouAeSeaeR0oPD+FA?=
 =?us-ascii?Q?uHQJr/Vt0cwBUO2jlnSxNDAFkKWbJ9OsTvo4jdmBKBQPkmSwmuAuWwY8geCl?=
 =?us-ascii?Q?tglf6wWhivvTsZ6YNTXgRj/oNmNld/sF2NMQ5aEgV/prNF+IhSwJGKkSQ3zj?=
 =?us-ascii?Q?HJxYKMCWJ7+Im95MUaTbC+ndR+DGiJB0H0tNuebtiIkJFHB67KtfERieBXXb?=
 =?us-ascii?Q?+E5rYmc0LS1TfRnM80k1A94eLMGDVO4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93be5175-cd73-4c61-e68d-08da38956f4d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 06:12:49.7348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NKFORTv0Mz8rd+YcHEtgTyWdJuXZ2sR7xaUX9dAViEOl5HcpA93+kbacOLDCK80DItwNJKW4BlQhRiLXWDNmUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2584

This patch implements a new struct bpf_struct_ops, bpf_mptcp_sched_ops.
Register and unregister the bpf scheduler in .reg and .unreg.

This MPTCP BPF scheduler implementation is similar to BPF TCP CC. And
net/ipv4/bpf_tcp_ca.c is a frame of reference for this patch.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 kernel/bpf/bpf_struct_ops_types.h |   4 +
 net/mptcp/Makefile                |   4 +
 net/mptcp/bpf.c                   | 162 ++++++++++++++++++++++++++++++
 3 files changed, 170 insertions(+)
 create mode 100644 net/mptcp/bpf.c

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
index b68eddf4639a..702b86e8ecb0 100644
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
index 000000000000..7de0c1ad313d
--- /dev/null
+++ b/net/mptcp/bpf.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Multipath TCP
+ *
+ * Copyright (c) 2020, Tessares SA.
+ * Copyright (c) 2022, SUSE.
+ */
+
+#define pr_fmt(fmt) "MPTCP: " fmt
+
+#include <linux/bpf.h>
+#include <linux/bpf_verifier.h>
+#include <linux/btf.h>
+#include <linux/btf_ids.h>
+#include "protocol.h"
+
+extern struct bpf_struct_ops bpf_mptcp_sched_ops;
+extern struct btf *btf_vmlinux;
+static const struct btf_type *mptcp_sched_type __read_mostly;
+static u32 mptcp_sched_id;
+
+static u32 optional_ops[] =3D {
+	offsetof(struct mptcp_sched_ops, init),
+	offsetof(struct mptcp_sched_ops, release),
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
+	s32 type_id;
+
+	type_id =3D btf_find_by_name_kind(btf, "mptcp_sched_data",
+					BTF_KIND_STRUCT);
+	if (type_id < 0)
+		return -EINVAL;
+	mptcp_sched_id =3D type_id;
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
--=20
2.34.1

