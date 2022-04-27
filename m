Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AF5621
	for <mptcp@lists.linux.dev>; Wed, 27 Apr 2022 01:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651024629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7IQbAaZuItqGn45zdY0b7mjJfFznzVRLGHb6Y1LCFzQ=;
	b=MgP2RRNwfB5wMSKQZ3Fr7TwgBL4J3JAjyTvczh60P6mBnOAsE5lzhvm8yQXLARkr1eYrJN
	09+5FN+WTYX40joGYyYCu2cIuNI9stFh8cdkHRhepWt/1hKemJlb1a8L9PlfUCYKm7pOrx
	sNbbOZXGOm1v47necq8MnLoy7av3wyA=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2176.outbound.protection.outlook.com [104.47.17.176]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-16-8lCCF8VCPdqLYKFMeYduHg-1; Wed, 27 Apr 2022 03:57:08 +0200
X-MC-Unique: 8lCCF8VCPdqLYKFMeYduHg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6G2zoM+OLk2EsSx9ZVy+05EsLKcvzM+oWtD6RxeCSP+JfWp7lFFqMi8NnQ/VTuPjhYTCQOUpR+yLq7VsCnfZAEtPGCOGxGtr4dN3LNEtafSKPDuEpnsVaNbGNgzCpE9jKl3/mRAv2qRGSAcoHFxCh5KcFNgTTVRK0MSXHbqK5I+uygzj2C5oTR8YmrOf7C8PQgUMgsmaW5hLgpYXvOEhqf8tJp+NV8z31ZKuAWd/gArxJOokLX12tAP50PzJSfRx367ABbJTnycnkxOIq7WYmdXwBluwDzZm7j2AjK7izBNyVSbYo1oqAiQnQK3X61St5O4FA+HwiLk8z8NiDfVQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oTvD3U+uuqWmxLTaY2GW03e01TiRVRGWjWeI4F6geis=;
 b=Zvwo59Ydcy8/DFe3McSQw68nQIw6DxZteIkBXmvyFOO2Jdpk+eyO1MgXFySqqIyRhhsUl9XwF8a182zl3KcMmd74ay6ic5ckJVqvkp2Noqs1qAdQ7f5U339y20x1klWTNHheLCDQ21muF1K2kfZdpWFUO/hTv4EId+29u6Cc24SdfHkKAUxHUQ81F+rZQZTWfRFRUZddIhZuSZO6oASa9D7zEqeJpy1/Gqi356Boim5dl4IiBrVH0ttF85YcRm2Zb1bFk8sLR4Yhrv7Gq2CBFYGCsoLEw3slTYrOtZDQ06O0hYkjTSPX2ATqCuhfQ+UCNlJhKIkAfeAt/C+qF6hqAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7661.eurprd04.prod.outlook.com (2603:10a6:102:e3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Wed, 27 Apr
 2022 01:57:07 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 01:57:07 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v16 4/8] mptcp: add sched in mptcp_sock
