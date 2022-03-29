Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B596520FF
	for <mptcp@lists.linux.dev>; Tue, 29 Mar 2022 07:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648537814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oo3//fx14XjCUefb+pfNy/oJL8lmMWbhrHvuCa3AHI4=;
	b=UtmmUyarzRhdo4IDaYzAOaNpmGYjFbQflYZoWv4qeZfxi34Sowwm4ePoO48jKM+5LHZmEI
	Yo8W6hRjcluIdtRGSz01O/DWYcTlrChH30vSvG2oQU+hjjkLSAqRvOIwwW0rranwTt+Phi
	q1FGwbvklsGizAD49I7MHykMD9aW1bk=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2169.outbound.protection.outlook.com [104.47.17.169]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-7-5ZiOiGk3NTCuJshWzyVA5Q-1; Tue, 29 Mar 2022 09:10:12 +0200
X-MC-Unique: 5ZiOiGk3NTCuJshWzyVA5Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VtzSo79FHfI2rIjbyZIkrnCo/U/mDXWkbL23is5oITgaQ6XgsTBnKIs9YAiB2NefCgTLSOdWUBpGMe0ciblSuRb7r5OckO1ahv3cVZimOlbs0THA0lrFf/gS8LitJE02WkIvJjZRV320BNkfX+DHa2cN8G1HFTVwyGbIS4bi+Y6Kl5itUShTYkVwyNxh4WvAg33nxS6vQm68cIWB4Zc0GkivtQo0YVw9YORLqCNCxeIi30/8szcHzoKScnpkrZj9XwJM3GuQChCWiGmiyUJOOonAR8mMgJKijqbE/J+tIO8tACn00/x5DheF/eJr5fslpZAfodVhyJXr2XVkIpJYrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RckPJ3GmfIEin07RhOIHtDwm8KHZir2Jika9vk0kB9M=;
 b=fX2bymYWeXCawm/QJZBAwcxh9IB1i9xB7qG2mP+pzjBpSOe4EhVc1/gQ7KP+9KJxwF0qdhrVWJygSVb/1QqaR8WJYxc6fcLNmXEAtb4j11Agc4DQM5iyX4ep8/z3B2VYAQH7VVPZ6uK6c4tr7RAWkbgdfaVlXoiH+evIMZEi9USex55zsCtceUj5Aef+Vlj/z4K7SPEuDIUkfqACbUDoTDlOAkssZtrvGWf7qs+J/oApXvIvfsjrXwpoEZ/8kthEoHSkPJWmFhloJVgPtQ8AsTBUNifsiyMB6hwgOq9RNNzXKwmQEEflpN6ii3KIrP/IAzOss8Ar0UCZCR+m7B92sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VE1PR04MB6735.eurprd04.prod.outlook.com (2603:10a6:803:124::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Tue, 29 Mar
 2022 07:10:12 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 07:10:12 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: fw@strlen.de,
	Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 6/8] mptcp: add bpf_mptcp_sched_ops
