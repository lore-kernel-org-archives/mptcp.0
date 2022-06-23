Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2044.outbound.protection.outlook.com [40.107.104.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7572E1876
	for <mptcp@lists.linux.dev>; Thu, 23 Jun 2022 10:50:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAWZWrlQmMZZQ60KK36CaxIH+B3ClBPwfTs7wd2FBJoIrmuLUamTFrqA5aTHFqqm2t2GlRUODVg6SFb5GS/p4eX8kzVW+Usp/Os1zTEyAsCfxrd7bsDKosJks60UC7wFznYvY+DWvViMg7cmVClWiPmojemuoAp7TaRj378C4jxAeobAid2vjmGm0kwXgIwoKy2ZLNcPLkNrWy2byI1KZ1AsmlBWoCJiSrqsnUJFQsphvG6CDRfWWxpvMcgdIANt4AIN2iilB6ar4JWmVycpExn9BbZs4uU1GBiotEF3qPlvcPZUNSUa9QwWFnNthLy+kl1eXwsgMxP2ycIiSiHhqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUbsTTrZd5PUw0Xzq4nFrnrPB5/MeC3mJFQBIeqs25s=;
 b=bl7d3H61XimOM/WRRrztX16oGIpEeyjrEd+9pYsXC6YEfUkxtBFk4hRtAIzFxWRP4g+2+/qXJV8ugsPGaLysj1lokJVzABauiT/A8M7FcY68Vi8FX1yNHl4ucBOrqjytne+qG9XLW9xOalQElGvDXlb6kXVfMOPwb7XQLaWqLX+tSgGOhehTA+PjLQZJvXo39r4/BMxX+GCDcagagOrwOB8rb6a781Gc2y3h4AZ8sxrMnkiV2z2+aLEAHqL7W44QyiRjAjfpq0xqgbv9XI0lLdc4BZn63GAbihN/30oVmul5y85wFUOICM10rDhw429PUcSTV7uXBE5mqOZZO/epkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUbsTTrZd5PUw0Xzq4nFrnrPB5/MeC3mJFQBIeqs25s=;
 b=Rm7kKTlusmrbQwqfci6r4vHaIrE4e2Zchv/Uf0TlM4pZxiX045IboSt67i2pt0/SZGaPWkDIqwG5lRvvXHw9UIjMDT2cdZf/TWbSDlpK25PCXJwjkopQ+9i1oGlNyWF0u6GtDHSN7iK64++yKpSO4Myac7tjXWClspmKia7gZuSvI+17A4cW7iI+TnI6kxF8oZ6d2PbdHNExTaVVebhjG2mGZMsi56onUD+BAkxujYpp7bnY2UyyOB6jYXeC/paHevFkiwgp/WF87dUnq54VozwMD7WrnLJXeOxK9TyYdmgSxt5oSKN0XOm5p4UebUzDcwKX9rqd5QeOb5gafLHXXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU0PR04MB9587.eurprd04.prod.outlook.com (2603:10a6:10:317::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Thu, 23 Jun
 2022 10:50:30 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5353.022; Thu, 23 Jun 2022
 10:50:30 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 1/6] Squash to "mptcp: add get_subflow wrappers"
Date: Thu, 23 Jun 2022 18:50:23 +0800
Message-Id: <a911f0b25336c9c4098daa4d58a1d8a2ee81213f.1655979747.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1655979747.git.geliang.tang@suse.com>
References: <cover.1655979747.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0142.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9e78bb1-7eba-4f35-58b0-08da55063099
X-MS-TrafficTypeDiagnostic: DU0PR04MB9587:EE_
X-Microsoft-Antispam-PRVS:
	<DU0PR04MB9587CA1DF5714676335141ADF8B59@DU0PR04MB9587.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XaIG+0Ugawf/gzbYAak4hMx7J+doZst0Lkg7MWwqmvP583kauJiDdGf4dCEUsW9g20T4hNAbYOH5OtCJVO8xhuc4DWmmSDK4TJ/3Kh/Juq0dx1OFtKjJeZloLZj4O1fJDZQqWLVKBPm+F/cydA1PZGiLCY2RXgwFSzpExIFssLWUcrc+ErQWFXiGKSw0sUOD3D0Irrai/gsuMO0O51Mk8iFfiX21ihOO0CstBDfTFVEzHQ2QURhe44fgaMHD5z/ntbaooUHb/Wh+7LrEjibtzztxzFeni0UojrZdjynfiNi4NucK6zkdMw+uDNMhcU5k7/BKMfPNikXSu5eCE2qpoWz61ObX4BTeXuQUx+fQ77o7YaNeOzl31xykZ6LJ2CfNTmQBtaVEG1r0eOfoiEpmm8FLQLr4nhWXpjE/bmDrp63gvawvd4sZq9miqbqahiDrcdlA+sUHhnEpzaSGHlD3dvzDQ1df/CLPsH39YLqIrhsz5q7T4eZ9k/Yi9lvFC+0SRPVIaINMuF3RuDWHZFjLzFVtBI8NNgn3RoTXcQC+Y5kl0qKcC79fVta1jAue/gPr4I8X2xymy0SEfoxO4VU0WtVrRIzzrG0Y/BqOuDa/wMfGf8tKAUTuzTTUYePxr5oUgMwJFqfH55EIqsPVOM9rXeiChsY0S5r4jpSsrcp8wFIGRyJQsS4a+MxNnazzBYkBqZAawp8AuXSg02OmoctTXVgHhXNBuxwy2qwyFbspql2/fqZZnMW6giqiXnlVwgFA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(396003)(376002)(136003)(366004)(66556008)(316002)(83380400001)(66476007)(6666004)(38100700002)(66946007)(6916009)(5660300002)(186003)(4326008)(36756003)(6506007)(8676002)(107886003)(26005)(2616005)(6512007)(41300700001)(86362001)(8936002)(6486002)(478600001)(2906002)(44832011)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q0V2n1+3ghU0VCxkvJkZaQQcmBh6BYazjNSVtIIUJI4HWLeXRFXVGQf5ggQ5?=
 =?us-ascii?Q?YZiZihrfUEdFQOj2YpxUxV9zofp2F+ilhDuHuYfca/B2/WnmQ+S8TyHdSwCi?=
 =?us-ascii?Q?s1lcNm36s0DCSXZbvTUGpenxY0sJr4y5Lnj3MI+5/SimOJ8Gdy1fMNRBBcXi?=
 =?us-ascii?Q?kx/hQRPxYdQn5C///QvUDaL9OoVYjENphoCrlWDqQHToLdJNP3qe0gP5vup3?=
 =?us-ascii?Q?BzdJyGzvn6Kf9uUCl9QV4Kdqfb7FWsWNRZHPVoT805B8SL3EpWhQOPrwYvVS?=
 =?us-ascii?Q?QqgZiMYzGmDzCZtbI+RG9TWjtNUc9AMUnBB4URoc7sZeik7d8V0zCY2jHjy+?=
 =?us-ascii?Q?cIBdhQ5proirTx5MiF7oPRErmHVl43lSO3kfNo+c8sfd83zBoj8gGYjf59bb?=
 =?us-ascii?Q?hiZPayis/tDSy7j7BAc9wmqMwIDD/BF/JRhJZX3srMURBaWlPmc7nnf0Knly?=
 =?us-ascii?Q?KqglkVJ8R8DlcrwbtJ4Cc42ThMaYaqA40/BBibxVd/6T3U/d0fIUNJLc4Mfk?=
 =?us-ascii?Q?Gu/8rI+lVXZG9gt0NBoK4Dnhl/8j4acgnLvMkzgTOzggP3gnmbRfyAdIpNfN?=
 =?us-ascii?Q?O9uXIBxEKXDWOxoj7r9ViUbNC52qcx9BmdPos7LPUTEGc2PmFPy3T9LHNHrU?=
 =?us-ascii?Q?/mFzRLyTVsxXzap2nmPxSw8+5rG3PHJz/hR1zEMcxUfBDwxXutbvZWdsvpa8?=
 =?us-ascii?Q?dG4TS/BGOLAtw8PtFsfNKntC9L9biBCN94o/rL3vh8tqDiITo3pCig7y2Etc?=
 =?us-ascii?Q?PbgMLDMSE0ECHz5aZ4QlqRwvFR+WnfcY6/7uDfUbcsUGcIRWVktamfa0/yRy?=
 =?us-ascii?Q?h3oTuRMUx/esNhBQkxrDzYIdSsCA7pRjAJAdTJ3GQoqHjucyaCzG015PAqvz?=
 =?us-ascii?Q?boRRJx5ZizkHALgPzrg6IlAt6o/DRyJf+geQpLmhX7unFWDOTTdsYdvbGzAa?=
 =?us-ascii?Q?RX61AEsC9JFBIiYJrBjATZK4NQ7Jc6lVN5hD44h3yl2IAl04mbr5Ug7HcGP1?=
 =?us-ascii?Q?ZsN0S3hSnquiSq90PFRFZNE08aXZDH7shsn3mnEMCLx4tifnVLcP2HuCsz8N?=
 =?us-ascii?Q?PeOBRMfBNA/s39JRbRl7WWdtOGq2vVqHQJBLRmtaQZ4YbvZME0+gE+sm0SeR?=
 =?us-ascii?Q?mvxX3w3rfCa1YmyByL0RnlW66PnAWsovFH0YeBGDUxKXyFibFSopqHkL4IXL?=
 =?us-ascii?Q?5qgXDQG3bGCYHAl4aQQ+J3by1/6kK6Z+0Qjt8S0QlcCQpIoL0rZIwPXiPy4P?=
 =?us-ascii?Q?YosIiMuFLO1ndIVLoosC0s+uPuoo9KfGq9pslTixJQN28FzwQgSC0lpmChHl?=
 =?us-ascii?Q?7d6xszvoV8JL87oguSETpfgB++5v6cplhQnMYw4gY+GSfB3hL5rkXt3m5LSp?=
 =?us-ascii?Q?+DtfQpO9Wb/tHLQ+HriRD+CKKe9nb+LLYWjMB7vRlNgTBhegeP971yqD+b7l?=
 =?us-ascii?Q?L09VoszgLrGKFj1nmRpvPCu7Nr94M8VXFb/MpTaFC6PjGU8PmcruTPeKjDm4?=
 =?us-ascii?Q?GQ0+J/SFftLD0BIePLXPWeBg6rXdq1Y+2jsW8LfnUxrRSUBO6lnhpMOnw+lI?=
 =?us-ascii?Q?kL6bq3Ybayrjg/VBtYptkykYEC4lYyyU2nVGokPQRGoHnjewe/EGgXWYWk7m?=
 =?us-ascii?Q?bvrkqCnsChYQE90TtIkNFGKFwaoBeNMx2L9OGGl3pw0PrN6VQCCB/Ef04B5l?=
 =?us-ascii?Q?7azWkvWzZ/yP4HmWxZoQy4VVG/AUd9H965OF3UBzaqZ4QS0TKQdZmIBZ6Nwc?=
 =?us-ascii?Q?VvogZyGiFqHJSyJnTuz/sgTKx3CLgKo=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9e78bb1-7eba-4f35-58b0-08da55063099
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 10:50:30.1742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NtKxhMWx3/Fx83Eo8iLrivzaZRUfm48ewkUBIiPPDm3FvKXX2Be8UAwIM5k0A9C4rVUOmOxVKAj65bPGmZbu1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9587

Please update the commit log:

'''
This patch defines two new wrappers mptcp_sched_get_send() and
mptcp_sched_get_retrans(), invoke get_subflow() of msk->sched in them.
Use them instead of using mptcp_subflow_get_send() or
mptcp_subflow_get_retrans() directly.

Set the subflow pointers array in struct mptcp_sched_data before invoking
get_subflow(), then it can be used in get_subflow() in the BPF contexts.

Check the subflow scheduled flags to test which subflow or subflows are
picked by the scheduler.

Move sock_owned_by_me() and the fallback check code from
mptcp_subflow_get_send/retrans() into the wrappers.

Redundant subflows are not supported in __mptcp_subflow_push_pending()
yet. This patch adds a placeholder in mptcp_sched_get_send() to pick the
first subflow for the redundant subflows case.
'''

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 12 +++++----
 net/mptcp/protocol.h |  4 +--
 net/mptcp/sched.c    | 63 ++++++++++++++++++++++++++------------------
 3 files changed, 47 insertions(+), 32 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b1fae2f747c9..15472d0af508 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1532,7 +1532,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 			int ret = 0;
 
 			prev_ssk = ssk;
-			ssk = mptcp_sched_get_send(msk);
+			ssk = mptcp_subflow_get_send(msk);
 
 			/* First check. If the ssk has changed since
 			 * the last round, release prev_ssk
@@ -1593,13 +1593,13 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
 		info.limit = dfrag->data_len;
 		len = dfrag->data_len - dfrag->already_sent;
 		while (len > 0) {
-			int ret = 0;
+			int ret = 0, err = 0;
 
 			/* the caller already invoked the packet scheduler,
 			 * check for a different subflow usage only after
 			 * spooling the first chunk of data
 			 */
-			xmit_ssk = first ? ssk : mptcp_sched_get_send(mptcp_sk(sk));
+			xmit_ssk = first ? ssk : mptcp_sched_get_send(mptcp_sk(sk), &err);
 			if (!xmit_ssk)
 				goto out;
 			if (xmit_ssk != ssk) {
@@ -2408,7 +2408,7 @@ static void __mptcp_retrans(struct sock *sk)
 	mptcp_clean_una_wakeup(sk);
 
 	/* first check ssk: need to kick "stale" logic */
-	ssk = mptcp_sched_get_retrans(msk);
+	ssk = mptcp_subflow_get_retrans(msk);
 	dfrag = mptcp_rtx_head(sk);
 	if (!dfrag) {
 		if (mptcp_data_fin_enabled(msk)) {
@@ -3090,11 +3090,13 @@ void __mptcp_data_acked(struct sock *sk)
 
 void __mptcp_check_push(struct sock *sk, struct sock *ssk)
 {
+	int err = 0;
+
 	if (!mptcp_send_head(sk))
 		return;
 
 	if (!sock_owned_by_user(sk)) {
-		struct sock *xmit_ssk = mptcp_sched_get_send(mptcp_sk(sk));
+		struct sock *xmit_ssk = mptcp_sched_get_send(mptcp_sk(sk), &err);
 
 		if (xmit_ssk == ssk)
 			__mptcp_subflow_push_pending(sk, ssk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 95c9ace1437b..406e1bb4fff4 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -635,8 +635,8 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 				 bool scheduled);
 struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
 struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
-struct sock *mptcp_sched_get_send(struct mptcp_sock *msk);
-struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk);
+struct sock *mptcp_sched_get_send(struct mptcp_sock *msk, int *err);
+int mptcp_sched_get_retrans(struct mptcp_sock *msk);
 
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *subflow)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 8858e1fc8b74..6d7cc4cba2be 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -114,34 +114,51 @@ static int mptcp_sched_data_init(struct mptcp_sock *msk, bool reinject,
 	for (; i < MPTCP_SUBFLOWS_MAX; i++)
 		data->contexts[i] = NULL;
 
+	msk->snd_burst = 0;
+
 	return 0;
 }
 
-struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
+struct sock *mptcp_sched_get_send(struct mptcp_sock *msk, int *err)
 {
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sched_data data;
 	struct sock *ssk = NULL;
-	int i;
 
+	*err = -EINVAL;
 	sock_owned_by_me((struct sock *)msk);
 
 	/* the following check is moved out of mptcp_subflow_get_send */
 	if (__mptcp_check_fallback(msk)) {
-		if (!msk->first)
-			return NULL;
-		return sk_stream_memory_free(msk->first) ? msk->first : NULL;
+		if (msk->first && sk_stream_memory_free(msk->first)) {
+			mptcp_subflow_set_scheduled(mptcp_subflow_ctx(msk->first), true);
+			*err = 0;
+			return msk->first;
+		}
+		return NULL;
 	}
 
-	if (!msk->sched)
-		return mptcp_subflow_get_send(msk);
+	if (!msk->sched) {
+		ssk = mptcp_subflow_get_send(msk);
+		if (!ssk)
+			return NULL;
+		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
+		*err = 0;
+		return ssk;
+	}
 
 	mptcp_sched_data_init(msk, false, &data);
 	msk->sched->get_subflow(msk, &data);
 
-	for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (data.contexts[i] && READ_ONCE(data.contexts[i]->scheduled)) {
-			ssk = data.contexts[i]->tcp_sock;
-			msk->last_snd = ssk;
+	mptcp_for_each_subflow(msk, subflow) {
+		if (READ_ONCE(subflow->scheduled)) {
+			/* TODO: Redundant subflows are not supported in
+			 * __mptcp_subflow_push_pending() yet. Here's a
+			 * placeholder to pick the first subflow for the
+			 * redundant subflows case.
+			 */
+			ssk = subflow->tcp_sock;
+			*err = 0;
 			break;
 		}
 	}
@@ -149,31 +166,27 @@ struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
 	return ssk;
 }
 
-struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk)
+int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 {
 	struct mptcp_sched_data data;
 	struct sock *ssk = NULL;
-	int i;
 
 	sock_owned_by_me((const struct sock *)msk);
 
 	/* the following check is moved out of mptcp_subflow_get_retrans */
 	if (__mptcp_check_fallback(msk))
-		return NULL;
+		return -EINVAL;
 
-	if (!msk->sched)
-		return mptcp_subflow_get_retrans(msk);
+	if (!msk->sched) {
+		ssk = mptcp_subflow_get_retrans(msk);
+		if (!ssk)
+			return -EINVAL;
+		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
+		return 0;
+	}
 
 	mptcp_sched_data_init(msk, true, &data);
 	msk->sched->get_subflow(msk, &data);
 
-	for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (data.contexts[i] && READ_ONCE(data.contexts[i]->scheduled)) {
-			ssk = data.contexts[i]->tcp_sock;
-			msk->last_snd = ssk;
-			break;
-		}
-	}
-
-	return ssk;
+	return 0;
 }
-- 
2.35.3

