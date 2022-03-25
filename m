Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD17128E0
	for <mptcp@lists.linux.dev>; Fri, 25 Mar 2022 16:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648224790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HJ9Kn3CqsvO6gHlstfJWiH7JJtDriLRy7bpXWqlc/M8=;
	b=Opo69PVRcStx1/BOY8xy3hu8QiHVRHVbcSlHvwBjTCgdi/GGPu6p3qjYotDchc6e/o/Eqr
	0ng172S+QJ8DsCY22lq/gt6tS4GorjDBcv2S1WOc6STJsfi0U5UAxaeqMoOKNbdR4lBHeJ
	1AH6yW5QpNfDIqp3JZ8bM5CGBEX63JM=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2054.outbound.protection.outlook.com [104.47.6.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-16-G_aTS_CYN6u-I3Pa6oJP0g-1; Fri, 25 Mar 2022 17:13:08 +0100
X-MC-Unique: G_aTS_CYN6u-I3Pa6oJP0g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OqlpPSYJD7HH1LvMO8JzYjTv/JWc7hN5xgpn2Y3pGnTmMQonuLvjc5g0syg5let/V6KImvTvQLmQnLpe5kijFlgHW/waLEC5xMa2+8aN3T0w8wOt6aFUUBK5X5vzdM9680pLU4zPmOwA7VAQgCUYCupFPxyVSUfvB7uHFO26h9tqIbL6kdiS9YgMtqzZ7YbyzInCH09R066zTIgDZ5YiGx/8x9yk0Dq1Z/LUmzl2mIqwjkMc3z2xoiH/oBciHIE7fMhHcn6cCvc8zC50NXaZIlouSK2+UPrbpjyE05poOdhytJh0CJG/KyW1BT7hxospM7iaHOUha30i/OL+o5s4fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rsJonClW8qFN8z2QDh3k8tKojRZx6OuVo+VqXRfPAqQ=;
 b=QjW6vzHbTHwCNWgYmUyen1C98pq7bSKzgygxJhNeC4FZk8Ec9h54eOvKPRuHFgaBNXIERQjE1fX+N+nMbiE87ecm5apFJO7o/egsu/vDu3bYKfKY3gtf+mFcVO8bqgnoCYXugK5uW06wB2WyfsgSMYSeDDKODbDJ/YFit2UbOZXJGAxu2yuVYllUUXI6tXT2p0z0n0CW0jNJOi/xwNYRjoIXpZUcHVaydHohJHuM8N2JS4iHxl/AGHI5GBZSlrcnTMU6uWataMw8vru1eEWm78cqrUWvI5c+8ppaCEofEG5RcdaxXKbGfjfjmyHwGbI6EIgWa+cNuINxu788If4n0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR0402MB3938.eurprd04.prod.outlook.com (2603:10a6:208:7::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Fri, 25 Mar
 2022 16:13:07 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Fri, 25 Mar 2022
 16:13:07 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 4/8] mptcp: add sched in mptcp_sock
Date: Sat, 26 Mar 2022 00:12:00 +0800
Message-ID: <19e9377ac9a72587f729820fc793ebdca12d7424.1648223504.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648223504.git.geliang.tang@suse.com>
References: <cover.1648223504.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0108.apcprd03.prod.outlook.com
 (2603:1096:203:b0::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9115d3a-4887-40e1-deab-08da0e7a5944
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3938:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR0402MB393808C5E45D76D2CAFCBA93F81A9@AM0PR0402MB3938.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5s9NoU2DdBXk86GFhNMt25VXGk4lOL9OEu+/PGGCOtmqWqeqxaKuCcdQmKrFT4VFDsbIep7+TBUDmQ96GvHPdLWEX8Fmv6rV1Pbe+nheFi79iBGm6muhkIq4Z09F/D4z8a/FRx4Er/LzkITJ1mkBfMNAo4e1i910hwg4xqZOPqx1Brq3g2LGn4YmU/R2yTfwEIhuhRLy3sC8mqCOYEGzg90iTBbONk/ZMdUrdn5Bl0nEuYfqPPJlIbqJOeHf7sSfRHQUil0n5L6mRd77ZBpHR0/Ai2XCJ95bxZ3KISLvfLk07Ma21/PaAoTxvfJKw43PXz94dgYFaD2LD1I8JqzOTzNZarypOfHoBk1OhzQc22UbrU+eAnfwG29LkL4VOsjhyUyz3nsRyl7u3+3IT94rgpzWsAHCONsiMR1JBE+6HPT3+FhF8fkuYU0iGfZCUmbdMEWQufWCptSTdwNgUmfOrISOmjEAdnaYTkI9JT3I+ZfjZDek0Xs1aGXzdHgPM28YGzFYg/bfHQaIIKDvyzYB1LwFm9XDwGRqPuKyZtEIX3qsrybBhcYumV/y/jHTF4jydpRXzxaUgah2R4onBcZAOg2aX9N63584fzZcDYQQCCxq8pKJs0VdTvAloB1Y9WDq9MjXIB8KAKvzYyvBt0938kZuJAcMzCIxrQmbjCMhDgJs3lI0EDTgKZesDQVtfJEFyllZL0QMw/YvzL+NQJddSw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(4326008)(508600001)(8936002)(186003)(26005)(8676002)(66476007)(66946007)(2906002)(38100700002)(44832011)(5660300002)(66556008)(83380400001)(2616005)(86362001)(6486002)(6512007)(6666004)(6506007)(107886003)(6916009)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?griyEylwxosGiHOyUMFmbUc44v0A0Fpvrf4qPRN1N33pivBPiBOo/Hff9r9I?=
 =?us-ascii?Q?M7y5bhAZbIXzzvADNVmzXMaYU74PKTms/iYagDfZMOvAaP86tJ3COs3Z4e1Y?=
 =?us-ascii?Q?9mapmW/kjKC0KntOTvN9y1ZJOp3nPQpECMgfnpqYLfgfYjTj9MtwqZJYKMyV?=
 =?us-ascii?Q?A4LJZ+OVJ9W5PgXeWfv/G/xGDPvcuaBbF8euWX0UTuKWcLysXKsTiDUOOF2z?=
 =?us-ascii?Q?1LBl5LoInYZTUE6FKZro7GjXDiJ8gQocundl6E6blXRwkVP9GASxe93mdJTs?=
 =?us-ascii?Q?O06qGRmvnmaz5a3FUqJ8jBrxZScG06eTp0BT++ckVWt9g1n47I+GvWztzPFm?=
 =?us-ascii?Q?xZQw/4sKkZLH91RyW5kGRxVG1cF/nu/5xtIEiakC+vX5j6kgFhHVw4P7pJoM?=
 =?us-ascii?Q?Q/bQF1VxPGNdlLAHz+V5PIw2cbFKyIHrvRbWW34vLjiyGt/qumqyokHcEhX2?=
 =?us-ascii?Q?VPHSWu9+1q+ojzfu4JRPCspW6DiJzkXL7IOQ93wEo46DRz0Hzb7ZjeI+q5o2?=
 =?us-ascii?Q?PHJrNuEAOv3K13zJoB5Gs8jytqfpRnZ2vblu4qBwc1EDiXNTfBzoeBQW3xpE?=
 =?us-ascii?Q?5Heb1a0pHuJnMemn5XRcEg6Npvzl6oRjIDH4yUVaEmGLKKvBy52m+U/3tZvt?=
 =?us-ascii?Q?85ZednCkcyajgWlBBuOWmbgZu0FAexOKIPwEmLOCpJ8nbAwhD6GX9VzWYx6A?=
 =?us-ascii?Q?43kYZgM7v6jyrq8KVOd4k2w7CcYvngtQ2LbCxfbRvUeQrpY1MmSe5RljedSU?=
 =?us-ascii?Q?vwEb2VkI6TF9nTShFHhZ9ZUQd4+aBVl+8DF3fQ9gIa2PD8K2u/6xmYEFMMY+?=
 =?us-ascii?Q?EbrJo1LfEyIYUTSTdNaKF2VNqvhACF+cvTKDPYJ0t2vKDj+IjFkwUkdpLcKv?=
 =?us-ascii?Q?ZR845pXErA234C8gTIP3ZZjfFfYt6d4xLOiaKGFbJ24zEMNlzqn0PKXfbp4+?=
 =?us-ascii?Q?LzWV9M9gXbxFaMw1xlC3rIs6mm508F1VRwxbcya8bQ4DL1BqECJpQ4jgbqVf?=
 =?us-ascii?Q?PUXSVDbAW4BTngvaSJ4f2UmLScIUgofHvf57ASls59KDgHoYEJchAgK1+Rbt?=
 =?us-ascii?Q?1IhtpQL8i7BtgoimR3TwTgnociIe5KNhL7OfxaODTQI1YSZmPKPPQ7B1f4kf?=
 =?us-ascii?Q?G73sGBceOtaESdjYIPj6ec5WkychtVScR+v6hciZWtP/jMzZmY+2MDD/WQPh?=
 =?us-ascii?Q?cIgqu+LmeU5Rlhsfj/Zm8/Vl1doAyx5jkz4YHbLKcJs+CLs5ZHtKnycf4g36?=
 =?us-ascii?Q?aSZs/QF/vnP2BLVpInrXXjSDqssr9E1WEZZ7xa9HBJFGq4JBc49p9+vcBjpQ?=
 =?us-ascii?Q?jKB0tETbNCUyRA0bsTqzckFieafDJDt2oaKGB0HuQj3yJzpEd0T1ZlCaZKvz?=
 =?us-ascii?Q?xDEgOR7AX16Ue7F4HsO63a391aIAHwqYAMkPIxBkk6Bk1vrQUdeReK6GpK4C?=
 =?us-ascii?Q?Ws+oyS4Ewh7Dn9dN26jgQcDcTlHE+EvOWWFqYYryTq5wZ8x27DtVCa9Sjc4A?=
 =?us-ascii?Q?YbgCV3GdU2TnVmualKZk4i7afLHZLqKAUIEyKKvTOr3RbOC6q/nbWndoicZI?=
 =?us-ascii?Q?njfj53GenyeOTD+nHYnjv3apqnBjmuBPrq11tUK1CixJPxCqWn0rTIUfvK6B?=
 =?us-ascii?Q?GKaP1MKM/T6GgwGSGFPgsnlh2zcGON4CPiEWqcojWs1fQhhbVaIl7CgOedoJ?=
 =?us-ascii?Q?85FY1Ce8RoG7XyFSAK4i1V5Lrknyl4b8To1BjCPuoLI2Gkylvbp/mmNonH/N?=
 =?us-ascii?Q?0vBfLtFiWdscmRQ7JMeB1J/r0LAxCyk=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9115d3a-4887-40e1-deab-08da0e7a5944
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 16:13:07.6580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fHDAd1kbfTzb8U2Oa4FUSpqf2qDvEQNTZtW7A/41T5ElIRisgkuM2oGGsrqaMHFvGwSc2ua+l/3b3q3jAzLECw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3938

This patch added a new struct member sched in struct mptcp_sock.
And two helpers mptcp_init_sched() and mptcp_release_sched() to
init and release it.

Init it with the sysctl scheduler in mptcp_init_sock(), copy the
scheduler from the parent in mptcp_sk_clone(), and release it in
__mptcp_destroy_sock().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  4 ++++
 net/mptcp/protocol.h |  4 ++++
 net/mptcp/sched.c    | 21 +++++++++++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2c684034fe7a..82b3846147a6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2662,6 +2662,8 @@ static int mptcp_init_sock(struct sock *sk)
 	 * propagate the correct value
 	 */
 	mptcp_ca_reset(sk);
+	mptcp_init_sched(mptcp_sk(sk),
+			 mptcp_sched_find(net, mptcp_get_scheduler(net)));
=20
 	sk_sockets_allocated_inc(sk);
 	sk->sk_rcvbuf =3D sock_net(sk)->ipv4.sysctl_tcp_rmem[1];
@@ -2817,6 +2819,7 @@ static void __mptcp_destroy_sock(struct sock *sk)
 	sk_stop_timer(sk, &sk->sk_timer);
 	mptcp_data_unlock(sk);
 	msk->pm.status =3D 0;
+	mptcp_release_sched(msk);
=20
 	/* clears msk->subflow, allowing the following loop to close
 	 * even the initial subflow
@@ -2994,6 +2997,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 	msk->snd_una =3D msk->write_seq;
 	msk->wnd_end =3D msk->snd_nxt + req->rsk_rcv_wnd;
 	msk->setsockopt_seq =3D mptcp_sk(sk)->setsockopt_seq;
+	mptcp_init_sched(msk, mptcp_sk(sk)->sched);
=20
 	if (mp_opt->suboptions & OPTIONS_MPTCP_MPC) {
 		msk->can_ack =3D true;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 9ad7d83767fa..b70582f9c3c9 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -288,6 +288,7 @@ struct mptcp_sock {
 	struct socket	*subflow; /* outgoing connect/listener/!mp_capable */
 	struct sock	*first;
 	struct mptcp_pm_data	pm;
+	struct mptcp_sched_ops	*sched;
 	struct {
 		u32	space;	/* bytes copied in last measurement window */
 		u32	copied; /* bytes copied in this measurement window */
@@ -618,6 +619,9 @@ void mptcp_unregister_scheduler(const struct net *net,
 struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
 void mptcp_sched_init(void);
 void mptcp_sched_data_init(struct sock *sk);
+void mptcp_init_sched(struct mptcp_sock *msk,
+		      struct mptcp_sched_ops *sched);
+void mptcp_release_sched(struct mptcp_sock *msk);
=20
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 1fb3dd24d6ff..5ccdb1756dc6 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -125,3 +125,24 @@ void mptcp_sched_data_init(struct sock *sk)
 {
 	mptcp_register_scheduler(sock_net(sk), &mptcp_sched_default);
 }
+
+void mptcp_init_sched(struct mptcp_sock *msk,
+		      struct mptcp_sched_ops *sched)
+{
+	if (!sched)
+		msk->sched =3D &mptcp_sched_default;
+	else
+		msk->sched =3D sched;
+
+	if (msk->sched->init)
+		msk->sched->init(msk);
+
+	pr_debug("sched=3D%s", msk->sched->name);
+}
+
+void mptcp_release_sched(struct mptcp_sock *msk)
+{
+	if (msk->sched && msk->sched->release)
+		msk->sched->release(msk);
+	msk->sched =3D NULL;
+}
--=20
2.34.1

