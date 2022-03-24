Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8993C1FC0
	for <mptcp@lists.linux.dev>; Thu, 24 Mar 2022 14:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648130991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4lss24/uaSM/pJrFpN8QFbALC8emQ710Pj0bvaAbCCs=;
	b=cxneJJ8rg7U6FsxCFiZWNvJbuuvCAud2xadJYwNduwvF3VCXz4ywMIqy51x0ZUdq48/Zny
	ZzZRZGLXFVyvsDGc1iEiJzmPsVhMWTJXfFMlVOgvL+g4/eXVycmsoWiA7hWnD/YOoPHKfZ
	JGJ18lM8KGnsFPVCp8eKOhE3i+2F1fk=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2108.outbound.protection.outlook.com [104.47.18.108]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-10-crIObiU4M9OJnu9iq5DhWw-1; Thu, 24 Mar 2022 15:09:48 +0100
X-MC-Unique: crIObiU4M9OJnu9iq5DhWw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TIe0gugqmutTf8EIUCpOAr60h3YyGN5c0E0ZPlxfrA1hoQeYfDKQaGfnnodrnhvUWlUrqgaPotci8MGmurd+T9wGT9VOLbikNuOUAdCFjcTOYggOHjcu31M7GvdyCEcwpQYFYoR9jAHgYwAHR1URkZrnTFpCa2nLeKzfhcByW9EyfSCzsgMGzxo5/swW1GCgdRbqJmxP1s/fPWSkQzWa1VnVZaV6cPrZOJb0+CXdmyVtvJHEb25YbQNlbvzCydx929weKyWxFW/ffWRVJ2Dnew6kEVv6ac36sCV+SVyRf+PAUH/JyP+M4znFVFxrh7D9EtR0P9sA6G/asZVuUaa2Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u2aNYpVRGLdIirLPL28/Eh/lr8u02Y0aOYDryi07r9A=;
 b=gzxmKrPkfaCESoRg8RDG/K6QaSRGpFIgChjD6P95Syxg5tIVKWfmFJ+w95I49oAyI2KgQgic0DfDvEzg+hzTtg8tOjx3ObSzst7qKTO3zHMxZ8vgu+a+n1xeZ8icZ/Pjh4RXw9GaBHDbJa+22ploblZEQi+y3tJ2KaPo5Jn66tRmAk4ATatN+y0ut5f9uU7xNWwVIzrt0+pPLm5RF5CSlRk2nDhpIcS8h9cQvXb96VtZ8QJw1M2SJ3Ci1SWjANu5wfO8L4xcDaOl46R2bfK7GxYd19kOmiW6A/wphVCMnS0b29KeKcvptpMyUxVsu9k1glhtH9YyUSZ/4qcawlCcNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB7PR04MB5275.eurprd04.prod.outlook.com (2603:10a6:10:24::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Thu, 24 Mar
 2022 14:09:47 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Thu, 24 Mar 2022
 14:09:46 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH RESEND mptcp-next v5 6/8] mptcp: add bpf_mptcp_sched_ops
