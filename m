Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694DB1391
	for <mptcp@lists.linux.dev>; Wed, 23 Mar 2022 09:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648027788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=30o9dqawjELxNI1XIygMh7C4rPD4Zx0ine1saTvV1+k=;
	b=W5EkP5Kr6OgjwLxpV6HlfmGde/BJZklMIO0RPqtEfjwA9VfBBHtk3wsxLnlrS9M0FLYvxR
	1Do8g1dqfVQtwXlbZCt1e0l1E2TuAipFH8nKeHXjkIlZGM5iWWRJGBTU998nyCQmANP+YK
	/3DoE0IqsURZlRQUIJMaxToTxi0ibSc=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2054.outbound.protection.outlook.com [104.47.14.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-13-EsPNrIifPZa18L5YG0xH3Q-1; Wed, 23 Mar 2022 10:29:47 +0100
X-MC-Unique: EsPNrIifPZa18L5YG0xH3Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRzFBO00zXvQykMY8kQeAW6T57n2YusLnJICUIyrizHgClMiTdmu/FoFadwTw8vErKNqc3IR3DtWZA/GclDBXfHfAIKFRO2BV2RGt/FAfGTpP4DcbkdenJ6MBr5VmZgH+hN4bPjfxQCLFpX6mo67GXHYZS6Q/RF+cNZAvI4DEeoZJPbWK9nnCl1nX9U16fqGpbTVKoKcXim1Njzy1LoXNfY6Phbkre/SFriEbyJ5ekKeTvjLwkvsXRS8ENO1HxXjnUXhy/2/nP1ASEgo3xfsfkkKdwTgW5LqwGXs1b6t7hu+7W/G2g/NLZzu6qKTOdYxHMXptcbwctJDa7EYbp+5sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDq7fswjcrNBl8Z+CypHoa/b4lWmhk6rkeNqoRFV+/c=;
 b=hEDKOoEBvOM/3FR0i8UiEYUngJr8ZdcPj3rj7wIP1ktQIu4SGdncQzIWspx5ix+sYZIop+Q0EvJB8qKbzqWGxVWuLLKgeMRBT5tQhUGcxDIljbsqSWeZfmoOriUi/Cnpyl0yaS5yHeGpYCGB3qx3fqqQDtKXVe5dRFDW7QlT63kLFFTzdVlYf6kghzPBw1IK84sZ3HjW+DhPYvrS3HbKLsHfmDk1TvMBsUq7aUU+UUlD9y6LLx1HfP4kmAJ/WVIg1nd7rqds6IRq/4UHL0Dh0BmUNauuUFFbOEdRAcq0tfGs4ldbHikHEyz2/CV+w/zxzK/Qqurqlnc1Jc0gZWXvCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB6PR0401MB2536.eurprd04.prod.outlook.com (2603:10a6:4:36::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.23; Wed, 23 Mar
 2022 09:29:46 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 09:29:46 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 6/8] mptcp: add bpf_mptcp_sched_ops
Date: Wed, 23 Mar 2022 17:29:05 +0800
Message-ID: <40b62df857a2a1fc3f96731ff5b9ef258ad1a3ca.1648026806.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648026806.git.geliang.tang@suse.com>
References: <cover.1648026806.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0062.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 634749ef-668e-4551-fe6f-08da0cafab62
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2536:EE_
X-Microsoft-Antispam-PRVS:
	<DB6PR0401MB25363940F6DECE639286A183F8189@DB6PR0401MB2536.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	x7BGFS3wkM5N/zQXdp+dI/WCIdtvjUpLYuMgAALhM4/74ryW4QO0ebMfcyiDoQvbtr9ce1moyePKEgTvJ/T7zlcoaJN0B+OX4LrmuncoTYFggKvNnWstOHQPI87hxuW6SsayHOH9YUh2EteAqPnfU7NXt/PqRu4tNiIsAvCfsqjeoL9VRp8BTZns10gfGLtmmbZHjh8UJuoUfKe65d2Z2ur04iDog3BW11ApSdbt/Frhk4nj3M5GtCDUKr4L8+j2+p4PjFf9shatOmTMImz/tYa4bzKezz9+q+ZE1AkV5f8tgNJ8RIIWGCOkTA6uCliZI1ZJzrOPHA3Bo94Rn7kXe7lF8x6Gd62U1+MKyuy+dW+NKixiaTff3MfbCud9EP1IIeaVKDv7zOo9G0dbZQpPvj/Y93c02U78xdiMVcHozX826kvQVQw3LjK40oIzZchAOWYryXOAvrSYsPJAsHEQHyBSbLiQ7BDDhw0KdyXEknAuJuhyAFgR2NhcQyau01B8SYQvn89s6hnGOygUqrvINhLdcec2sgJCFESh/Yfnffv4x+vpgSxYMeqe928x2rCy497Q5KI7B0y7T6lqTRZLpRIU+daoPCVAQ3SP588+t1pYFlCTyqBXmEiLVR6JA5+nNfYixHvYW0o4MKFX0RjaMqsWv32sJbcQ7D1x/kZaSuAKFpqAsDoAm1hitUq4Vlyz9VhKmycNzn45Pdk+kq3MMw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(44832011)(6486002)(8676002)(66476007)(66946007)(66556008)(6666004)(6512007)(6506007)(36756003)(4326008)(107886003)(2906002)(8936002)(5660300002)(86362001)(316002)(6916009)(2616005)(186003)(26005)(83380400001)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gFgsNp54XkTMyylzw+D85YBpzZnw2ahWCQHlctp1cCj+rpxUlqpZ+jFdSfdn?=
 =?us-ascii?Q?Wttf1VDzijwvk6kW33+/4vWnVrUWQSiOpm9kdMGK9dWbDEvSF/1IaYsz6YrT?=
 =?us-ascii?Q?HaHivTkmGnZPM+5cAjsGi8pIMXDBpSsKArMjBAvh5vrQK0TkI04s9Z3EyIz3?=
 =?us-ascii?Q?hhhlul9PuiMsyFCkoSYRyNi4kAlxqnsR7ZSHikOZoqVa4CHOr20DxHwC3gMY?=
 =?us-ascii?Q?O/e+ALASdijH8Dp4UjSN2+VSLC0H5T4fGPx0Vbv163r9Yac279oYWiuCQ8FV?=
 =?us-ascii?Q?0+NY7Xl41rfwcpOzchGIyFgaESjzRrLiHRe8y33y4qOa0haCQIlIWhPJODjk?=
 =?us-ascii?Q?1HheGwuTeUPOgsZKfJg+uC33H17UDjm4gV1TZTWQBnlBkFdfBN3qihuTF/Tc?=
 =?us-ascii?Q?XsfP/Vq+pY+nLIrf4q1xisQyTTousj435RXDMa1d6kYw52bpILbG+6pMbB26?=
 =?us-ascii?Q?ZeZMebNFE2WbBvskhLWCKmBCZWjB7fpC8Wggh6ns4QcXpcK2FIzEAfJB6IC9?=
 =?us-ascii?Q?TjjXk3u96Y0SUd+t/4Ezf/rudfN9PN3jJK4GyiVKwSLTgwPXJyU5SgIajhSa?=
 =?us-ascii?Q?jSGcnMlx30oi/Bj6y6S44Du6A7rL8UAm0d2CFpGQDwkvWXp+VZaDAm5t5NkA?=
 =?us-ascii?Q?oiEleW+3CGssdXQ5I3nzdyeNpldQhWH8TvsKO+zw+1H0//3kwHC6L92gfXbS?=
 =?us-ascii?Q?WNC6n+X2195TuYfzeD32jQAOib+jNY+mMofFvitUE0g4FYRE9azIi1uUy/Cg?=
 =?us-ascii?Q?XI3E/TlC2A03VAphza+Gr3A1lIJVwka2wHSVPFQNrwHz71M+ieWrrzklQldb?=
 =?us-ascii?Q?EZK7bKFVXbZFuGteXRTgL06Dip2a/NTzwo0hQhp/Q7icrpq+mL7t6IXi4ETs?=
 =?us-ascii?Q?lBPq9z+lmgIWNmxHL3IpWyggOHWr85uORYbYzmJBIsoF9dxL05EBPzL/h08E?=
 =?us-ascii?Q?zmn9lROctdIj7n+/Z/OvJGxOPR2w6xxmjg3pfq7C9GjYUeZ9nef4HbbbCYoJ?=
 =?us-ascii?Q?EXlucR/r7evitL94KsS9NsrMhDRRb/sDwkgu4ZOmYD+prsMF/HNOTOTQ+v2Y?=
 =?us-ascii?Q?vdmerXaKAQSv0Ny8kbXwAm5hO8JBrb5LNeFw++cYPoRkMlxzREkZUtA+qs5z?=
 =?us-ascii?Q?EeePotAxD89wRD0lsoV18Un9YdPQ98856tfgK+6NuAUXoH/Di+S7hbPWjwMg?=
 =?us-ascii?Q?HyJ42tTGR21A6TDOTv3oOJwxIgfiEcx5J0G0Jx9Pmb6uSZmk8N3miOjxLF1g?=
 =?us-ascii?Q?cYZxZ5fdjLorn1otaZ0c7ZCj0Lld0DzLozW1liB2pURtbQW1gotGskq3p3D/?=
 =?us-ascii?Q?YawvVBgZg5o+Go+sPR8b4UOqRcO1hA04u26yWLrAgoeRKtG0dxVrkOakuHsi?=
 =?us-ascii?Q?G6LKiYiaX5XqQMthADn0YItmM8+iD/+LUsKW7jhfpZvUvBmmS5Q/o23CGApZ?=
 =?us-ascii?Q?AaWCwziqRcsM0cx5oxBy5JQFDOXvekjaXxdcLByqTWmwkQDg59ag0A=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 634749ef-668e-4551-fe6f-08da0cafab62
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 09:29:46.3360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6qoAvJ7o0J2s9z0ltUGKhaa4V8lvsSO21dRN+XcIudP999Z1k3/8pt1v3g0Uy+0mE4/ewgyrPcJWz2nY7Gr1fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2536

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
index c3b6f94f033f..c706850f0a87 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -8,8 +8,110 @@
  */
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

