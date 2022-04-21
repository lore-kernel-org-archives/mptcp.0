Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF13F7A
	for <mptcp@lists.linux.dev>; Thu, 21 Apr 2022 06:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1650522168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=azDBSFukhtOfvTG7Dc0AEcJV1cfoZJDiJuywIRC9vb4=;
	b=X9sX1MURimF313toowBO0jGfuE6XWXY2wamooNGTTxKOutmXXcda6N93+CwZTE446qMKbo
	0ZZN6wnbVkS2n45l9AIL6vzzUsVsvqSqOJEsifTHOEiUqShpmvoEjlAQkZa/32YeBCJZPv
	mmYH2+8B7YZb1NsyDZM6Vw48J1kKpGM=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2104.outbound.protection.outlook.com [104.47.17.104]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-16-e88apHg1Po6S1EZIZDWOPg-1; Thu, 21 Apr 2022 08:22:47 +0200
X-MC-Unique: e88apHg1Po6S1EZIZDWOPg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FcNZA41Tq7yvGb1frfE2TvZ4W/xCQOjRYGZHIw+uxCUrd528XCluJT8yn1Pj7Bwu9igIcuY0XGTW7DzjmnhsPsrTAZMzmkU9nDEwvs+8IuZRZlN8Mg39wVGrniN9aZ0m8GlTipYWx4IhI/wfQRFlZUs66EB1Ba02mh0H7gsMt1P0BrohTNo4cmyFFzig5BpoDssCBfKIjFT5g9vGWdZfAj+jCrHArGfzCip/de+gEkdM8UKjHxJDKvE1xPAjXHXuMQno4GW3knQyXuqsOj4NoUd2370zcxzJtw4p3TsSNahJ+pEKf2aFJK3ghp8Ofc1FueyMRb9ocsB8NIP+euk2Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sclt9QV7fyH4N3cK/kAGFpSHRwRT4CfHEcCgesoNI0U=;
 b=IxCfnouD0qRRQmVb711tXIMOCjz2hzeH4SkC5+kVcjTyZ7FJjtsTDC6M4uXJ/bVU07ZcpHtqLDS/6p3cqYFm/XB3orb1b5LFIFzIdd6zDK/qCHvSX4gjoc8MWkmcNg+kSgY4OpRW41nMzqK+PuTPRfh5QstxkhhhDNS98DakRKD1dIxZ/KE4to6ZGfbYz9KtT80tK9cYtYwwYDToAgTszMrL0nd22dojoN8Xxo3Jq8Qt26XJE73Vdqwy2dvdl1zcG/TKsoslQbXxCRrGmYfBEeC7IUQZVKtE1Z9g+oXseNQQEh0vYvBVCXv9n69o1AbH5I6gIGRspIle2Ls2zabE5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7346.eurprd04.prod.outlook.com (2603:10a6:20b:1d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Thu, 21 Apr
 2022 06:22:46 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.014; Thu, 21 Apr 2022
 06:22:46 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 4/9] mptcp: add sched in mptcp_sock
