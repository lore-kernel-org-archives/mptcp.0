Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBE7110B
	for <mptcp@lists.linux.dev>; Wed, 20 Apr 2022 04:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1650430648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=INtnfcyJZjxaHsi3lb56Xg8puY9zI/fDm+gY4YRaZV4=;
	b=Vuwz7v0Gfu/0Xhkk13YbeoUBtlBf0BkXcUmXVQmc0CB3WY1Tozm9YGvj7SqQE+wa3ItRzR
	7072DKkpK2estJBlyX1qqZb5gZVMecD1lodaBmpB6TtdHvy5uZ3wyqj8pTf10qgoLg24Lt
	H7qKWiImwVOC1UvdRQYldffJLW6bnW0=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2108.outbound.protection.outlook.com [104.47.18.108]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-5-ga9QdvmvNDmUIpuVNLwA_Q-1; Wed, 20 Apr 2022 06:57:27 +0200
X-MC-Unique: ga9QdvmvNDmUIpuVNLwA_Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJtN84ps70CRPXvY5W5jBeoSnjU/14CMP9SkBa6Pn6fE7xGD+ANG2DHX4bzEj2AJBM8OdOxJMNaDWCQ9GUlHvD1amwdhyQghomC1iSMWNRteDP3CqfJ/WhPwUUrgk8I+nUNAxr85/Y+h4XOwG5ThEHDuWjRFKI1YddroXhpiJLGz7MSSY0MdlhafCmZhUqSUjWxjlJJb/29Xg274cYAR9t1yzGO7PbJ4wW3J7lOKvT3svam1pZeQU6dW9SI8ZgO9uRIHbQ9tBYnBYww/BZRguFErcVYA27Ej23A/T1XS7DWGjlE7OwCGmbo8KSjI81X3H20S7Xcq9Rj/kXqG6lulxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0tdVuuczTx3NtTNG3ARzlbLUn7dqST0/Kgb8AkIMCSA=;
 b=EvWqc+Hn87FFJTEAD+4yMwaCctqLwxgfKrMXWmGd6Fd957jkb6G0bbvMtiPDXs5EUFGM8jXe040jzPF727iep6+XA1riBYgMQKYVKjfqreisofPNXRr09fLc7jbqBRwz4QyZZ9Q9KjcVADq3pyDGCxnMQtXFWFCvgBCnsdvtICwi1Tsw+ldOdtECEpTKW0qDlx5nqgDCPEHCY0uC21wFs+B5AosANs/Jn+EAD0qAMqRXuc7XGxjGYha/iCgWqwUshbrAM1cMKDkLKmFf27EUSzhXHScqbjiWbqjYn6r3UzUN1+I+KAy5uCnDNZ0kp05p02JMkZB50K81m0Oc7fEJXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB5752.eurprd04.prod.outlook.com (2603:10a6:20b:a7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 04:57:26 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.013; Wed, 20 Apr 2022
 04:57:26 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 04/10] mptcp: add sched in mptcp_sock
