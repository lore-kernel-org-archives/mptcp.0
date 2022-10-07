Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80053.outbound.protection.outlook.com [40.107.8.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31445468F
	for <mptcp@lists.linux.dev>; Fri,  7 Oct 2022 15:02:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X9VmWbrnk6jVYfoiqNa5snCf1aOe/7i8S2VT7+vr/AOWFtubgtt4PU64zgOeBXhjyifKAwDhgHgQP7ifn6QIBboikvt6dIz7vicXYnydcnXzjH2hUQttL7MVvm1HReJGX8sV8Yo0A4xL4beznZniNAqlRwab0MOKzUU4BIoMKYQ/+2lTTXHorQYibESXNceasdbUpJCymxCsQB4nQ1/JIV/LLCR7B1ggNHhlu0mWRe9v0itdaOUS5sSMTsUn0bqPam/PnrWEdq2ffUkJlwISKtafN2DsU+yyBmmzvbZNx8ZMh+bvIHRD6i5iGR2ScDGxE31Cd4nkzLbZjOM0NIOTLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JT4x1IZBdUMfB0jobqHpAmG8pXvflI91n65VhMEyAMU=;
 b=lvP/aRtHIAzwg9PTbwnx7GNazgzQYJSgRncgyvC7P/U7nX0+zDCZPpbmeeo9p6tQihbskBRJnUovdkbJsrHT+RfzfenGGGJDT0Bl2T9O1i8sK7i7Jz0jdNXVHvpGLvLriXwF5s/B+6/SUuaMzA40l8DrsH0QSTHnJN/ceWFP8/8sNemI1ijIWh2TYyMDfmC5VqlWpT/wdA7i24tLB/tSawKxjS0lAJ61P7MV/wujHS/DuJEcBkNv/lUr/uUXGfj1v5fouXecOGk41mjl95USbpBWNmmoBC2kVtEJyR909two1JehR4gw9OE1uopRb/ZBk3fwDjZt3ilZwr/XSMe26g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JT4x1IZBdUMfB0jobqHpAmG8pXvflI91n65VhMEyAMU=;
 b=iJGjPI9NECbLJSf8oaCPBVShLlckYsD7UWBrLy5r4y2+jHVgAsqfkffkqGlh8vpah77FVtflvdStjW1vIi6XOYkgDXeVJ+8jpM/tXe7MuIguAsg2Xuo7QisQrmNcv24+V4/QU9aP5T2hyIRK0tBtvc+O3mwxdyArl6b/AmS1Pn+UC+VUdjtGwg+HsSt5SvBsRyeb7TR+TTnXZD4Y0P7LM2LIEHVes7XYrzF5CDtwzR7x71uMCRYmxPxcdcntDWuDcH/YDK1xO7vzPQefNPw1g/Pe7Odw3FuwupengE4bx+WnBIXO2DYVjUSP34VH7O6bHvuYflegO+jU/6UCGUbOkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8295.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.34; Fri, 7 Oct
 2022 15:02:29 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c5ff:965f:506f:6770]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c5ff:965f:506f:6770%4]) with mapi id 15.20.5676.034; Fri, 7 Oct 2022
 15:02:28 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 05/10] mptcp: register default scheduler
