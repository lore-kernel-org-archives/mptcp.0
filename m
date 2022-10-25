Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60056.outbound.protection.outlook.com [40.107.6.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CB5800
	for <mptcp@lists.linux.dev>; Tue, 25 Oct 2022 03:27:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbse7kUw9fK92D2YewoilGctcrK4f2Ee0ZUcKc8znXlysl3tj2xZqmmOkTO7P5ALFAz7I4L5Jfjd/eavn9LQgEmED+g4UuNVPGoJViXyXwG2W8Qg68w2wS3NylDpB0cQZr4hH25S2COGDe8VsYKxxzESEr0F9URAcUgSeAHEE7zCtU9t3fWJsoeMhnsr0JebcIWiRgOmo9HOC7U2b2fN+YRFUVgL/hnLnkVD0i4Faca5uSS5e3SCgutmGJjThNS4+QKFDk8yhxY3UHFt+4CUuj1+5Y8090/pHq4T4pUIyTZVB86ITrrNwXrLG9ZF0Y+qs4m7zXXuQSwe4wvhWx9DIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afhgehuSWZaKtdkizepq30f6S6qdUCMuZGkyoVJiB9o=;
 b=cU2oRsvgnvLRno4gMxmGBpSzQLIvNcDjVCLL3t7opiTi6JaUmwGts6fAhAIjf58YTU5Nk4xjbMC1t00z1Y2h+GOK1bPDhAtvTpMa2eRUI4OngodcOz2GHo5PNdhOLAiPMvTsqYFp59R0GYMZm+0aG479hgirjkXmdS0xG37x7AjC6fycaAHuWmilXyI3551SZaGuKfMJM+WZ1kVLZiQ3RFWZ1SntLzpBOcl2m/5Gk2hKJjNttAyI/gHMZGak8siLkKj+WQksgG1ul7wF8kXIijOVm3KL4Lxr4eGaI+bxtZAESVf9grF5tgN++0j4ers2ap3wnKl74n74Co7IoBC5Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afhgehuSWZaKtdkizepq30f6S6qdUCMuZGkyoVJiB9o=;
 b=omOTCaktDoswo/je5QqBNRuQVYpXyBU4XMAx3qtY/7h/lODXHi90P/UeO0mXYPNnC7fI6LdTKwHxlsdL/756htMaxVCD8x5nVuLQKDQFm7cRZ1AjcAqN9mA7dZ2Uuz4XFcfXMNcx+9HGs/1hDWugYUsfg0Nsd78evEd7Vzr0Lr77R6V32E70+56TX2LxZ4PW/a4unDB0ZlmykVqJpBwMVgvhLaUH+EJTIzWLhqRIWnA+bXIDLV432hT6adOqvrGWnDYgBo1+4FxCxaOptP3HARJprn1jZ2w5TZesVRV9y7XpnNQ6vabDZVkqQA6XOVsNBcZO1K6lXJAetsx+nn3lbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8434.eurprd04.prod.outlook.com (2603:10a6:20b:406::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Tue, 25 Oct
 2022 03:27:52 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::84de:d6d2:6710:556a]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::84de:d6d2:6710:556a%5]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 03:27:51 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next v2] Revert "mptcp: add get_subflow wrappers" - fix divide error in mptcp_subflow_get_send
Date: Tue, 25 Oct 2022 11:27:53 +0800
Message-Id: <95f77f38e54f9564608e844f507701c04745475b.1666668425.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0090.apcprd02.prod.outlook.com
 (2603:1096:4:90::30) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8434:EE_
