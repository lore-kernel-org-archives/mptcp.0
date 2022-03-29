Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA4C20FF
	for <mptcp@lists.linux.dev>; Tue, 29 Mar 2022 07:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648537798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=df2jRxIA0Y/ABAn/8uK6G3u0d+ynwFDV+RCRXwFkJSs=;
	b=bOKxyj930qlJd7YJxpr3bSxq2lV0JqCE3qbb8dPo3e8iQGRd9QvvIgqgjUd+TEbFOhsAmc
	fLImAp0t6XC0ChYVZHc9o+guIkgBF3rSVPtezxvhu6z4B5wqaqideaUsPxoNA0ocdYMs/X
	OwRHAOGzQp0dGKZcHG/UFqxqWQ+pGwQ=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2177.outbound.protection.outlook.com [104.47.17.177]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-39-jajkMgmsNJ6f8ADkpLsP8A-1; Tue, 29 Mar 2022 09:09:57 +0200
X-MC-Unique: jajkMgmsNJ6f8ADkpLsP8A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGgyaJtfga+eu0m7A45FCRksIlh4xV7drXhGN6nd0U9hLBfMvU734N16tCBgRQxXyOspgPjeRSO1/khFk3UPOxtayl9NVUkg5vEF32BmIJj/GLvTVVF47B3qYsSozTfkveQk7EyfsgaFog8sDFEGw1ChHYh/IiwD2rnM5KGxszPOZcYctfKldV7UoNDhbc9wp40ddyNf3bUG1XRcX1UU8V0osjoa23RY91os5IYYSjUmNrPx3TNH8hkqY8jOuHuYiS64CCnDfhhn6WRRAm1O/4+wU0k9u1ZaDOKFBRGGz9xXKhO+93Wj5K87N0M6J75fiO3gI5b6kk8hJtMhfuvYAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5cAviDVumocNGXcupv+rJCHxwSsWxV/99bHzvvp38C8=;
 b=NgNuai9c3Ngsme3ZZ5YwjIwt2chSkSEnIAasH9cYUyR3ezaq22T0s2GwZHeo1/uAt0Vln9tKYVbS6X76M06BxrRdNAK4VA9u5FSx48STqkDVyjRm1Aghpfh0OvVWupRE6NlKzg2xuxK86OLsdAFoGoSAyaEAx1PoieK9CGU/RsLFkXkUuwLG0z6NnuclkW7ECvdimC7jfpncN1h3/3wSqKZ2snjIob9dSCXj0NyOtKzlNcjtjvGX4/kd8S+D6lp+ykKzcKmbdh8Ev/3h82VwCDbv6LOKLq2xOJpJAI8jzg/vtRDX4I9EUHg7V2s+LRMIiyEp//X21lDGnU5yxYqbTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VE1PR04MB6735.eurprd04.prod.outlook.com (2603:10a6:803:124::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Tue, 29 Mar
 2022 07:09:56 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 07:09:56 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: fw@strlen.de,
	Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 4/8] mptcp: add sched in mptcp_sock
