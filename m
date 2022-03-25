Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D06928E0
	for <mptcp@lists.linux.dev>; Fri, 25 Mar 2022 16:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648224803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=403NC//BzxNy+eal0mq1CgE2HyEPxAJS5JJ4BI6kTa8=;
	b=jMiHGWXN1MRnD5mVKN3H9dZ0O4jRP5M9DNK2am0xHHfOKeCmbA1tR3ABAjRn4mQ2ybeNg2
	fzW4yO1I+qPoQSEwVcUer434zecz4mDLQeN/CiqRQ4t7H5GbkM9VP2hly8AdfQ7rW6NWcN
	xWbHDUzNnP6NNNBi6DXn2PjMJRcyQNs=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2058.outbound.protection.outlook.com [104.47.6.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-10-PX4cWsXEMwypvAlhtNqYRA-1; Fri, 25 Mar 2022 17:13:22 +0100
X-MC-Unique: PX4cWsXEMwypvAlhtNqYRA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYx9Ikds4gNcZYwzuWf+XxOV3mhUWIm+opmENfuhqcXLtg5YqHXmZAle9ynUxYq5aPHo2SGKkMgElczF1+k/0XcAKLz2FocbDWLrEEgA7X0AWGq9UtDfTSKNCx/E32xbKoKTyBlIx4ltKygUxG3Z/9O1Qa8yXTocjtzxhkQb0d0njES8uTtuXtGYx2XsweP5oqqFW7lutYfyy+/4sTIYn5CFUWPQbYKZq56ia8eP3eRbLhUpvv9Npank6t5OHlO1ObhuqYm8SwVxH81CXRjQkehUdO5Kk/KLVCBbn3HhFqvnEeg6CxPmwQ3iQkyXOtZywruKPvrv0/nf53oKSgfX/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbFbJx7cZItfPcmZEu11ek3xFdnXq6L7H6KcbcEhc3E=;
 b=WZJ+ABnltCqhxkL6+6vgUIJrJotE6UqW8rV9j45K/o581cIczHX22l6NKPGmtQOW3eXjE1X1hkX1dbuYM/jvB4md+PoNNDIf4SoY+ViMcQn5smGnoozNRGYjHEJzWumpWLFi0n4h/Dv70V1s/lW9v9wPW7tBmAIEhtUDIGRYtRpswlC6LAEABuZQW6xaBkRRWMeobMSLMwEjRiOog/IbZMQMtVtin4qcLwGMqkf4t3qnAHyJGP68+PHTN9clUh0FswiulrtB5zwEmd5uU0f/k3RuFq6rvxWkzJ9NdJIj7n/mkxtZnCMUBopLktnaeoVNRL9cNkcTjLhzn753ac9tIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR0402MB3938.eurprd04.prod.outlook.com (2603:10a6:208:7::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Fri, 25 Mar
 2022 16:13:21 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Fri, 25 Mar 2022
 16:13:21 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 6/8] mptcp: add bpf_mptcp_sched_ops
Date: Sat, 26 Mar 2022 00:12:02 +0800
Message-ID: <531f998e3069db7f5a21ba9e3a888ad5f1024253.1648223504.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648223504.git.geliang.tang@suse.com>
References: <cover.1648223504.git.geliang.tang@suse.com>
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
X-MS-Office365-Filtering-Correlation-Id: ce20de32-fea3-471e-6488-08da0e7a6193
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3938:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR0402MB3938E42898B989B73EE5FFC0F81A9@AM0PR0402MB3938.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pMtrSwXFTHkujmGPIpAbNjpBU9KRlXudxzekQ3jQsn0GhOGRRrjBxr/e4DxZ7YaK66ZLXQOO0Iw2S/pzLaFLzCspQmtx4D9AQqI+lLM4BU+aDsCbegTURUnsHVeRvhwErdkPbIdkVJFITfvdAod5DG9n8p8xD4cwfe3owBMaxme43HRUI27EhNVqaP/EvpCCdjV/3By47OUeo9fdwLzUgDZer6m1eqDLtwFK2G0FhPbJ8msUseROE4WWnn0x5dE00Cgp2CAIflHsvsayMpbzf1/2z4b6PnMvQHECvHidUoMOsJayLnbi3y2xU7QIwsO86UCGkV6xcqd3zvpVxrMKvNwLl7BNk56gOvMkXk2dRowZd89wWu+yPVq04uuNFMa1WWlG300QenagmDPYcgsrIaZ7a4IGdf7B2qNi4WhDnszLtn6aGvumrUjK1wYZ9ouyacdSgeiR0Zdlu3xL0CKGnHyvF4cMGrAA2/9A4X2caf1EtKBoOWvycIdBOlyVGHfs0pSY01PCTl5GSbhPM4dpJu/tqdRPB7ctt1JimhOPEyYRjqOi9yvjtIc1GWnh8XGMfpL1jTZBOwYiabwqj+pkG+PqCjDFnf9Thrwe2W8W8cUFelXRXbkwS8FjK8Z7EW5YNHWsCTAn/g2CeMOCxOvf7aBIthYn/scSYd6bjMtp+ZiKg/4aEBqKa/X+KmBH5BYhRQHjBVWLTR/N5usN4++fwA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(4326008)(508600001)(8936002)(186003)(26005)(8676002)(66476007)(66946007)(2906002)(38100700002)(44832011)(5660300002)(66556008)(83380400001)(2616005)(86362001)(6486002)(6512007)(6666004)(6506007)(107886003)(6916009)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rBJWg89OPmQcQu7+Gkye0l7oeL+58TEzCArLnIEl6GhJLF8AjIkGN+Mp4tJ8?=
 =?us-ascii?Q?4fRpDihMNAeuszRkAO+79qsirSwBJOVz4aTY5dA+Fs5LGBPsSKBYdhiSnHkp?=
 =?us-ascii?Q?0Q3efUmx1pRWaRU45axLBSwCNgBXyRpc4iqqvHrfPt/x0geEf3i7yj8X1IaV?=
 =?us-ascii?Q?3rUgicxmdDhWDhTO4Tr4b+3gxq4N6hf03ZfjMJy5bpqd2F4BNTVTetRIGRBX?=
 =?us-ascii?Q?AfDKcLI4jFtFSb3oHj9BCXehEO7aUfLAavNkhhrO8JfYK3MK0MbT4qoGJxB0?=
 =?us-ascii?Q?e6vgfbQKPlt1YtK419QSqZ3LUJBvyLh53s1xWawD5+vsaTUsSWFk1LEqwAEh?=
 =?us-ascii?Q?R7X+xBkW6zLnFocIMDa5NwrkLReNZpRZdzFl0K8WzHY0LLQj1axH8BZE/6nK?=
 =?us-ascii?Q?t2BWBXmXcR6+K5HdfBo1G2dUfXy8oe8ZwFjC9ZS6Cbk8Bq+mz2Yl4PXHEUpC?=
 =?us-ascii?Q?47F81KaoYgqU5bJ0DGh9FrXWVBMJB9iGcNOolS0p31FpE4iJ2SIZlTyIWhg/?=
 =?us-ascii?Q?KHZDw0MjOKEyzeSiD2lQ8mM1JAegLVUtStidJPLLHnrZSpkUQwSdiqWcO7O8?=
 =?us-ascii?Q?cfHcfCOm2Zz4CzY3nDe1XfFqyyUWl134c9D3X61DTdiDcjU/7INq0G4NxOZS?=
 =?us-ascii?Q?T59i145P7UnEv4+zV+48V3OZqf9522Z4wVUYfrgyhkaJD9sMIvTVj4WQimpY?=
 =?us-ascii?Q?2rcyPu2JKfVJ1X82EVSLEBJUxCK6OKaGqFDb4elzfhZMADBSqt59YMchljcd?=
 =?us-ascii?Q?rEDXaxdxdAuJ/AbCswcCwnB3vObNpy+poHLqX4ClWZJL6y6v0R0t8kI1GVP8?=
 =?us-ascii?Q?H9SjuPU2aZRbuZOHhxIkQlfKCNHIeUhkRmI24tzCvhvw3OkPkRuTt09lmFjG?=
 =?us-ascii?Q?UgysnRgqSXCduHzMXxVJzaWCw94wvFL5DzGFFJFSKVsFYPdzsJAhmTu5/eNH?=
 =?us-ascii?Q?OcHei2c+8yFKlvC0E1HFXJp1st2Ewk0/KuJqDz+nmcIBU3sovChiutY4Oln2?=
 =?us-ascii?Q?DwgGNJVbWq0UOk90UyMNGUXkWy5Okc88R9euutDbN3PbW62eCrNW81dZ5EeX?=
 =?us-ascii?Q?h6nFPgsdbXs8XhEGIQJO+mTu1GKY/etmcIihqelyJ9ICkLGvko2hkj58VTjU?=
 =?us-ascii?Q?6pc1EUNWUljWSLYkVJycBhfRkoPvRxuMnMSWJ8Z/oYLpInWimtfHzMKGbHnn?=
 =?us-ascii?Q?yLHJfqzwtrlsbt9czokCa/+Sq5vUy1PQiDN459ElVcerrgiszBAmx2EnIe4a?=
 =?us-ascii?Q?I92YVHoxkbYNt7Xuz9GPBZJ2aYm/yjg6wLTO1F4jrN/2VCvIvKQLTHIMlbmm?=
 =?us-ascii?Q?YcaN4qeJgyTi11tcV/MAxli7rycwrMQyv1+fj43kYWad1vCR29nPkwOm/RsT?=
 =?us-ascii?Q?srl6guGt15pLGK9yW3JycFPvAKvUxfa/9z4GFI6bC13vz0nllmc/H5e8ssBQ?=
 =?us-ascii?Q?+SMY/LbFPgdqZaoCGxG+GH7SpLSn6r28icpKVu4coBc5jpGTg1eKyTc9ZEjj?=
 =?us-ascii?Q?5qcibTHknkK9F0wDKyawahIm6GbeuufL4muJgh+/InhmvP/30reGq10HFcS3?=
 =?us-ascii?Q?kTrgg+WaLBwCKNdE6ESvYAAb8hm9HSinJ+LQaFIeEogEQqMRwqRN4xK75IEh?=
 =?us-ascii?Q?+8KzDeAReQGhJW56V2dVsfkkGio4RdvZjQLuvspRMjGPBc1wv3rgPZ5ysjdf?=
 =?us-ascii?Q?G2x21ekciCxNZTm7SPDWJmumoZua8cd/1VZ5XOrDRpxUur+0/AnT0mr/pglE?=
 =?us-ascii?Q?x12FIqANPn6qbo9jbNpq/99pIOU2z94=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce20de32-fea3-471e-6488-08da0e7a6193
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 16:13:21.4382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Mi+As+AfqX1QzG3Z1LG/w4kQegYxgMcYVY5cD4ylB6H2HZNM//4JplK2rT5JEqCbfDptajHkMRROJgTvaQTYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3938

This patch implemented a new struct bpf_struct_ops, bpf_mptcp_sched_ops.
Register and unregister the mptcp scheduler in .reg and .unreg.

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