Date: Wed, 27 Apr 2022 09:56:51 +0800
Message-ID: <2852082212c716a93ad8351993f9fc138cda9a8a.1651024344.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1651024344.git.geliang.tang@suse.com>
References: <cover.1651024344.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0217.apcprd02.prod.outlook.com
 (2603:1096:201:20::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d07bd05-f7c0-430f-9d42-08da27f13c0a
X-MS-TrafficTypeDiagnostic: PA4PR04MB7661:EE_
X-Microsoft-Antispam-PRVS:
	<PA4PR04MB7661090250A300CB975D81E4F8FA9@PA4PR04MB7661.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ulf1ebdY8M++2SMRBvGvLcU5Ze8YUepYg+Y+2Syb++SS+87Xi0AuTLTmW+8bZXv3xC+ZHy9cRqi35BlUo9Nl1pauTHgJi5wSMuYfbquzrmnE7NEbzZMrWBE/CqSIPi7TyTx51o4S0PqG1+Yz0jwXv0j/ajx6O5BrXli41NlcBu8lYjfUi6SX1wIdqVqQkqFGCdKvSs1WpsN8p/TxjTpBC2UumdowjilDY6B1twVF7B2S0Z61XjrNop95zSbrEvbSNZlqnRzybQZsugs7fMXha0RelU9uUfnTHSMnu24ZAghurOyR4lewGPMr/VLSeYG+h72s7tWyZJqisKLT4eY/BtRh/5M2Z7FzCa/MuawsceCAXoDRxDq5t/66LqZwaGwwcIUem9euCr4k/SS1z9IFihvp2GtnHoW9QGBn6TgOh9pbWWWjZUUArfbBQpTKJ01pcR56IiVbY9DyeOhl5eVP0ncx8tD7IHhS6jsVFI63A4g0JSFWJzGLHWgtLjg+suL/tidBn2gRR91W46nM2GvHsa3orJAG93u6JLhDu6WS8zTuHHT1+/1wRyefbdNWWM1B2WPgxopuUCjsR7Js3ZdpDyyrrH2gmuYILIkKoZDYfZDyUMiukyyTKYIz1NnRkNn8hrWeVMBFF8fJtPL0v8kwKlEDH4pP2b7x8TaM36KHvN3jHLvz0OzUGvMjUwHnGrZv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(86362001)(107886003)(5660300002)(6916009)(83380400001)(66476007)(66946007)(44832011)(66556008)(8676002)(316002)(186003)(26005)(2616005)(4326008)(38100700002)(2906002)(6666004)(6512007)(6506007)(508600001)(6486002)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tn/i7EwRWFWt8NHpfsblzR/GcQm2+oKbR7icSK8oOdtbdlmlPS4eABctmT3p?=
 =?us-ascii?Q?Cgxc7Ac0aD/LeNF2LeavmbKORmklxfRPMWNYu9UvQWlnYJ03VwTVcPhWgPGc?=
 =?us-ascii?Q?KOFTfRoV11OKDjgiPhTKTo8SXpyksjITO2GYfm3dqzOWUlysaAn71ugH4AxU?=
 =?us-ascii?Q?Tq2Zi1rbTXCoBtvYf/hfTksCZNTnZvItEKMuUmfjj/XcYSq0tO27AWiO0dr2?=
 =?us-ascii?Q?TOBOzhUoYDnjkT+4QVUd9VG2b0UDhNo9YOkXowScqGkF4iUBxn08FLCzTCsQ?=
 =?us-ascii?Q?jZ1nMhbKgOrxdVwdo4QcsxLM7UhBf/ttD0s3joxY26HP7PDuuDF4zZ4/N5v/?=
 =?us-ascii?Q?yu+4ZWEqufTqrMti+OxxxUJccIQEprKU5fl31aWWpw89jebopDmtLMMRiCp2?=
 =?us-ascii?Q?JsxR3JbrEs4c2LQ/0VR/oiaqufTQIRMMkqjivOA7L/NOYWgng2/rRqKNfKzG?=
 =?us-ascii?Q?rRo2Hyq958L0o8KgueFISJvcng1NORxGq72ezkgwxiAHSUWDdolaqizvu5Zq?=
 =?us-ascii?Q?k8J4V3YUON+gqu5RglvV16ZbHRata79fIQz1BSL8YeMMYgS6rJwQpI1nCdmk?=
 =?us-ascii?Q?KjJ93smIjbWsph18Mr1M2uTNU8NY3MRNX0cIr9l6EuR6vyfc3mSOmpjlb2fg?=
 =?us-ascii?Q?bLS7GXgi0iADgerIcJ2CRt8BMIbHcCNyORByKZ4br6Ib/uG+YP9PBkYXU+hW?=
 =?us-ascii?Q?K6opkgZhIph4IZOYEwxxQVxSGWPqPafSE/M5r7RN4ICvIbfzaDtYU0SZmz/p?=
 =?us-ascii?Q?1FYcspdFqGwMsNhZ4+CuFE3InFynM+7SHTsMgh7xtdSC2JYROoxsEJkoTfc4?=
 =?us-ascii?Q?Go6xti1bKgySmj/fKg1TK1eqibW/GBTpDRFEllqSmGyCZIxSAnuVTU4fEwvq?=
 =?us-ascii?Q?zGPrx3s85BAo6mAY67i/9u8EnkrgZLMkaPjPlp95yAw7VR7gYEGGvUeJHEa/?=
 =?us-ascii?Q?nQnoB0Wib/IEPUh6N61NVsgjcpz3o4D+cTl3RndtO8qzCgvaQdivpYapDkQ7?=
 =?us-ascii?Q?tFwHe952nll/yR0hmBLVepIQf1cCvLu5XxHTTQLHJaK5eJEaif17Ejn4wawo?=
 =?us-ascii?Q?tZWnKThBiTOiLvGo7X7Us6VmjwIX5oJY7Dki8HEvR+kk50x4PFZh6NCIS6F1?=
 =?us-ascii?Q?Ip6D8QEHNDpiRN7s/oLYfw36S1XqDMn+uF2YBqEzNzbHYxgKrBLTWbIG3+zP?=
 =?us-ascii?Q?vn78X3iSikHQsO253CwPxLYyv7iWbqabB9rNzay0ROlsOm/vJFDjVGfBwnUG?=
 =?us-ascii?Q?+y+IDlgAeBvW+bn9YexCfgHpYXyx8zSrnlXKZux+SsQLLWY9ePkpm8ekkikW?=
 =?us-ascii?Q?AkrhNa4WQh40kVkeXVfyPZMOvcoArv+3QAuPAikst5S5zGnsPNVrxJKTLoC7?=
 =?us-ascii?Q?YlrJYMzmMGekgU47tQhZAyiuiO5701pPR/gMLfvuZBLt5LzJBMHeQU7WVjEy?=
 =?us-ascii?Q?++kJwW5nniYwUxueZaMFBkkFaEgoxvrs2gf7yL1ByxT0rOdvIOADn1d+/SP6?=
 =?us-ascii?Q?elgH7UGMclbtdtcBL3+KuuW0scT6SNt0GjRRHwhjBXmUtfw7BPzRo7jc9Nip?=
 =?us-ascii?Q?vMyEwE0QA3KPHd/Upz9w95OgSoi7R2gg/+GTiw/V/gkLCzwdKWGJ8e86zhcE?=
 =?us-ascii?Q?lOMMmDMMGtW+1wfEwEAxAkiqvl1xzTEska2r8y/h1qrFzJ16G9rhxT2Nplyb?=
 =?us-ascii?Q?3yoiFRnjQbHoO9i+VK5zTnTAkZMrRJ1tR6dNEl+nUdDaPqImYsLqayWIWG71?=
 =?us-ascii?Q?/G0Hw1UWTVUGwexh9CqST0beNINMJJI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d07bd05-f7c0-430f-9d42-08da27f13c0a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 01:57:07.7401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DNLpamo3VotB0uzyzK3aKhPqWEOKySolPuCCWzxcCjDuA1Yarpndc4L4G6SqoBM8C38l85wUYkAYjZfWRTJkTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7661

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

