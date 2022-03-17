Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC562F38
	for <mptcp@lists.linux.dev>; Thu, 17 Mar 2022 11:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1647515105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UYT5h+Xz2FDHu39DZCQ/GHp2DAN3NBjKvtOMDc1S0Ds=;
	b=Q2eho3YqipwYCB6z1pRWhaHusIeDF42HD4KWq2839wVQCEZXpLrqzLOSnm3rOMlPhsEDJl
	xNSLS6NUR4WWhhU9v7XAuwXNkpEKSfBEEpR+DrDmOGFCEI2sCSTgSQr/TfizSLndduHV/3
	QNq8UwF7bS4JTj5KIMfHj9mpv27OezI=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2113.outbound.protection.outlook.com [104.47.17.113]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-16-xXhGi3EyMeKrdZOj9OtYkw-1; Thu, 17 Mar 2022 12:05:03 +0100
X-MC-Unique: xXhGi3EyMeKrdZOj9OtYkw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fzz1r0/58gmoe9EsLTAgU7Op13hPUboxps/VQtD8+kOiP19l5s2actU1OhTNau1rj0+2qtM+CQj7OK4Em0dKBkBB1xY1qx8bZIm7Cl6FJ0KEk360DTa1A6ZMFXLFhcw/IhRN5KPUP1REH4Vzz8QNX6XDLDT3rxXpXUWaCWG4RkP6652rUybs9miJL+NfTmpU+G3Hy0ywi4YFuYya34l7WLMZmC7eFwGROvbOzGR4+iR5dVk3vxoFv1WTo8HlsuhGKos65aQKBxgUwIzbbzmPovocqHnBB6pjlAOMl5Kfxilv8K148WOq8KQhqnftIUY+BliZKMfWRnxGASiAbH5e9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GH3LUR+8TvoKnK7xyA9z4kW1v09xrwNt0JS3kJO7+TE=;
 b=j7WD464IsA3YfL0LTCMUW3B6iZfvwPjrkteCMMydMW9wF91TEsufy0oR8LaVYMyFsnyiYD6dEcnZS67gFhz4cgUvGMuTchjktMMUl0OTUngfUdXlePe0tovTD3WNVke31VAON475DTVqNgic3gkTawbmRy/vZCYKxNmaOdgJA8DV0WzChzRTVwzWBE1iLy5EkhJV/tIQzWcssGAdOvQG+7aq+ygMvY0r9HnJKz8OgaKIHjzQlAi59GrTlSGHatwehfZhgR4uEpoX96k5RiNYbF4/RdpsDjJ54nK3m9vD6gRKnwaIVUj2uvMxoq6d2o9CKUNC94Tx/mkWfoRpco3pHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6256.eurprd04.prod.outlook.com (2603:10a6:803:f5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Thu, 17 Mar
 2022 11:05:01 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 11:05:01 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 2/5] mptcp: add struct mptcp_sched_ops
Date: Thu, 17 Mar 2022 19:04:43 +0800
Message-ID: <ade0194842d12d9da08120bd1acc2bf6722439ea.1647514852.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1647514852.git.geliang.tang@suse.com>
References: <cover.1647514852.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0172.apcprd02.prod.outlook.com
 (2603:1096:201:1f::32) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96071beb-cecd-4ed8-894d-08da0805fb2e