Date: Fri,  7 Oct 2022 23:02:29 +0800
Message-Id: <244277cc5822c3df401c7f6b5fdb5b233ed89e1c.1665154582.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665154582.git.geliang.tang@suse.com>
References: <cover.1665154582.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:194::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8295:EE_
X-MS-Office365-Filtering-Correlation-Id: 3da0171e-b334-4beb-1cdd-08daa874f37d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yI3Pa9VO9CQn0EeckApkUfojkeLBsJx8i2XIiBrhOgT7AAXcxizavTe5zD6l+xWqHqZLvIKbi6fy7jJMe6/+zHmDZ05sJJYEkwn4boA3yCpz3RyPcrRGZEeFRl7OOJHJeLKkxE46Uy4wIHrjQqO5dARm8+NzAZYPlU9FtUEDqj3zRFJXtrSXh2iQdLXNRdYjGBROmN2sW17KgSnHiNKAaaJf38FvjLEtYzTscHuCPwwLHnWYLAATlXgwYB4h2p7rz0ObV8leZDos04YyQKmby6Nnv9b8Y0n1orxxNJt2luTxky2s1VWxAl95FmF2vPiElLRxuJ2sTSpUh3Vj52ymkB0tv0+z0+ZGYQouSyID0RnYetwpeBNoIeuVCxuA2y1tZb2QOckB476tqLNRbOUiruPP9lY/tzlACQQYHIDtvErGRzzvGKegz6TISwfnYpUC6ZcWHKU+Rkw8jzFgEU9EKzWVCq3ZiOg6tPa5EnCd29fIwmkz+QvQBMtcK1sT3FFUbpy61Azeo9M/jck9UrmiP4slRyaYP6OB5bg32LjJNLQLNRSD434ODXLX2bu2/FnNPu+oYcZEGuwI1lATRwHkI5ZA1STlM4+U3HKtSZ78qq5z4cLXq1awsDEnR31rKOT1xc/u27OPTZxHQ8pIsotTq+TT2z6Qdt1LiOYxRZiKp6fLvhZ09LEFCm1Peder5cNmIgUO6QOaDjC8fKerqvYoUAD9VfjX2DJCWw4+03JQUkwR6x5rc4t2nrjnetYxEhw6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(366004)(396003)(39860400002)(376002)(451199015)(5660300002)(41300700001)(8936002)(6506007)(26005)(6512007)(36756003)(83380400001)(2906002)(44832011)(2616005)(186003)(38100700002)(478600001)(6486002)(6916009)(8676002)(86362001)(107886003)(4326008)(66556008)(66476007)(66946007)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WEHLu36TuEfsKH/fX6bq2/Qd6HGLT6OBIu0nUz2Fa3G2jYOG/ahCfiIFc2Us?=
 =?us-ascii?Q?9KCo1QaMfxDERbShPfWnykE1Xdh1QHTdiNLyw3Wll0OGd/C/hOu9UZ3zV8Oz?=
 =?us-ascii?Q?a0KPP75eWssQGSDD1XEmzfAeAQbwehfEi1eALMXHq+PkZ7GnltRAgUAIVkWa?=
 =?us-ascii?Q?ar3+XILP1I11iCmS6Ejyc+RL2nVFjmweYPg8vxiTuFu9cl68jMdvogKZh0Fg?=
 =?us-ascii?Q?zhrw+cxX3qla5kk/5pyxaJovNg/TpGI0fSMFBSG9rk8cSjzkFlZZIpQI1xQX?=
 =?us-ascii?Q?TBucUZhuayjIP4XhZeBABbJwGJ1Tj7waq0hvbfBvIL5gVX8LjLwsFo2P6+BH?=
 =?us-ascii?Q?L8ujmv0drDNWMj9Jr6zJf+NaIh+DKdelErvTNLlMYH9Zoxwm1s3P76g1H6Iq?=
 =?us-ascii?Q?L96hKDYmKC785TWIgihTyjL7hbmkGiuNEskvANCki4bwFQTl6niUWep+Cn09?=
 =?us-ascii?Q?zeLz+SgWRefraUYXvklXoosZVVL4p31xr8kQOwDidt3O/UzqoljSj0zYWlEG?=
 =?us-ascii?Q?h30MfOK6TgpaplrBSTAJcedjvpMDm+opKlNQ1kHLUa6MwzIHAzNL4cVoq/X1?=
 =?us-ascii?Q?m1g3B34WvOpHUcbuTgyYEkSIrOjmHG+HRXWrz2jlxsxheifKIsedJ0fHu+5k?=
 =?us-ascii?Q?ll79cFbQqqlk2QY8ITbvGZNHQ44kTZvTxtSAkKyC+0CkZ+TIR2KyeIQ/r5eI?=
 =?us-ascii?Q?NK4zdxCs0UmwUIeid9byXaSGwUgn9iYbUsR1R78bkqYyIJVNjD9iG87/of6K?=
 =?us-ascii?Q?oJSPlVWv3Toh8paapCNnU970mbd6klvpNV4hdYnBhZTtrClapCllrHqGZqzB?=
 =?us-ascii?Q?k8VJKLo5Nzod7vPdmDcBthM2TGnqfWIUPGzl7doVvUeZAXljC75slylG2PGi?=
 =?us-ascii?Q?XgVGXP3kaQ3Km0bKlPEMcdg/Pr2CTFHE3hApKQ9w8DQByhWtpTfjFbcBcslv?=
 =?us-ascii?Q?nUQJ4GNfX9NRDHjcTMgyRFSdmjaATiULS9jLfA41oY5DIKTSzK9qw9nImuIU?=
 =?us-ascii?Q?bBZ/GAXCyztqzDqRdlM/laAtca70sLcQVIR82hcEXPdqaRCZSXLE06T3EPeX?=
 =?us-ascii?Q?G+hgCygle97yZGb7m8MkUkU0vm6cniG9lb0yPoMXuPxxV+LgSiVvNiI3M7Hh?=
 =?us-ascii?Q?fZ3QMsW+7PM9vfOf6AqDZeBpA9TLPWdOR3UzKDpa5EjjobgNBrbijR7zViWc?=
 =?us-ascii?Q?XxLMkH553dApDTvMInxAus3PpOdmDP2vLzM8cwphlCFF69TwWsa4l7F8d/e9?=
 =?us-ascii?Q?favs5R/Wf+HINAoStGUx8ArqR8FxN7OS66KA7QOJjvrqMxzMjoj0LTIA4QfX?=
 =?us-ascii?Q?KYXWC2J/KnRRucPT1ryMlVMqWPDOPvIZ1pIqlNsVABa5EPgA98BRWFsNf7a3?=
 =?us-ascii?Q?S/SQ69u/fZJB/amIvBrpV8/qoPzSwiisNXxJouwTKl5U2UyX/ZV3/QQuePZb?=
 =?us-ascii?Q?/ibj+q0opTV99nckY0qLfeGHsVVu6iVihFoPe03LhMdsc+8rGwxFG+gL5jX8?=
 =?us-ascii?Q?bI5vqT2k7K/cz1n7Ig+cIJe7gNCW5BYEdhZ06wp+KOnAoqY3nubqPrCWweow?=
 =?us-ascii?Q?AdfzVzUEd7If9GHq1AtvEcMCnCKv2lzkwDStxVGqm/TyjahG6mbZy42P34yg?=
 =?us-ascii?Q?zQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3da0171e-b334-4beb-1cdd-08daa874f37d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 15:02:28.3113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I6OElDGHikL7jce4tcjUNox0UKKu0SIuNBOGlcLonNICz62QtAT7Ren7793Uic63nlIZlTnOcKc3Kb3Eag8rvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8295