Date: Tue, 29 Mar 2022 15:09:25 +0800
Message-ID: <21d4ddf37544ad71bccd4d4d027301c822ebf9fa.1648537203.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648537203.git.geliang.tang@suse.com>
References: <cover.1648537203.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0098.apcprd03.prod.outlook.com
 (2603:1096:203:b0::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cdd9acc7-7579-43d9-6a9f-08da11532a5e
X-MS-TrafficTypeDiagnostic: VE1PR04MB6735:EE_
X-Microsoft-Antispam-PRVS:
	<VE1PR04MB6735CBD1789A231FD5717815F81E9@VE1PR04MB6735.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yfwP8Yf+69ARGAGsPKkU3fpDssRlghUSfQvmfiiX3uaZ41wqF+HVnS/u/PooJwln4vQspONWZCz3idnJSWJbTqL3OxmG6NJRVFNiZooInfMXB4uyCbNch+kPPz1dG4TAg5r8Jq/xH9T1EoxT615d9PkJk5vjW3JbkLvfJTAWz67YrO7HN3u62f+Vm9ucgTTvKGN24T5PTqzaor2vl/n1zuxp4cwWphHzN3H8Jzu0t+nDxAlkZP3mVwFwR339BWeNrRyeH9FwVVw7h3sgWZgiy96XTgab4rpr3Y+iCU7FoyJIAONWUb/lybUeJCCXg0d6nayd0nZi/8IvkB7oISde0MpMMEwTfI7ykbzHICyxXHOi9X7//08Cd+eb68hkG9W/Q7ZtjTnwqgc1JmBskhGVJYoXdpjgJDjTHHghLBp8UjkWAAHewY2zjNEKoZHWQ27gPCitg7iuOYpk0uQhPfNZHsb8a5lAvf2Nj9MNSz464UKzNCBbTsCuFH3Ui2dQ7wKuo7EO4V4Bh//Sd4GRgOzyzB3pFseO9kLBoyRLxF4QfU1QoBqjDgZPJod5O0TTnP7XYOya77VLAAWrs4KeHoFrgTEXRNAinj9sxlQGgrE7ZscTXTEEEjyLOfeIRA5d/nW0mj0pO64lry/3IrCg9I+kaM2HGajC+DbKCHYds63Ou1AUmnEb0TuTxFz/e2umG4ADvjGZmwBTKytkmhQp+DBw8g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(6666004)(6916009)(86362001)(8936002)(8676002)(4326008)(36756003)(2906002)(6486002)(508600001)(316002)(2616005)(66556008)(6512007)(66946007)(66476007)(44832011)(107886003)(26005)(5660300002)(83380400001)(186003)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Po/nN0wJ3fdtF1Fhi8aO39IPADUWTyui68cTkgA2iP7zNj+HXVB6ZdZnqUOG?=
 =?us-ascii?Q?0KB8FdZAudLGaZjdfFwxo79Cq8K8xyxajhuTbttToQufEmcR56GMLSAEP9SZ?=
 =?us-ascii?Q?Qj+mrxrp46Q/Zc7HmMj8bUuDN80YgPfZr/5WgG/r++Y96Vy5TUMbLMuLxWmz?=
 =?us-ascii?Q?7x1vJwlx9QISJG0OCM43QQPMd7vB+5tgK0QiT+sKAAUTXe4UX8mvGMaxlUu6?=
 =?us-ascii?Q?lkbFmKM4hNHHE4C7fWlXXcGFOYquad0E7TBBb4cV+xSJD1UHoEv8lv87Sv8B?=
 =?us-ascii?Q?GKxmZJxjXjyE3iZ9tDJ6VfVqRjIcmkTInCYTqzMS7RdlF+GT7i6QvblHtrQu?=
 =?us-ascii?Q?ggSMpWoEOkQg3QtkeR3m9Xl53FSKoK3QJXMC7TC53YrDzl4ZU6PxyErngPrU?=
 =?us-ascii?Q?WjkMCD0C+m+fhD/KqooC8kKbHNbQm4/I4TFd5zsmRqZT0aBsSejbaqgFTcyY?=
 =?us-ascii?Q?gHfSJ39fsx/JJUusfEalneAmp7FdJ7Xt5Nwj918hMSxzbX85l0t1bmV0JFD6?=
 =?us-ascii?Q?eVqLNuSZ9FN4Tu7BAAz1RjnSCEAKn/iTLW13WuMGfMMNHxoPhT3VRaHc3kCX?=
 =?us-ascii?Q?Va53vdLbend9xpROj1z31yzpp8jpSK7/yR+Z9L/AdEyi73i6mnm6nrCWlfw3?=
 =?us-ascii?Q?/Cn7H0ZHnJrR+39NA4343GMQlKSYBLdVBdWHOMgJsARjoUknexbLRE+NsHqC?=
 =?us-ascii?Q?zHQEIGrAjpHESqHaM+2LkbGQI/aY2De/c/7lKFtQE7Z6/q0EuwdUPD+94UYW?=
 =?us-ascii?Q?+JeXakeLw5Fxc99SHhpnjVrekrtVnO776ZehjRILXY0HlfNM9Ewy8CfM2MJM?=
 =?us-ascii?Q?3u8jKRylahyA80S7FnU0F5q/OHN1JktlUEtWLOw4f20JNZHLlij1xkarzvF/?=
 =?us-ascii?Q?RQz/6wxxcAsxTh+2PfVKlO8Bxf0p8nyfMRjrDdPLGRo06dk7+E+WQcFrNPHm?=
 =?us-ascii?Q?l/O+8uyzrZ556j0vAJNC6SxfX/Pp6exlwPyNlGx7b9PQXqlCb90fV9kNStOi?=
 =?us-ascii?Q?soyhwA3UMfVT93kordgBonj+05+3Wg8lXXKp460w8tmpjEW5HW9NKaeFmU/g?=
 =?us-ascii?Q?lOGQc4TPTAggyvH5yPgkx6IxFEv7X50vPNGe+wAbQs9hzQq3H56XCsXXrV0Z?=
 =?us-ascii?Q?4orTig9lUToUaqbiyVkA1d6Uf3Lw9b/23Kx1Z70H/zH8oK3OZxS0v3jNM4hs?=
 =?us-ascii?Q?6grzE7fxyq22jadrUtCI9Hir7xQGWn++FkkDG5Ic3mgjMhiqC92GTfKmTRjp?=
 =?us-ascii?Q?7eCZMyZSZDbJrF+PthN2RrbdY4j5vEamyBqou4TK4cqg4br7WHe3Y4pNl0+S?=
 =?us-ascii?Q?xBlzeIVx5CUhCMXNxKm+ky3HRTFDeO1HywF5Nw1D0jrWTS4/VJuw6lkuDGY6?=
 =?us-ascii?Q?omOIpmabMthFvWay/aW/+0w0xQgdmDPdRoLBQHAShxYlx+bOcQpwdLpsZ4An?=
 =?us-ascii?Q?O1rmmjmvj4N5mhzkFJNJlrHDtWIg2LPn9d+UolZWvLPlkCsH2cxJKDmfDVsj?=
 =?us-ascii?Q?/i1hQJLEQRQyr0l2O1AfONLCq6tJSzk3/NOG7E72VlJu5Zki0cTm4WqTKbXy?=
 =?us-ascii?Q?ILArAydAK6muRNiD2s+9VIdk+cTkHzgmw3lZh/yIhbCkkPefavJ8zfkb3au+?=
 =?us-ascii?Q?vJBRX/bQ0caRE42tLIYtCN28mkmdfUmJVMau9OOS5Lbywg2K/mBLWJLIg2CF?=
 =?us-ascii?Q?JFaIjdpDzPFmdOoRzaU0fn6yuu9C1jnQKw4sS0IcBct104Bdqrs2By1VMneG?=
 =?us-ascii?Q?DC7EH/Genl7gDSa4PuY7qoEy1XLG10o=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdd9acc7-7579-43d9-6a9f-08da11532a5e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 07:10:11.9947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CFSCGShfY0BMSBxL5gOAylPMceCjmqq7Bl8QQFGJqrcKK8Vy1vqYYHNj/avjjQLudipq4NPlzcP50wM77NzpXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6735

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

