Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8DB1391
	for <mptcp@lists.linux.dev>; Wed, 23 Mar 2022 09:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648027776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zrjfIdT4p9oZ7ZSa95HmOvm9+2EPj5oac2eeNaHFfik=;
	b=Zpl9gb4b1wbMVhmTyv8CKHOdr2P9E9xnNiTkRbuZRo9MehDC98B4YwbyOVJEoJnlBD3dfn
	2Kj18o7/cxDKrZpgRbLYMDRwUoHxUtw/AMl8uPv6zVCPuWQCu+j/+HMnKpUN5YBP2TouWJ
	9gVfhLJEox0+fRopGy6riJ7ZqRLQMNI=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2057.outbound.protection.outlook.com [104.47.14.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-17-tlAnhAR8NeiX_X0vgTpbnQ-1; Wed, 23 Mar 2022 10:29:35 +0100
X-MC-Unique: tlAnhAR8NeiX_X0vgTpbnQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPxCSgTobcUIslce+pyFQlpFh3vQhw1VwOf5jiYjcyc8FZ5rpQPcoaFu4GQL4An632RWgz9Uv0l8grahPM6XCeuYDWiK8XZS4JOLEUeFvkcmv5LBFlQHI6U8/ptyUiW9xJbGugbgt46Zc63YSdkKysFSCg5qFSL31ticQUmBjsYgLS6LF3Je8F1nbYXjBaJdiphPn3JbaDM0ptsVzJGmlwMe3ZAaJrJYhoPxrkB1JjHwaPyF7enOtWMtistRJ/7mJGjRURmWnxZ/nd3/JD+e4o/KE1xCICrgkwMYgt5qEnPMPP0pJqUw+6Ya6ZcwsijIoNYdo+57cgHXnlKvT49Pqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E9i75V0DyOfyw0OYUYar9BQ8bjd40BpFos/j68qYDio=;
 b=kTJdCeR4EcC/BJkKFjVzufdm5VJhzEITDpG+S7NeRP4QGJEijzVF93EZU2RlvBvQUxv5/cgjqcJxsE+9Dy4UVRt9zJdSPCizH1E/7xwnaF7YtqGYzo1zUuuV+6+7TNJhV8uEIJNDHRrcRT8JeCR/WB+aMGw+WRk9QYIQGbg3r9BhHYZA33vZuPFMh85wot9GX21EtdyWDXEGA8GCBpa7CqYkxy4//h35IHUhP9klYwFQUGGCrrUjx0siFoc5JLkq2LsHuXCmSQdUUMNl5ODOF1N0a+sRJ6C2eAy1fpnRl7CIIyh7XFnHPDseCF31WGLOtH1EqZiaJOdDYQgeEDZSHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VE1PR04MB6733.eurprd04.prod.outlook.com (2603:10a6:803:11e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.23; Wed, 23 Mar
 2022 09:29:33 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 09:29:33 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 4/8] mptcp: add sched in mptcp_sock