Date: Thu, 24 Mar 2022 22:09:08 +0800
Message-ID: <5eba709492c40eb2e27aa2647f9b7e0f12ac882d.1648130637.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648130637.git.geliang.tang@suse.com>
References: <cover.1648130637.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0204.apcprd02.prod.outlook.com
 (2603:1096:201:20::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9ae278f-2630-4ac2-5ac9-08da0d9ff3c1
X-MS-TrafficTypeDiagnostic: DB7PR04MB5275:EE_
X-Microsoft-Antispam-PRVS:
	<DB7PR04MB5275CAC826E9D7DFBABB5AC1F8199@DB7PR04MB5275.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HcaQ+Y6UWStGI7Ob+/FmyRqS47zZ9/p0sdE7v2CvdC17WKQD+FEfDglcm2xy9L3foIvPgzp2pusz0E23Kv1VQZbIxq6Tb8TparDHNHXlbz3hOfhBxFx96W7ZXHIuhUkMJVcTU9ybnDIBlSDxRpFQISyiOZSAHLIBpusuie0X4YhFhHPuIrVgYQPCcJ7Y6MCpVJH5h/FOnEDO3VMx8quJ/j/f/pZ9zATH7EKji97REst2dhlwZ2I32+AxAtUwY0nq1P5Eg1ZvL02IxYl5KN9CLK+4FV8xW9qiflaqbnd3vTxvCbvxfuYTYgHDjL7/ItLHt80sp0PeMvUFW69FurV0sMf+gcj3DXXXHBXsbRLczobp9mHcmSBx2FAMQtOezKQeeaJWn4WG2G1WKTu7T6zHUJdoMQH6opYRaCMq9UHbTI2cVbBuyL7EA/+hSs3RwSz7ogwLz4SIOiFzE/tZB9JUJ4TB0MF11mzyuM4FyUx767XKLKk+xcrMIeksFCLmDcdrl+AXll3Medid8bqrwAKhLdf03gdE43GUk9+uiFg3SUEng5n/ocGQxbhnEwgZNsYcZ/Y0UNjPrsezuq3t5ePtOY+cooy6o4qVY0mAsraRHbwH/lmAsakpZGQfOFoKYhVPAnOhhMKY/Jet4tAtcfnLb3ul0REb59b10aXj01/La7QB5k/cQ/a+EUVWCjqxV0WU8zDHCq6vI06NjpofNItyGA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(4326008)(66946007)(66476007)(66556008)(8676002)(38100700002)(8936002)(5660300002)(316002)(86362001)(2616005)(107886003)(36756003)(508600001)(6512007)(6486002)(83380400001)(6666004)(26005)(2906002)(186003)(44832011)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3IsrUIAvPMRV7uvqMI5WjVKow6/h6PjI+w2OVTfMf1X06NB4ghhHqPB53K6y?=
 =?us-ascii?Q?9Y2pMTQebk+hD6q2uExQUoAnrmb2ideFelvSKsAVwIzdbEn2DB5tVxuFKFmx?=
 =?us-ascii?Q?yxVvxZZbWQA0ewpbUJUT+WA0i4yozaNep+6eh0pVdXhM50oVe//gbtf812el?=
 =?us-ascii?Q?uGI/IM8gGV7TtrOZh3gVj+NxxeBPLxVhmMIQZvZceEnlkEo0a8OfEZ2p7kcg?=
 =?us-ascii?Q?/FeznspTCRvtfGqfO1/Xepbacm3IVwU/EFXBUCMBvgqXsOxjywKeuK1Ga8tD?=
 =?us-ascii?Q?V6JvJAv57ZRAwmWfBBkD8MlEn4FmuKjwn4gCMuV+43GIbIPj++IsM26L7AeO?=
 =?us-ascii?Q?nnTfkv8x3ovPz9S5pkest2SJQkUrIGsjiNyJ+WVppjpJ9nDx8p98mcSsOWvj?=
 =?us-ascii?Q?fbeOm1OWfeA/YY+S8Rk2JIdGRnPSjXp43OgLYFMFYOk4DHIsFnf7+6H28eFK?=
 =?us-ascii?Q?3MS/0TfJuLJ/e4ix7Y72KmHPAvv24qiwVwBkmtX9bKx64RwEcVgPhM0w9xiG?=
 =?us-ascii?Q?7niTahBvHjJt9PJ3EMRgyEZq5FQYZpkFoHSxFJ9lPnT91XVxRH0Qh4iSEX5g?=
 =?us-ascii?Q?tRP6+fFORoH5NfHix9dUEIwRSxEv2Ab5Bsua1eF1jxjP7OgIrsNrE/z/r4zq?=
 =?us-ascii?Q?VPvANzb+UqPvqSbzg1LfrAmOTsV+TgKeAF7OV/1gzeUy640aqx43wsEymiz0?=
 =?us-ascii?Q?Oae2X41j2p76fiE+vawxlXcrl5hVJAWYFO4e/q0X9GqRoxl96TH0L2V2rqnD?=
 =?us-ascii?Q?A/lcQyDGFZjvJAgq6CiEYUfv7OEXBcRw0lbmCOCFyzlkzNveGsFidA4ogZrt?=
 =?us-ascii?Q?J87bd3iIvPClAxLlIutRQ7AXYBDF/IxqdL4mlhq+m6f2uzwuCAaE2BMDNjWw?=
 =?us-ascii?Q?fjJxouQlmAgTrpfVJDLKd05s98V3pgnKkFRuGP02Ws7qqh17bU7YsVWYzl+5?=
 =?us-ascii?Q?Ccx+129L8XiQHI0bEamGnnZTPGYuC6fSSuP8P9W02Y5wzPbJ4G2M3P4r6qDw?=
 =?us-ascii?Q?oBmTjh1Cr3suhBKT+s8ZnfGUkUufJ/iYahZ8vcHoOVtVXyMWYrVrpVJmfdKu?=
 =?us-ascii?Q?feOz7roeSIE/QgH+r4rDnhcy9utIAGYn0QwN63A8m8T5VH7RRkbtbmigx3US?=
 =?us-ascii?Q?nCP+GR+CRFcmTS6k9aZyY2lfSu3oNSItZws/ccCGf/BL+bUk3skelCY9dp8O?=
 =?us-ascii?Q?KsRs33cwb/g4QAk0+xJ6pESOonQHv3ny0UcbKiSD4StJiIKWRm4DPLSnBoXn?=
 =?us-ascii?Q?sACcNZuD0IkBLDHrWLSv4toJ+EhflgqYOw0q7c+5iTOT+wwhiCNHnssxMaq4?=
 =?us-ascii?Q?1rEMdc4eA1A95Xk6pOMt2Vt2t0iUdORl9ciewlEtYDaMAcAX0sQ4eg8O+JP6?=
 =?us-ascii?Q?oyfz3spbjyzUTPAk+GsuBV2aWhTd/JqfKE3pG0AhnKOglREtY/sF8JZW4UyN?=
 =?us-ascii?Q?NxZzFexuv2xFNlafdNAsqM0JkEyHrKs9I58WLz7tjM652bkz/DI1sA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9ae278f-2630-4ac2-5ac9-08da0d9ff3c1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 14:09:46.8717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JSr2GCeg3RdCLaJUnIQgaVduqIPtjtYa4zWQkMatIMdVONLHnZHZVVuXaE1S85e7U8Xm4j6ix9/pkQxDLZJWIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5275

This patch implemented a new struct bpf_struct_ops, bpf_mptcp_sched_ops.
Register and unregister the mptcp scheduler in .reg and .unreg.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 kernel/bpf/bpf_struct_ops_types.h |   4 ++
 net/mptcp/bpf.c                   | 102 ++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)

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
index 535602ba2582..14a42cae89cb 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -10,8 +10,110 @@
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
+	return mptcp_register_scheduler(&init_net, kdata);
+}
+
+static void bpf_mptcp_sched_unreg(void *kdata)
+{
+	mptcp_unregister_scheduler(&init_net, kdata);
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
+		if (mptcp_sched_find(&init_net, usched->name))
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

