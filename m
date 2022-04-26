Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB267E
	for <mptcp@lists.linux.dev>; Tue, 26 Apr 2022 14:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1650981679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7IQbAaZuItqGn45zdY0b7mjJfFznzVRLGHb6Y1LCFzQ=;
	b=ea+KJdJMO8Wia5i8EzIm96Nakse5p56Ag8DwOjGdGrSkUr6nFq+A45sTJHcEoGhCrtLj4C
	PzlBwFrWzB9l1/vljQmXKJU7svkurqdo8VMzB7XbFd9Ul4+UmFyD26T00bqr2CL8vxIfJ8
	WwOefieNQ7Fq8rhu2CZSOSWQGY07UA4=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2055.outbound.protection.outlook.com [104.47.2.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-11-kZonh_ciMJe1PZRxXEt0oQ-1; Tue, 26 Apr 2022 16:01:18 +0200
X-MC-Unique: kZonh_ciMJe1PZRxXEt0oQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJcVdLg5Se96IaaMcCOeidbsH4F/2TUb4cA7SI9i4B5VNMJ0So4rTVAhjafcyoMlJl8EED+RzHcYsfQo8fpwz7/wZoSS20Yq415QmfWbFf3JBS5rch6zHPH4k326mJmWveGp8gqZ65+pA74Mu4IJNyCv92pAAHHmiga7ilwpOI+c1+gUv3DzsEzUplobeGIaz4a+SYSYLo+fzZQwXqfAAamRc1Fwe2HU3bEMOGJki/6mHjjL925M+SkjxIThtpd5vs9DtRui1K/iWdxmOeLMmWrC4iBypfYg1KSJKst+PYu2KCk4PPmFs9qRHyKgAk9T4cLkdPLj5KmWPirNCi9qyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oTvD3U+uuqWmxLTaY2GW03e01TiRVRGWjWeI4F6geis=;
 b=Pi0FsauW2raodhkoypyiyiGJ2aymFJKf/Vun8IeVurJth6X8zB5bjLYuh4erGA3x+EBIppte8d1vkdpocCFLcJ5y0H+r4luC8DiIQZn1uzG53TRXhEHbrC6ui64Je6HTWKpoMUKC7QabohoDDM5kmT67AX5JLXzTGnIOLnEhc09mLPvBWu6g8sQLkINtJEHZf6zzMTCbspF2Lb33mUTC4XgndLH6y1hpH0A9S4uxtx0+4W0ezHSvSvOx11pzcOgpI0/G4eJthRaqJ1kMJKBXm/BdDGFaQ8gfnYyGUxv/uN/9yFDrcGaMinnaYPr5KsYbdL6/vV+RiZrq4u/zhuWyWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8816.eurprd04.prod.outlook.com (2603:10a6:102:20f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Tue, 26 Apr
 2022 14:01:16 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 14:01:16 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v15 4/8] mptcp: add sched in mptcp_sock
Date: Tue, 26 Apr 2022 22:00:55 +0800
Message-ID: <50efb6a21637218d86e1e9a990a6bb6a42f3f5d8.1650981078.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650981078.git.geliang.tang@suse.com>
References: <cover.1650981078.git.geliang.tang@suse.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8294ac0e-662b-497e-cdec-08da278d3b64
X-MS-TrafficTypeDiagnostic: PAXPR04MB8816:EE_
X-Microsoft-Antispam-PRVS:
	<PAXPR04MB8816AF56AB4DE809822C35FFF8FB9@PAXPR04MB8816.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	34LXH2ZrOZ/kRqct8LfxQKj/p0AyRRmlMbiw0jTEpViHTcigvx56ohxdUrTWBbnQOqtE82JiVIeaRvxg+a+KEGvkBLTs7kmMNlBJqFfHjP8eY8Cotk9KRLtpQwFD70AjDJgA1jyaX543CFdwoRPrVuiYd2hpTqTq3HUvmjZBeMfGznGZNwE2ncJ5kseU7RdUpGhP73jOAifLEHo+LKm+6GQ+63MAClXyTXsIlnhvNdyIZdSWgEP1taQtFpdKY+vezx1PJ4FrnzB79tfxfV2OjiwegX7lcI1YVbZ+L5QarJLxoUZQ2acNZKh9B8D5ae04K3VwAcLPvDpMR/Oj97Pt/dyZ2tKQuKTj2kdhW6MbtX9nKXTVDM6yIl4UiGmIdsnDuKOU1W0gsTCmDvXXI9tKf7Alq/ainkvccwdCsQdIBojgONzfiYOuoxQ2h4N1TyzwnMjQrOUwCRftM8NkjNAAhTlG3Tt0R6cnVxKLE/hXJFYDkBWteAr1JIJGsFRk1MD1PJZyHRjh7LPt3SxiGgSl+/x474xJzrEgGZpqaVKmmNHX/cz7271LlGvNepwkXPKHIowXMQ5eb+9O8lScFmI2diJV3J9WGM9QFG+DFDbhYqKmAVexcSScgSZ80WM0VHGNFWC2YS+LxnntQWeojP11Rm3c/AFmjizM43IsIP6HmmSrMxOHbXxcp3cwCiARmE0p
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(66946007)(8676002)(4326008)(83380400001)(107886003)(2616005)(316002)(6916009)(86362001)(186003)(508600001)(6486002)(6512007)(66556008)(6666004)(6506007)(26005)(38100700002)(8936002)(5660300002)(36756003)(44832011)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9DnjjSnkwLNd2tm1UUxdlQihydf/QYkYrDrnyzOTAJHnHUGhL6sDZkHcGWEL?=
 =?us-ascii?Q?ihezlA2em6f6WKntx38hoW3CS+BWdeWMY29deqC2VVOC6tl2Z5SJFg81gLAu?=
 =?us-ascii?Q?dwvG8R2KTCHOf0R4ufSV7OgPaxpiYfpscsayDL6Wrsy9O6rkPKrU0qMYci6f?=
 =?us-ascii?Q?AgDQDGlSTbFg7A1VhyVPbRVx9a37X7OT1XeP+Aq1PYZYAAGveUyBVT8iWvNG?=
 =?us-ascii?Q?NgaCygAfn1ATGdKaTExmW9DBmuYXrjPxFKVVP7TEPqMGZde0xQcAYVMWvjz+?=
 =?us-ascii?Q?VjFsURpMv8rHJL4AxU6HR1Lvi18EUrAwh6DMg0VhO1AfOgOLnX3JRt/wtR3c?=
 =?us-ascii?Q?9yHy7ye2hGnDmKlf1c3uxt6LfBSk0kKAd0wUzwRutSes9yXYF9lqPSBTSwWJ?=
 =?us-ascii?Q?avWJFuQP4LAROG8eVkrQwCqWy/e7iPXTZhY27zsWZwssAUnWXPcTRftfe2mj?=
 =?us-ascii?Q?xv6Mg/iLU0xmWsGb8aJ0Cda+8FgqASOmNgcbERMVvKcL55iMYnQQ/MEN+ozo?=
 =?us-ascii?Q?D0PrtvjlyWVHHjLYcTFk88iAhQMHBLi9c9I3HHKgch/tqdG5YznPibE9ckKP?=
 =?us-ascii?Q?5Xfk0cBN8q/5MhZMCfOvlRD/X0EjZg6BpbzG2ecTlajb0SwmNf/RVIPV6PO5?=
 =?us-ascii?Q?UpFwDtGyzaOE7Qo9CmLdhi+nOgLCKPew2iKBBxA+9CPiKAwApKeCcnn0lQoc?=
 =?us-ascii?Q?/KYYRUgzb0Wqi7g6NuJ3ZfG4H9E7Gmjv7waIz0lDOgB0KJBd8apJKml3FzgY?=
 =?us-ascii?Q?QlWojPxuOyy89XXouMDAkmaQzaE3JWWSdxn84Innlo2IiNCxGrJn9e+FNjri?=
 =?us-ascii?Q?1kMDgQUAK/XFUMMTaRhcUxELrPH39x9mMrqMVPyP7cA8IR555kz6dtx5S7ea?=
 =?us-ascii?Q?IOdsmEOsDnHwHhYnZo6pTIe+gZwvxT+qI6MsMgc65xzS8VH9DSmdoB5Pf4gB?=
 =?us-ascii?Q?c/U6tvWaUtranl+Sw7SaRhTYhITqLxHzvynZmSzbdu+U65kA3SIBVOtCDpyZ?=
 =?us-ascii?Q?/pz7M96zdYP0luupqnZp7tvOt1NXsfHmzSFXuPhlDdWfCWo0cV2Yv5VT/rOx?=
 =?us-ascii?Q?vi4faGZqLbXM/HeYgel9Z1bgdCLBgGxreC5XehQTOXiWrRgjMkuYOOCp4y5o?=
 =?us-ascii?Q?/u0mHfPlNhRD+LhyGaNp2trKBQ0/emIoxAKhd2s/rio46fSaQTYRuizWy2Yn?=
 =?us-ascii?Q?jn4+Eh3fYHs3wUdF4xPZTrlhwQlTWR6vV9r/YSBvgvSVZdgL7nLMz+BCyKCZ?=
 =?us-ascii?Q?hiENpCGRN53EPVDJU/oFezX32soMullgz3hb8YBRTJtzyOXj8kIsS8fOIfzl?=
 =?us-ascii?Q?kumObPv8JxbDM9RVEIM0eHawsCta3FXb+qy6KhB5E+ojxI3qV9ploRIJy1bt?=
 =?us-ascii?Q?iakmfjjzFi6jfw5nc0lPkUJyeE7+Se7j8DlegrraE+wr55enhBvchOFZ3mwH?=
 =?us-ascii?Q?U4SU0m1C5pdZm1tCD1YEDtCNfmnWiEe0ioFGWdJZCutLCiGmrkxoEiRkso7A?=
 =?us-ascii?Q?MHvhG87/kVwEwf0EWp/v/S4IRhIaRfZ1Vi4JGTO3XwbAJQFtEB2ZEhiSjC7z?=
 =?us-ascii?Q?FJmpetBd8f+Iqf4SAtyurcTTgppWEahvZjAxXrfZpZsWU/+9pbrFZZuc8EVs?=
 =?us-ascii?Q?X8b3F5uI0Xv9ay4TItJaOiIG3KtFb7PRHjbixDv7J7jWVmkWc7TwqVmyDMPl?=
 =?us-ascii?Q?A6fHFyslc/C68eAe0Hre9nWR5FsA5vP/NpvoLrNevl+jBtkEawFZNGd/z7Tq?=
 =?us-ascii?Q?F3L192LpATVrMIFQ1QPSehqEQ42tpKQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8294ac0e-662b-497e-cdec-08da278d3b64
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 14:01:16.8867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RMSeL6yxt7rgSff76OjRbiCXFW4OrSqJ3RbshtJ8uv5ayCPOlFaddiad2OarIxZyeKNd31gvy2yrBAr/uAszTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8816

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
index bf9d5bd8dfa6..7590e2d29f39 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2673,6 +2673,11 @@ static int mptcp_init_sock(struct sock *sk)
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
@@ -2832,6 +2837,7 @@ static void __mptcp_destroy_sock(struct sock *sk)
 	sk_stop_timer(sk, &sk->sk_timer);
 	mptcp_data_unlock(sk);
 	msk->pm.status =3D 0;
+	mptcp_release_sched(msk);
=20
 	/* clears msk->subflow, allowing the following loop to close
 	 * even the initial subflow
@@ -3009,6 +3015,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 	msk->snd_una =3D msk->write_seq;
 	msk->wnd_end =3D msk->snd_nxt + req->rsk_rcv_wnd;
 	msk->setsockopt_seq =3D mptcp_sk(sk)->setsockopt_seq;
+	mptcp_init_sched(msk, mptcp_sk(sk)->sched);
=20
 	if (mp_opt->suboptions & OPTIONS_MPTCP_MPC) {
 		msk->can_ack =3D true;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4842a28f34c2..22f3f41e1e32 100644
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
@@ -628,6 +629,9 @@ void mptcp_unregister_scheduler(struct mptcp_sched_ops =
*sched);
 void mptcp_get_subflow_default(struct mptcp_sock *msk, bool reinject,
 			       struct mptcp_sched_data *data);
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
index de20fbdb6d98..a0b83fbe8133 100644
--- a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
@@ -29,6 +29,7 @@ struct mptcp_sock {
=20
 	__u32		token;
 	struct sock	*first;
+	struct mptcp_sched_ops *sched;
 	char		ca_name[TCP_CA_NAME_MAX];
 } __attribute__((preserve_access_index));
=20
--=20
2.34.1

