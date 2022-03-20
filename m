Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037C033D3
	for <mptcp@lists.linux.dev>; Sun, 20 Mar 2022 14:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1647785400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=grcdMS2N7Pp41aFBDIXXHigkqVAfXMeFh1AWipxkJaw=;
	b=imUkwDs0EC0rpn9pJTg3+DUM5YWb5LqT/Jjg6E8djoOgQ1ISo0pwXf4d3tcO70QvuqmKOn
	ycgIO0x85PLNBzODz9yDjfF1ZerqmP7eokV93LDwF/0IZ/PlC3V0DVBz0vPz1GwHOSgS+w
	QfZhznfuqTvkR0YKGLPQLrW6IjwXRaI=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2053.outbound.protection.outlook.com [104.47.6.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-27-p5EvJH7_M9G7bWmnDRO9rw-1; Sun, 20 Mar 2022 15:09:59 +0100
X-MC-Unique: p5EvJH7_M9G7bWmnDRO9rw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8HnrOLipRfLO2Wf40sGazqNbCmvVK877Dq6G8qgEHoemdeBn6MHijEVJfyYTmFbTQLz5oWgfJVFk6EOIni037YoeVwEkUfM0ydiZ01cYzRO40vJ/EaFQ2tr1p/F53rHFR5PkGaeac3eYdZ8gVMmlScGZa8dRFlvbMfW3WNDUsR37rFbCZziEpKDSKQDDfWxS9sVCYE8/bwm9oP+QaDGk7u0xa4M3BuRmkj7hsi3+YSI++8ZzJm3SCRpxJnvZmJjNwqT22rb1x/cEDESaZshakifySqxZ7csM24WdZiaF/lfzkq7SDqd4blRchS5d+jhu/3VdtD+0+Fw7vTozcL48w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/G/QSFKdupfUOdH3RmTK+MYz4usRE5bHtUGSTosJdQ=;
 b=H5F5H1Q37lTDXKyhwTZGu41FyJcMx3mw8V6B7NLZtUlAkj0QkpeUxMbWAqHkw/seHWW/siTvG5Dg18fd77nuFU0cTAbhuLD4Y6kSo5oujdIiV9VIa4xMExnF6MhVyX6FqGrOzsXHfDs9QjODCcQ/4+8hD4dzVqGqpl6zjzccqnJDPDGtOxDipP7mCmqkf0uFnvzmEi/+6IsYljZtFb3tWrySXhGPpQtvpKfjpwKTA5JC96TeVz8MvsMG1mgDy6djP8wy/Jf8kq3CR781asLk+Rq7i3zQlf6g9XlAwDVcG/xwJEUs2kDq4vbi2D6lrKi+actf8XfMA0VFPIvXyofRpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB7035.eurprd04.prod.outlook.com (2603:10a6:10:127::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.22; Sun, 20 Mar
 2022 14:09:58 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5081.022; Sun, 20 Mar 2022
 14:09:58 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 6/8] mptcp: add bpf_mptcp_sched_ops
Date: Sun, 20 Mar 2022 22:09:10 +0800
Message-ID: <7a35fbeeddd750033128ebf8ca41d68505cf60fb.1647784679.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1647784679.git.geliang.tang@suse.com>
References: <cover.1647784679.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0010.apcprd04.prod.outlook.com
 (2603:1096:203:d0::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8331e84c-2bb8-43a4-8c22-08da0a7b50a6
X-MS-TrafficTypeDiagnostic: DB8PR04MB7035:EE_
X-Microsoft-Antispam-PRVS:
	<DB8PR04MB7035F2A6D157D26619F07E16F8159@DB8PR04MB7035.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	azQHcI04Ubps1xGEoLT0vxjAr1SNgG2VK3Q4OGRhMcK1nUoiQDF/d2pvySPZAyAu0IN6bp3nEY0GSH8Qd8jFV9eCR8kCdTIiVtn8KeG15M6KPHM5ygD+PBYRykIYNMLc4Th/0SLGMZXX2/Fu6d2qOlcb24AMAl8wXzNtVWuNBTP5uodVQqhox4ZgJNaE+DoiHOghUc+0n7GWwyZmNxzWmaQqCqdgDxMuqiJ1/icJpc5EWiaUO8N9mI8IqNIv0EXZSzr9RqE+ie6Dn37nIQBpNZAG2uLPb7WocvkWgvBRlxlTTUskv/0aS/Kl/9xaJtEIVQGIlA/SdTUqoB6ntlAL1wSLZyC5r/qqnSpNjMuT7c6WUKtIPp+O61VydcisrIyagUWydFaiosLNeyB7UvH31oTKt4YQ0L/FVc7PXXSkfb3WJ0xatmg5SK+pr5ZGufw6xLsdKMTG+Vy65lG4a10QrwiSQCLv68jnBVKfO8kyeuUrX/9lWLJB1rMoYtgb6vg8WkP/0t8+kzFaN17v/u4oOsRZLaZzBMAPkJfPGXVImZlKOqKn7mZ79gmGA+7lO1ITjpEJGbbxbl/Kz0R8THCIAP8OaVWhiemSkjm98HCmpEEMGxPiEaInIFRmTDjZaDEJ03UaoL0wGTSEIIQtJqHTtmrs7VyJH3UJQVpAJrWMDt8ZDFB/1/Iml+eQyDkXxnWiRNPU5nTd/Tvx1mTRPlXOOw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(83380400001)(44832011)(66946007)(66476007)(8676002)(66556008)(4326008)(6486002)(6506007)(508600001)(6666004)(2906002)(36756003)(86362001)(2616005)(107886003)(186003)(26005)(8936002)(6916009)(5660300002)(316002)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gh2W82FaMThm8FBggcIlg1pPiZ7TKVWIvubq+ENjIDlOKsR8BDd2YT3L63+7?=
 =?us-ascii?Q?qzMmRDLOdTcPacMyQOhpzIjU54uWahyb12fjtIgiAYV5c3KWPhifuwuTCaBw?=
 =?us-ascii?Q?pQX5HqlYItva4BbR53A61y3GIhLH8+taJNU59AebMt/ooKGvUDhp0P4gKsgP?=
 =?us-ascii?Q?6NJoyqq/gE/xq8VbDy2d4c7hmOUkwtGr93gG24zlkLH3lcYgzQjEUXT5bfe+?=
 =?us-ascii?Q?ZsnuDNxn5GK6YiuGI/jdx/4MfkXE4MvQHYC6G7rUEEPJ6baaS6IjI6qaRjXs?=
 =?us-ascii?Q?eugGRAfq8os1xJKF9Fus+l0EwrCo7I0tru39KsqKOWzs8U8mwUB4SWTrUYEc?=
 =?us-ascii?Q?5Fo1wjN/nnsXtjXwyzo6FwHXpjw7Wm5xmpxk/hDf0BWFuURQxuGCXWaqCZLQ?=
 =?us-ascii?Q?TVf83zM0kF1r7iThYislpnhuu4OGmRyezzaGJtmilxE0CKGvmMbfrrvtw34o?=
 =?us-ascii?Q?+CJ42+lLYN3K0Z5n6jxw23u4q/l2NZhke80QU+QVbUMOwKImhbUunoHZvbR8?=
 =?us-ascii?Q?Qtczu5GuKnoxDTpKrZPE9lnCtk6DixeLHNofNEzc2XtC8/82DiDZQfeX/Dtg?=
 =?us-ascii?Q?zEngDI4n+eQ12S6w+ZW9+K+cbhJWI2N8+43KQxDOhKYkqtPpIvgetAtFrYgB?=
 =?us-ascii?Q?9fZDG/jqMlNktT0oZZLP4wDtBb3LJxQswmmXJxV09qlz86uvzArPY7dmbf3P?=
 =?us-ascii?Q?hyk2aVwKHKtplkyZDrP7SnRkFY0htkOcxXwxsS7RxeB388KhYweM7MJQb5s8?=
 =?us-ascii?Q?nGWpKo3ov3bgvwPJkxi8nW4NJ1gkmuBy9bLwfIlKj5e0LzA0TMjIDSxrtFcD?=
 =?us-ascii?Q?IZ9AHOIi+kTYVRCe5GRFWESjugeGeq9y0KohI5wWTfbxaNdL9Q1SgIuMBZRE?=
 =?us-ascii?Q?raX1PRztcSnNNa+aKAlixSC0AVSH98EkGInlUKEBsdmNHznNVcrTIdVlPvVG?=
 =?us-ascii?Q?viLTvpX/4MhrE5gejRytileET3r6zkMh0WcXZnBzfanMGPKBXjzRyrHRCdKw?=
 =?us-ascii?Q?7rexGS/DusJKnO9DZoyDRrrtIKmF0/uJa2BrrnT1SDrpHjq9kFKy+s9Z6mt2?=
 =?us-ascii?Q?uqTHDK+Vd1lDP7+WBBOSGBisTwQGv4lVXJUQ1vV//LIBZUjrpHMmDLx433do?=
 =?us-ascii?Q?jRacKXyL0BmpKy113F1YxdsPmvyVaQA/6DJen06A2yodzkymx09io7QEEfR6?=
 =?us-ascii?Q?vocmFoVKrfDcpM5QQBucPgKfHmN5bWJAwqgrbZ+AoY7yfUPMUN9d1W8sw0yI?=
 =?us-ascii?Q?sl0dLXWObXq8xWGDltNouY40k9WevFGBvMgYWV4H1vodoJYRkzyVaJxZOJpa?=
 =?us-ascii?Q?GAiTAuvYnFH/YWd7fX4VL5KeuHu3APyyr4B+a40cC8Cb+gpxq4EUkTL/E+w2?=
 =?us-ascii?Q?HUihJ5zoB1tbP9Oe+DP40hbHdcQv8hnNmVx706FzV/0K7cYvIcgebTQOjY1D?=
 =?us-ascii?Q?YX3KribLpZ/4Jn8lIM1072yujHTmTkAbVR9KWlV+aM30DtF3xGyUCA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8331e84c-2bb8-43a4-8c22-08da0a7b50a6
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2022 14:09:58.0287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dhItH8xNoEpdBkRubNkX11GRkk19nBlcZKhEfbZXxGNTUSxrrOfQl62ZaoXp9l25qIKSOINh93ZBVM1alPhZiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7035

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
index da79dae559b2..5f7f9d30ecd4 100644
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

