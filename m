Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE50B23C8
	for <mptcp@lists.linux.dev>; Mon,  4 Apr 2022 02:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1649038268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oo3//fx14XjCUefb+pfNy/oJL8lmMWbhrHvuCa3AHI4=;
	b=cQwx9+sirm5HeEEtbDu8okEqxhUk9QMMR6DDwmx2ULQLsMqF+KZSvHx6EDK8XyfbLStoKx
	nR8OluInm2U3pWAjUExhxfbdJYRnnVj4qG20IWQHLlUXXJ7/QdUiWvPV5Ts9oXWXEWblGC
	0VN8eBCn3yuSGHc5S5Pv77qmsv8Jfco=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2055.outbound.protection.outlook.com [104.47.8.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-19-kdLWg43QPsO-xiuc708HkQ-1; Mon, 04 Apr 2022 04:11:07 +0200
X-MC-Unique: kdLWg43QPsO-xiuc708HkQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3mj7dcQ15KaS69X3BKSlilYgM02Ch8WaJ4vYUSvowB4evcu1nbdWGX6SLRtLj34K95YiklvUhFhtbteHxkaPdolti0iWWldtqNFvVv7d+/JKqUNkZohZCFssJMGE7sLeQSbfg48Opi/F6N2zHezCULceNKtH16Dj4ztnvU6mcRD56oDhkkxzwfQtUW9RBe0C8R1sX3VyzutVcD0HdAGwYb6ajIOV0P+24RteccyY92ffSoVtWe2CxuL98CIVWRE8uEJyQwErasdBS3iWVGxY5GtXTRKs2j4rgV+540oy7bfbJZUCJA9Oeq4jB2o/wC9/7KmtiB5X44vFx350kHj8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RckPJ3GmfIEin07RhOIHtDwm8KHZir2Jika9vk0kB9M=;
 b=ZlctrxbNKZ9jIumOvurRR2sKfyeJClrO98pRxXir87yHH0AMncaARe+MxalPrpgw2QQ54yPfEErbK7BfkCrpg/+yWNRhYxwtiNvwmIRzuSvRGKQRSmX0BqwQG6ty9e9Z5aJZUvT+5p14YhrG6k5Gi+g3n160DRvbkd+KH0yPVmdyzD8ymIRQfTUiLzi0/rJPPNsCHM0Eo+hwyiyrHCPftxBaRVNRpotgd4TCrh9le71Zdu9VjgAbZBeHuFt0aQ3skeph2L41CZ/IkedBka+o04mDcRA89BclknK1caGTytTxUQ+wyKKUX7wT5teI1vNqq1zypTYnP0paR3vEzEkUrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB7189.eurprd04.prod.outlook.com (2603:10a6:20b:116::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 02:11:06 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 02:11:06 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 6/8] mptcp: add bpf_mptcp_sched_ops
Date: Mon,  4 Apr 2022 10:09:58 +0800
Message-ID: <31b426d5e4d7ccb318ee96f122bc1ac0421d5162.1649037838.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649037838.git.geliang.tang@suse.com>
References: <cover.1649037838.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TY1PR01CA0160.jpnprd01.prod.outlook.com (2603:1096:402::12)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a05ce71a-95b7-4612-3ffb-08da15e06074
X-MS-TrafficTypeDiagnostic: AM7PR04MB7189:EE_
X-Microsoft-Antispam-PRVS:
	<AM7PR04MB71891BAFA739A667E29B9BE9F8E59@AM7PR04MB7189.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vOGH1Piz8sKI2XuDxWoISfMkCi8ZrVwvZOnM6GPxVwKLdIoJj4cLUv5ezmAPm3yKoFay980+PasbdJM4KggjCMZTWNn+0rznrNmN6TAPa4eimjnFczGcWssxCyh3wr2MjVdw+/c0gqWrmoUMPVVhZdNVRA6Q2rKTjjWqMUltEav7xNszWekGRWZIuJoTOS86PW+3wKg5lVHZ3uOFHk5wyc/OZgprP62nOA089gX5uytysA5T9KUa7oJZtWJg5qGyXJhOPLsAT2nBG1RLbjfU9tUuAMdQ4W6h5sqRfOw60v/ONK3wGh9/DIP0TRfFk5II1QVqwzW0pN04PnhAVkfb3JQRrX2iTssWURn8q9MAgf/ke4vOZVfLxksnju70rGsNhhBAf7Gparvrs2lZtH/Y1pD3Jqbgah4zUxXdkRvd8CVF6iE5KA4+WtYrpa52C/IiA6pxriVyFznNotREYeZwSoRefKAI9ILMrpOJPmP12rL3FtiZMBJAQHV9FQ6mY13e4H/SzjcIw0BCg8ut5IeHqj9ch9+SpmmsdBDMzf/Pde+y/pw6JApYHeL6Rp1qWGvWtzI8RQVzlGXnYPKMS1se1lLNnJOapgh/bFLDvabQjyh8GsVJjgUMAMlUltewkKWBu8N7OzqBv35Q9l8OBhOsOLrxTvCQzWQpufNvguAwfm2WH7wHSykgDQOA+3lJ3fqMBzLr7EgjPKIvFJQgXUqHOQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(107886003)(6486002)(5660300002)(83380400001)(8936002)(36756003)(26005)(2616005)(6666004)(2906002)(508600001)(38100700002)(66476007)(316002)(86362001)(6916009)(66556008)(8676002)(4326008)(6512007)(6506007)(66946007)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wqkzssPmaNH7CbQeQpo06v4QeBJPvym6UIsVwOP0f4agsf/e/6biTGEBdA33?=
 =?us-ascii?Q?GVomQFmkdqU+cQf6WKig2V8uicF4SimvY0LOOViZs/TPF1eI1fGso10oKyAi?=
 =?us-ascii?Q?RfWhW3qkGkc/wiENg0t2J5uiFakv/T+Y6zXP4c5tV8Q5ZzZphUkVViE3IHcz?=
 =?us-ascii?Q?v+ePsa+9rM25vkMuN8+YFu7Kyw6fSUeAAg/Pa6YKwTnqY9Bsb6fd+qNow52U?=
 =?us-ascii?Q?WIl7ID3fiZI47ONSsJHrwkrzykkq6Dzv02nL/X7rH6cil/JNRj7S9nR3Qo4i?=
 =?us-ascii?Q?xmY5rU0oCK4ilGnDkebN82a5CtnuToGJj90Ai0iO0sAJ0Wvqfet4v+hGdSk8?=
 =?us-ascii?Q?/t/ryjTGUq+ilJ3FOfJPAfhl15W5ekdEPIsIf3OQNAGvYiA0ZPGW5i1pUENz?=
 =?us-ascii?Q?sN9H4Wc5sEmG+V1EaiJH1TsBUz1Q/lIYTLgB/slO1sd2lfGPelA6qeEjZAGm?=
 =?us-ascii?Q?BNwV8UM4NS+bwgLL2QbFFgPEaRHXcKMx5WCsKeybJ49Rlo/x+jdBz9tb1xq5?=
 =?us-ascii?Q?kPnBoMClUn8YzGXafXhx5z8MTJMx9LzGyDFXaecFDBKDv8Hfqzikbdx7ivsA?=
 =?us-ascii?Q?7FmOYXGevpQkE9hSY7Ec6fO3NMRkSmE+fNIv5xE0JKzUbOcKRF9iTOahGVGP?=
 =?us-ascii?Q?wc75nhgzbNH1Mip3emtTyx+1gcF2LaDsz4+1nhIAXr+B9jiRK7no+Nm1UM+x?=
 =?us-ascii?Q?dpuOkYMCkTr2egF/UGW9tMqlIKa7rVxZYOt4TMnSTg3Qp/MOVY4BNEOWBl57?=
 =?us-ascii?Q?T420bf3GNFDaFFDi0IdsD/MdNBdcu2eVARpmwggG73h00j8yWNZjNtqpsK4V?=
 =?us-ascii?Q?lOL2IR7UHaI5PMBVI/+x81UAhToJar6KzMn+gr7aeYSjDc6GUSY1ztZBTmRX?=
 =?us-ascii?Q?vXyHOpVTMOUd3t4fwV3lL+jx5m4XcGEMdXSfz1yJODpG8/dJEOzcGAtoKbBD?=
 =?us-ascii?Q?INN9tjqLs34ZYuduyfIw/YL1aHxZeZ3mIuPp7DJEZSt9IwR5Z1X5x5jlvUsq?=
 =?us-ascii?Q?J3zZC3TZt7lqA8uXnwtTPswAvSBEkVNJEmhpdqT3qjKH58ymciJi+MdUFkpg?=
 =?us-ascii?Q?I/MxvfFiGs6E+nNEhFi2iiPcNqkSH9TtCOzHY1pk9uSezkfTu1+lVItIa/1I?=
 =?us-ascii?Q?031cbtm2+sATpoBMqAWG/ywRLzVr4652YvVvb0ap6gAYYVfUHpGBNX24sREH?=
 =?us-ascii?Q?pBa+Jo+atBBmn17abrY4ksxdIpVKRWbrf4pYEHexOgMRoyYgOa7WgypIrZhc?=
 =?us-ascii?Q?8x43xuMi5zacWROZWpnKDS0CTFGezzMKjhDyTlm+yge+2MtuJbim78R1Lx7n?=
 =?us-ascii?Q?QFhhTee0/CyqwcNZXl5B2WAKjZqQK6kj65cb5qQWIRHkg0/5qeJ4svbRAKAm?=
 =?us-ascii?Q?NunlHuL56U9JrSKEexGHrlhL0E8P5anjNRCsMUWB2nvPEyYn2971Cm+bn6YW?=
 =?us-ascii?Q?aSvTbY49iJ0rMdpMRnWWbrAcGLuzirWlJI0iNRUbS/WfBWcVUvNJA85QGu6t?=
 =?us-ascii?Q?GqGY3SSoLRNYYWVzuwcj/cdAMVok6m3ONZbqGbqgb+LDXyR2WpLRueHa1Zzk?=
 =?us-ascii?Q?X+OhCOjLMlvQwm7ljdjr2eDIBfAj1uuGKHlq2shPljEZvZi0pjShrRY7VFn4?=
 =?us-ascii?Q?Q8r5LBN5IKkmtGg79h+AJN2ROeh2iYXEaZQ64/EDCvOQI5HVMmKbA6VT8HDR?=
 =?us-ascii?Q?brpgHbOCBkSfGlfIiMjnAwc+NZxzXqvHz/510RnG+ijhVqPqgFgSBzQH1b8F?=
 =?us-ascii?Q?ziit2RfF1p8uNWvnHB7WWAXOvAElYYY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a05ce71a-95b7-4612-3ffb-08da15e06074
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 02:11:06.2997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R6331GcTkN5l39U0eVfBucPnIQ+J/QD3dwoAKjHuzC6VbEgnThNvdpjlzivZhQtzGht/4S6rPCCE5wKh5aRx1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7189

This patch implements a new struct bpf_struct_ops, bpf_mptcp_sched_ops.
Register and unregister the bpf scheduler in .reg and .unreg.

This implementation is similar to BPF TCP CC. And some code in this patch
is from bpf_tcp_ca.c

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
index 535602ba2582..647cb174d917 100644
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