Date: Wed, 20 Apr 2022 12:57:03 +0800
Message-ID: <8b5f84ad8419d70ead8837433d2e43f14a55cabb.1650430388.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650430388.git.geliang.tang@suse.com>
References: <cover.1650430388.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0199.apcprd02.prod.outlook.com
 (2603:1096:201:20::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a20351d-b305-4783-596a-08da228a4372
X-MS-TrafficTypeDiagnostic: AM6PR04MB5752:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB5752D27EA1A494FA180FAF99F8F59@AM6PR04MB5752.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2c7Bu3iHctANkciyw8PMwLbkc5Kc5dDmUuZ60SIlrFCwdASPOrc76EHe2GiXncknnRGk791RHXCWMsLUrVqP992TkLVIwUeY0uzm5rM+Zp5+wAqbORd9P284+t+sws8DeXkNmXc8kES6loDqZMCej8lB6KW1XvMGDR84zPOmujyLeJx43HyApUQ0AHMk10bc09a2J2NcRBSEfpLk6UKGtR6n5FYAzm+bAk0VAl6lHKaVklFGhfU5lksJKl0VgdjuhRgp5ZukjmHhdpIMJM2Zb+PwAGP3clRK8S4OQAfYrh41WmJvuQfonLYicsdwSPCTPWzp4wr5ZIudX67YEyeH2NiFef87zKFMlRLE5A3F0PL3o34zZLTr7S2Nw9syjjRVFyBYFE1Bxb71p2u0uh38v/NE+b8aQbEptCUNrwLWOTzGSZNH4JGp1/wpMq9vdWAhXIZPJNr9Q/X+J8j1UhTcNz+M9e7+vcRMURthmbnOobJYaHZBBIJNShQvOyLmlvV5QS+EVWz41fCUzGoTdW9ipi11IZZ19xnDBbdquxSn+IdmV+VhEM+cWvry33yZmpMaDPB5skqU9AOATXdA757Su8VMv8yszcNakQ63sAYPXFgewQZ9ADRHYadZVWMV2xBArUXcjYMXHE6O7PK5Z1wIzyHbwUJ4Gj1CnuNSPmodg1up7579ZaqH9G+LVWgMW9Rv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(38100700002)(508600001)(36756003)(316002)(6916009)(6486002)(66946007)(4326008)(2906002)(8936002)(6666004)(8676002)(86362001)(6506007)(44832011)(107886003)(6512007)(66556008)(66476007)(5660300002)(186003)(83380400001)(26005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PQespZunc0z+CTaMKHxG5bMQ0QVBnyK0ZLZibxYvZwkyscyOqGuQviVvbH1p?=
 =?us-ascii?Q?MPPv+spv1Ipr6rx/L/ZQORdIF5PZSTvjHJbTVbmE7SdQJVoFzsaxhhEkOgt3?=
 =?us-ascii?Q?8r6n1gmJ4xjiNBeJTXaAmhT0mus+FvnDgNBos6Lvf6ZrhyiHe2rJpDPleBjv?=
 =?us-ascii?Q?IkpPhzeRfQIZlqaQjheKGIDCi5G8x8EtwWs00qldULshhspqv3bSjSMhGMsn?=
 =?us-ascii?Q?/CnwBZLPNoZI9I1nsYpD3uSIZzAqss8IDdcMUAZ+5Kc30Pc4htowlWItSSfe?=
 =?us-ascii?Q?auOT7ycU4sPjE2zcqNNXbDsiGXdnNa3kV+SXE4n/oVuRZ66juqJ9tX3UnegR?=
 =?us-ascii?Q?jRbFGjsZO+AQh0FHGbDzqkP/qlaQsjYIaYZMO2Xr53/sf4tga1NTka3IzQY8?=
 =?us-ascii?Q?RdBABUOnpuR12qH8fi1EraSmT5VadpObL5Cq6ccLPNxYmzStLfse+UjRFGek?=
 =?us-ascii?Q?A/aJSahba2VAjlckNXl8Swv+PoH9JQy1ed7OfyYwtR2ys7US+mB+zfqGBjR7?=
 =?us-ascii?Q?xj05bRJdwkRgyxD9K84qqy6mNJZE5I4fPtB8ewc3LoINridlCNgZBAVxBIYy?=
 =?us-ascii?Q?qFfICcDRWlF5e2Lkj6ibMfmwLNhKfdd6PMAT1BMYafcLSllzOyLcB3BWiMsA?=
 =?us-ascii?Q?78oLVRZ1Ft45bKiFMERJ/3hM7jrzbXnQHT/QEVJQvLsLnYcV365Qj7CFj44X?=
 =?us-ascii?Q?J7H1zZ+D6hVNNFlaZiQkX4/Zngy9nkL5m+s/iDr7jUnZSoHbQDV9H6yd7EBR?=
 =?us-ascii?Q?+0ZCGoclTtdxr28jUv0WhSXxpXZ9lDHsTGjikTI9dHn2wZEJH0RnDRWPJe3e?=
 =?us-ascii?Q?bNkMxtBFjcId3+8WdT2tf99wwk8HbkDN7w2eNWbThUGUOJmcgAW8BVlGaJAN?=
 =?us-ascii?Q?AgP1r5GkdGXOyob1UK3pWrfFLkhJI8vJp2jz/GbwttzDc7RXeey6bvM3aXZw?=
 =?us-ascii?Q?cZa+ywJkkGCIIVRtdpGGs10eAfN1AmXqx/a0kf3IsoH5uuPCejvuikXX1+/H?=
 =?us-ascii?Q?68YmXLQQWj3KWJLSxx85h4Jh4nvSuZFPCUilyepoMzyxRuCCgQVxq5Rt3npA?=
 =?us-ascii?Q?SSly2O4t2wI9kB+JkBjNWc9xgfwWgv2usYxs0d2c1k2sEvNXjvKljtwNlqO6?=
 =?us-ascii?Q?aBecZ/qCUpUvIUNKK4wWA1AP2e8WOU/pUEPRNS6PgUdiB2G+N+m+2pAHEAhl?=
 =?us-ascii?Q?yKK+1jMb7caaSJB3Zl7izMb+bYgIGcpONSkUhLzbeDhUjhcTM0Cksn4P4MLb?=
 =?us-ascii?Q?3+f/d2OvzPC/kslZJjj2zSqLltQkf2qHdnIysH6RyqnHcWpTHuGzqhMnwwBY?=
 =?us-ascii?Q?FA3e1zkVAc3emIWzo28SUVQDev5ZfG9nnS73hR1jr7BIGluhd/93elFF5atK?=
 =?us-ascii?Q?sPfAw1jnhd8XUCB7KChv2E/Chev73mfQFb3uAUD4S7Ims77CctPAxk5nXBAK?=
 =?us-ascii?Q?2whWF401Tu0Aog5tBSYvT7xfJbcnzau3eHjCCoD5WEAoqhHfgoAJwxncKOHH?=
 =?us-ascii?Q?vdmPEs5YSJ8dooNnMAd7xrPrZdO26p4wen7Ge7ZMVCudl8dlocXjUhTUqJsZ?=
 =?us-ascii?Q?iNo9KTx+Ad8iYNsOYfhkYEJXBx85+KyMbDdAeg9+VgAWe8sVe4SgBxDp92RP?=
 =?us-ascii?Q?EiraDgUZu+O8LpEAZ0OAOhMkE9DRwHFSZGegddXGwE8kXTnjxGTzhhuK34hZ?=
 =?us-ascii?Q?ihUaNWf/maM8XDs35OIqA36R8pwTNn57ZqGSF3cVIpDLjl+IsrVDwsEoypFj?=
 =?us-ascii?Q?D6OIab2BdZcKqWD7QsR0JPDezWZcxPw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a20351d-b305-4783-596a-08da228a4372
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 04:57:26.2026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6POKv7GXFjt/gJsIlo1GXMMSrGto4VJhfextkRBUytk85gBrP3KgB/jSy2fRZV2nhAOtBurfo6R/YxX5qAqz1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5752

This patch adds a new struct member sched in struct mptcp_sock.
And two helpers mptcp_init_sched() and mptcp_release_sched() to
init and release it.

Init it with the sysctl scheduler in mptcp_init_sock(), copy the
scheduler from the parent in mptcp_sk_clone(), and release it in
__mptcp_destroy_sock().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c                          |  7 ++++
 net/mptcp/protocol.h                          |  4 +++
 net/mptcp/sched.c                             | 34 +++++++++++++++++++
 .../testing/selftests/bpf/bpf_mptcp_helpers.h |  1 +
 4 files changed, 46 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8679289a8394..3d50c35c0b33 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2665,6 +2665,11 @@ static int mptcp_init_sock(struct sock *sk)
 	if (ret)
 		return ret;
=20
+	ret =3D mptcp_init_sched(mptcp_sk(sk),
+			       mptcp_sched_find(mptcp_get_scheduler(net)));
+	if (ret)
+		return ret;
+
 	/* fetch the ca name; do it outside __mptcp_init_sock(), so that clone wi=
ll
 	 * propagate the correct value
 	 */
@@ -2824,6 +2829,7 @@ static void __mptcp_destroy_sock(struct sock *sk)
 	sk_stop_timer(sk, &sk->sk_timer);
 	mptcp_data_unlock(sk);
 	msk->pm.status =3D 0;
+	mptcp_release_sched(msk);
=20
 	/* clears msk->subflow, allowing the following loop to close
 	 * even the initial subflow
@@ -3001,6 +3007,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 	msk->snd_una =3D msk->write_seq;
 	msk->wnd_end =3D msk->snd_nxt + req->rsk_rcv_wnd;
 	msk->setsockopt_seq =3D mptcp_sk(sk)->setsockopt_seq;
+	mptcp_init_sched(msk, mptcp_sk(sk)->sched);
=20
 	if (mp_opt->suboptions & OPTIONS_MPTCP_MPC) {
 		msk->can_ack =3D true;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d05dd2e2d05c..b06836d1a899 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -298,6 +298,7 @@ struct mptcp_sock {
 	struct socket	*subflow; /* outgoing connect/listener/!mp_capable */
 	struct sock	*first;
 	struct mptcp_pm_data	pm;
+	struct mptcp_sched_ops	*sched;
 	struct {
 		u32	space;	/* bytes copied in last measurement window */
 		u32	copied; /* bytes copied in this measurement window */
@@ -627,6 +628,9 @@ int mptcp_register_scheduler(struct mptcp_sched_ops *sc=
hed);
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched);
 struct sock *mptcp_get_subflow_default(struct mptcp_sock *msk, bool retran=
s);
 void mptcp_sched_init(void);
+int mptcp_init_sched(struct mptcp_sock *msk,
+		     struct mptcp_sched_ops *sched);
+void mptcp_release_sched(struct mptcp_sock *msk);
=20
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index bd0beff8cac8..8025dc51fbe9 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -68,3 +68,37 @@ void mptcp_sched_init(void)
 {
 	mptcp_register_scheduler(&mptcp_sched_default);
 }
+
+int mptcp_init_sched(struct mptcp_sock *msk,
+		     struct mptcp_sched_ops *sched)
+{
+	struct mptcp_sched_ops *sched_init =3D &mptcp_sched_default;
+
+	if (sched)
+		sched_init =3D sched;
+
+	if (!bpf_try_module_get(sched_init, sched_init->owner))
+		return -EBUSY;
+
+	msk->sched =3D sched_init;
+	if (msk->sched->init)
+		msk->sched->init(msk);
+
+	pr_debug("sched=3D%s", msk->sched->name);
+
+	return 0;
+}
+
+void mptcp_release_sched(struct mptcp_sock *msk)
+{
+	struct mptcp_sched_ops *sched =3D msk->sched;
+
+	if (!sched)
+		return;
+
+	msk->sched =3D NULL;
+	if (sched->release)
+		sched->release(msk);
+
+	bpf_module_put(sched, sched->owner);
+}
diff --git a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h b/tools/testin=
g/selftests/bpf/bpf_mptcp_helpers.h
index 8d4e4f08d327..eb51fc1f54d5 100644
--- a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
@@ -23,6 +23,7 @@ struct mptcp_sock {
=20
 	__u32		token;
 	struct sock	*first;
+	struct mptcp_sched_ops *sched;
 	char		ca_name[TCP_CA_NAME_MAX];
 } __attribute__((preserve_access_index));
=20
--=20
2.34.1