Date: Wed, 23 Mar 2022 17:29:03 +0800
Message-ID: <4aee9fa6f5d21337cf826463d5c9f92ffc1ba5c0.1648026806.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648026806.git.geliang.tang@suse.com>
References: <cover.1648026806.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0069.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::33) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5504a7f8-e02e-4454-30c9-08da0cafa3d3
X-MS-TrafficTypeDiagnostic: VE1PR04MB6733:EE_
X-Microsoft-Antispam-PRVS:
	<VE1PR04MB6733782B0FE402A2CF3885AEF8189@VE1PR04MB6733.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZEnB+hiDzSzg2aSI/DE8Ek3FpWUSx5FSetBDJjw2DtTrf4kt/WD5BuU0o8jDmS1FhkKanMCdETO5idfc+inRI7TXnlsoQrXZAKUD7VITACgtMfxtUk5rwqdt+sDtU2zlqewVPXrDdfVKZp3HJiR4qnRwOE3A73hRKZNqCERsa4WQxkW12YToYUXJu3WnaLJDcC31r/K4Ez3ZcvjZqhWUFQV5rApI3DW1C5cI+3EAPCg0r3axVV7UBy7gaKF571x0U7nWGyA60Ciu4zJaIHSIG/vvyxOwO+6A+Unb403VNQ6MmpYhds/yXosZN5GY7WG2Ufgg0+XV975N1VyXC/eGtTufVgI94YTcRWCcyjrWstjfUaGHfuBfV1rDYH0TLdWeuqweWxK03mglh6f313UdsJtKtLseXUVaDzElESB9bPML4q9RzEOw7A9jLIYxURKeSfsoozOe11qjapCa0Ct0v2xvXA5UNqmZaVSZTb1+TXbcPh9weypBnV2uMgiCZO1S+BVkALDmjwKvopZ8HmAH91nap9/rHaDPNIA84irih9z0vicndOLHgrI2FtwCJ+QuNhmPiVQNHLndHupU3JlKjh7ivg/TJbdte3prrOzEQlWL+rYY12Ca0EbjS2S0FyxY+v2kkA+tRqlF+8fzHvpBCrQ4S4qVr/ZMCtJ/i4TAK5CqhdxgcWkCPCKILC/OHJNbburxhhkmLzgf0WpcOXY3lQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(508600001)(8936002)(83380400001)(2906002)(38100700002)(6916009)(2616005)(316002)(26005)(186003)(6666004)(107886003)(44832011)(66556008)(66476007)(66946007)(8676002)(4326008)(5660300002)(86362001)(6506007)(6486002)(6512007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1FqaAitlvkfjKwW0pxeP6T09oS4wSMjehOKd4tfZZmcn15mESSEOvCWv9X8D?=
 =?us-ascii?Q?mcOSMsHzAstxbmWi+m39FjUZ2RPBsuQLxsNFaFwV3hW1/p8TaR3PH9GU6XFU?=
 =?us-ascii?Q?Zg9I+8fZIDtd9CkaRJBJhRJIYlbDruC4PAG8nTXIk2hi9tEwkGayV7B9bBLu?=
 =?us-ascii?Q?cNlQhxpotuOw8OwB6hxC2y2eVYaEForcwCOEZbRnkKOzIVppb2/9ITgEU3v/?=
 =?us-ascii?Q?lusbrP70wRrcxI8rs2YipJOnNKIEcBo6Tjd+F8qXPWHIZ9EpOX30aBwfOglu?=
 =?us-ascii?Q?s04X9LpJhg9ic41difiXUn3y8DUDpJG2NfUzyDC5yX2kafMU7bV4tIOYChNQ?=
 =?us-ascii?Q?9gaVTaTBYLT+4Nnr0XEl6oAefKloj/iN2VqJKVGlLH9n9VDr+pAGyo7mEvTS?=
 =?us-ascii?Q?SeabJW83zne6lyYHivu5GyDZO/LgLvEWpltUmdelY9frOJUIZ2SnP8th2ZlB?=
 =?us-ascii?Q?xX5of3YwymyZd3DR4BvBynnHRWKkyEdqR6DgLne7DsH4RtnF7obABZGsK71/?=
 =?us-ascii?Q?gdyGaFtVbyzGOra3pK3DXVE3bYREZ7PMPenFdT6ONzDhM8I0qzSnqR59qdFp?=
 =?us-ascii?Q?LLL8lqHovB495reGhmfS6JguG936c2UxaVNL1uVtt/RqOiDa3/VF6wm/CmFy?=
 =?us-ascii?Q?igzU3blpQAoJDsVWDzGGw74X7snfjDClwexJybTNXcJoy5x+c/GRJ9CrZjIL?=
 =?us-ascii?Q?04oONo3X/FFpg4MxaF7lvpdHy3r3bNkU18WNNI665MTbK8tncDTJgS++k9MQ?=
 =?us-ascii?Q?c+FLrm4r6wwOs+NfQkllz1roSPPWsVMXavV709VtrS0FmHnP8A7zEr0CrhI4?=
 =?us-ascii?Q?PuraIqYh/r340t2F5zTN6NJMeLES5tBq1QBpMTPPrna8lzEU20KF0hXm1Ra/?=
 =?us-ascii?Q?23qEzRNe3AWbv8+sNmPU2P99dFu0DXsIrxr8DvQcMprhpkeRkM6N7uNqHIi1?=
 =?us-ascii?Q?RX/t/gb0AUFSf+Y6FKAfbYjPYnvtsn04HEnEZoD88x22cRAaEgJ806vkfbOD?=
 =?us-ascii?Q?4KeVY3M8501mx9nYudSVinFzuIcr6rZQD6UmsxCgZHOJK03vkeD861eeJoXn?=
 =?us-ascii?Q?pLDMQoCkgtLM+D+NK7R3IGDcsYobbN7EEEVjtkAzoiYtx8nIChFvD46g7qPu?=
 =?us-ascii?Q?UjujzpYSo45L1N/2rlrRvwhnViPMlUGQZXOQE4Fs0dUO/Uu4+w4iTKTSqH/b?=
 =?us-ascii?Q?A3mtU8UiVnUOfKPo8Zc2165YZvRrTMpt5fL5aqebOyZ1DleZ8cYtzV9KhSB4?=
 =?us-ascii?Q?335UtckIUVZHEVRJ0IsllG5vL51JaX43iBkykU6bXX6l1p+7EL8zPZm8XPwm?=
 =?us-ascii?Q?f0oHMVraJQzc5evhn3WawOJ6CDdKN17z2IUnKhKJaLuV5PFnO5RqmtS/7nFu?=
 =?us-ascii?Q?5L30xMGnnUgo6ja/hlmIpNjgm5sgf1SCR57FE8B9hUzGJ/aTQSATXnWx+n3u?=
 =?us-ascii?Q?LPE24xCRSRdmnjKMg0rSVq394VV/insH4vtyqZfX/oscRRePJGbzMg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5504a7f8-e02e-4454-30c9-08da0cafa3d3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 09:29:33.6651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GKayZaAmfhzd8QEP1+EuIdrSgw8PJ9z9Fch6qVSfx7hlfol81Ham0OVgdjMfMk+AOrgXKGXu70T1VFp63NKXbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6733

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
index 11e19ac9d5af..c309922bdb66 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2609,6 +2609,8 @@ static int mptcp_init_sock(struct sock *sk)
 	 * propagate the correct value
 	 */
 	mptcp_ca_reset(sk);
+	mptcp_init_sched(mptcp_sk(sk),
+			 mptcp_sched_find(net, mptcp_get_scheduler(net)));
=20
 	sk_sockets_allocated_inc(sk);
 	sk->sk_rcvbuf =3D sock_net(sk)->ipv4.sysctl_tcp_rmem[1];
@@ -2760,6 +2762,7 @@ static void __mptcp_destroy_sock(struct sock *sk)
 	sk_stop_timer(sk, &msk->sk.icsk_retransmit_timer);
 	sk_stop_timer(sk, &sk->sk_timer);
 	msk->pm.status =3D 0;
+	mptcp_release_sched(msk);
=20
 	/* clears msk->subflow, allowing the following loop to close
 	 * even the initial subflow
@@ -2933,6 +2936,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 	msk->snd_una =3D msk->write_seq;
 	msk->wnd_end =3D msk->snd_nxt + req->rsk_rcv_wnd;
 	msk->setsockopt_seq =3D mptcp_sk(sk)->setsockopt_seq;
+	mptcp_init_sched(msk, mptcp_sk(sk)->sched);
=20
 	if (mp_opt->suboptions & OPTIONS_MPTCP_MPC) {
 		msk->can_ack =3D true;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ffe7e551ac84..9441a510ec6e 100644
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
@@ -611,6 +612,9 @@ int mptcp_register_scheduler(const struct net *net, str=
uct mptcp_sched_ops *sche
 void mptcp_unregister_scheduler(const struct net *net, struct mptcp_sched_=
ops *sched);
 struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
 void mptcp_sched_init(void);
+void mptcp_init_sched(struct mptcp_sock *msk,
+		      struct mptcp_sched_ops *sched);
+void mptcp_release_sched(struct mptcp_sock *msk);
=20
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 3ee23b24b771..9ddfeb553c78 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -119,3 +119,24 @@ void mptcp_sched_init(void)
 		panic("Failed to register MPTCP sched pernet subsystem.\n");
 	mptcp_register_scheduler(&init_net, &mptcp_sched_default);
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

