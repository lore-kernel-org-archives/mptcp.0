Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09212564
	for <mptcp@lists.linux.dev>; Fri,  8 Apr 2022 15:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1649432322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nR/o1B00CRpVRW84Wfx50XC51Z5j2vsw0vCvPeiFZcM=;
	b=Nf8Z1bCq9XNMGRnweJYxhtLy7eKl4QP9Pumwj9HztnQ/fa8hz7cwmTQ6ujPbEOHd1aaOBg
	CaM/wVil7zAbkmmPTg8qKF+5cL9EBt8ao6OAIPfyCEhQSxfxcsp06fWSZuDK3SXvOKiLqq
	YPN4hP42PubvdwTWfq3/wd+FnXyrCMc=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2168.outbound.protection.outlook.com [104.47.17.168]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-41-Lte3UkGBOAGDlthgTrfaww-1; Fri, 08 Apr 2022 17:38:41 +0200
X-MC-Unique: Lte3UkGBOAGDlthgTrfaww-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mggnyU3Tc+rOuvBIiVPaPdj1Ed/5iLX1nZrUK6gXdMenl6yEmcgoiPXUvTWcWWza26pmQ9JsAcAi1oa6x+o9A2rrRTRcWFeMA+9sozMtB+FL3PspWpuWJ5tpGtdYgBi8vPqebDvcsvX1+BD3ActLr7+7GC4HrOy8Htac8J9sVWDJVv2yR7EYO47gR7lXUy7Rbto3wZ3/RdTab4JTVDC01IJ6DQjU9jOTzH2dXNhXy13dNG+ZEKGYEnPc9ftqWbsT4dBGJO8AY8tcTxBj5nerH1Q3Ht5yr8gAOvu5WavfllYD5clBEM270baZOdSExUpOFwZ5gBad8tcduYOp7MYkWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yJxLKdX/QtDMO4gfwx2IXKOaD4gfC02gbqGDmbLPrMs=;
 b=E/LOSLAYsn6cJ6qvZ8qvL+LCE8wIn9ABT8zlOsCdZZaIZ8iqLYzok24cWDNAIlwB+xAVI5BzoEHqPkAMD+QzyoxOhC+6NPfjbf3Scce59tlILVuTI+ZWXeWmpie92ytQt1QhkLp72BRbwFijWz7Sq3bdm3EvYeKLzq00lmPsx6wBYglIy3ipH6cXhFGyKB3OsI1ZBaqc6rUbwKIr7/68vwI7c7Rdch5HrbADoupqlkhIP2+pM8Zedqw6oKVXEeEF5IxNZvHiWE8lhmx9XY4CAGQwrvGUVhPb5bJYouOFFg9bHVYLpHMIrlamz3chNjTAPFl0KKHaxob1r8xtJJGlwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM5PR04MB2995.eurprd04.prod.outlook.com (2603:10a6:206:9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Fri, 8 Apr
 2022 15:38:40 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5123.031; Fri, 8 Apr 2022
 15:38:40 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 4/8] mptcp: add sched in mptcp_sock