Date: Thu, 21 Apr 2022 14:22:22 +0800
Message-ID: <85b04fec49ab4b081e9ccb030c8099f9d638a65f.1650521788.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650521788.git.geliang.tang@suse.com>
References: <cover.1650521788.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0015.apcprd03.prod.outlook.com
 (2603:1096:202::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 073a2af1-9383-4e73-ed0a-08da235f59e4
X-MS-TrafficTypeDiagnostic: AM8PR04MB7346:EE_
X-Microsoft-Antispam-PRVS:
	<AM8PR04MB7346280FFC6A4AAC67E1ADA6F8F49@AM8PR04MB7346.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JqkMuNA2pwtZGiM1ldGLMTiDVLbqv2z3GXFttEVImVzphf5jbOd+Tp5Ol3fs1QUOheWxFEajC7QJOehXT/+s6U6b3FoTo39pDEslyo9Uwb0N/5sIxyg4cQLaRVsj5sX2E07y1VAIsCrt7uNldfBWTqzXpIdss8ACYcg4xa/dQWdhgiYl1uRkfAz6h5CnjWNhZu/qCbXFiF81HxmbJp84oKSkNnx/eRDfspX/vCIfcZLXBvKTLC/3WZSjAkDrs9lPEY2WMm8jpFcRTqJbCg2lBsY3tKVKgFe+9ND+S9PK+zI73cr81zcekQJEGZ9d03kiuZuYD7qFhszq7lhaAxDgY6ViYvWVD89OgAtMf+luGUtqrzrVL3+8XiqNAm/NTXeiSUqcn/Fxlccft+zjn08UnzyVDUDMJ+bC7M9XB1UFe71Bj8VW7RPxGhFDw5WNXAfqckGjtN27ZKsRi9LvgwOMM+Hf4nN1R1Qd3cQK0AOTsFbklkI4lP9Ou8IqOz6iIvHXcoE6eeaML9qsabxMj52w4YZ7PSo5zAXzPTV1npD38E+sXT6dUoPrgWk+sijpenuSWYNEeBChLmJoIQRDzRu3sJoktzn2sxDkASnEQjrC26h5kmzZDm5jfZUfZq6MpFixZsYldDyUhFt5JLIeVWrjSFCEQUOMEoLlz7PRxOcYZCiQIhn/u9W5b111wy68XrRN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(107886003)(6666004)(6512007)(6506007)(26005)(86362001)(38100700002)(186003)(2616005)(8936002)(4326008)(44832011)(5660300002)(66476007)(8676002)(66556008)(66946007)(36756003)(2906002)(316002)(508600001)(6916009)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AGBcRM4r6GCx5GFOyYXgSCMR9MjK7poa/Cqkent1w2S2E+HDSTFdiVd8ANYl?=
 =?us-ascii?Q?WmRz8m0hmLKaTXlNJmOcacRii53NgZTnnYbfttosxhlAwDPl6mOaXss6mgBP?=
 =?us-ascii?Q?5zRyqw896n8cznYiJVBjQIPJcVQDGp2UYsgWrt1yFMHhwFeOht4fE3MfUEAa?=
 =?us-ascii?Q?fA1/jlnfUGGmpdtt5/hRMFxozA2ZL+NekWtajWQF6I14rFr/y1LrUBxscG7A?=
 =?us-ascii?Q?ytCkbVYa1hiqqQBlm0t2wN/Dgf2OOiANPlXBxGBqAKWaAh/S8HtCJN6hcOR5?=
 =?us-ascii?Q?bjxu1pdUKUL+DnqJUiCWSa4/CasD1MHnPNVsQQrNsbS7geM1c8QVGdorXdZb?=
 =?us-ascii?Q?iKFE/Yg+drKBOYdzkFPl9v4NgxcY7k4VdutEE6jN/yRhGKyplRfjr+JcOhdx?=
 =?us-ascii?Q?aqF+5gygaA7U/28dCRaWkcIvDJjci7Ostq2DJPz3mpzIIUyyX3kxY6Cj36mv?=
 =?us-ascii?Q?ubFujdrcRO+nqdr+cLmNv6h3V+fHtiUV87XnS+nlXEqGlWqhDH6TLxvTLLz+?=
 =?us-ascii?Q?omeD337ww9lP3kQ79mdBX46ZTRVhCPtezCyIGds+4A4uiQ4SDS4bvoZ7ZKSW?=
 =?us-ascii?Q?CBhIjVNSl8uTyYSP983r9pmqDJPtuS0TpsQaJoESf6w3Bgmf3tr1GjKceWFv?=
 =?us-ascii?Q?tbNWGfMCQm6pid+p/r6OocSRvD6JueT0t2C/9TIpzFosIMVouKeRBtawXrXN?=
 =?us-ascii?Q?YfAqZ/nFvHKjcy4i6pJgXrHQALnoDgBjvALSam1PV2rLeZrdLVBgdbvo/YQV?=
 =?us-ascii?Q?KySnpw1T+8g2h/0LrbbrjdVcQKeA9K2a8okyaeX8vxv+/adrvQzADzpBwBYR?=
 =?us-ascii?Q?FHRg1MozP6oW6ZVxRA1CD8IMD9ykDEpLlwuO4WEeGY2TI1w2y7PRBTYgRPM0?=
 =?us-ascii?Q?F7NA0WGszI8ut0g7NQa8pre8YICCvXnYZMIV8bRNIsfk8+LfXx3krghfFUBh?=
 =?us-ascii?Q?KvHUE+BanT3AZuqwuBjYZvKVGq9NnLK/2KMR+7adolLWvfyZLFUOTS7uqpAR?=
 =?us-ascii?Q?QiEyrX9yzezqYYXUI38i1b7F9g5dP0tiAu5jUr4vqwyQFL3KzJZa/leVVjZL?=
 =?us-ascii?Q?jzOfn5l0B6T/jOFWEzsgRRBUosh9VKSr9qrghE7ayaCOkw18TfnBWkio/sy9?=
 =?us-ascii?Q?PJbqgcON7SIOWuN/a5XQii7+qWzE+fVCU6rSkOmAy2Pz9EmpeD0EeHZ9QYCn?=
 =?us-ascii?Q?Qtpl/fl5TbigNekcmiBvY2ta/inHGiQnHGZmgyeaFKsO4fuPVrt5dtVsqdMX?=
 =?us-ascii?Q?2ZpGoMMLU2RZbBlGGWwwn62CSUDX8CIg6XclA/7E63nlbGwhcW0VCZL8gEtr?=
 =?us-ascii?Q?DKDONQyhyHHTc+H2YfD5tiwoXHC/+9XHa6fA951GbGX9R5lTw6iW0Cw8VuWQ?=
 =?us-ascii?Q?vfdKnn5QD+q0eqoAKr0tdOqffrKW956c2cpidrVT8qflrjXP6YBI8Ju9gKgj?=
 =?us-ascii?Q?SqBbB+1BB5LMjAv0yBtXaAVAYFoozCxyg0hXWkq4dyPCvUODgpMzjBb12ts2?=
 =?us-ascii?Q?RoCNjNh3jlMac/4G62IgJLYQMl7M79vfbX7Rsn3YEl3YqwfxGXp0NPS3lZtJ?=
 =?us-ascii?Q?II26DeYS36AsCZR+MxCynsWlHlF11deYEOaoqbaWamFjgpsYmCd4gCInnDc1?=
 =?us-ascii?Q?bPds+Tpg/QJ4dl+qcHLime2zBfZI/jC8hmfXhM14BmyN+XXl2OKdte+LkMVf?=
 =?us-ascii?Q?SUJTOVC3eJMVtR4r6YIx/RwYMmj5s8/Xw9ypLcPruF1mtZiuVBGmac69Ffam?=
 =?us-ascii?Q?XqDGJW+gQxX0DFdnFbfsKngDitLEKsE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 073a2af1-9383-4e73-ed0a-08da235f59e4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 06:22:46.6511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iHRhoeuUZGYNs08D40kqsN+xxKBKWbSMSZazkwYbsqlhcWdd6lKL/eVhXl0/cXfdcNgjMd3UMPAbcSXdr8bPkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7346

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
index 4a9a55c4e2b1..3a5189b2d9b8 100644
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
index bfa37f6b9063..427a42e04ae8 100644
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
 struct sock *mptcp_get_subflow_default(struct mptcp_sock *msk, bool reinje=
ct);
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
index 8587f951ccfe..81a9c5d91aae 100644
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