X-MS-TrafficTypeDiagnostic: VI1PR04MB6256:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB62567A373051585161EC3872F8129@VI1PR04MB6256.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	814FkP7L7+U3PVPLShf0QvfxpLE7nfcV35a9EJ9Lsu1XyV719Ttn05dKjzAljUNMIZ7GwG2QBda3EtuOIb459OP71eLieONfdIhKIj+8tSOQPzRD4/OgxW6vWNW5QqHXSS9/47rnpL1R7PGDFOfRXstF7zO4AS+v3n8Mt8flVKvXfxlQiOR1Re5VJqKnovDo9R0N6KULFlZmHkUYKpJHc29r2XuX9hn5I0zB7yM1SoZSBZTjTBok1Zw69JLMzhome8bkfMn01msdjxLFVPuBpx5Gqp9yUoOn48HG/DDudx9hCVrPsbOhC5iHLUChueCXuKRSstnXVbRVw5+3t4ilBvfkFZCxZj0bTcPvgoo5I7hitqWlX9GBCB8kMbkFesdDTKFn/BP6gzuumjQ083C2l6N9HqdpgJaxmw+RVzh1hZ5yTlCeKPBIooYP4XqkwiMR4E+Jm6pyjaoZeHsM334nAUrRIG9y/SmT3TU2TKTsKnPBlUz4prmclZDIIWyeCTGFpRuOjY0YlAMmsGwba57lQTehveXEjVV/7H8Qm8D3aOcnCYcNoWuAcHi4yFOqBccin5Pm61+K8HQm8KF6ENQeWxjLqtXWlpnEVc7NenOGd/cBR6QiAiyikob7X7SYqdsSCITIPFYNdSFOoGoXEvSrBCDClfeZ+z2lUODNOBLvDqm0oJssY2v4y/2NzVtDEQTj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(316002)(8676002)(2616005)(107886003)(26005)(186003)(38100700002)(4326008)(2906002)(6666004)(6506007)(66476007)(66556008)(6916009)(66946007)(86362001)(44832011)(83380400001)(508600001)(8936002)(36756003)(6486002)(5660300002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5Ac/ZlhwL5eb3cnfr7C/LxG9pbr7tXrrR+aGLPuBDLPTCYOS3VEiVNxCAXSm?=
 =?us-ascii?Q?l4bs4vvSmk467ouFiNKGsuYfQ4VCGfDowXRXI1iz/22SmGbncfhTAekMNMDe?=
 =?us-ascii?Q?z6tXwtMk1K/+ZuNMYwF001/ou5qhs0E3TTAeQLRX00PM7N2UVKdEL6wkMSCO?=
 =?us-ascii?Q?QqIfC3SzlSnI14EcX4M+uvG2vHx1fD4lRfr0Wi/DWidaKWzNQ+RkoLaBrbUU?=
 =?us-ascii?Q?BbJYqXdYab4tt1l46+dadQDaHw0QNPvOAT3oBFR8l2coot3QRXaC7Za3MB1A?=
 =?us-ascii?Q?kodYTcaml0KQobBaCcMjz/uwlQbkjcxMJ2jCYzNAD9fZ3rvNjm40rg5R/WXY?=
 =?us-ascii?Q?mP/owJ7z+uk3VbvI+V+W299ptwO10m60fJzOk1YUVzNJmZZPUBOq3YJK3qbs?=
 =?us-ascii?Q?wvzETRNnpi92z0gIXrLMpPw8pabXAqb9iXWNsV2lCvhV8HfucJhWYW6kxHDz?=
 =?us-ascii?Q?QYeg8tj9F9eg5cWrdmk9wzCt62xMIdNTk8L/hYH2wtLXMtcmnn/962Dxprpi?=
 =?us-ascii?Q?hwRRJWntEZkCm6LmKCa0LXBa/7DYvnD3mgwYZ+UGcqiZX1cXRuF2XzvQZTaz?=
 =?us-ascii?Q?mnaYouxBxAFGGvWuGvZNY2tCXI22IORqgec7GXOLWWcklOLuHXosbsxuTmbR?=
 =?us-ascii?Q?xDhKBasbKDMZl1Dm25klpmTWp6eaicoK/CXJ55PWIz521gK/TZ/qK4HIxx6w?=
 =?us-ascii?Q?Ju/GgF28rZkhuMd4JuyhIvHEvT56U0PsnwmIKk4A7cDEk+r4ixpLKYv8y2Kg?=
 =?us-ascii?Q?8k6zRehYNTENK+7ImHs8BZSK1Xx5+KsVAGBKNM7+kBSTCkDj2F9VtCEHUwNR?=
 =?us-ascii?Q?ReTbl49sunLoBFunBTtFRPa3aPqtiuKVtW76G3EqpBc1nb/af3O+HHHQW1tn?=
 =?us-ascii?Q?mLbmp8jBtSoTdbjZiT106wRxNKYO7W6E9Shg7WSND2L9hTMX2likxR3aZsXY?=
 =?us-ascii?Q?2g8UqixggyGdZ7mfP3jaWnRx6lcIoYLfqoBbws6PcG62ErMAYxGm0e2IydBP?=
 =?us-ascii?Q?tGWCucfFTQpxMCC4y5T8xNJyI/C20wzlc1EH7AObgBkxRBm+m90Y2Sjx4z/L?=
 =?us-ascii?Q?DM0y8dsmzFZoscEKf6uGKN7l/cagMG2pOAxvbhqr4x+UmU42BHErpX5upQU/?=
 =?us-ascii?Q?raMQ3Id99hrP70LIPkPG3TmBDTydA9AV/YqxNbnuuc2Gp/BO6iyvWc8azKRD?=
 =?us-ascii?Q?WJ+bY7zHGEgsuEsGfS45Wqy8o/OMP69IJcMI1Fq7P6mwhEahHZR7PZ4DAKgS?=
 =?us-ascii?Q?anJd6HKsg+O3EaFgF5bd7xvq0Mz0DdZLTTDki8D1d63EvSXpjJ1h7hmf+yFM?=
 =?us-ascii?Q?3jEpq2WndXdiydM3hmA7omXsW3qhlJ9kALdQP1ypq1cm0cq4+tpVbrP6IND1?=
 =?us-ascii?Q?BI3kbpPkslDG+R7xExcmlBav90eEbQWtgm8H28K5iWk2gIIELoS2gmmy3i35?=
 =?us-ascii?Q?+58zu9JU9348RKDa3yqbMw2eM/s90UlGzg80h0l/p0LBZelb6ljKKA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96071beb-cecd-4ed8-894d-08da0805fb2e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 11:05:00.9742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W0tCZcM6ECA/BSbC5ebrOyfpSv+ZfjdkNZHXsNiQfRaBeoFzvDeKbNobWg+KdOSH1j7ByY4AGlJbd4xZ7yt01w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6256

This patch added struct mptcp_sched_ops. And define the scheduler
init, register and find functions.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h  | 13 +++++++
 net/mptcp/Makefile   |  2 +-
 net/mptcp/protocol.c | 12 ++++--
 net/mptcp/protocol.h |  8 ++++
 net/mptcp/sched.c    | 89 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 119 insertions(+), 5 deletions(-)
 create mode 100644 net/mptcp/sched.c

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 2dde95412fc3..bf7f4ba00424 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -286,4 +286,17 @@ static inline void mptcpv6_handle_mapped(struct sock *=
sk, bool mapped) { }
=20
 #define MPTCP_SCHED_NAME_MAX 16
=20
+struct mptcp_sched_ops {
+	struct sock *	(*get_subflow)(struct mptcp_sock *msk);
+
+	char			name[MPTCP_SCHED_NAME_MAX];
+	struct module		*owner;
+	struct list_head	list;
+
+	/* initialize private data (optional) */
+	void (*init)(struct sock *sk);
+	/* cleanup private data  (optional) */
+	void (*release)(struct sock *sk);
+} ____cacheline_aligned_in_smp;
+
 #endif /* __NET_MPTCP_H */
diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
index 0a0608b6b4b4..aa5c10d1b80a 100644
--- a/net/mptcp/Makefile
+++ b/net/mptcp/Makefile
@@ -3,7 +3,7 @@ obj-$(CONFIG_MPTCP) +=3D mptcp.o
 ccflags-y +=3D -DDEBUG
=20
 mptcp-y :=3D protocol.o subflow.o options.o token.o crypto.o ctrl.o pm.o d=
iag.o \
-	   mib.o pm_netlink.o sockopt.o
+	   mib.o pm_netlink.o sockopt.o sched.o
=20
 obj-$(CONFIG_SYN_COOKIES) +=3D syncookies.o
 obj-$(CONFIG_INET_MPTCP_DIAG) +=3D mptcp_diag.o
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index fbb14dfe62b3..2250b1c11e9b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1424,7 +1424,7 @@ bool mptcp_subflow_active(struct mptcp_subflow_contex=
t *subflow)
  * returns the subflow that will transmit the next DSS
  * additionally updates the rtx timeout
  */
-static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
+struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 {
 	struct subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
@@ -1567,7 +1567,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned i=
nt flags)
 			int ret =3D 0;
=20
 			prev_ssk =3D ssk;
-			ssk =3D mptcp_subflow_get_send(msk);
+			ssk =3D mptcp_get_subflow(msk);
=20
 			/* First check. If the ssk has changed since
 			 * the last round, release prev_ssk
@@ -1634,7 +1634,7 @@ static void __mptcp_subflow_push_pending(struct sock =
*sk, struct sock *ssk)
 			 * check for a different subflow usage only after
 			 * spooling the first chunk of data
 			 */
-			xmit_ssk =3D first ? ssk : mptcp_subflow_get_send(mptcp_sk(sk));
+			xmit_ssk =3D first ? ssk : mptcp_get_subflow(mptcp_sk(sk));
 			if (!xmit_ssk)
 				goto out;
 			if (xmit_ssk !=3D ssk) {
@@ -2609,6 +2609,7 @@ static int mptcp_init_sock(struct sock *sk)
 	 * propagate the correct value
 	 */
 	mptcp_ca_reset(sk);
+	mptcp_sched_data_init(sk);
=20
 	sk_sockets_allocated_inc(sk);
 	sk->sk_rcvbuf =3D sock_net(sk)->ipv4.sysctl_tcp_rmem[1];
@@ -2760,6 +2761,7 @@ static void __mptcp_destroy_sock(struct sock *sk)
 	sk_stop_timer(sk, &msk->sk.icsk_retransmit_timer);
 	sk_stop_timer(sk, &sk->sk_timer);
 	msk->pm.status =3D 0;
+	msk->sched =3D NULL;
=20
 	/* clears msk->subflow, allowing the following loop to close
 	 * even the initial subflow
@@ -2933,6 +2935,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 	msk->snd_una =3D msk->write_seq;
 	msk->wnd_end =3D msk->snd_nxt + req->rsk_rcv_wnd;
 	msk->setsockopt_seq =3D mptcp_sk(sk)->setsockopt_seq;
+	msk->sched =3D mptcp_sk(sk)->sched;
=20
 	if (mp_opt->suboptions & OPTIONS_MPTCP_MPC) {
 		msk->can_ack =3D true;
@@ -3070,7 +3073,7 @@ void __mptcp_check_push(struct sock *sk, struct sock =
*ssk)
 		return;
=20
 	if (!sock_owned_by_user(sk)) {
-		struct sock *xmit_ssk =3D mptcp_subflow_get_send(mptcp_sk(sk));
+		struct sock *xmit_ssk =3D mptcp_get_subflow(mptcp_sk(sk));
=20
 		if (xmit_ssk =3D=3D ssk)
 			__mptcp_subflow_push_pending(sk, ssk);
@@ -3743,6 +3746,7 @@ void __init mptcp_proto_init(void)
=20
 	mptcp_subflow_init();
 	mptcp_pm_init();
+	mptcp_sched_init();
 	mptcp_token_init();
=20
 	if (proto_register(&mptcp_prot, MPTCP_USE_SLAB) !=3D 0)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c36b9c40c314..33720856bfed 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -286,6 +286,7 @@ struct mptcp_sock {
 	struct socket	*subflow; /* outgoing connect/listener/!mp_capable */
 	struct sock	*first;
 	struct mptcp_pm_data	pm;
+	struct mptcp_sched_ops	*sched;
 	struct {
 		u32	space;	/* bytes copied in last measurement window */
 		u32	copied; /* bytes copied in this measurement window */
@@ -584,6 +585,13 @@ int mptcp_allow_join_id0(const struct net *net);
 unsigned int mptcp_stale_loss_cnt(const struct net *net);
 int mptcp_get_pm_type(const struct net *net);
 char *mptcp_get_scheduler(struct net *net);
+int mptcp_register_scheduler(struct mptcp_sched_ops *sched);
+void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched);
+struct mptcp_sched_ops *mptcp_sched_find(const char *name);
+void mptcp_sched_data_init(struct sock *sk);
+void mptcp_sched_init(void);
+struct sock *mptcp_get_subflow(struct mptcp_sock *msk);
+struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
 void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow=
,
 				     struct mptcp_options_received *mp_opt);
 bool __mptcp_retransmit_pending_data(struct sock *sk);
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
new file mode 100644
index 000000000000..f1bb3adeb71b
--- /dev/null
+++ b/net/mptcp/sched.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Multipath TCP
+ *
+ * Copyright (c) 2022, SUSE.
+ */
+
+#define pr_fmt(fmt) "MPTCP: " fmt
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/indirect_call_wrapper.h>
+#include "protocol.h"
+
+static DEFINE_SPINLOCK(mptcp_sched_list_lock);
+static LIST_HEAD(mptcp_sched_list);
+
+struct mptcp_sched_ops *mptcp_sched_find(const char *name)
+{
+	struct mptcp_sched_ops *ops;
+
+	list_for_each_entry_rcu(ops, &mptcp_sched_list, list) {
+		if (!strcmp(ops->name, name))
+			return ops;
+	}
+
+	return NULL;
+}
+
+int mptcp_register_scheduler(struct mptcp_sched_ops *sched)
+{
+	int ret =3D 0;
+
+	if (!sched->get_subflow)
+		return -EINVAL;
+
+	spin_lock(&mptcp_sched_list_lock);
+	if (mptcp_sched_find(sched->name)) {
+		pr_debug("%s already registered", sched->name);
+		ret =3D -EEXIST;
+	} else {
+		list_add_tail_rcu(&sched->list, &mptcp_sched_list);
+		pr_debug("%s registered", sched->name);
+	}
+	spin_unlock(&mptcp_sched_list_lock);
+
+	return ret;
+}
+
+void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched)
+{
+	spin_lock(&mptcp_sched_list_lock);
+	list_del_rcu(&sched->list);
+	spin_unlock(&mptcp_sched_list_lock);
+
+	synchronize_rcu();
+}
+
+void mptcp_sched_data_init(struct sock *sk)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	struct net *net =3D sock_net(sk);
+
+	msk->sched =3D mptcp_sched_find(mptcp_get_scheduler(net));
+	if (!msk->sched) {
+		pr_debug("sched %s not found", mptcp_get_scheduler(net));
+		return;
+	}
+
+	pr_debug("sched=3D%s", msk->sched->name);
+	if (msk->sched->init)
+		msk->sched->init(sk);
+}
+
+static struct mptcp_sched_ops mptcp_sched_default =3D {
+	.get_subflow    =3D mptcp_subflow_get_send,
+	.name           =3D "default",
+	.owner          =3D THIS_MODULE,
+};
+
+void mptcp_sched_init(void)
+{
+	mptcp_register_scheduler(&mptcp_sched_default);
+}
+
+struct sock *mptcp_get_subflow(struct mptcp_sock *msk)
+{
+	return INDIRECT_CALL_INET_1(msk->sched->get_subflow,
+				    mptcp_subflow_get_send, msk);
+}
--=20
2.34.1