Date: Tue, 29 Mar 2022 15:09:23 +0800
Message-ID: <abdb9bbf1526c9503a0486064e82198c671a3444.1648537203.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648537203.git.geliang.tang@suse.com>
References: <cover.1648537203.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0107.apcprd03.prod.outlook.com
 (2603:1096:203:b0::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7fa3a40-38ff-40ea-f468-08da11532136
X-MS-TrafficTypeDiagnostic: VE1PR04MB6735:EE_
X-Microsoft-Antispam-PRVS:
	<VE1PR04MB6735B0F01D92B49F7260EDB9F81E9@VE1PR04MB6735.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eH04Sc9Fw/U3Cl6++5XhjU2XR2Pz1Poszn8hz9JFVgOf5/IY8JrWgxU3EmDhNGfZQRiV80Os3T5GBSEwi5M1f7Cig4ZkICMLw5sFBJ7GJqLFZ5edvEolVQnpKyKYzI5+Slmg9dHOzl7Cg3O5Pn+n4Pd6DUBDblbrJej9czqcl0QR+i38kRDaRx3JYY9wQCMNCZ4Fe6KQ4GN6UfvWy4HBcShgWzDHcSWSTbtDyFaHRrOn6Ao/YxQnkenGH6C8LhxAaI+CVil0qGT48DmlvetqhngL8Nu5w7G6iaGbbPpt+GYBYy27Cl9qy4BsEkbKqx5dD3WhnMXgPln3J0PaapZyGUTqGoC3NHc9Pllh2VCiYzpQsBiAiP1qXFSBkXdxxbRuR6QGBeQyyvSOlodHCufcf68mGV7tzq8N4jcZvyG6313G4Kafn8hu3WgnDWfVlRf0Lt6XGfqGNCr9SajBpnAU3a14iYuujGlfk5PEg5133ppLRKZ5LArZVd6zI2ExEuPp7B4aWmnXDwL8G5kGo8Eevfs4dI/cOMp52P35zcfsWAe0lsK+a0DeTSpXhSMuYjPcqkFXFQHGClM50Yfy9kTd7LuintTtuk/Xqx3Y4A6raPNMRcTi7a7hSq3wnoHDL2+dVHkKCEcKdRd/RyguGDsUFJFS0qfs6csMubY00Mf/sf5aEfxlqDYtTLoex9i1fzCh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(6666004)(6916009)(86362001)(8936002)(8676002)(4326008)(36756003)(2906002)(6486002)(508600001)(316002)(2616005)(66556008)(6512007)(66946007)(66476007)(44832011)(107886003)(26005)(5660300002)(83380400001)(186003)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LEtSJEjgqjMHWIe+PtZLrqOnxJRxDcmvAl+qJCkwzsvwpmycAekxUuzyo6V4?=
 =?us-ascii?Q?E0yo/ZeiuVt8n4OfdnG1RX4iYXMjzlTQzgk+2nl721OVnzqcpfv+punltp4p?=
 =?us-ascii?Q?1l0+jNUseOTFBi4Fv/lqOQdYq7U8JjAWGIRQ4O5J1C1IPidvGt0D0wCmRhVE?=
 =?us-ascii?Q?o7F4/dwwQqYRJ2iG8mtdTOQt/MBwTExOX6b/4uHIVEJzwT25l8tOm/izjlyM?=
 =?us-ascii?Q?4SEYW3zY97+l1ad4HKgd1xFBjVWBnNJGgqH1fHwbMAffylriBsWCKfCBj0Fc?=
 =?us-ascii?Q?8mOCzOpOSN0qBr17twYPKrRfHy4zhI+dTahjymM9i63YLOFBNI1FnSk7TWm7?=
 =?us-ascii?Q?BrZBVJD1ThsdizALz4W1V5cnLFovuBznjx3cMtOIdQWJ2yerNXdGFNFvSOgH?=
 =?us-ascii?Q?/lJdmtHGctvzmqHVt8zdpR2jr2xY7UypddPm/ZQhwx65GtFyC3mCvMfTch4F?=
 =?us-ascii?Q?Tk3x7ncY2L73nHfsZ4G/yFLGvo/Gt48Ngo/fCdJntxLJVigCv9dv3+cn/mJx?=
 =?us-ascii?Q?1WrTq94FaE/pUosmT5t8VD5FibLKe7lohrrTl/eVNnvZF9I9apDV7Ni4OfLr?=
 =?us-ascii?Q?xl5elXvXQ0HD3oF1OWlWoRJEuQlMUwK6b/SVTTsPUs7PR6S9Zjxjo1r5kGN1?=
 =?us-ascii?Q?vg2XEwbpVT2CilwpZ9REoPE9mhWsBCA6HErvPsEW9GSDU+Zn77/ctKwWndTT?=
 =?us-ascii?Q?b8693/fC7+yiFLFp7uH5vBLupd7m+C6V0c30R0y6X5hQ+y4uDJgTT4OShq7m?=
 =?us-ascii?Q?bwbRKeL0RyL+F6NS9oI4Gf+Go5SJGzD5x53/IYUH/HERLF3SSsNonRG0amBO?=
 =?us-ascii?Q?4KvHPYlI+iXD34mr7NV+y0QCAQrMKLLBagOycdTbHBwUpZjk/KOThdjSYuTj?=
 =?us-ascii?Q?BhHJ+esOO1ckTlleKRWlbFdYRjz+pqY+msh9ZcazDkGFEptiv9/efKcvHigc?=
 =?us-ascii?Q?GIRu3kT6GWj1K/W4NC8Tmc5fCIbRt4UN/wWzgLQSnPXubjuHAWwaFXpFlC+3?=
 =?us-ascii?Q?JzY2A8guKbP7VNqbvmSR6l1TF9kERN92yVLM0T/Gdh/1ySTGNKJ3iKXM2lMg?=
 =?us-ascii?Q?GP0HBW6tWpPn4ZhFOJrxhP5mY3jwZuaZ0QsPRlRBuL4FTiJpazGWe6KY3QhL?=
 =?us-ascii?Q?snJfN/rhR4VFNlvM8+dqUZMW0QvcTT/GEvHEKhIVLzSHUCRPN4kkhGbNRueU?=
 =?us-ascii?Q?VR4tl/L/WWxn0ZS552T1tNcugkjN2ILZ76xLRp9HD43vFqD0Ag57UMAm8Vhv?=
 =?us-ascii?Q?6U4H2VA//R7aWfXk70IDvjcFsXskmYHE5WFr7aPPfWLDEA36ytIj+0853LfX?=
 =?us-ascii?Q?7aclqca2MwD4wwJkI1PUol9pf+0hqtgoFz2qMEi05QuDmcj+xe5xxNibI7CC?=
 =?us-ascii?Q?uEXHMKjUFMJ1Em+ydno9pCtKCdP83hNWBlB/YS0bYuE4DYBzgo6OS5+gBahb?=
 =?us-ascii?Q?duj1XPs+EGF8S6a3V7RbU9AUNXHPgEDovdx5R64RsLLeMndkkp4z2qzcI87e?=
 =?us-ascii?Q?cdY5jwVbWx7hEc2u8/X1fARHw6yTjFR1f7SezJDcsiWp7PP9tQEYOGcc0sS3?=
 =?us-ascii?Q?5dc4C3nOCXGHRGN4qTt27auMMVj0ot+izJV1WIa0y0ufM12LRkvsdN9ZBJ20?=
 =?us-ascii?Q?gO3pzw4xzZkZUzcyl/O8dOq0u+5rltyV05+SKVMrSMx/TVrB/Or4E5wzGRHo?=
 =?us-ascii?Q?PWC1cYcLpeJ56hE9lpBoNWQ5gq98K/TJW82kc5gVnzJpK2AlP+sPv2RTPgo4?=
 =?us-ascii?Q?ZjHxqnLZtntGkqK2p+ReMDg0FVxjhgg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7fa3a40-38ff-40ea-f468-08da11532136
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 07:09:56.6991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g1ZaGFhBHA/I4NjMWTzfZCsBZA+gHGEQwzzaFNSew7FHgD1ML8bakoUQNv9TrMbdnE3l06Gq707IRWPX65G+Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6735

This patch adds a new struct member sched in struct mptcp_sock.
And two helpers mptcp_init_sched() and mptcp_release_sched() to
init and release it.

Init it with the sysctl scheduler in mptcp_init_sock(), copy the
scheduler from the parent in mptcp_sk_clone(), and release it in
__mptcp_destroy_sock().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  7 +++++++
 net/mptcp/protocol.h |  4 ++++
 net/mptcp/sched.c    | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6c2d6b932d25..e65b4dfcb758 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2657,6 +2657,11 @@ static int mptcp_init_sock(struct sock *sk)
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
@@ -2816,6 +2821,7 @@ static void __mptcp_destroy_sock(struct sock *sk)
 	sk_stop_timer(sk, &sk->sk_timer);
 	mptcp_data_unlock(sk);
 	msk->pm.status =3D 0;
+	mptcp_release_sched(msk);
=20
 	/* clears msk->subflow, allowing the following loop to close
 	 * even the initial subflow
@@ -2993,6 +2999,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 	msk->snd_una =3D msk->write_seq;
 	msk->wnd_end =3D msk->snd_nxt + req->rsk_rcv_wnd;
 	msk->setsockopt_seq =3D mptcp_sk(sk)->setsockopt_seq;
+	mptcp_init_sched(msk, mptcp_sk(sk)->sched);
=20
 	if (mp_opt->suboptions & OPTIONS_MPTCP_MPC) {
 		msk->can_ack =3D true;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index e9fbed723caf..74d2b05f5d6b 100644
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
@@ -614,6 +615,9 @@ int mptcp_register_scheduler(struct mptcp_sched_ops *sc=
hed);
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched);
 struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
 void mptcp_sched_init(void);
+int mptcp_init_sched(struct mptcp_sock *msk,
+		     struct mptcp_sched_ops *sched);
+void mptcp_release_sched(struct mptcp_sock *msk);
=20
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 52828eb741c0..5d20d252088f 100644
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
--=20
2.34.1

