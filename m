Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED822564
	for <mptcp@lists.linux.dev>; Fri,  8 Apr 2022 15:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1649432349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0hvgizazLSVqB/vatjqRkjg0r7EonKFUfE/VaWeXCr0=;
	b=FViWx9h0Lpoo50jET18YScrF19l1ntOPhglI4Zyoc0zJ1C0+syzc0dFis/cnG4GZ+3OLpU
	6igk9HsMocqACxv/ItTFRgAj43O/v/P8fN2LWf7G4DbE41y3Jl1M8GdY8xeIUj1NBU6Dej
	wW4OxSHE5Fy5MKig2ryIzzkzvdYAdDg=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2168.outbound.protection.outlook.com [104.47.17.168]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-18-wJTiCzKbPwCTeEm-EffIvQ-1; Fri, 08 Apr 2022 17:39:09 +0200
X-MC-Unique: wJTiCzKbPwCTeEm-EffIvQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNBbdtHY6S+7dfFRZXCCjUMMGyyKi+EelPuzzqOfZRE8fGwlYq/3xgpw+8zKWM8Jr/oL5jLWSWIE0vpPCFs4GEpk2Sr290zf/kAVs0L748MPhem9kZqmAaV5tRcHZgxYu1QVLKfyTjvM52wKLJ7yXPdFvfR7NBpiJto+3MZGlNMptHWHepNy/ZksWutn7K9i8z5GhK+7qIRYNZ1eK7xbKjUnCCxCLR1rpGqUnOgdAAKntrHrubFYNIkzRLNizuAf2Poqt0mqsdkvBJ0gR6YD0bgzVUeqKhd2HONLfUPwxUqlTHxfeh3amDXLH9jEyXPlDG7tLMCwavH3J22dvha0tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/QGFqUTVH0QlTuFZqXcDHVQX6mvFPq1GybMAx2rAjk=;
 b=Qv2pS3yxrbEARcPFJvmZl5aXEH4zQKUsB9bWm+cs4Y1n2qhPaKC5dzjPMG/mapPzLloYj23x7YxalSX1xUAlpdbHIBkaUmxAajumf7qh1TrGMPvK+5U1GQhS3ozTm84nwejgtApyGWpx4HB9iMLw7hWRbfqkZiufRed8joTByh2wtt0X4TxNOc/ASAvTj3x7wOhTMM6D7MnNbcVE/zapBq6cEwM+GlU2Y4Ke4yHO1wDCvZURy8ewLSvrIETO+c1D7dODM52jdI05Kz+SQosNsnNJDY4sn0TrC1SOeiXut9WXT+rOINYwqmAyGf/3jLzBDaZiE8k5avgHdnE3Ncig9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM5PR04MB2995.eurprd04.prod.outlook.com (2603:10a6:206:9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Fri, 8 Apr
 2022 15:38:58 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5123.031; Fri, 8 Apr 2022
 15:38:58 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 6/8] mptcp: add bpf_mptcp_sched_ops