Date: Fri,  8 Apr 2022 23:38:01 +0800
Message-ID: <ac53cd08537f0e7c97ebb7d26a03744ac2328e25.1649432004.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649432004.git.geliang.tang@suse.com>
References: <cover.1649432004.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0123.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1506947-6468-428e-98de-08da1975dabc
X-MS-TrafficTypeDiagnostic: AM5PR04MB2995:EE_
X-Microsoft-Antispam-PRVS:
	<AM5PR04MB299589FEFC0761E108450BA6F8E99@AM5PR04MB2995.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Yy/GDlBxPyxDNNSattCQHEJl1WRtRQFopq8DYLQcgIybJBeFBxKrtY58u1A9dnCxn1RRzUGYFBohjdH64q5dRjHJloPSff0Mrkem3dK5occiRwg77k4XneKCYLlm8xzZNzmdEqOe/tstMOxApRn0w1/qlru+4n7h9jHYbZ5k/etNEWesLA1rkr02evrYjQHWJNmiQ3Tl+NBld0NJTH+6gMH521nfouDwRt8LZjtcKOzIjm4cyRoIzqeBJaNVxm+Lzddnlzkp4gclRDWHbSyCewfbB0ke8xLmprXow0LSoBZqARrEZrXCsrbDRrfYGI0WacL6busrMPpYeL5xXe0gSgbhuWCCMw1LRvC58mlLTyzz8GdyNQ0hvw2pdA5RRKNnnp/HHI17w2QqVykl5Z0Pn8V/3XFYCZDaQJA1kaasr/dt1lvIaGuRuixbiMfJEEJ6814qnYwtHKzGCDPNrdU9bTA4YpOqg1xqAIPqiVYF2CrMriT0P3NBJdmpBBpiTocJOnP8yDXgcxsqKsDVcbAFhwPiQd1U5f6NHzU8kkiZHi0CYx51VwaLJtDxoohs5E/dRZqauM9A8144rAghZhbr0LG4Znc+cW2EbbQwQldL4lprLWJFJFKXu9Rw7zf0b9vaS0qt2SC5EnxhzqcQ0pVU0upxzYl1sYP5lmuquS1gHqn0L/BBsEmhzpR7FsSQmGzQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(38100700002)(2906002)(4326008)(5660300002)(44832011)(316002)(186003)(86362001)(26005)(508600001)(8676002)(107886003)(6506007)(2616005)(66946007)(83380400001)(66476007)(6486002)(36756003)(6512007)(6666004)(6916009)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fgK2ulyCq7s8nHyTqH77NsfWalyXQOMr7Ub242z+3nQFRR4MdcqqfLWG3VqV?=
 =?us-ascii?Q?DpY34aqdE3Eio8rFrYZKHPdXRGxE2fUSFYu5cCYmYrWUfM1rJ+b6D12KK/bH?=
 =?us-ascii?Q?9Vr02JxyBSq4Dt8e+VNWiANB8xvgcXR7FLCJxRTp+sxzsblNHtsHW58+IdCw?=
 =?us-ascii?Q?mSvNn+TH1VduOfuLqMJsubYlanLstsRNawow6OHCf4mtB/pvC2/SDPCLWgVM?=
 =?us-ascii?Q?Vt/n9uQsA9jpPpm9SphbXisvJ9TlBbP8OnWRexyzK8xmDEINSBHfeOTlkIPe?=
 =?us-ascii?Q?Slq01KrRsCa9WhU92fH3+MXucetj9guPPMG+oXR9UyeBsAYlZUyVY4QLoZhc?=
 =?us-ascii?Q?7y91pmep0la8wk9LY4D6WoSMxCW3YYOCdsqD3VXsEWH/jjwfCAVk02T+3pHm?=
 =?us-ascii?Q?Biw2Ym7I2G5uwHNOOuDd10GOAvRq+AcraXWUspWpZtA2xRJubxGeGT2F1r29?=
 =?us-ascii?Q?l8w/sY38VIq6sXolclqNYGl/G00rFqoEshhNP5abjyuf7Nycm70TH9wYOjd9?=
 =?us-ascii?Q?BIO38Klkp5ZQVVxDqov5H5OV6n58YqBe/QJLCFaMx/mIH2TcFhRWSqMOGS81?=
 =?us-ascii?Q?eH0/pvfzeR5h1O8cNAQkUP91gm1UnBiLMKreRtH3ReUgaDmLTFJqnsOhff65?=
 =?us-ascii?Q?6SNlfRV3PGheJozW7LtSGy6y6MZXUlkbaNu9IQlDwfEpW6BaGp25QIaFESue?=
 =?us-ascii?Q?lVPm1pFb6i+rYgu/6hdzO0xTc6U6NHGCLXotO1hlVhkJDZHYsyueh2sVzwEz?=
 =?us-ascii?Q?lMDO9e+N32OsVPyLl5GcoVT22rmlIRWlcjUc81DjNDyFKrZm3Qt8Du8JxNW8?=
 =?us-ascii?Q?1WdALdaQV87q87gdk+zLS640x3B5xMUETtgUcTDG3yP6LSyI9DrB9agQ029o?=
 =?us-ascii?Q?Foyy2b8pUKKos3Pgx1uBrJwAY4Gslph02U7B/sY3mWm5JHl13HCuoQLSrxOE?=
 =?us-ascii?Q?84e/lpsc+gvumliNNd7mUPMOf7KKx5FcYADxpGhcL4l4RuCmWSmGi60XH+LO?=
 =?us-ascii?Q?5fHl8svdfmgZDPA+pmzfi5Yjsbw8+FWKLLtazOoPI4qlLE4bXb+5LsIUNbPy?=
 =?us-ascii?Q?fndZGVx4Xf43TnRVVM2hpEq/yxoUzGOa2Iwu09YG4feAAKjFtLxCEROaqLf2?=
 =?us-ascii?Q?t6KW9PGsqeC4Uac7J47QNV3s9tEEmG/bd93onhTd1XbD+csh2N2ISxZ2zAly?=
 =?us-ascii?Q?dZG+SQxJ49ES2WOgsI0dj5aEWr6nJlh/lTIiaGAt/fl7jLgQdortfepizK59?=
 =?us-ascii?Q?b5MU9F8zwypgzryUcGpzum88hR5PmWsdBc9+W1XWMOG2I+TNYgZJWbAH7j02?=
 =?us-ascii?Q?mNn6FP6hiVQEju/EFjWk5adczZ4th03/YmQt8+gaW48gZfVFLfMN9syS2TEa?=
 =?us-ascii?Q?EzM3hhjSzqh5K8421tUVWA7VRsojaBUYs02kSDy3U63zCSsAZDO6VTZUgrqX?=
 =?us-ascii?Q?TRpglW+0SvUnk3rBAU+cS6c5hafTdGvSvBhTi0c86dLjRs34Pnk09RAtOazV?=
 =?us-ascii?Q?9jB4g/mpvoKQYW9fE0bKpvBxq6XpTyMKmI6UbJAy3ic/83kkIqbkqMD1b/Ey?=
 =?us-ascii?Q?2zjga+2eQ7CZiIQ8ozm/51Y+4e1yXfgc4m9Ya9HKaGFSRSgiVeJ3sgq1kfja?=
 =?us-ascii?Q?reEqzTd39DhGZx63K9jnEUk11jIQENLlVY1sWrUpnknnoi4//xjHJBVu8WNu?=
 =?us-ascii?Q?HzhgP0eMSZkgccijOVk3HqLVMJRcb4/m5xpsB/sIjXL2ihHziFirZHGWzAD6?=
 =?us-ascii?Q?0hK4Zrr8LnklshUpBt6jv9kQ/ERJlYM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1506947-6468-428e-98de-08da1975dabc
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 15:38:40.1600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LRgZf1pJ1YpbQIR5FMF51y3iC2M5Sig0iJdLoqB9H1+yZpOn9QXd+MJlCkjM6kFHWy+MtFTrkKxkXnY3m0fECw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB2995

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
index 0187059307d0..1153bddb92a6 100644
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
index 213d75a58aa5..2b3143045f89 100644
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
--=20
2.34.1