This patch defines the default packet scheduler mptcp_sched_default,
register it in mptcp_sched_init(), which is invoked in mptcp_proto_init().
Skip deleting this default scheduler in mptcp_unregister_scheduler().

Use data->snd_burst instead of msk->snd_burst.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 15 ++++++------
 net/mptcp/protocol.h |  7 +++---
 net/mptcp/sched.c    | 55 ++++++++++++++++++++++++++++----------------
 3 files changed, 47 insertions(+), 30 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1154bc746148..d99a09ada0d4 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1406,7 +1406,8 @@ bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
  * returns the subflow that will transmit the next DSS
  * additionally updates the rtx timeout
  */
-struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
+struct sock *mptcp_subflow_get_send(const struct mptcp_sock *msk,
+				    struct mptcp_sched_data *data)
 {
 	struct subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
@@ -1476,7 +1477,7 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	subflow->avg_pacing_rate = div_u64((u64)subflow->avg_pacing_rate * wmem +
 					   READ_ONCE(ssk->sk_pacing_rate) * burst,
 					   burst + wmem);
-	msk->snd_burst = burst;
+	data->snd_burst = burst;
 	return ssk;
 }
 
@@ -1488,8 +1489,6 @@ static void mptcp_update_post_push(struct mptcp_sock *msk,
 
 	dfrag->already_sent += sent;
 
-	msk->snd_burst -= sent;
-
 	snd_nxt_new += dfrag->already_sent;
 
 	/* snd_nxt_new can be smaller than snd_nxt in case mptcp
@@ -1535,12 +1534,13 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 			info->sent += ret;
 			copied += ret;
 			len -= ret;
+			data->snd_burst -= ret;
 
 			mptcp_update_post_push(msk, dfrag, ret);
 		}
 		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
 
-		if (msk->snd_burst <= 0 ||
+		if (data->snd_burst <= 0 ||
 		    !sk_stream_memory_free(ssk) ||
 		    !mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
 			err = -EAGAIN;
@@ -1617,6 +1617,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
 		 * spooling the first chunk of data
 		 */
 		if (first) {
+			data.snd_burst = 0;
 			ret = __subflow_push_pending(sk, ssk, &info, &data);
 			if (ret <= 0) {
 				if (ret == -EAGAIN)
@@ -2206,7 +2207,7 @@ static void mptcp_timeout_timer(struct timer_list *t)
  *
  * A backup subflow is returned only if that is the only kind available.
  */
-struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
+struct sock *mptcp_subflow_get_retrans(const struct mptcp_sock *msk)
 {
 	struct sock *backup = NULL, *pick = NULL;
 	struct mptcp_subflow_context *subflow;
@@ -2278,7 +2279,6 @@ bool __mptcp_retransmit_pending_data(struct sock *sk)
 	mptcp_data_unlock(sk);
 
 	msk->first_pending = rtx_head;
-	msk->snd_burst = 0;
 
 	/* be sure to clear the "sent status" on all re-injected fragments */
 	list_for_each_entry(cur, &msk->rtx_queue, list) {
@@ -3886,6 +3886,7 @@ void __init mptcp_proto_init(void)
 
 	mptcp_subflow_init();
 	mptcp_pm_init();
+	mptcp_sched_init();
 	mptcp_token_init();
 
 	if (proto_register(&mptcp_prot, MPTCP_USE_SLAB) != 0)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ffcb9d02896b..fd0f41bf090c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -258,7 +258,6 @@ struct mptcp_sock {
 	u64		rcv_data_fin_seq;
 	int		rmem_fwd_alloc;
 	struct sock	*last_snd;
-	int		snd_burst;
 	int		old_wspace;
 	u64		recovery_snd_nxt;	/* in recovery mode accept up to this seq;
 						 * recovery related fields are under data_lock
@@ -632,13 +631,15 @@ void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
 struct mptcp_sched_ops *mptcp_sched_find(const char *name);
 int mptcp_register_scheduler(struct mptcp_sched_ops *sched);
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched);
+void mptcp_sched_init(void);
 int mptcp_init_sched(struct mptcp_sock *msk,
 		     struct mptcp_sched_ops *sched);
 void mptcp_release_sched(struct mptcp_sock *msk);
 void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 				 bool scheduled);
-struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
-struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
+struct sock *mptcp_subflow_get_send(const struct mptcp_sock *msk,
+				    struct mptcp_sched_data *data);
+struct sock *mptcp_subflow_get_retrans(const struct mptcp_sock *msk);
 int mptcp_sched_get_send(struct mptcp_sock *msk,
 			 struct mptcp_sched_data *data);
 int mptcp_sched_get_retrans(struct mptcp_sock *msk,
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index ab4683e15868..8ee6e15b6534 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -16,6 +16,33 @@
 static DEFINE_SPINLOCK(mptcp_sched_list_lock);
 static LIST_HEAD(mptcp_sched_list);
 
+static void mptcp_sched_default_data_init(const struct mptcp_sock *msk,
+					  struct mptcp_sched_data *data)
+{
+	data->snd_burst = 0;
+}
+
+static int mptcp_sched_default_get_subflow(const struct mptcp_sock *msk,
+					   struct mptcp_sched_data *data)
+{
+	struct sock *ssk;
+
+	ssk = data->reinject ? mptcp_subflow_get_retrans(msk) :
+			       mptcp_subflow_get_send(msk, data);
+	if (!ssk)
+		return -EINVAL;
+
+	mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
+	return 0;
+}
+
+static struct mptcp_sched_ops mptcp_sched_default = {
+	.data_init	= mptcp_sched_default_data_init,
+	.get_subflow    = mptcp_sched_default_get_subflow,
+	.name           = "default",
+	.owner          = THIS_MODULE,
+};
+
 /* Must be called with rcu read lock held */
 struct mptcp_sched_ops *mptcp_sched_find(const char *name)
 {
@@ -50,11 +77,19 @@ int mptcp_register_scheduler(struct mptcp_sched_ops *sched)
 
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched)
 {
+	if (sched == &mptcp_sched_default)
+		return;
+
 	spin_lock(&mptcp_sched_list_lock);
 	list_del_rcu(&sched->list);
 	spin_unlock(&mptcp_sched_list_lock);
 }
 
+void mptcp_sched_init(void)
+{
+	mptcp_register_scheduler(&mptcp_sched_default);
+}
+
 int mptcp_init_sched(struct mptcp_sock *msk,
 		     struct mptcp_sched_ops *sched)
 {
@@ -118,8 +153,6 @@ void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 int mptcp_sched_get_send(struct mptcp_sock *msk,
 			 struct mptcp_sched_data *data)
 {
-	struct sock *ssk = NULL;
-
 	sock_owned_by_me((const struct sock *)msk);
 
 	/* the following check is moved out of mptcp_subflow_get_send */
@@ -133,14 +166,6 @@ int mptcp_sched_get_send(struct mptcp_sock *msk,
 		return -EINVAL;
 	}
 
-	if (!msk->sched) {
-		ssk = mptcp_subflow_get_send(msk);
-		if (!ssk)
-			return -EINVAL;
-		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
-		return 0;
-	}
-
 	data->reinject = false;
 	msk->sched->data_init(msk, data);
 	return msk->sched->get_subflow(msk, data);
@@ -149,22 +174,12 @@ int mptcp_sched_get_send(struct mptcp_sock *msk,
 int mptcp_sched_get_retrans(struct mptcp_sock *msk,
 			    struct mptcp_sched_data *data)
 {
-	struct sock *ssk = NULL;
-
 	sock_owned_by_me((const struct sock *)msk);
 
 	/* the following check is moved out of mptcp_subflow_get_retrans */
 	if (__mptcp_check_fallback(msk))
 		return -EINVAL;
 
-	if (!msk->sched) {
-		ssk = mptcp_subflow_get_retrans(msk);
-		if (!ssk)
-			return -EINVAL;
-		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
-		return 0;
-	}
-
 	data->reinject = true;
 	msk->sched->data_init(msk, data);
 	return msk->sched->get_subflow(msk, data);
-- 
2.35.3