Date: Fri,  8 Apr 2022 23:38:03 +0800
Message-ID: <39a111f7231e9e8b32d731dfd6491026e278f935.1649432004.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649432004.git.geliang.tang@suse.com>
References: <cover.1649432004.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0125.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5c4bc62-ef08-43cc-bc54-08da1975e55c
X-MS-TrafficTypeDiagnostic: AM5PR04MB2995:EE_
X-Microsoft-Antispam-PRVS:
	<AM5PR04MB2995A97C1051E1DAE61BD998F8E99@AM5PR04MB2995.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vBmBciP8xWX7ppWwWj1/niVt8TRS1caeML2qp8SNityrdzraJXP6dm+cnMjy9rTGE8Ewltcq1Ll6HdK/GfbQHWo6aCb+DPijz9FGXqIyFBHfSi8nhV94pEK9UVTvOibda7FhPD1iFMWie8dTZnf7Nc3m9m5o7IXIrzrmZcwmxNLS4zdEBmgSHtQ/RawUs9R6tgbI5cqlaZtKytdXBgI5QseBiHs+XXRfScX1Nj9VW2DqKs6cixlB4/AJAjaDPndwiqh2g3qq3Zoovshj8gj/AFc64ffNLokzqvielleQCv2TJeO6XcLLJLyf4kwC2uPBUFHfrwXGUEh19xc1DrhRnvewiEDimmGuF1jwkTWf6o52pK0g12D+oi2DELN4IhoaHKqttcnDVpgW/gUEZ0vJbErJy5jzNSwwlKr5nSMV2BxU+nKrf5NG3rPd9wd08/tFQ+KC3K41n7UtOqS4B8VtmfZjXnCfQrDLu2bZ0uQVWjVTAHh301krKbo1iTowHDEQMshfx4KI0S1OCO3Jf+DA9IGUWsIW9mSorsT5unjxGshZAPeeoFZVLAszvbp/kjUqs0dXs14OaB2bJgWzJ6Vy0edYGKmhZymljqLaA3SrSS1uVObytK6gEwwGCrMCZig4749effh8pStVexbvpGI3oMX8XSJJyummA2nECp8ATYa9PQqirbgS2KHgaLCaQo15ZrZPWMHlCODLX37zgvPfkQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(38100700002)(2906002)(4326008)(5660300002)(44832011)(316002)(186003)(86362001)(26005)(508600001)(8676002)(107886003)(6506007)(2616005)(66946007)(83380400001)(66476007)(6486002)(36756003)(6512007)(6666004)(6916009)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vybSJ7HD+YSt8zCzFezvuQAC2HAll5TeYXhdjcgFQNNZzgtIQNfO7JvNY5aO?=
 =?us-ascii?Q?WrdOyF64t9YNjBNVid8KXNLR+bNp79bQ5w9/x0i2Cj+NZeGXwGB2rJhjdlJF?=
 =?us-ascii?Q?WJUjXCaZbpkyT02W7Z0zoephUKp7SLOZj9Ng0RJeRto2yEIvsYbWluh9kQ8N?=
 =?us-ascii?Q?mG4EdvL0nBoXDVDTMQDAqQ+kFQvuDJjSR28EJ2Aw2pbD7FKUb48dPNKGhft0?=
 =?us-ascii?Q?1+v1H3yIKbC1b5mwz0KL6TbG3lJZUURNg9L4VME1w4SyYC0RriPC7F7Ebivw?=
 =?us-ascii?Q?4tjIWLLOhlJDiM9mCQcLwIylzEVTzN7LmXiqPksMyhe16XlRo26KRrNrFmiZ?=
 =?us-ascii?Q?CRPVrlxJY2w4xmMHZAnrnchlZ5Ef8vBY6b6rAMAb0Q7KZRX+fabe6BeN1Css?=
 =?us-ascii?Q?SEcdzKB3B9ocILtPLKTGw1qWORz6OnEh2rGTFkubtS1QOvQ0jqzft6v0W9Uj?=
 =?us-ascii?Q?bIwx6QiQIveI/rNE7uT3WnZj4+SRFx5gNrFkbyIHyfNgLkqnwvDCli+L9a5Q?=
 =?us-ascii?Q?pRw2goOgFu6B5gAMkJNAC9e+0jiWr/GdVWG4lo0Gkml5ugW6dWnDmxIkQEHi?=
 =?us-ascii?Q?sGYoUmScu30EKomfvQBCC7iLwoDz3+p+eNYIyKxfjwzXhA0px9P04EaThTFB?=
 =?us-ascii?Q?Ht/T0Q91AYu4KMfpTovNGPuiOnkSC/Zwuz87OmbNJWXt3qo+jFGb4cwLSs+O?=
 =?us-ascii?Q?DXJogZ8LGJjI9nia+KCSVPC/I5O5/PjC7VA9g6JtM8BNcji2y9q4mDBbJjnK?=
 =?us-ascii?Q?H/cy0652dRp//FC4O8VCTNZYkR0qm5Iie/bOyJtWqmw0X6Jh8xAxEHtZuePV?=
 =?us-ascii?Q?u7a4QcY5Uee3RXcY669mSFrZiKAB3WcrAzzpSPHQjgSJONuLnPsQK2yi1YQt?=
 =?us-ascii?Q?77qLZD83v+xT0x13dWrbM7OaJHkfKjo0Zt4ilJI5h9pb1tFPbQuhDeX+TNQZ?=
 =?us-ascii?Q?5z9zIktSpX2ajHYYKRdHh3nn/NQUlg+t9lyvwYuDYOYvSgmi4KeTRjWp1aGG?=
 =?us-ascii?Q?SwpruOe28wLkyNzipRRi89RtOXEYJ8U+xMcFgDrZo3muY4phtygN1DnBOnV6?=
 =?us-ascii?Q?r/A6n/mXnlMEuaBp18Ca+5H6jphn9mumoC1u8rCxbcPrjgB8AoFWDdWV1ZgC?=
 =?us-ascii?Q?gp8Vubn2Rqrl+O1ANBgn0yIlbvKIWnPVrZvh8n0dJ/M4lbs/Em3jxJ0JynZz?=
 =?us-ascii?Q?vd11lb2SVINWOg+cgD60UqDm+eFLbKukBrCK/W84UyDHF/dhgUX/BTN4H+SG?=
 =?us-ascii?Q?1MBTXUamtiUsxRd7+SSCBTTZbI5Q8tst5B4t3ZHhQoRIsydi6VtA6DQXV93j?=
 =?us-ascii?Q?ZHGaLouGjKjINKPP7eTxUCnyZZp3ztBYuyRwj2STXjMz/6ZkDRYyFY7D2Zbq?=
 =?us-ascii?Q?fy48K3QX35+CXTH1979qfSAn8VCMkzBnCGsTa5dxS6xMBbU3RLzjDzScIly2?=
 =?us-ascii?Q?z0ILBTn9yuZDAApCw4DVz34xGT2EGOmhPgt9h/c2p3PaZYeHuMykELKuMIfl?=
 =?us-ascii?Q?YcCqXtiPTceJfyrcoih2ZUZ7tOV0O7c9mC38ZVKDauhypo03yUk+vlTe5ltw?=
 =?us-ascii?Q?SttS1VFMOUeHw04Nf6eJmj+UHyEv3v4DgqFZo74mJ9LPKrmObr7Kma4GA3ar?=
 =?us-ascii?Q?fA92Ko6LOD8ECc8GrjwwBV+P7Jlz+EUvfMAIhJN2okGF/Zp3yjhMeTishX2k?=
 =?us-ascii?Q?l+lo8WpUFjCn84fcRqk4gaA2jv5Cyqi4KmG+qq6OrlaS8eI1XnvoF6K/Iewe?=
 =?us-ascii?Q?GARwKOptNYN3GXBijVRNzgd1oLMwHRU=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5c4bc62-ef08-43cc-bc54-08da1975e55c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 15:38:57.9867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xk6XT13+4G9KWb8vTc3eenUcWe6hpfejOutyG/GLfbF6jguvLiliX4FOkgFUvTAreiGEi/8QOGkFr2tnmA/kyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB2995