X-MS-Office365-Filtering-Correlation-Id: d9c981d9-bd0f-46ad-992f-08dab638e5ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Q5ofdB6hzNc5pDGSMsw038mXNBSZ9ReKUy58h+4MYQ0YNvvH9UeVf0SItziO5GqHswsuLq1PgM5OEFJ+HRZmKLxw9mIMdvoFbQ2fQiMx9JI8mkO9gyMHFsPmFALV+hzvQl/mmTrVIIgNvQlvG0PUtzXPDbDN0tahMkXa+PDxdPuYqp3erWN0TXhQDqnOAjv0JBcwtxTyxvJzlm2Y8s7qhXGkvOFUR/BcNO72hqvT/CC4aLPmdVqvyqH9AQZt4weEi4Ywg6ZBM998jpReaYKhNSpA4kEARPBBlpcIpnCCIUugmaYRiYyK++tCqyby0MTen5CUqpxuCwydjqs0jXWXR+75w5V0m+75jti0SF2U6nfEUOQodpKhk64IWv+NMKCNIaiVrgcRVsLQFe5iRJ6PpHTMOPQvHGxMgWzSmFx5Qkc7iKPLOimAxKyCS0n0QflKuFjEnViYO2NayvrQk2n/9Bmft4kJ9fPycr3t8rTR7TwNHt37tzBJ2PZfrRR++NNikzriU6yoM8LhwnGxv6dO9bpOkP4TQV4CuXLt6l0zdZkcXGv3OZODkbBBzB39tigyPeAL3lkJBPfd01SNLRGk4/DLRYk8xmx7PpXDHVBeMwCmGvMJRejTnL6pDZbh1mbmJ061eHiI+b7c/L2vlmJXdJMHGK0i5N1WJ8PwyF3OQa8lnDhyDPBF2JvAH4APhfe3xMcQIedqXm5ONjDkUUTTvA6LzNfN/TbxyoFGBDsTEs3ISUvoj9VxAOpaP00kOFg8sRY+efWZtP2iUveNhu25A7gfBNipFHILVC+qMcfNthk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(39860400002)(376002)(366004)(396003)(451199015)(186003)(83380400001)(26005)(6506007)(6512007)(316002)(41300700001)(5660300002)(8676002)(66476007)(66946007)(66556008)(6916009)(54906003)(2906002)(478600001)(86362001)(8936002)(2616005)(44832011)(4326008)(38100700002)(36756003)(6486002)(966005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5PJZOboGoikv8vtjhuOaa9yxo/DfdM98lqC/0Dfl4Ea44m6reYtXuXTqUa3z?=
 =?us-ascii?Q?MOXdhaIOSLGm2cxSPxyFpL1EZlRwyKIK3LhS1/X6eyOleKzNVEjqF9zLadNL?=
 =?us-ascii?Q?4AC/hsSAtCaEe42ZrjRPxaBAfYkSi9SDKlmVDRa1ySbcs+2mOi5wum+vMBIw?=
 =?us-ascii?Q?mYxZ/IFwlNaNBzaR1bQwpPCXywQdV4RvsaAyusQkj2oTHvsNxC8F92rVdbsL?=
 =?us-ascii?Q?w6oNy7OhNuldNolFLQBvViH47moOhk9wPZXxUd5KQq7sFWB354i3YoWcC8PM?=
 =?us-ascii?Q?F0R8gYuqrg0TJ2eYyZyTZ2e2yGl8xMwK31yyTdHFLsJJNEGxbJMlGmIRlH3N?=
 =?us-ascii?Q?TKc1fbFi1km0oy4TOER2/jUrV9bUiEWydctPMjj7Mx9FnCWgTRYS0gK2KPpO?=
 =?us-ascii?Q?6Ew1tg/910YXDFj4a9knzlQogz1buuLDMkyGXn8n6HT9Cw54o4GuEsGN+2GY?=
 =?us-ascii?Q?dZn/142z2RltBb8KtxwJDIa9aUAHHO1v0FBEEfEkC+xxFAW5aYDwkB3E05mQ?=
 =?us-ascii?Q?RQ1EhYFfBDs+7B4OP13TeZGme3wqTRNZUeuUGLtU+mSQtUJNE7yjb+e+K37p?=
 =?us-ascii?Q?pWktHkEHA5p4OfCAtlv7ike6JspvwfuAZPUJAqlT+GwNnlh63M0MkeObOLiJ?=
 =?us-ascii?Q?vYsAyz791Vd3oaaRaRouZXblExubWm0aZBvI5MJoz731PmmIq9Cl893Qdq/j?=
 =?us-ascii?Q?zhdpmqRC565cLotsio8xadEKhrVuiqEOBNOjdwkipBqbF1TPlVAwhHosEzrk?=
 =?us-ascii?Q?sddOxssTQ6FKgyI64OMCUS9dg4a+E1+JIDzCjYAAsD5xcHatm6gUdPD0zQ3d?=
 =?us-ascii?Q?aCEXmTXqvTmW4iY0ZuJ4BZJGxMmHkcTZ3Gcs8vcRrUl6aLQml4bK1oHH3a6b?=
 =?us-ascii?Q?EEkMQrBsTbqd+j3N07BBmPJ9RjeGIAIUSl2gmdduuUTfAYGxoVFwa7CLQVUI?=
 =?us-ascii?Q?ueP++MmGWRhw+cP3tb4GGNgu4p1fyUn1WhBiYWo4qSiUDjkIkMXSeO2IOuRU?=
 =?us-ascii?Q?n7TaS31eRR+9hoaktIMJHfzUMyrzJS3e5Kt+EtySwjnKGIOBR2AipDq4BoD1?=
 =?us-ascii?Q?MXJMUzXI0VnFmik+j2I2ueQBqH52/tDNpV4sAmhxaFyRVaoESO/PnT8YT7Hn?=
 =?us-ascii?Q?BAJK+RdkeMeymbUFL+4qr0b5i+Ofp5UNjP6DQ6My8BZXuL6XMDgcZTEsw3n1?=
 =?us-ascii?Q?Rs4AWwgADaISmLcl7562/1TP1e0mpaiNaf6pGnrTfzwzZjaFN+8UGNqFYVrB?=
 =?us-ascii?Q?ShBlaW8FuHpQIu4AEK2RylK7di9/Uw68eIbUCrJGf+y7ipA6Ih3djsvD5Zlc?=
 =?us-ascii?Q?ZyIzn1kKrb2rDVEMyZikeXtTxhiO8X/ryE7dyW/Kr1uQhE8ekbhpxbTQbwat?=
 =?us-ascii?Q?bQgkwmB4Alu9Qd76ccQwQ3kqhaOfyA4fwbSz8+G2pI5vO4Oohlomv/geE4OG?=
 =?us-ascii?Q?IZPrkY+mylmCrBS08Fpy60lO7S6dY6NnyiOO1dQNpqAwNbHREyeDt6RtaKjV?=
 =?us-ascii?Q?X9R42zTWTuLnRGQLadWH8fO1MJcHJYnVjqmzqpCLvdUvnlwGOglVhvlAdNPb?=
 =?us-ascii?Q?pqdXDMDMFI2HwfFhzsx6yB48DX/we/CA1SWvWBcJ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9c981d9-bd0f-46ad-992f-08dab638e5ae
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 03:27:51.8101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nCiIDkxdRiUZesdU7DuTETHKR1g1/S+8/3v9CmaeN2B9meRt3f1yptMprPYIEadIzd3sY+6+4btE+8Fx4fDchQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8434

This reverts commit 8ae8437eb930b887219dc50b159322f6f9331bfb.

The wrapper mptcp_sched_get_send() will be added in the later patch
"mptcp: use get_send wrapper", and the wrapper mptcp_sched_get_retrans()
will be added in the later patch "mptcp: use get_retrans wrapper".

Fix this divide error:

----
divide error: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 PID: 14336 Comm: syz-executor.6 Not tainted 6.1.0-rc1-00215-g47aa7f23f440 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:div_u64_rem include/linux/math64.h:29 [inline]
RIP: 0010:div_u64 include/linux/math64.h:128 [inline]
RIP: 0010:mptcp_subflow_get_send+0xa87/0x1200 net/mptcp/protocol.c:1486
----

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/314
Reported-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 18 ++++++++--
 net/mptcp/protocol.h |  4 ---
 net/mptcp/sched.c    | 82 --------------------------------------------
 3 files changed, 16 insertions(+), 88 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2419d7be542b..3cf44b5ef937 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1406,7 +1406,7 @@ bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
  * returns the subflow that will transmit the next DSS
  * additionally updates the rtx timeout
  */
-struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
+static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 {
 	struct subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
@@ -1417,6 +1417,15 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	u64 linger_time;
 	long tout = 0;
 
+	sock_owned_by_me(sk);
+
+	if (__mptcp_check_fallback(msk)) {
+		if (!msk->first)
+			return NULL;
+		return __tcp_can_send(msk->first) &&
+		       sk_stream_memory_free(msk->first) ? msk->first : NULL;
+	}
+
 	/* re-use last subflow, if the burst allow that */
 	if (msk->last_snd && msk->snd_burst > 0 &&
 	    sk_stream_memory_free(msk->last_snd) &&
@@ -2210,12 +2219,17 @@ static void mptcp_timeout_timer(struct timer_list *t)
  *
  * A backup subflow is returned only if that is the only kind available.
  */
-struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
+static struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
 {
 	struct sock *backup = NULL, *pick = NULL;
 	struct mptcp_subflow_context *subflow;
 	int min_stale_count = INT_MAX;
 
+	sock_owned_by_me((const struct sock *)msk);
+
+	if (__mptcp_check_fallback(msk))
+		return NULL;
+
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8f48f881adf8..270c187c9001 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -641,10 +641,6 @@ int mptcp_init_sched(struct mptcp_sock *msk,
 void mptcp_release_sched(struct mptcp_sock *msk);
 void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 				 bool scheduled);
-struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
-struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
-int mptcp_sched_get_send(struct mptcp_sock *msk);
-int mptcp_sched_get_retrans(struct mptcp_sock *msk);
 
 static inline bool __tcp_can_send(const struct sock *ssk)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 9b128714055a..d295b92a5789 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -93,85 +93,3 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 {
 	WRITE_ONCE(subflow->scheduled, scheduled);
 }
-
-static int mptcp_sched_data_init(struct mptcp_sock *msk, bool reinject,
-				 struct mptcp_sched_data *data)
-{
-	struct mptcp_subflow_context *subflow;
-	int i = 0;
-
-	data->reinject = reinject;
-
-	mptcp_for_each_subflow(msk, subflow) {
-		if (i == MPTCP_SUBFLOWS_MAX) {
-			pr_warn_once("too many subflows");
-			break;
-		}
-		mptcp_subflow_set_scheduled(subflow, false);
-		data->contexts[i++] = subflow;
-	}
-
-	for (; i < MPTCP_SUBFLOWS_MAX; i++)
-		data->contexts[i] = NULL;
-
-	msk->snd_burst = 0;
-
-	return 0;
-}
-
-int mptcp_sched_get_send(struct mptcp_sock *msk)
-{
-	struct mptcp_sched_data data;
-	struct sock *ssk = NULL;
-
-	sock_owned_by_me((const struct sock *)msk);
-
-	/* the following check is moved out of mptcp_subflow_get_send */
-	if (__mptcp_check_fallback(msk)) {
-		if (msk->first &&
-		    __tcp_can_send(msk->first) &&
-		    sk_stream_memory_free(msk->first)) {
-			mptcp_subflow_set_scheduled(mptcp_subflow_ctx(msk->first), true);
-			return 0;
-		}
-		return -EINVAL;
-	}
-
-	if (!msk->sched) {
-		ssk = mptcp_subflow_get_send(msk);
-		if (!ssk)
-			return -EINVAL;
-		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
-		return 0;
-	}
-
-	mptcp_sched_data_init(msk, false, &data);
-	msk->sched->get_subflow(msk, &data);
-
-	return 0;
-}
-
-int mptcp_sched_get_retrans(struct mptcp_sock *msk)
-{
-	struct mptcp_sched_data data;
-	struct sock *ssk = NULL;
-
-	sock_owned_by_me((const struct sock *)msk);
-
-	/* the following check is moved out of mptcp_subflow_get_retrans */
-	if (__mptcp_check_fallback(msk))
-		return -EINVAL;
-
-	if (!msk->sched) {
-		ssk = mptcp_subflow_get_retrans(msk);
-		if (!ssk)
-			return -EINVAL;
-		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
-		return 0;
-	}
-
-	mptcp_sched_data_init(msk, true, &data);
-	msk->sched->get_subflow(msk, &data);
-
-	return 0;
-}
-- 
2.35.3

