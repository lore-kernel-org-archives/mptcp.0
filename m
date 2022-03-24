Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15561FC0
	for <mptcp@lists.linux.dev>; Thu, 24 Mar 2022 14:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648130982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S8yex8u3vodzhx/QOdpWjG2Vl2eRp0NvhtPa3eP0QkI=;
	b=hWaMSG390IL6YjNZsulLPebAKSRAFa70S1qIMV2C/0tMpJXJL28BFcfj6C/k4Kn/kQC/Y6
	B3g61E1yL8ekUqvpVy7p6q840M0Rnnpw5X+m3QW16IYPJRaCnnjB5hqb+exHtFW/9ITK5Y
	zgnNtgCHmuA4JZ331Nme8LfC17hlTXY=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2057.outbound.protection.outlook.com [104.47.6.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-23-doI__19GM02YrJzAy2MXcQ-1; Thu, 24 Mar 2022 15:09:40 +0100
X-MC-Unique: doI__19GM02YrJzAy2MXcQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gGLU2ivykaXlkP0CYhKjllc7hBKUbT9RaB/kzC7aODd4i/ccgSEnItBy23SxS0ev370ALZFenPLfJ9oBAYKkZhmjcvBG+u1MDEzNsU/owMEBsP02Uu6VYjl1jJN1UJJfbJLXhgujC6gbuP4esgKJxpjXOuTcK9NZ8rFEcZR7DXlACnzpyO2s67L/xEXRsMC2LuBNP/rx4z9jEi7HraCH9osMHleCc4B+W8W5ql02v80tujkQCUnXJLkIG6zjhOXo6vr4jjGv37phPHSaRefwQU1Jxl/7sKJW+lT6dMlysJoMHsuNks4y4Wrqgau09V1uD3a4HW0t6ms/gTAYBAVO7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EUmaJiP9qdsB96fKyu2uMH6otJZFqqHJLWMJn7WWdKU=;
 b=RJrrpRnq8F8jqryQWiMSNaEpnPsRijwebphw2wV9C18RNKOB6qMEVgduLG2aI+fXMn0r3qfYZa0jRIntKCLUDcInEzA31lLjD4JM5PIhowvIMxt4rROUdml3rHSLpVof3c+/4difP+V0iPL4/Gi2GyS1Y1j4TAsfLAhMvro/EGXPDK2e7ypRvoDeL8g3JdYGfGLo+3bYcNEXwSFU7tYhu+Gd7VF8R8Iim1sJ68NP8xeshOr7WZj2UHwCUsH1SevfozbfU4kRjv8JmBoiIkBWar7i7RouHw0nnJ6rF+H8tOXP1ife2yzuS83/02dhsZrNAISjjfixmukuBml5EXsKQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR0402MB3616.eurprd04.prod.outlook.com (2603:10a6:803:8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Thu, 24 Mar
 2022 14:09:40 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Thu, 24 Mar 2022
 14:09:40 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH RESEND mptcp-next v5 5/8] mptcp: add get_subflow wrapper
Date: Thu, 24 Mar 2022 22:09:07 +0800
Message-ID: <0c0a5ee87793b0292eb80a57248c6ae4fcdeda93.1648130637.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648130637.git.geliang.tang@suse.com>
References: <cover.1648130637.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0201.apcprd02.prod.outlook.com
 (2603:1096:201:20::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fc93fc2-6b77-465d-cbf7-08da0d9fef8b
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3616:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR0402MB3616FEA7E87C7F56F1BDEE98F8199@VI1PR0402MB3616.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	szi4Crft7lBAsTspO93tGVNCjG+6NfZRkDCljrRduS+IdpCN+a+6OIC3YdiB5MpeUrx0zD6ButwuYWc4TN1OVuheSDebZ0FeJsrRXHC/oZObGtInV3UGO3D1u4R1Xz0VTKDKxO6xsOvEA4NpiWVrRTxu/iP0G75ebVz4eD9VJRSNhyfjQfy0IMaGK3xrWm/COJPTmezDQ5pFv3C/AyXtnoHnW2DFjoU6LHhOyTUZp5H8sX6L8B9AyBeNl93ZQGLA73RRe5exuevPe4oGIanjDdeUCG+3rr3I8tdXaLNXkzIqPSHeYvhdEH3U8hqsPVipRHNMYq00WlZgY4xSNYUS+CZk7rx/QxNDHr4Nn4Q+64VvUlcfu9sa0Xfakkx5DW+LEph4pvXoVpZ0TflMwfF0Wwf/lkrv/7Gt6xaNzyUiHfzIKhd6WnD0TghvSe/HdBtQMLZuHTiNVeYCYLTPLz9QBocGcQb8eWePCJxW5G/hoM7bdfYVPLERGLLLRFVRpauEe7leY7ImTFJeEi8N4QY8cVZ3OK9wadXQCa1huFnpakuE7p/lKBHDDSGf42OzbnHCQmK148ux45zP6j5PcakJanefRB1ENLYePQ3NJsWVPq+1sZE/fS4z7QYdZV7w7ilxbF/ehWANKwwpS7U2cjk4SvQbz69CPz20vEAIH34RTeAMmP0XdD9Deug3x92YoPoL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6506007)(6512007)(2906002)(8936002)(6666004)(5660300002)(38100700002)(44832011)(186003)(107886003)(2616005)(86362001)(26005)(6916009)(66946007)(83380400001)(66556008)(6486002)(36756003)(8676002)(316002)(4326008)(66476007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kdCOH4x0NMN+BYBsT07P6cKIfRDB4ZJt/F0Y8T5hxYyPgXlWS481HecfyDAi?=
 =?us-ascii?Q?l0FFeH28eR9O/zZFZz/2+0nEbnz3H2CLMd7FxvkYTYQS7LQT4I1q7u+lp9br?=
 =?us-ascii?Q?vghlxAQ48GhD+RR09DlNII+yYEWX9784YwwdoVMUaVuJyJYt4RHFGFVclyWO?=
 =?us-ascii?Q?3r0bIeSzuTpCyJ800WsU7yzklV/oQCRMo7hXYan94lRLp/HAabQTMN9OP/vd?=
 =?us-ascii?Q?G5ng4BFp9t9mp3emC3yOADtEzSKnuR35pWGBjRCZx06vpJVJvl2HZ++zB8vy?=
 =?us-ascii?Q?uJlR1k7yd69V8JTCubyIX9O7dExiG99LBf82DSsdFGO56ycKgpUeM41UyVK/?=
 =?us-ascii?Q?8eh9/H3iItJsyjYcwrIWwm+2TgPbTCqFA6oAAftSMdkJgIAd0Q6kJz5SNMtw?=
 =?us-ascii?Q?z0V/IEjTnnX4NQlWihFCUWpKRZwY3uoS4Qb/5kI+9YeZWsbsBZJTGwiw3Slb?=
 =?us-ascii?Q?Y4pno1xvR3nw6Ksuxx7G1znBNquzsx7hpV/2c/RuQE1J1PitBE/NHnx0k5lN?=
 =?us-ascii?Q?rLTk2eHya6ObveZL5/jtueJj/dbPVK7qm2ws0MFaxeMu8sAscs5pLMzJYI9n?=
 =?us-ascii?Q?Q49derVhF32aPkvts9zyaXFkcwEkfDqqjThGyFxzRpdRav4e9NykqRK4NsTN?=
 =?us-ascii?Q?pej2BCgu9WpxVkSUcLMMK6Odu0s3Enpg6WJ4qBHhL5PWtzbQoeAUZAjPlMbx?=
 =?us-ascii?Q?xQj75HTXn9E+RGX3VUnn2Ln9ke8QtJjTSzFs9oSehyrr37EWgUNNnfSpnSAq?=
 =?us-ascii?Q?t3MxcDcYpvbMdavFFY9nIFX6mmH6EJcVwzMWQnz4xNFQUGbEo2Q/0tACcMe0?=
 =?us-ascii?Q?eCCQqGVOZGx0ZaNc7+4PeYH4HrFVT7g8YbS5O+og3p2NUv3v+K71r2rcDk7k?=
 =?us-ascii?Q?lmfYowgPWbFMAdXyq3CYCQOfJo2P42ugifp+Rql5F0xY/cvFGVWvzZhsmurS?=
 =?us-ascii?Q?ZHIUw3qy2xuGo0h99n6dTxQ6zPHc9yjAg4O4+ZQd/EJT6gWcamNqzgx1OBdq?=
 =?us-ascii?Q?FJayRx9Sshcmn5mpo4nOepFkW9r4WkaBjTDmQzfv5DyCaUZbXzCot6wz1QZ+?=
 =?us-ascii?Q?hKqZ4Nv2pMJAUqnyzimbzAjtwLuXwcV8qMAQVoLMgzmZRqLT/nfgDy69g19T?=
 =?us-ascii?Q?zumePqqNcckRd0mtBM/eg8aAnvRvK/UCuT7jn9vxrLzpz8eGkkrjD40a2ao6?=
 =?us-ascii?Q?DWrm/zyCul+UNjXWecRbCNqKDgcObgh1BhPd/TSmc37o5b4+SnqJJXx8+Oh4?=
 =?us-ascii?Q?eBCSrNeEeem7qkWVsVnDQ+kswRv053qfSCxOFZBtRvEYG0Cd4Q/5D5lEx+FE?=
 =?us-ascii?Q?2LIFrZFvgWaJYVrJ1NMhhgh0CxdY7nU4jOCEOj767i0YiwiEEESiXFedKlAN?=
 =?us-ascii?Q?VhkvfUcr3KjfhuuFZ4MndqPCYug0UrPqeH4Q0YVwHzIhPr70DXpqyvQWDPIF?=
 =?us-ascii?Q?S3Z8OP39TxJHosWgfvx47b3bX05Qx9679SfAVpjjW8PvgK5kxeyhQQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc93fc2-6b77-465d-cbf7-08da0d9fef8b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 14:09:39.9504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HqsYlxfQ8oYPTpPFNVPSC5tRP+QTAaK5xl8zS5aOUEt4XI7gZWq4CPh76waIxmAgIRSL3HyIzoLqYE+d99RoAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3616

This patch defined a new wrapper mptcp_sched_get_subflow(), invoke
get_subflow of msk->sched in it. Use the wrapper instead of using
mptcp_subflow_get_send() directly.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 6 +++---
 net/mptcp/protocol.h | 1 +
 net/mptcp/sched.c    | 7 +++++++
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c7969b9b567e..241cfda822c0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1567,7 +1567,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned i=
nt flags)
 			int ret =3D 0;
=20
 			prev_ssk =3D ssk;
-			ssk =3D mptcp_subflow_get_send(msk);
+			ssk =3D mptcp_sched_get_subflow(msk);
=20
 			/* First check. If the ssk has changed since
 			 * the last round, release prev_ssk
@@ -1636,7 +1636,7 @@ static void __mptcp_subflow_push_pending(struct sock =
*sk, struct sock *ssk)
 			 * check for a different subflow usage only after
 			 * spooling the first chunk of data
 			 */
-			xmit_ssk =3D first ? ssk : mptcp_subflow_get_send(mptcp_sk(sk));
+			xmit_ssk =3D first ? ssk : mptcp_sched_get_subflow(mptcp_sk(sk));
 			if (!xmit_ssk)
 				goto out;
 			if (xmit_ssk !=3D ssk) {
@@ -3134,7 +3134,7 @@ void __mptcp_check_push(struct sock *sk, struct sock =
*ssk)
 		return;
=20
 	if (!sock_owned_by_user(sk)) {
-		struct sock *xmit_ssk =3D mptcp_subflow_get_send(mptcp_sk(sk));
+		struct sock *xmit_ssk =3D mptcp_sched_get_subflow(mptcp_sk(sk));
=20
 		if (xmit_ssk =3D=3D ssk)
 			__mptcp_subflow_push_pending(sk, ssk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ad45281e8562..7781eb527b9a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -621,6 +621,7 @@ void mptcp_sched_init(void);
 void mptcp_init_sched(struct mptcp_sock *msk,
 		      struct mptcp_sched_ops *sched);
 void mptcp_release_sched(struct mptcp_sock *msk);
+struct sock *mptcp_sched_get_subflow(struct mptcp_sock *msk);
=20
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index e431b1eec5e1..2fd2a034ba49 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -11,6 +11,7 @@
 #include <linux/list.h>
 #include <linux/rculist.h>
 #include <linux/spinlock.h>
+#include <linux/indirect_call_wrapper.h>
 #include <net/tcp.h>
 #include <net/netns/generic.h>
 #include "protocol.h"
@@ -143,3 +144,9 @@ void mptcp_release_sched(struct mptcp_sock *msk)
 		msk->sched->release(msk);
 	msk->sched =3D NULL;
 }
+
+struct sock *mptcp_sched_get_subflow(struct mptcp_sock *msk)
+{
+	return INDIRECT_CALL_INET_1(msk->sched->get_subflow,
+				    mptcp_subflow_get_send, msk);
+}
--=20
2.34.1