This patch implements a new struct bpf_struct_ops, bpf_mptcp_sched_ops.
Register and unregister the bpf scheduler in .reg and .unreg.

This MPTCP BPF scheduler implementation is similar to BPF TCP CC. And
net/ipv4/bpf_tcp_ca.c is a frame of reference for this patch.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 kernel/bpf/bpf_struct_ops_types.h |   4 +
 net/mptcp/bpf.c                   | 129 ++++++++++++++++++++++++++++++
 2 files changed, 133 insertions(+)

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
index 535602ba2582..e849fc3fb6c5 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -10,8 +10,137 @@
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
+static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
+					     const struct btf *btf,
+					     const struct btf_type *t, int off,
+					     int size, enum bpf_access_type atype,
+					     u32 *next_btf_id,
+					     enum bpf_type_flag *flag)
+{
+	const struct btf_type *state;
+	u32 type_id;
+
+	if (atype =3D=3D BPF_READ)
+		return btf_struct_access(log, btf, t, off, size, atype,
+					 next_btf_id, flag);
+
+	type_id =3D btf_find_by_name_kind(btf, "mptcp_sock", BTF_KIND_STRUCT);
+	if (type_id < 0)
+		return -EINVAL;
+
+	state =3D btf_type_by_id(btf, type_id);
+	if (t !=3D state) {
+		bpf_log(log, "only read is supported\n");
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

